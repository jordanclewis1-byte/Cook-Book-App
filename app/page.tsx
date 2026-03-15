"use client";

import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import type { Recipe } from "@/lib/types";

const proteinOptions = ["All", "Chicken", "Beef", "Pork", "Turkey", "Fish", "Tofu", "Beans", "Other"];

export default function HomePage() {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [searchText, setSearchText] = useState("");
  const [proteinFilter, setProteinFilter] = useState("All");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadRecipes() {
      setLoading(true);
      setError("");

      const query = supabase
        .from("recipes")
        .select("*")
        .order("title", { ascending: true });

      if (proteinFilter !== "All") {
        query.eq("protein", proteinFilter);
      }

      if (searchText.trim()) {
        query.or(
          `title.ilike.%${searchText}%,description.ilike.%${searchText}%,ingredients.ilike.%${searchText}%`
        );
      }

      const { data, error } = await query;

      if (error) {
        setError(error.message);
        setRecipes([]);
      } else {
        setRecipes(data ?? []);
      }

      setLoading(false);
    }

    loadRecipes();
  }, [proteinFilter, searchText]);

  return (
    <div className="stack">
      <section className="card stack">
        <div>
          <h2>Your recipes</h2>
          <p className="muted">
            Search by name, ingredient, or description. You can also filter by protein.
          </p>
        </div>

        <div className="search-row">
          <label className="field">
            Search
            <input
              placeholder="Try: soup, garlic, pasta..."
              value={searchText}
              onChange={(event) => setSearchText(event.target.value)}
            />
          </label>

          <label className="field">
            Protein
            <select
              value={proteinFilter}
              onChange={(event) => setProteinFilter(event.target.value)}
            >
              {proteinOptions.map((option) => (
                <option key={option} value={option}>
                  {option}
                </option>
              ))}
            </select>
          </label>
        </div>
      </section>

      <section className="recipe-grid">
        {loading ? <div className="card">Loading recipes...</div> : null}
        {error ? <div className="card">Error: {error}</div> : null}
        {!loading && !error && recipes.length === 0 ? (
          <div className="card">No recipes found yet. Add your first one.</div>
        ) : null}

        {recipes.map((recipe) => (
          <article key={recipe.id} className="card recipe-card">
            <div className="protein-pill">{recipe.protein}</div>
            <h3>{recipe.title}</h3>
            <p>{recipe.description}</p>

            <div className="two-column">
              <div>
                <h4>Ingredients</h4>
                <p style={{ whiteSpace: "pre-line" }}>{recipe.ingredients}</p>
              </div>
              <div>
                <h4>Instructions</h4>
                <p style={{ whiteSpace: "pre-line" }}>{recipe.instructions}</p>
              </div>
            </div>
          </article>
        ))}
      </section>
    </div>
  );
}
