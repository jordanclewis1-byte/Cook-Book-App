import type { Recipe } from "@/lib/types";

export const categoryOptions = ["Lunch/Dinner", "Side Dish", "Breakfast", "Dessert"] as const;

export const proteinTypeOptions = [
  "Fish",
  "Shrimp",
  "Beans/Lentils",
  "Tofu",
  "Eggs",
  "Dairy",
  "Chicken",
  "None/Vegetable"
] as const;

export const fishSubtypeOptions = [
  "Cod",
  "Salmon",
  "Halibut",
  "Tuna",
  "Pollock",
  "Sablefish",
  "Generic Fish",
  "Shrimp"
] as const;

const fishSubtypeDefinitions = [
  { label: "Cod", patterns: [/\bcod\b/] },
  { label: "Salmon", patterns: [/\bsalmon\b/] },
  { label: "Halibut", patterns: [/\bhalibut\b/] },
  { label: "Tuna", patterns: [/\btuna\b/] },
  { label: "Pollock", patterns: [/\bpollock\b/] },
  { label: "Sablefish", patterns: [/\bsablefish\b/, /\bblack cod\b/] },
  { label: "Generic Fish", patterns: [/\bfish\b/, /\bwhite fish\b/] }
];

const mojibakeReplacements: Array<[string, string]> = [
  ["\u00e2\u20ac\u2122", "'"],
  ["\u00e2\u20ac\u0153", '"'],
  ["\u00e2\u20ac\ufffd", '"'],
  ["\u00e2\u20ac\u201c", "-"],
  ["\u00e2\u20ac\u201d", "-"],
  ["\u00e2\u20ac\u00a2", "-"],
  ["\u00e2\u20ac\u00a6", "..."],
  ["\u00c2\u00bd", "1/2"],
  ["\u00c2\u00bc", "1/4"],
  ["\u00c2\u00be", "3/4"],
  ["\u00c2\u00b0", " deg"],
  ["\u00c2", ""],
  ["\u00c3\u00a9", "e"],
  ["\u00c3", "a"],
  ["\u00f0\u0178\u2018\u2030", ""],
  ["\u00f0\u0178\u201c\u009d", ""],
  ["\u00f0\u0178\u2018\u00a9\u00e2\u20ac\u008d\u00f0\u0178\u008d\u00b3", ""]
];

function normalizeHeadingText(text: string) {
  return text.toLowerCase().replace(/[^a-z0-9]+/g, " ").trim();
}

function matchesHeading(normalizedHeading: string, targets: string[]) {
  return targets.some(
    (target) =>
      normalizedHeading === target ||
      normalizedHeading.startsWith(`${target} `) ||
      normalizedHeading.endsWith(` ${target}`) ||
      normalizedHeading.includes(` ${target} `)
  );
}

