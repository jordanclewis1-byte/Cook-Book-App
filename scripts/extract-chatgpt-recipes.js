const fs = require('fs');
const path = require('path');

const EXPORT_DIR = path.join(process.cwd(), 'chatgpt-export');
const OUTPUT_DIR = path.join(process.cwd(), 'data-import');
const TARGET_GIZMO = 'g-p-69534c4a2bd881918d461401f82ff136';

function readConversations() {
  const files = fs.readdirSync(EXPORT_DIR)
    .filter((name) => /^conversations-\d+\.json$/.test(name))
    .sort();
  const conversations = [];
  for (const file of files) {
    const data = JSON.parse(fs.readFileSync(path.join(EXPORT_DIR, file), 'utf8'));
    conversations.push(...data);
  }
  return conversations;
}

function walkThread(conv) {
  const mapping = conv.mapping || {};
  let current = conv.current_node;
  const chain = [];
  const seen = new Set();
  while (current && !seen.has(current) && mapping[current]) {
    seen.add(current);
    const node = mapping[current];
    if (node.message) chain.push(node.message);
    current = node.parent;
  }
  return chain.reverse();
}

function getTextFromPart(part) {
  if (typeof part === 'string') return part;
  if (part && typeof part.text === 'string') return part.text;
  return '';
}

function messageText(message) {
  const content = message?.content || {};
  const contentType = content.content_type;
  if (contentType === 'text' || contentType === 'multimodal_text') {
    return (content.parts || []).map(getTextFromPart).join('\n').trim();
  }
  if (contentType === 'code') {
    return (content.text || '').trim();
  }
  return '';
}

