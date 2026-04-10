"use client";

import { Suspense, useEffect, useMemo, useState } from "react";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { recipeWritesEnabled } from "@/lib/app-config";
import { useAuth } from "@/lib/auth-context";
import { supabase } from "@/lib/supabase";
import {
  categoryOptions,
  getFishSubtypes,
  getIngredientItems,
  getInstructionItems,
  getMetaItems,
  getProteinTypes,
  getRecipeCategory,
  getRecipeHaystack,
  normalizeImportedText,
  proteinTypeOptions
} from "@/lib/recipe-metadata";
import FavoriteButton from "@/components/FavoriteButton";
import type { Recipe } from "@/lib/types";

const categoryFilterOptions = ["All", ...categoryOptions];
const proteinFilterOptions = ["Any Protein", ...proteinTypeOptions];

function matchesSearch(recipe: Recipe, searchText: string) {
  if (!searchText.trim()) {
    return true;
  }

  return getRecipeHaystack(recipe).includes(searchText.trim().toLowerCase());
}

function SearchResults() {
  const searchParams = useSearchParams();
  const initialQuery = searchParams.get("q") ?? "";
  const initialCategory = searchParams.get("category") ?? "All";
  const { user } = useAuth();
  const canWrite = recipeWritesEnabled && !!user;

  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [favoriteIds, setFavoriteIds] = useState<Set<string>>(new Set());
  const [searchText, setSearchText] = useState(initialQuery);
  const [categoryFilter, setCategoryFilter] = useState(initialCategory);
  const [proteinTypeFilter, setProteinTypeFilter] = useState("Any Protein");
  const [fishSubtypeFilter, setFishSubtypeFilter] = useState("Any Fish");
  const [favoritesOnly, setFavoritesOnly] = useState(false);
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

  // Load favorites whenever the user changes (login/logout).
  useEffect(() => {
    if (!user) {
      setFavoriteIds(new Set());
      setFavoritesOnly(false);
      return;
    }

    supabase
      .from("favorites")
      .select("recipe_id")
      .eq("user_id", user.id)
      .then(({ data }) => {
        setFavoriteIds(new Set(data?.map((f) => f.recipe_id) ?? []));
      });
  }, [user]);

  function handleFavoriteToggle(recipeId: string, newFavorited: boolean) {
    setFavoriteIds((prev) => {
      const next = new Set(prev);
      if (newFavorited) {
        next.add(recipeId);
      } else {
        next.delete(recipeId);
      }
      return next;
    });
  }

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

    setRecipes((current) => current.filter((r) => r.id !== recipeId));
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
    (proteinTypeFilter === "Fish" || proteinTypeFilter === "Shrimp") &&
    fishSubtypeFilter !== "Any Fish";

  const filteredRecipes = recipes.filter((recipe) => {
    const matchesCategory =
      categoryFilter === "All" || getRecipeCategory(recipe) === categoryFilter;
    const proteinTypes = getProteinTypes(recipe);
    const matchesProteinType =
      proteinTypeFilter === "Any Protein" || proteinTypes.includes(proteinTypeFilter);
    const matchesFishSubtype =
      !isFishSubtypeFilterActive || getFishSubtypes(recipe).includes(fishSubtypeFilter);
    const matchesFavoritesOnly = !favoritesOnly || favoriteIds.has(recipe.id);

    return (
      matchesCategory &&
      matchesProteinType &&
      matchesFishSubtype &&
      matchesFavoritesOnly &&
      matchesSearch(recipe, searchText)
    );
  });

  return (
    <div className="stack">
      <section className="card stack">
        <div>
          <h2>Recipes</h2>
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
            <select
              value={categoryFilter}
              onChange={(event) => setCategoryFilter(event.target.value)}
            >
              {categoryFilterOptions.map((option) => (
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
              {proteinFilterOptions.map((option) => (
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
              <select
                value={fishSubtypeFilter}
                onChange={(event) => setFishSubtypeFilter(event.target.value)}
              >
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
          {user ? (
            <button
              className={`button${favoritesOnly ? "" : " button-secondary"}`}
              type="button"
              onClick={() => setFavoritesOnly((prev) => !prev)}
            >
              {favoritesOnly ? "♥ Favorites" : "♡ Favorites"}
            </button>
          ) : null}
          <button
            className="button button-secondary"
            type="button"
            onClick={() => {
              setSearchText("");
              setCategoryFilter("All");
              setProteinTypeFilter("Any Protein");
              setFishSubtypeFilter("Any Fish");
              setFavoritesOnly(false);
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

              <h3>
                <Link href={`/recipes/${recipe.id}`}>{recipe.title}</Link>
              </h3>
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
                <Link className="button button-secondary" href={`/recipes/${recipe.id}`}>
                  View Recipe
                </Link>
                <FavoriteButton
                  recipeId={recipe.id}
                  initialFavorited={favoriteIds.has(recipe.id)}
                  onToggle={handleFavoriteToggle}
                />
                {canWrite ? (
                  <>
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
                  </>
                ) : null}
              </div>
            </article>
          );
        })}
      </section>
    </div>
  );
}

export default function SearchPage() {
  return (
    <Suspense fallback={<div className="card">Loading...</div>}>
      <SearchResults />
    </Suspense>
  );
}
