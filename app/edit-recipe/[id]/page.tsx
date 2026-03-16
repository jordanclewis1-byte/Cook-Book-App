"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import type { RecipeFormData } from "@/lib/types";

const proteinOptions = ["Chicken", "Beef", "Pork", "Turkey", "Fish", "Tofu", "Beans", "Other"];

const emptyForm: RecipeFormData = {
  title: "",
  protein: "Chicken",
  description: "",
  ingredients: "",
  instructions: ""
};

export default function EditRecipePage() {
  const params = useParams<{ id: string }>();
  const router = useRouter();
  const recipeId = params.id;

  const [formData, setFormData] = useState<RecipeFormData>(emptyForm);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState("");

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
        instructions: data.instructions
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

    const { error } = await supabase.from("recipes").update(formData).eq("id", recipeId);

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
          Protein
          <select
            value={formData.protein}
            onChange={(event) => setFormData({ ...formData, protein: event.target.value })}
          >
            {proteinOptions.map((option) => (
              <option key={option} value={option}>
                {option}
              </option>
            ))}
          </select>
        </label>

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
