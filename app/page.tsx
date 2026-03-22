"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { supabase } from "@/lib/supabase";
import type { Recipe } from "@/lib/types";

const categoryOptions = [
  "All",
  "Seafood",
  "Beans & Lentils",
  "Tofu",
  "Breakfast",
  "Side Dish",
  "Other"
];

const fishTypeDefinitions = [
  { label: "Cod", patterns: [/\bcod\b/] },
  { label: "Salmon", patterns: [/\bsalmon\b/] },
  { label: "Halibut", patterns: [/\bhalibut\b/] },
  { label: "Shrimp", patterns: [/\bshrimp\b/, /\bprawn(?:s)?\b/] },
  { label: "Tuna", patterns: [/\btuna\b/] },
  { label: "Pollock", patterns: [/\bpollock\b/] },
  { label: "Sablefish", patterns: [/\bsablefish\b/, /\bblack cod\b/] }
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
  const lines = text.split("\n");
  const items: string[] = [];

  for (const line of lines) {
    const cleaned = cleanLine(line.replace(/^\s*[-*]\s*/, ""));

    if (!cleaned || isIgnoredLine(cleaned)) {
      continue;
    }

    if (/^#{1,6}\s*/.test(cleaned) || /^\d+\.\s*/.test(cleaned)) {
      continue;
    }

    items.push(cleaned);
  }

  return items;
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

function getRecipeHaystack(recipe: Recipe) {
  return normalizeImportedText(
    [recipe.title, recipe.description, recipe.ingredients, recipe.instructions].join(" ")
  ).toLowerCase();
}

function getRecipeTitle(recipe: Recipe) {
  return normalizeImportedText(recipe.title).toLowerCase();
}

function isBreakfastRecipe(recipe: Recipe) {
  const title = getRecipeTitle(recipe);
  const description = normalizeImportedText(recipe.description).toLowerCase();
  return /(oats|oatmeal|pancake|breakfast|crepes|breakfast bowl)/.test(title) ||
    (/breakfast/.test(description) && /(ricotta|yogurt|oat|pancake|berries|egg)/.test(title + " " + description));
}

function isSideDishRecipe(recipe: Recipe) {
  const title = getRecipeTitle(recipe);
  const description = normalizeImportedText(recipe.description).toLowerCase();
  const haystack = getRecipeHaystack(recipe);

  if (/(fish|shrimp|prawn|tuna|cod|salmon|halibut|pollock|sablefish)/.test(title)) {
    return false;
  }

  if (/(cauliflower rice|brussels sprouts|lentil mash)/.test(title)) {
    return true;
  }

  if (/red lentils/.test(title) && !/(stew|curry|bake|casserole)/.test(title)) {
    return true;
  }

  return /(side dish|side ideas|serve alongside)/.test(title + " " + description + " " + haystack);
}

function isTofuRecipe(recipe: Recipe) {
  const haystack = getRecipeHaystack(recipe);
  return recipe.protein === "Tofu" || /tofu/.test(haystack);
}

function isBeansAndLentilsRecipe(recipe: Recipe) {
  const haystack = getRecipeHaystack(recipe);
  return recipe.protein === "Beans" || /(lentils|chickpeas|white bean|black bean|cannellini|butter beans|beans)/.test(haystack);
}

function isSeafoodRecipe(recipe: Recipe) {
  const haystack = getRecipeHaystack(recipe);
  return (
    recipe.protein === "Fish" ||
    /(fish|cod|salmon|halibut|shrimp|prawn|tuna|pollock|sablefish|seafood)/.test(haystack)
  );
}

function getRecipeCategory(recipe: Recipe) {
  if (isBreakfastRecipe(recipe)) {
    return "Breakfast";
  }

  if (isSideDishRecipe(recipe)) {
    return "Side Dish";
  }

  if (isTofuRecipe(recipe)) {
    return "Tofu";
  }

  if (isSeafoodRecipe(recipe)) {
    return "Seafood";
  }

  if (isBeansAndLentilsRecipe(recipe)) {
    return "Beans & Lentils";
  }

  return "Other";
}
function getFishTypes(recipe: Recipe) {
  if (recipe.protein !== "Fish") {
    return [] as string[];
  }

  const haystack = normalizeImportedText(
    [recipe.title, recipe.description, recipe.ingredients, recipe.instructions].join(" ")
  ).toLowerCase();

  return fishTypeDefinitions
    .filter((definition) => definition.patterns.some((pattern) => pattern.test(haystack)))
    .map((definition) => definition.label);
}

function matchesSearch(recipe: Recipe, searchText: string) {
  if (!searchText.trim()) {
    return true;
  }

  const haystack = normalizeImportedText(
    [recipe.title, recipe.description, recipe.ingredients, recipe.instructions].join(" ")
  ).toLowerCase();

  return haystack.includes(searchText.trim().toLowerCase());
}

export default function HomePage() {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [searchText, setSearchText] = useState("");
  const [categoryFilter, setCategoryFilter] = useState("All");
  const [fishTypeFilter, setFishTypeFilter] = useState("Any fish");
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

  const fishTypeOptions = useMemo(() => {
    const types = new Set<string>();

    for (const recipe of recipes) {
      for (const fishType of getFishTypes(recipe)) {
        types.add(fishType);
      }
    }

    return ["Any fish", ...Array.from(types).sort()];
  }, [recipes]);

  const isFishTypeFilterActive = categoryFilter === "Seafood" && fishTypeFilter !== "Any fish";

  const filteredRecipes = recipes.filter((recipe) => {
    const matchesCategory = categoryFilter === "All" || getRecipeCategory(recipe) === categoryFilter;
    const recipeFishTypes = getFishTypes(recipe);
    const matchesFishType = !isFishTypeFilterActive || recipeFishTypes.includes(fishTypeFilter);

    return matchesCategory && matchesFishType && matchesSearch(recipe, searchText);
  });

  return (
    <div className="stack">
      <section className="card stack">
        <div>
          <h2>Your recipes</h2>
          <p className="muted">
            Search by name, ingredient, or description. Filter by cookbook category, and narrow seafood recipes by fish type when useful.
          </p>
          <p className="muted">
            Showing {filteredRecipes.length} recipe{filteredRecipes.length === 1 ? "" : "s"}.
          </p>
        </div>

        <div className="search-row search-row-wide">
          <label className="field">
            Search
            <input
              placeholder="Try: soup, garlic, lentils..."
              value={searchText}
              onChange={(event) => setSearchText(event.target.value)}
            />
          </label>

          <label className="field">
            Category
            <select
              value={categoryFilter}
              onChange={(event) => setCategoryFilter(event.target.value)}
            >
              {categoryOptions.map((option) => (
                <option key={option} value={option}>
                  {option}
                </option>
              ))}
            </select>
          </label>

          <label className="field">
            Fish type
            <select
              value={fishTypeFilter}
              disabled={categoryFilter !== "Seafood"}
              onChange={(event) => setFishTypeFilter(event.target.value)}
            >
              {fishTypeOptions.map((option) => (
                <option key={option} value={option}>
                  {option}
                </option>
              ))}
            </select>
          </label>
        </div>

        <div className="button-row">
          <button
            className="button button-secondary"
            type="button"
            onClick={() => {
              setSearchText("");
              setCategoryFilter("All");
              setFishTypeFilter("Any fish");
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
          const fishTypes = getFishTypes(recipe);

          return (
            <article key={recipe.id} className="card recipe-card">
              <div className="recipe-card-header">
                <div className="tag-row">
                  <div className="protein-pill">Protein: {recipe.protein}</div>
                  <div className="category-pill">Category: {recipeCategory}</div>
                  {fishTypes.map((fishType) => (
                    <div key={`${recipe.id}-${fishType}`} className="fish-type-pill">
                      Fish type: {fishType}
                    </div>
                  ))}
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
