const fs = require('fs');
const path = require('path');

const ROOT = process.cwd();
const INPUT = path.join(ROOT, 'data-import', 'recipes-project-cleaned.json');
const OUT_DIR = path.join(ROOT, 'data-import');

const approved = new Set([
  'fish and chickpea stew',
  'oven-baked creamy lemon-garlic cod (or halibut)',
  'easy miso butter cod (serves 2)',
  'greek yogurt protein oatmeal',
  'cottage cheese "cheesecake" oatmeal',
  'creamy cod with leeks & mushrooms (weeknight-friendly)',
  'protein pancakes recipe',
  'dump-and-bake broccoli, chickpea & feta quinoa bake',
  'dump-and-bake white bean, spinach & tomato casserole',
  'dump-and-bake red lentil coconut curry (ultra lazy edition)',
  'crispy miso-maple tofu with garlicky greens',
  'gochujang sheet-pan tofu & veggies',
  'creamy miso-ginger tofu skillet',
  'sticky gochujang tofu (20-minute skillet)',
  'creamy lemon-garlic red lentils (mediterranean style)',
  'smoky harissa red lentils',
  'coconut-miso red lentil mash (ultra cozy)',
  'high-protein savory miso broth oatmeal',
  'restaurant-style miso-ginger tuna (nobu inspired)',
  'ginger-scallion cauliflower rice (bright + umami)',
  'lemon-garlic herb cauliflower rice (mediterranean)',
  'miso-butter cauliflower rice (deep umami)',
  'smoky tomato-paprika cauliflower rice',
  'crispy oven-roasted brussels sprouts',
  'one-pot shrimp, black bean & cauliflower rice stew',
  'creamy greek yogurt & dill fish stew',
  'coconut lemongrass fish & cauliflower rice stew',
]);

const hold = new Set([
  'one-pan halibut with leeky brown rice',
  'egg-white oatmeal (creamy, not eggy)',
  'high protein oatmeal ideas',
  'high-protein egg white crepes with ricotta & berries',
  'why this recipe works',
  'fish',
  'bake the fish',
  'whipped ricotta breakfast bowl (dessert-style)',
]);

const reject = new Set([
  'low-carb sides for eggs',
]);

const titleOverrides = {
  'dump-and-bake broccoli, chickpea & feta quinoa bake': 'Dump-and-Bake Broccoli, Chickpea & Feta Quinoa Bake',
  'dump-and-bake white bean, spinach & tomato casserole': 'Dump-and-Bake White Bean, Spinach & Tomato Casserole',
  'dump-and-bake red lentil coconut curry (ultra lazy edition)': 'Dump-and-Bake Red Lentil Coconut Curry (Ultra Lazy Edition)',
  'crispy miso-maple tofu with garlicky greens': 'Crispy Miso-Maple Tofu with Garlicky Greens',
  'gochujang sheet-pan tofu & veggies': 'Gochujang Sheet-Pan Tofu & Veggies',
  'creamy miso-ginger tofu skillet': 'Creamy Miso-Ginger Tofu Skillet',
  'restaurant-style miso-ginger tuna (nobu inspired)': 'Restaurant-Style Miso-Ginger Tuna (Nobu Inspired)',
  'cottage cheese "cheesecake" oatmeal': 'Cottage Cheese "Cheesecake" Oatmeal',
};

const proteinOverrides = {
  'greek yogurt protein oatmeal': 'Other',
  'cottage cheese "cheesecake" oatmeal': 'Other',
  'protein pancakes recipe': 'Other',
  'creamy lemon-garlic red lentils (mediterranean style)': 'Beans',
  'smoky harissa red lentils': 'Beans',
  'coconut-miso red lentil mash (ultra cozy)': 'Beans',
  'high-protein savory miso broth oatmeal': 'Other',
  'ginger-scallion cauliflower rice (bright + umami)': 'Other',
  'lemon-garlic herb cauliflower rice (mediterranean)': 'Other',
  'miso-butter cauliflower rice (deep umami)': 'Other',
  'smoky tomato-paprika cauliflower rice': 'Other',
};