function cleanText(text) {
  return text
    .replace(/\uE200[^\uE201]*\uE201/g, '')
    .replace(/\r/g, '')
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

function isRecipeLike(text) {
  const haystack = text.toLowerCase();
  return (
    /ingredients|instructions|how to make|method|serves:|serves\s*\d|time:|protein\s*[:|]|calories/.test(haystack) &&
    /oat|tofu|fish|cod|halibut|tuna|shrimp|lentil|bean|egg|breakfast|rice|sprout|stew|bake|recipe/.test(haystack)
  );
}

function scoreRecipeMessage(text) {
  let score = text.length;
  if (/ingredients/i.test(text)) score += 1000;
  if (/instructions|how to make|method/i.test(text)) score += 1000;
  if (/serves|time|protein|calories/i.test(text)) score += 400;
  if (/would you like me to/i.test(text)) score -= 200;
  if (/soften the butter|nutrition information|when should i add|best time to add/i.test(text.toLowerCase())) score -= 1200;
  return score;
}

function selectPrimaryRecipeText(conv) {
  const chain = walkThread(conv);
  const assistantTexts = chain
    .filter((message) => message.author?.role === 'assistant')
    .map(messageText)
    .map(cleanText)
    .filter(Boolean);

  const recipeCandidates = assistantTexts.filter(isRecipeLike);
  if (recipeCandidates.length === 0) {
    return assistantTexts.at(-1) || '';
  }
  return recipeCandidates.sort((a, b) => scoreRecipeMessage(b) - scoreRecipeMessage(a))[0];
}

function inferProtein(title, body) {
  const haystack = `${title}\n${body}`.toLowerCase();
  const checks = [
    ['Fish', ['cod', 'halibut', 'fish', 'tuna', 'salmon', 'shrimp', 'seafood', 'pollock']],
    ['Tofu', ['tofu']],
    ['Beans', ['bean', 'beans', 'lentil', 'lentils', 'chickpea', 'chickpeas']],
    ['Chicken', ['chicken']],
    ['Beef', ['beef', 'meatball']],
    ['Pork', ['pork']],
    ['Turkey', ['turkey']]
  ];
  for (const [label, patterns] of checks) {
    if (patterns.some((pattern) => haystack.includes(pattern))) return label;
  }
  return 'Other';
}

function extractMetric(text, regex) {
  const match = text.match(regex);
  return match ? match[1].replace(/[*_]/g, '').trim() : null;
}

function splitMultiRecipeSections(body) {
  const lines = body.split('\n');
  const sections = [];
  let current = null;
  for (const rawLine of lines) {
    const line = rawLine.trimEnd();
    if (/^#{1,3}\s+(?:\d+[.)]\s+)?[A-Za-z0-9????????????].+/u.test(line)) {
      const heading = line.replace(/^#{1,3}\s+/, '').trim();
      if (/ingredients|instructions|method|tips|why this works|quick flavor|optional/i.test(heading)) {
        if (current) current.lines.push(rawLine);
        continue;
      }
      if (/recipe|oatmeal|crepes|stew|bake|tofu|fish|rice|sprouts|breakfast|quinoa|cauliflower|brussels|lentil|tuna|cod|halibut/i.test(heading)) {
        if (current) sections.push(current);
        current = { heading, lines: [] };
        continue;
      }
    }
    if (current) current.lines.push(rawLine);
  }
  if (current) sections.push(current);
  return sections.filter((section) => /ingredients|how to make|instructions|serves|protein|calories/i.test(section.lines.join('\n')));
}

function normalizeTitle(text) {
  return text
    .replace(/^\d+[.)]\s*/, '')
    .replace(/\*+/g, '')
    .replace(/^[^A-Za-z0-9]+/u, '')
    .trim();
}

function conversationToRecipes(conv) {
  const primaryText = selectPrimaryRecipeText(conv);
  const sections = splitMultiRecipeSections(primaryText);
  if (sections.length > 1) {
    return sections.map((section, index) => {
      const body = cleanText(section.lines.join('\n'));
      return {
        source_conversation_id: conv.id,
        source_conversation_title: conv.title,
        source_gizmo_id: conv.gizmo_id,
        extracted_from_multi_recipe: true,
        recipe_index: index + 1,
        title: normalizeTitle(section.heading),
        description: body.split('\n').find((line) => line.trim() && !/^[-*#]/.test(line.trim())) || conv.title,
        protein: inferProtein(section.heading, body),
        servings: extractMetric(body, /serves\s*:?\s*([^\n]+)/i),
        time: extractMetric(body, /time\s*:?\s*([^\n]+)/i),
        calories: extractMetric(body, /(~?\d+\s*(?:-|–)?\s*\d*\s*cal(?:ories)?(?:\s*per\s*serving)?)/i),
        protein_note: extractMetric(body, /(~?\d+\s*(?:-|–)?\s*\d*\s*g\s*protein(?:\s*(?:per\s*serving|total|day))?)/i),
        raw_text: body
      };
    });
  }
  return [{
    source_conversation_id: conv.id,
    source_conversation_title: conv.title,
    source_gizmo_id: conv.gizmo_id,
    extracted_from_multi_recipe: false,
    recipe_index: 1,
    title: conv.title,
    description: primaryText.split('\n').find((line) => line.trim() && !/^[-*#]/.test(line.trim())) || conv.title,
    protein: inferProtein(conv.title, primaryText),
    servings: extractMetric(primaryText, /serves\s*:?\s*([^\n]+)/i),
    time: extractMetric(primaryText, /time\s*:?\s*([^\n]+)/i),
    calories: extractMetric(primaryText, /(~?\d+\s*(?:-|–)?\s*\d*\s*cal(?:ories)?(?:\s*per\s*serving)?)/i),
    protein_note: extractMetric(primaryText, /(~?\d+\s*(?:-|–)?\s*\d*\s*g\s*protein(?:\s*(?:per\s*serving|total|day))?)/i),
    raw_text: primaryText
  }];
}

function toCurrentSchema(record) {
  return {
    title: record.title,
    protein: record.protein,
    description: String(record.description || record.title).slice(0, 240),
    ingredients: 'TO REVIEW: extracted from ChatGPT export\n\n' + record.raw_text,
    instructions: 'TO REVIEW: parse final recipe steps from extracted text\n\n' + record.raw_text
  };
}

function csvEscape(value) {
  const text = value == null ? '' : String(value);
  if (/[",\n]/.test(text)) return '"' + text.replace(/"/g, '""') + '"';
  return text;
}

function writeCsv(filePath, rows, columns) {
  const lines = [columns.join(',')];
  for (const row of rows) {
    lines.push(columns.map((column) => csvEscape(row[column])).join(','));
  }
  fs.writeFileSync(filePath, lines.join('\n'));
}

const conversations = readConversations();
const recipeProjectConversations = conversations.filter((conv) => conv.gizmo_id === TARGET_GIZMO).sort((a, b) => (a.create_time || 0) - (b.create_time || 0));
const extractedRecipes = recipeProjectConversations.flatMap(conversationToRecipes);
const currentSchemaImport = extractedRecipes.map(toCurrentSchema);

fs.writeFileSync(path.join(OUTPUT_DIR, 'recipes-project-conversations.json'), JSON.stringify(recipeProjectConversations.map((conv) => ({
  id: conv.id,
  title: conv.title,
  create_time: conv.create_time,
  update_time: conv.update_time,
  gizmo_id: conv.gizmo_id
})), null, 2));

fs.writeFileSync(path.join(OUTPUT_DIR, 'recipes-project-extracted.json'), JSON.stringify(extractedRecipes, null, 2));
fs.writeFileSync(path.join(OUTPUT_DIR, 'recipes-project-current-schema.json'), JSON.stringify(currentSchemaImport, null, 2));
writeCsv(path.join(OUTPUT_DIR, 'recipes-project-current-schema.csv'), currentSchemaImport, ['title', 'protein', 'description', 'ingredients', 'instructions']);

console.log(JSON.stringify({
  conversation_count: recipeProjectConversations.length,
  extracted_recipe_count: extractedRecipes.length,
  output_dir: OUTPUT_DIR
}, null, 2));