function extractSection(text: string, headings: string[]) {
  const lines = normalizeImportedText(text).split("\n");
  const targets = headings.map((heading) => normalizeHeadingText(heading));
  const sectionLines: string[] = [];
  let capture = false;
  let matchedHeadingLevel: number | null = null;

  for (const line of lines) {
    const headingMatch = line.match(/^(#{1,6})\s*(.*?)\s*$/);

    if (headingMatch) {
      const headingLevel = headingMatch[1].length;
      const normalizedHeading = normalizeHeadingText(headingMatch[2]);

      if (capture && matchedHeadingLevel !== null && headingLevel <= matchedHeadingLevel) {
        break;
      }

      if (matchesHeading(normalizedHeading, targets)) {
        capture = true;
        matchedHeadingLevel = headingLevel;
        continue;
      }

      if (capture) {
        sectionLines.push(line);
      }

      continue;
    }

    if (capture) {
      sectionLines.push(line);
    }
  }

  return sectionLines.join("\n").trim();
}

function extractIngredientSection(text: string) {
  const lines = normalizeImportedText(text).split("\n");
  const ingredientTargets = ["ingredients"].map((heading) => normalizeHeadingText(heading));
  const instructionTargets = ["instructions", "method", "directions", "how", "steps"].map((heading) =>
    normalizeHeadingText(heading)
  );
  const sectionLines: string[] = [];
  let capture = false;
  let matchedHeadingLevel: number | null = null;

  for (const line of lines) {
    const headingMatch = line.match(/^(#{1,6})\s*(.*?)\s*$/);

    if (headingMatch) {
      const headingLevel = headingMatch[1].length;
      const normalizedHeading = normalizeHeadingText(headingMatch[2]);

      if (!capture && matchesHeading(normalizedHeading, ingredientTargets)) {
        capture = true;
        matchedHeadingLevel = headingLevel;
        continue;
      }

      if (capture) {
        if (matchesHeading(normalizedHeading, instructionTargets) && matchedHeadingLevel !== null && headingLevel <= matchedHeadingLevel) {
          break;
        }

        sectionLines.push(line);
      }

      continue;
    }

    if (capture) {
      sectionLines.push(line);
    }
  }

  return sectionLines.join("\n").trim();
}

function extractPlainSection(text: string, headings: string[]) {
  const lines = normalizeImportedText(text).split("\n");
  const targets = headings.map((heading) => normalizeHeadingText(heading));
  const sectionLines: string[] = [];
  let capture = false;

  for (const line of lines) {
    const cleaned = cleanLine(line);

    if (!capture) {
      if (targets.includes(normalizeHeadingText(cleaned))) {
        capture = true;
      }

      continue;
    }

    if (!cleaned) {
      if (sectionLines.length > 0) {
        break;
      }

      continue;
    }

    if (/^#{1,6}\s*/.test(cleaned) || cleaned === "---") {
      break;
    }

    if (targets.includes(normalizeHeadingText(cleaned))) {
      break;
    }

    sectionLines.push(line);
  }

  return sectionLines.join("\n").trim();
}

function isIgnoredLine(line: string) {
  const lower = line.toLowerCase();
  return [
    "why this works",
    "how to make",
    "how",
    "quick miso butter",
    "method",
    "tips",
    "main",
    "staples",
    "finish",
    "serve with",
    "optional upgrade"
  ].some((prefix) => lower === prefix || lower.startsWith(`${prefix}:`));
}

function cleanLine(line: string) {
  return line.replace(/\s{2,}/g, " ").trim();
}

export function normalizeImportedText(text: string) {
  let normalized = text.replace(/\r/g, "");

  for (const [from, to] of mojibakeReplacements) {
    normalized = normalized.replaceAll(from, to);
  }

  return normalized
    .replace(/^TO REVIEW:.*$/gim, "")
    .replace(/^Perfect\s+(?:-|\u2014).*$/gim, "")
    .replace(/^Would you like me to.*$/gim, "")
    .replace(/^### Want to optimize further[\s\S]*$/gim, "")
    .replace(/^### Want a direction[\s\S]*$/gim, "")
    .replace(/\*\((.*?)\)\*/g, "$1")
    .replace(/\*\*(.*?)\*\*/g, "$1")
    .replace(/\*(.*?)\*/g, "$1")
    .replace(/^---$/gm, "")
    .replace(/\n{3,}/g, "\n\n")
    .trim();
}

export function parseIngredientItems(text: string) {
  return text
    .split("\n")
    .map((line) => cleanLine(line.replace(/^\s*[-*]\s*/, "")))
    .filter(Boolean)
    .filter((line) => !/^(?:base\s+)?method:\s*/i.test(line))
    .filter((line) => !isIgnoredLine(line))
    .filter((line) => !/^#{1,6}\s*/.test(line))
    .filter((line) => !/^\d+\.\s*/.test(line));
}

export function parseInstructionItems(text: string) {
  const lines = text.split("\n");
  const items: string[] = [];
  let currentStep = "";
  let hasSeenNumberedStep = false;

  for (const line of lines) {
    const headingNumberedMatch = line.match(/^#{1,6}\s*(\d+)\.\s*(.*)$/);
    const numberedMatch = line.match(/^\s*(\d+)\.\s*(.*)$/);
    const bulletMatch = line.match(/^\s*[-*]\s*(.*)$/);
    const cleaned = cleanLine(line);

    if (!cleaned || isIgnoredLine(cleaned)) {
      continue;
    }

    if (headingNumberedMatch) {
      if (currentStep) {
        items.push(currentStep);
      }

      hasSeenNumberedStep = true;
      currentStep = cleanLine(headingNumberedMatch[2]);
      continue;
    }

    if (/^#{1,6}\s*/.test(cleaned)) {
      continue;
    }

    if (numberedMatch) {
      if (currentStep) {
        items.push(currentStep);
      }

      hasSeenNumberedStep = true;
      currentStep = cleanLine(numberedMatch[2]);
      continue;
    }

    const continuation = bulletMatch ? cleanLine(bulletMatch[1]) : cleaned;

    if (!continuation) {
      continue;
    }

    if (currentStep) {
      const joiner = /[:.]$/.test(currentStep) ? " " : ": ";
      currentStep = `${currentStep}${joiner}${continuation}`.trim();
    } else if (!hasSeenNumberedStep) {
      items.push(continuation);
    }
  }

  if (currentStep) {
    items.push(currentStep);
  }

  return items;
}

function getRecipeTitle(recipe: Pick<Recipe, "title">) {
  return normalizeImportedText(recipe.title).toLowerCase();
}

function getRecipeDescription(recipe: Pick<Recipe, "description">) {
  return normalizeImportedText(recipe.description).toLowerCase();
}

export function getRecipeHaystack(recipe: Pick<Recipe, "title" | "description" | "ingredients" | "instructions">) {
  return normalizeImportedText(
    [recipe.title, recipe.description, recipe.ingredients, recipe.instructions].join(" ")
  ).toLowerCase();
}

export function getIngredientItems(recipe: Pick<Recipe, "ingredients">) {
  const normalized = normalizeImportedText(recipe.ingredients);
  const section = extractIngredientSection(normalized) || extractSection(normalized, ["Ingredients"]);
  const sourceText = section || normalized;
  const withoutFinishSection = sourceText.replace(/\n#{1,6}\s*Finish\s*\n[\s\S]*$/i, "").trim();
  return parseIngredientItems(withoutFinishSection);
}

const instructionSectionHeadings = ["Instructions", "Method", "Directions", "How", "Steps"];

function getFallbackInstructionItems(text: string) {
  const normalized = normalizeImportedText(text);
  const items: string[] = [];

  for (const line of normalized.split("\n")) {
    const cleaned = cleanLine(line);
    const methodMatch = cleaned.match(/^(?:base\s+)?method:\s*(.+)$/i);

    if (methodMatch) {
      items.push(cleanLine(methodMatch[1]));
    }
  }

  for (const heading of ["Finish", "How to make"]) {
    const section = extractSection(normalized, [heading]) || extractPlainSection(normalized, [heading]);

    if (!section) {
      continue;
    }

    const parsedSection = parseInstructionItems(section);

    if (parsedSection.length > 0) {
      items.push(...parsedSection);
    } else {
      items.push(cleanLine(section));
    }
  }

  return Array.from(new Set(items.filter(Boolean)));
}

export function getInstructionItems(recipe: Pick<Recipe, "instructions">) {
  const normalized = normalizeImportedText(recipe.instructions);
  const section = extractSection(normalized, instructionSectionHeadings);
  const parsedFromSection = parseInstructionItems(section);

  if (parsedFromSection.length > 0) {
    return parsedFromSection;
  }

  const parsedFromWholeText = parseInstructionItems(normalized);
  const numberedLines = normalized
    .split("\n")
    .filter((line) => /^\s*\d+\.\s+/.test(line.trim())).length;

  if (numberedLines > 0) {
    return parsedFromWholeText;
  }

  return getFallbackInstructionItems(normalized);
}

export function getMetaItems(recipe: Pick<Recipe, "servings" | "time_text" | "calories_text" | "protein_text">) {
  return [
    recipe.servings ? `Servings: ${recipe.servings}` : null,
    recipe.time_text ? `Time: ${recipe.time_text}` : null,
    recipe.calories_text ? `Calories: ${normalizeImportedText(recipe.calories_text)}` : null,
    recipe.protein_text ? `Protein: ${normalizeImportedText(recipe.protein_text)}` : null
  ].filter(Boolean) as string[];
}

function getProteinSourceText(recipe: Pick<Recipe, "title" | "ingredients">) {
  return [getRecipeTitle(recipe), ...getIngredientItems(recipe).map((item) => item.toLowerCase())].join(" ");
}

function inferProteinTypes(recipe: Pick<Recipe, "title" | "description" | "ingredients" | "protein">) {
  const title = getRecipeTitle(recipe);
  const description = getRecipeDescription(recipe);
  const proteinSourceText = getProteinSourceText(recipe);
  const proteinTypes = new Set<string>();

  if (/\bshrimp\b|\bprawn(?:s)?\b/.test(title) || /\bshrimp\b|\bprawn(?:s)?\b/.test(proteinSourceText)) {
    proteinTypes.add("Shrimp");
  }

  if (/(\bfish\b|cod|salmon|halibut|tuna|pollock|sablefish|seafood)/.test(title)) {
    proteinTypes.add("Fish");
  }

  if (/(\bfish\b|cod|salmon|halibut|tuna|pollock|sablefish|seafood)/.test(proteinSourceText)) {
    proteinTypes.add("Fish");
  }

  if (/\btofu\b/.test(title) || /\btofu\b/.test(proteinSourceText) || recipe.protein === "Tofu") {
    proteinTypes.add("Tofu");
  }

  if (/\bchicken\b/.test(title) || /\bchicken\b/.test(proteinSourceText) || recipe.protein === "Chicken") {
    proteinTypes.add("Chicken");
  }

  if (
    /(lentils|chickpeas|white bean|black bean|cannellini|butter beans|beans\b)/.test(title) ||
    /(lentils|chickpeas|white bean|black bean|cannellini|butter beans|beans\b)/.test(proteinSourceText) ||
    recipe.protein === "Beans"
  ) {
    proteinTypes.add("Beans/Lentils");
  }

  if (/(egg white|egg whites|whole egg|eggs\b|crepes)/.test(`${title} ${proteinSourceText}`)) {
    proteinTypes.add("Eggs");
  }

  if (
    /(dessert style|breakfast bowl|ricotta|cottage cheese|greek yogurt|yogurt|cheesecake)/.test(
      `${title} ${description}`
    ) ||
    /(ricotta|cottage cheese|greek yogurt|yogurt|feta|mozzarella|cheesecake)/.test(proteinSourceText)
  ) {
    proteinTypes.add("Dairy");
  }

  if (proteinTypes.size === 0) {
    proteinTypes.add("None/Vegetable");
  }

  return Array.from(proteinTypes);
}

function inferFishSubtypes(recipe: Pick<Recipe, "title" | "ingredients" | "description" | "protein">) {
  const proteinTypes = inferProteinTypes(recipe);

  if (!proteinTypes.includes("Fish") && !proteinTypes.includes("Shrimp")) {
    return [] as string[];
  }

  const proteinSourceText = getProteinSourceText(recipe);
  const matches = fishSubtypeDefinitions
    .filter((definition) => definition.patterns.some((pattern) => pattern.test(proteinSourceText)))
    .map((definition) => definition.label);

  if (proteinTypes.includes("Shrimp") && !matches.includes("Shrimp")) {
    matches.push("Shrimp");
  }

  return matches.length > 0 ? matches : proteinTypes.includes("Fish") ? ["Generic Fish"] : ["Shrimp"];
}

function inferCategory(recipe: Pick<Recipe, "title" | "description">) {
  const title = getRecipeTitle(recipe);
  const description = getRecipeDescription(recipe);
  const text = `${title} ${description}`;

  if (/(dessert|dessert style|cheesecake mousse|mousse)/.test(text)) {
    return "Dessert";
  }

  if (/(oats|oatmeal|pancake|breakfast|crepes|breakfast bowl)/.test(title)) {
    return "Breakfast";
  }

  if (/(fish|shrimp|prawn|tuna|cod|salmon|halibut|pollock|sablefish|chicken|tofu)/.test(title)) {
    return "Lunch/Dinner";
  }

  if (/(cauliflower rice|brussels sprouts|lentil mash)/.test(title)) {
    return "Side Dish";
  }

  if (/\bred lentils\b/.test(title) && !/(stew|curry|bake|casserole)/.test(title)) {
    return "Side Dish";
  }

  if (/(side dish|side ideas|serve alongside)/.test(text)) {
    return "Side Dish";
  }

  return "Lunch/Dinner";
}

function normalizeStoredList(values: string[] | null | undefined) {
  return (values ?? []).filter(Boolean);
}

export function getRecipeCategory(recipe: Pick<Recipe, "title" | "description" | "category">) {
  return recipe.category || inferCategory(recipe);
}

export function getProteinTypes(recipe: Pick<Recipe, "title" | "description" | "ingredients" | "protein" | "protein_types">) {
  const stored = normalizeStoredList(recipe.protein_types);
  return stored.length > 0 ? stored : inferProteinTypes(recipe);
}

export function getFishSubtypes(
  recipe: Pick<Recipe, "title" | "description" | "ingredients" | "protein" | "protein_types" | "fish_subtypes">
) {
  const proteinTypes = getProteinTypes(recipe);

  if (!proteinTypes.includes("Fish") && !proteinTypes.includes("Shrimp")) {
    return [] as string[];
  }

  const stored = normalizeStoredList(recipe.fish_subtypes);
  return stored.length > 0 ? stored : inferFishSubtypes(recipe);
}

export function getLegacyProteinValue(proteinTypes: string[]) {
  if (proteinTypes.includes("Chicken")) {
    return "Chicken";
  }

  if (proteinTypes.includes("Fish") || proteinTypes.includes("Shrimp")) {
    return "Fish";
  }

  if (proteinTypes.includes("Tofu")) {
    return "Tofu";
  }

  if (proteinTypes.includes("Beans/Lentils")) {
    return "Beans";
  }

  return "Other";
}
