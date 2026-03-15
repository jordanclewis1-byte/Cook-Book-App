"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

const proteinOptions = ["Chicken", "Beef", "Pork", "Turkey", "Fish", "Tofu", "Beans", "Other"];

const emptyForm = {
  title: "",
  protein: "Chicken",
  description: "",
  ingredients: "",
  instructions: ""
};

export default function AddRecipePage() {
  const router = useRouter();
  const [formData, setFormData] = useState(emptyForm);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState("");

  async function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setSaving(true);
    setMessage("");

    const { error } = await supabase.from("recipes").insert(formData);

    if (error) {
      setMessage(`Error: ${error.message}`);
      setSaving(false);
      return;
    }

    setMessage("Recipe saved.");
    setFormData(emptyForm);
    setSaving(false);
    router.push("/");
    router.refresh();
  }

  return (
    <section className="card stack">
      <div>
        <h2>Add a recipe</h2>
        <p className="muted">Keep this simple. Paste ingredients and instructions as plain text.</p>
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

        <button className="button" type="submit" disabled={saving}>
          {saving ? "Saving..." : "Save Recipe"}
        </button>

        {message ? <p>{message}</p> : null}
      </form>
    </section>
  );
}
