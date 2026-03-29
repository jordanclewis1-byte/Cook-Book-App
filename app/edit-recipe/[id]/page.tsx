"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import { recipeWritesEnabled } from "@/lib/app-config";
import { supabase } from "@/lib/supabase";
import {
  categoryOptions,
  fishSubtypeOptions,
  getFishSubtypes,
  getLegacyProteinValue,
  getProteinTypes,
  getRecipeCategory,
  proteinTypeOptions
} from "@/lib/recipe-metadata";
import type { RecipeFormData } from "@/lib/types";

const emptyForm: RecipeFormData = {
  title: "",
  protein: "Other",
  description: "",
  ingredients: "",
  instructions: "",
  category: "Lunch/Dinner",
  protein_types: [],
  fish_subtypes: []
};

function toggleValue(values: string[], value: string) {
  return values.includes(value) ? values.filter((item) => item !== value) : [...values, value];
}

export default function EditRecipePage() {
  const params = useParams<{ id: string }>();
  const router = useRouter();
  const recipeId = params.id;

  const [formData, setFormData] = useState<RecipeFormData>(emptyForm);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState("");
  const selectedProteinTypes = formData.protein_types ?? [];
  const selectedFishSubtypes = formData.fish_subtypes ?? [];

  const showsFishSubtypeField =
    selectedProteinTypes.includes("Fish") || selectedProteinTypes.includes("Shrimp");

  if (!recipeWritesEnabled) {
    return (
      <section className="card stack">
        <div>
          <h2>Edit recipe</h2>
          <p className="muted">Recipe editing is disabled in this deployment.</p>
        </div>
        <div className="button-row">
          <Link className="button button-secondary" href="/">
            Back to recipes
          </Link>
        </div>
      </section>
    );
  }

  useEffect(() => {
    async function loadRecipe() {
      if (!recipeId) {
        setMessage("Recipe ID is missing.");
        setLoading(false);
        return;
      }

      setLoading(true);
      setMessage("");

      const { data, error } = await supabase
        .from("recipes")
        .select("*")
        .eq("id", recipeId)
        .single();

      if (error || !data) {
        setMessage(error?.message ?? "Recipe not found.");
        setLoading(false);
        return;
      }

      setFormData({
        title: data.title,
        protein: data.protein,
        description: data.description,
        ingredients: data.ingredients,
        instructions: data.instructions,
        category: getRecipeCategory(data),
        protein_types: getProteinTypes(data),
        fish_subtypes: getFishSubtypes(data)
      });
      setLoading(false);
    }

    loadRecipe();
  }, [recipeId]);

  async function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();

    if (!recipeId) {
      setMessage("Recipe ID is missing.");
      return;
    }

    setSaving(true);
    setMessage("");

    const normalizedProteinTypes = selectedProteinTypes.length > 0 ? selectedProteinTypes : ["None/Vegetable"];
    const normalizedFishSubtypes =
      showsFishSubtypeField && selectedFishSubtypes.length > 0 ? selectedFishSubtypes : [];

    const payload: RecipeFormData = {
      ...formData,
      protein: getLegacyProteinValue(normalizedProteinTypes),
      protein_types: normalizedProteinTypes,
      fish_subtypes: normalizedFishSubtypes
    };

    const { error } = await supabase.from("recipes").update(payload).eq("id", recipeId);

    if (error) {
      setMessage(`Error: ${error.message}`);
      setSaving(false);
      return;
    }

    router.push("/");
    router.refresh();
  }

  if (loading) {
    return <section className="card">Loading recipe...</section>;
  }

  return (
    <section className="card stack">
      <div>
        <h2>Edit recipe</h2>
        <p className="muted">Update the saved recipe details and return to the main list.</p>
      </div>

      <form className="stack" onSubmit={handleSubmit}>
        <label className="field">
          Recipe name
          <input
            required
            value={formData.title}
            onChange={(event) => setFormData({ ...formData, title: event.target.value })}
          />
        </label>

        <label className="field">
          Category
          <select
            value={formData.category ?? "Lunch/Dinner"}
            onChange={(event) => setFormData({ ...formData, category: event.target.value })}
          >
            {categoryOptions.map((option) => (
              <option key={option} value={option}>
                {option}
              </option>
            ))}
          </select>
        </label>

        <fieldset className="field option-group">
          <legend>Protein types</legend>
          <div className="checkbox-grid">
            {proteinTypeOptions.map((option) => (
              <label key={option} className="checkbox-option">
                <input
                  type="checkbox"
                  checked={selectedProteinTypes.includes(option)}
                  onChange={() => {
                    const nextProteinTypes = toggleValue(selectedProteinTypes, option);
                    const withoutNone =
                      option === "None/Vegetable" && !selectedProteinTypes.includes(option)
                        ? ["None/Vegetable"]
                        : nextProteinTypes.filter((item) => item !== "None/Vegetable");
                    const normalizedProteinTypes =
                      withoutNone.length === 0 ? [] : Array.from(new Set(withoutNone));
                    const keepsFishSubtype =
                      normalizedProteinTypes.includes("Fish") || normalizedProteinTypes.includes("Shrimp");

                    setFormData({
                      ...formData,
                      protein_types: normalizedProteinTypes,
                      fish_subtypes: keepsFishSubtype ? selectedFishSubtypes : []
                    });
                  }}
                />
                <span>{option}</span>
              </label>
            ))}
          </div>
        </fieldset>

        {showsFishSubtypeField ? (
          <fieldset className="field option-group">
            <legend>Fish subtypes</legend>
            <div className="checkbox-grid">
              {fishSubtypeOptions.map((option) => (
                <label key={option} className="checkbox-option">
                  <input
                    type="checkbox"
                    checked={selectedFishSubtypes.includes(option)}
                    onChange={() =>
                      setFormData({
                        ...formData,
                        fish_subtypes: toggleValue(selectedFishSubtypes, option)
                      })
                    }
                  />
                  <span>{option}</span>
                </label>
              ))}
            </div>
          </fieldset>
        ) : null}

        <label className="field">
          Short description
          <input
            required
            value={formData.description}
            onChange={(event) => setFormData({ ...formData, description: event.target.value })}
          />
        </label>

        <label className="field">
          Ingredients
          <textarea
            required
            value={formData.ingredients}
            onChange={(event) => setFormData({ ...formData, ingredients: event.target.value })}
          />
        </label>

        <label className="field">
          Instructions
          <textarea
            required
            value={formData.instructions}
            onChange={(event) => setFormData({ ...formData, instructions: event.target.value })}
          />
        </label>

        <div className="button-row">
          <button className="button" type="submit" disabled={saving}>
            {saving ? "Saving..." : "Save Changes"}
          </button>
          <button className="button button-secondary" type="button" onClick={() => router.push("/")}>
            Cancel
          </button>
        </div>

        {message ? <p>{message}</p> : null}
      </form>
    </section>
  );
}
