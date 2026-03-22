"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { supabase } from "@/lib/supabase";
import type { Recipe } from "@/lib/types";

const categoryOptions = ["All", "Lunch/Dinner", "Side Dish", "Breakfast", "Dessert"];

const proteinTypeOptions = [
  "Any Protein",
  "Fish",
  "Shrimp",
  "Beans/Lentils",
  "Tofu",
  "Eggs",
  "Dairy",
  "Chicken",
  "None/Vegetable"
];

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

function normalizeImportedText(text: string) {
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

function normalizeHeadingText(text: string) {
  return text.toLowerCase().replace(/[^a-z0-9]+/g, " ").trim();
}

function extractSection(text: string, heading: string) {
  const lines = normalizeImportedText(text).split("\n");
  const target = normalizeHeadingText(heading);
  const sectionLines: string[] = [];
  let capture = false;

  for (const line of lines) {
    const headingMatch = line.match(/^#{1,6}\s*(.*?)\s*$/);

    if (headingMatch) {
      const normalizedHeading = normalizeHeadingText(headingMatch[1]);

      if (capture) {
        break;
      }

      if (normalizedHeading.startsWith(target)) {
        capture = true;
      }

      continue;
    }

    if (capture) {
      sectionLines.push(line);
    }
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

function parseIngredientItems(text: string) {
  return text
    .split("\n")
    .map((line) => cleanLine(line.replace(/^\s*[-*]\s*/, "")))
    .filter(Boolean)
    .filter((line) => !isIgnoredLine(line))
    .filter((line) => !/^#{1,6}\s*/.test(line))
    .filter((line) => !/^\d+\.\s*/.test(line));
}

function parseInstructionItems(text: string) {
  const lines = text.split("\n");
  const items: string[] = [];
  let currentStep = "";

  for (const line of lines) {
    const numberedMatch = line.match(/^\s*(\d+)\.\s*(.*)$/);
    const bulletMatch = line.match(/^\s*[-*]\s*(.*)$/);
    const cleaned = cleanLine(line);

    if (!cleaned || isIgnoredLine(cleaned) || /^#{1,6}\s*/.test(cleaned)) {
      continue;
    }

    if (numberedMatch) {
      if (currentStep) {
        items.push(currentStep);
      }

      currentStep = cleanLine(numberedMatch[2]);
      continue;
    }

    const continuation = bulletMatch ? cleanLine(bulletMatch[1]) : cleaned;

    if (!continuation) {
      continue;
    }

    if (currentStep) {
      currentStep = `${currentStep} ${continuation}`.trim();
    } else {
      items.push(continuation);
    }
  }

  if (currentStep) {
    items.push(currentStep);
  }

  return items;
}

function getIngredientItems(recipe: Recipe) {
  const normalized = normalizeImportedText(recipe.ingredients);
  const section = extractSection(normalized, "Ingredients");
  return parseIngredientItems(section || normalized);
}

function getInstructionItems(recipe: Recipe) {
  const normalized = normalizeImportedText(recipe.instructions);
  const section = extractSection(normalized, "Instructions");
  return parseInstructionItems(section || normalized);
}

function getMetaItems(recipe: Recipe) {
  return [
    recipe.servings ? `Servings: ${recipe.servings}` : null,
    recipe.time_text ? `Time: ${recipe.time_text}` : null,
    recipe.calories_text ? `Calories: ${normalizeImportedText(recipe.calories_text)}` : null,
    recipe.protein_text ? `Protein: ${normalizeImportedText(recipe.protein_text)}` : null
  ].filter(Boolean) as string[];
}

function getRecipeTitle(recipe: Recipe) {
  return normalizeImportedText(recipe.title).toLowerCase();
}

function getRecipeDescription(recipe: Recipe) {
  return normalizeImportedText(recipe.description).toLowerCase();
}

function getRecipeHaystack(recipe: Recipe) {
  return normalizeImportedText(
    [recipe.title, recipe.description, recipe.ingredients, recipe.instructions].join(" ")
  ).toLowerCase();
}

function getProteinSourceText(recipe: Recipe) {
  return [getRecipeTitle(recipe), ...getIngredientItems(recipe).map((item) => item.toLowerCase())].join(" ");
}

function getProteinTypes(recipe: Recipe) {
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

  if (/(lentils|chickpeas|white bean|black bean|cannellini|butter beans|beans\b)/.test(title) || /(lentils|chickpeas|white bean|black bean|cannellini|butter beans|beans\b)/.test(proteinSourceText) || recipe.protein === "Beans") {
    proteinTypes.add("Beans/Lentils");
  }

  if (/(egg white|egg whites|whole egg|eggs\b|crepes)/.test(title + " " + proteinSourceText)) {
    proteinTypes.add("Eggs");
  }

  if (/(dessert style|breakfast bowl|ricotta|cottage cheese|greek yogurt|yogurt|cheesecake)/.test(title + " " + description) || /(ricotta|cottage cheese|greek yogurt|yogurt|feta|mozzarella|cheesecake)/.test(proteinSourceText)) {
    proteinTypes.add("Dairy");
  }

  if (proteinTypes.size === 0) {
    proteinTypes.add("None/Vegetable");
  }

  return Array.from(proteinTypes);
}

function getFishSubtypes(recipe: Recipe) {
  const proteinTypes = getProteinTypes(recipe);

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

function getRecipeCategory(recipe: Recipe) {
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

function matchesSearch(recipe: Recipe, searchText: string) {
  if (!searchText.trim()) {
    return true;
  }

  return getRecipeHaystack(recipe).includes(searchText.trim().toLowerCase());
}

export default function HomePage() {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [searchText, setSearchText] = useState("");
  const [categoryFilter, setCategoryFilter] = useState("All");
  const [proteinTypeFilter, setProteinTypeFilter] = useState("Any Protein");
  const [fishSubtypeFilter, setFishSubtypeFilter] = useState("Any Fish");
  const [loading, setLoading] = useState(true);
  const [deletingId, setDeletingId] = useState<string | null>(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadRecipes() {
      setLoading(true);
      setError("");

      const { data, error } = await supabase
        .from("recipes")
        .select("*")
        .order("title", { ascending: true });

      if (error) {
        setError(error.message);
        setRecipes([]);
      } else {
        setRecipes(data ?? []);
      }

      setLoading(false);
    }

    loadRecipes();
  }, []);

  async function handleDelete(recipeId: string) {
    const shouldDelete = window.confirm("Delete this recipe?");

    if (!shouldDelete) {
      return;
    }

    setDeletingId(recipeId);
    setError("");

    const { error } = await supabase.from("recipes").delete().eq("id", recipeId);

    if (error) {
      setError(error.message);
      setDeletingId(null);
      return;
    }

    setRecipes((currentRecipes) => currentRecipes.filter((recipe) => recipe.id !== recipeId));
    setDeletingId(null);
  }

  const fishSubtypeOptions = useMemo(() => {
    const subtypes = new Set<string>();

    for (const recipe of recipes) {
      for (const fishSubtype of getFishSubtypes(recipe)) {
        subtypes.add(fishSubtype);
      }
    }

    return ["Any Fish", ...Array.from(subtypes).sort()];
  }, [recipes]);

  const isFishSubtypeFilterActive =
    (proteinTypeFilter === "Fish" || proteinTypeFilter === "Shrimp") && fishSubtypeFilter !== "Any Fish";

  const filteredRecipes = recipes.filter((recipe) => {
    const matchesCategory = categoryFilter === "All" || getRecipeCategory(recipe) === categoryFilter;
    const proteinTypes = getProteinTypes(recipe);
    const matchesProteinType =
      proteinTypeFilter === "Any Protein" || proteinTypes.includes(proteinTypeFilter);
    const matchesFishSubtype =
      !isFishSubtypeFilterActive || getFishSubtypes(recipe).includes(fishSubtypeFilter);

    return matchesCategory && matchesProteinType && matchesFishSubtype && matchesSearch(recipe, searchText);
  });

  return (
    <div className="stack">
      <section className="card stack">
        <div>
          <h2>Your recipes</h2>
          <p className="muted">
            Search by name, ingredient, or description. Filter by meal category and protein type.
          </p>
          <p className="muted">
            Showing {filteredRecipes.length} recipe{filteredRecipes.length === 1 ? "" : "s"}.
          </p>
        </div>

        <div className="search-row search-row-wide">
          <label className="field">
            Search
            <input
              placeholder="Try: soup, garlic, oats..."
              value={searchText}
              onChange={(event) => setSearchText(event.target.value)}
            />
          </label>

          <label className="field">
            Category
            <select value={categoryFilter} onChange={(event) => setCategoryFilter(event.target.value)}>
              {categoryOptions.map((option) => (
                <option key={option} value={option}>
                  {option}
                </option>
              ))}
            </select>
          </label>

          <label className="field">
            Protein Type
            <select
              value={proteinTypeFilter}
              onChange={(event) => {
                const nextProteinType = event.target.value;
                setProteinTypeFilter(nextProteinType);

                if (nextProteinType !== "Fish" && nextProteinType !== "Shrimp") {
                  setFishSubtypeFilter("Any Fish");
                }
              }}
            >
              {proteinTypeOptions.map((option) => (
                <option key={option} value={option}>
                  {option}
                </option>
              ))}
            </select>
          </label>
        </div>

        {proteinTypeFilter === "Fish" || proteinTypeFilter === "Shrimp" ? (
          <div className="search-row fish-subtype-row">
            <label className="field">
              Fish Subtype
              <select value={fishSubtypeFilter} onChange={(event) => setFishSubtypeFilter(event.target.value)}>
                {fishSubtypeOptions.map((option) => (
                  <option key={option} value={option}>
                    {option}
                  </option>
                ))}
              </select>
            </label>
          </div>
        ) : null}

        <div className="button-row">
          <button
            className="button button-secondary"
            type="button"
            onClick={() => {
              setSearchText("");
              setCategoryFilter("All");
              setProteinTypeFilter("Any Protein");
              setFishSubtypeFilter("Any Fish");
            }}
          >
            Clear filters
          </button>
        </div>
      </section>

      <section className="recipe-grid">
        {loading ? <div className="card">Loading recipes...</div> : null}
        {error ? <div className="card">Error: {error}</div> : null}
        {!loading && !error && filteredRecipes.length === 0 ? (
          <div className="card">No recipes match those filters yet.</div>
        ) : null}

        {filteredRecipes.map((recipe) => {
          const ingredientItems = getIngredientItems(recipe);
          const instructionItems = getInstructionItems(recipe);
          const metaItems = getMetaItems(recipe);
          const recipeCategory = getRecipeCategory(recipe);
          const proteinTypes = getProteinTypes(recipe);
          const fishSubtypes = getFishSubtypes(recipe);

          return (
            <article key={recipe.id} className="card recipe-card">
              <div className="recipe-card-header">
                <div className="tag-row">
                  <div className="category-pill">Category: {recipeCategory}</div>
                  {proteinTypes.map((proteinType) => (
                    <div key={`${recipe.id}-${proteinType}`} className="protein-pill">
                      Protein: {proteinType}
                    </div>
                  ))}
                  {proteinTypes.includes("Fish") || proteinTypes.includes("Shrimp")
                    ? fishSubtypes.map((fishSubtype) => (
                        <div key={`${recipe.id}-${fishSubtype}`} className="fish-type-pill">
                          Fish: {fishSubtype}
                        </div>
                      ))
                    : null}
                </div>
                {metaItems.length > 0 ? (
                  <div className="meta-row">
                    {metaItems.map((item) => (
                      <span key={item} className="meta-pill">
                        {item}
                      </span>
                    ))}
                  </div>
                ) : null}
              </div>
              <h3>{recipe.title}</h3>
              <p>{normalizeImportedText(recipe.description)}</p>

              <div className="two-column">
                <div>
                  <h4>Ingredients</h4>
                  <ul className="recipe-list">
                    {ingredientItems.map((item, index) => (
                      <li key={`${recipe.id}-ingredient-${index}`}>{item}</li>
                    ))}
                  </ul>
                </div>
                <div>
                  <h4>Instructions</h4>
                  <ol className="recipe-list recipe-steps">
                    {instructionItems.map((item, index) => (
                      <li key={`${recipe.id}-instruction-${index}`}>{item}</li>
                    ))}
                  </ol>
                </div>
              </div>

              <div className="button-row">
                <Link className="button button-secondary" href={`/edit-recipe/${recipe.id}`}>
                  Edit
                </Link>
                <button
                  className="button button-danger"
                  type="button"
                  disabled={deletingId === recipe.id}
                  onClick={() => handleDelete(recipe.id)}
                >
                  {deletingId === recipe.id ? "Deleting..." : "Delete"}
                </button>
              </div>
            </article>
          );
        })}
      </section>
    </div>
  );
}