const descriptionOverrides = {
  'fish and chickpea stew': 'One-pot tomato, chickpea, fish, and rice stew.',
  'oven-baked creamy lemon-garlic cod (or halibut)': 'Oven-baked cod or halibut in a creamy lemon-garlic sauce.',
  'easy miso butter cod (serves 2)': 'Quick baked cod glazed with miso butter.',
  'greek yogurt protein oatmeal': 'Protein oatmeal with Greek yogurt, berries, and cinnamon.',
  'cottage cheese "cheesecake" oatmeal': 'High-protein oatmeal with cottage cheese, vanilla, and fruit.',
  'creamy cod with leeks & mushrooms (weeknight-friendly)': 'Weeknight cod with leeks and mushrooms in a creamy skillet sauce.',
  'protein pancakes recipe': 'Blender oat pancakes with Greek yogurt and eggs.',
  'dump-and-bake broccoli, chickpea & feta quinoa bake': 'Quinoa bake with broccoli, chickpeas, and feta.',
  'dump-and-bake white bean, spinach & tomato casserole': 'White bean and spinach casserole with tomatoes and mozzarella.',
  'dump-and-bake red lentil coconut curry (ultra lazy edition)': 'Baked red lentil curry with coconut milk and vegetables.',
  'crispy miso-maple tofu with garlicky greens': 'Pan-crisped tofu glazed with miso-maple sauce and greens.',
  'gochujang sheet-pan tofu & veggies': 'Sheet-pan tofu and vegetables with a gochujang glaze.',
  'creamy miso-ginger tofu skillet': 'Tofu skillet with a creamy miso-ginger sauce.',
  'sticky gochujang tofu (20-minute skillet)': 'Crispy tofu tossed in a sticky gochujang glaze.',
  'creamy lemon-garlic red lentils (mediterranean style)': 'Creamy red lentils finished with lemon, garlic, and olive oil.',
  'smoky harissa red lentils': 'Red lentils with smoky spices, harissa, and lemon.',
  'coconut-miso red lentil mash (ultra cozy)': 'Soft red lentils finished with coconut milk, miso, and lime.',
  'high-protein savory miso broth oatmeal': 'Savory oatmeal cooked in miso broth with eggs and toppings.',
  'restaurant-style miso-ginger tuna (nobu inspired)': 'Quick-seared tuna with a miso-ginger sauce.',
  'ginger-scallion cauliflower rice (bright + umami)': 'Cauliflower rice with ginger, garlic, soy, and scallions.',
  'lemon-garlic herb cauliflower rice (mediterranean)': 'Mediterranean cauliflower rice with lemon, garlic, and herbs.',
  'miso-butter cauliflower rice (deep umami)': 'Cauliflower rice finished with miso butter and scallions.',
  'smoky tomato-paprika cauliflower rice': 'Smoky cauliflower rice with tomato paste, paprika, and herbs.',
  'crispy oven-roasted brussels sprouts': 'Roasted Brussels sprouts with crisp edges and optional lemon or balsamic.',
  'one-pot shrimp, black bean & cauliflower rice stew': 'Shrimp and black bean stew with cauliflower rice.',
  'creamy greek yogurt & dill fish stew': 'Fish stew with Greek yogurt, dill, lemon, and cauliflower rice.',
  'coconut lemongrass fish & cauliflower rice stew': 'Thai-inspired fish stew with coconut broth and cauliflower rice.',
};

const replacements = new Map([
  ['’', "'"],
  ['‘', "'"],
  ['“', '"'],
  ['�?', '"'],
  ['—', '-'],
  ['–', '-'],
  ['•', '-'],
  ['→', '->'],
  ['½', '1/2'],
  ['¼', '1/4'],
  ['¾', '3/4'],
  ['°', ' degrees'],
  ['�', ''],
  ['👍', ''],
  ['👀', ''],
  ['🗓', ''],
  ['🛒', ''],
  ['🥞', ''],
  ['🥚', ''],
  ['🍋', ''],
  ['🐟', ''],
  ['🍓', ''],
  ['💡', ''],
  ['✅', ''],
  ['✔', ''],
  ['❌', ''],
  ['️', ''],
  ['⃣', ''],
  ['Sauté', 'Saute'],
  ['sauté', 'saute'],
  ['crème fraîche', 'creme fraiche'],
]);

const tailPatterns = [
  /\n+If you want, I can[\s\S]*$/i,
  /\n+If you'd like, I can[\s\S]*$/i,
  /\n+Just say the word[\s\S]*$/i,
  /\n+Just tell me your priority[\s\S]*$/i,
  /\n+Want me to turn this into[\s\S]*$/i,
  /\n+Since you cook[\s\S]*$/i,
  /\n+### Want to optimize further\?[\s\S]*$/i,
  /\n+### Want a direction\?[\s\S]*$/i,
  /\n+### Flavor Upgrades \(Still Light\)[\s\S]*$/i,
  /\n+### Optional Easy Upgrades[\s\S]*$/i,
  /\n+### What to Serve It With[\s\S]*$/i,
  /\n+### Simple sides that fit your cooking style[\s\S]*$/i,
  /\n+### Estimated nutrition[\s\S]*$/i,
  /\n+### Nutrition \(approx\.?\)[\s\S]*$/i,
  /\n+### Approx macros[\s\S]*$/i,
  /\n+### Approximate nutrition \(per serving\)[\s\S]*$/i,
  /\n+### Calories \(approximate\)[\s\S]*$/i,
  /\n+### Easy variations[\s\S]*$/i,
  /\n+### How to serve it[\s\S]*$/i,
  /\n+### Tips[\s\S]*$/i,
  /\n+### Key oven tweaks \(why they matter\)[\s\S]*$/i,
  /\n+### Optional broiler finish \(restaurant-y touch\)[\s\S]*$/i,
  /\n+### What to watch out for[\s\S]*$/i,
  /\n+### Make-ahead friendly\?[\s\S]*$/i,
];

function cleanText(text) {
  let value = String(text || '');
  for (const [bad, good] of replacements.entries()) {
    value = value.split(bad).join(good);
  }
  value = value.replace(/\r/g, '');
  value = value.replace(/\uE200[^\uE201]*\uE201/g, '');
  value = value.replace(/image_group\{[^\n]*\}/g, '');
  value = value.replace(/\n{3,}/g, '\n\n');
  return value.trim();
}

function normalizeTitle(title) {
  let value = cleanText(title)
    .replace(/^#+\s*/, '')
    .replace(/^\d+[.)]\s*/, '')
    .replace(/^[^A-Za-z0-9]+/, '')
    .trim();
  value = value.replace(/[??????]/g, '').trim();
  return value;
}

function normalizedKey(title) {
  return normalizeTitle(title)
    .replace(/[��]/g, '"')
    .replace(/[��]/g, '-')
    .replace(/\s+/g, ' ')
    .toLowerCase()
    .trim();
}

function stripTail(text) {
  let value = cleanText(text);
  for (const pattern of tailPatterns) {
    value = value.replace(pattern, '');
  }
  value = value.replace(/\n---\s*$/g, '');
  value = value.replace(/\n{3,}/g, '\n\n');
  return value.trim();
}

function toCurrentSchema(row) {
  return {
    title: row.title,
    protein: row.protein,
    description: row.description,
    ingredients: 'TO REVIEW: extracted from ChatGPT export\n\n' + row.raw_text,
    instructions: 'TO REVIEW: parse final recipe steps from extracted text\n\n' + row.raw_text,
  };
}

function csvEscape(value) {
  const text = value == null ? '' : String(value);
  return /[",\n]/.test(text) ? '"' + text.replace(/"/g, '""') + '"' : text;
}

function writeCsv(filePath, rows, columns) {
  const lines = [columns.join(',')];
  for (const row of rows) {
    lines.push(columns.map((column) => csvEscape(row[column])).join(','));
  }
  fs.writeFileSync(filePath, lines.join('\n'));
}

const sourceRows = JSON.parse(fs.readFileSync(INPUT, 'utf8'));
const normalizedRows = sourceRows.map((row) => {
  const key = normalizedKey(row.title);
  const status = approved.has(key) ? 'approved' : hold.has(key) ? 'hold' : reject.has(key) ? 'rejected' : 'unclassified';
  return {
    ...row,
    normalized_title: key,
    title: titleOverrides[key] || normalizeTitle(row.title),
    protein: proteinOverrides[key] || row.protein,
    description: (descriptionOverrides[key] || cleanText(row.description || row.title)).slice(0, 240),
    raw_text: stripTail(row.raw_text),
    review_status: status,
  };
});

const approvedRows = normalizedRows.filter((row) => row.review_status === 'approved');
const holdRows = normalizedRows.filter((row) => row.review_status === 'hold');
const rejectedRows = normalizedRows.filter((row) => row.review_status === 'rejected');
const unclassifiedRows = normalizedRows.filter((row) => row.review_status === 'unclassified');

const approvedCurrentSchema = approvedRows.map(toCurrentSchema);

fs.writeFileSync(path.join(OUT_DIR, 'recipes-project-approved.json'), JSON.stringify(approvedRows, null, 2));
fs.writeFileSync(path.join(OUT_DIR, 'recipes-project-approved-current-schema.json'), JSON.stringify(approvedCurrentSchema, null, 2));
fs.writeFileSync(path.join(OUT_DIR, 'recipes-project-hold.json'), JSON.stringify(holdRows, null, 2));
fs.writeFileSync(path.join(OUT_DIR, 'recipes-project-rejected.json'), JSON.stringify(rejectedRows, null, 2));
if (unclassifiedRows.length) {
  fs.writeFileSync(path.join(OUT_DIR, 'recipes-project-unclassified.json'), JSON.stringify(unclassifiedRows, null, 2));
}

writeCsv(path.join(OUT_DIR, 'recipes-project-approved.csv'), approvedRows, ['title', 'protein', 'description', 'servings', 'time', 'calories', 'protein_note', 'source_conversation_id', 'source_conversation_title', 'review_status', 'raw_text']);
writeCsv(path.join(OUT_DIR, 'recipes-project-approved-current-schema.csv'), approvedCurrentSchema, ['title', 'protein', 'description', 'ingredients', 'instructions']);

console.log(JSON.stringify({
  total_rows: normalizedRows.length,
  approved_count: approvedRows.length,
  hold_count: holdRows.length,
  rejected_count: rejectedRows.length,
  unclassified_count: unclassifiedRows.length,
  kept_pancake: approvedRows.some((row) => row.normalized_title === 'protein pancakes recipe'),
}, null, 2));

