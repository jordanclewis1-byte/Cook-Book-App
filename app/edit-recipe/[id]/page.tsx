"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { recipeWritesEnabled } from "@/lib/app-config";
import { supabase } from "@/lib/supabase";
import {
  getFishSubtypes,
  getProteinTypes,
  getRecipeCategory
} from "@/lib/recipe-metadata";
import { useAuth } from "@/lib/auth-context";
import { emptyForm, normalizeFormPayload } from "@/lib/recipe-form-utils";
import RecipeForm from "@/components/RecipeForm";
import type { RecipeFormData } from "@/lib/types";

export default function EditRecipePage() {
  const params = useParams<{ id: string }>();
  const router = useRouter();
  const recipeId = params.id;
  const { user, loading: authLoading } = useAuth();

  const [formData, setFormData] = useState<RecipeFormData>(emptyForm);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState("");

  useEffect(() => {
    if (!authLoading && (!user || !recipeWritesEnabled)) {
      router.replace(`/login?from=/edit-recipe/${recipeId}`);
    }
  }, [user, authLoading, recipeId, router]);

  useEffect(() => {
    if (!user) {
      return;
    }

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
  }, [recipeId, user]);

  async function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();

    if (!recipeId) {
      setMessage("Recipe ID is missing.");
      return;
    }

    setSaving(true);
    setMessage("");

    const selectedProteinTypes = formData.protein_types ?? [];
    const showsFishSubtypeField =
      selectedProteinTypes.includes("Fish") || selectedProteinTypes.includes("Shrimp");
    const payload = normalizeFormPayload(formData, showsFishSubtypeField);

    const { error } = await supabase.from("recipes").update(payload).eq("id", recipeId);

    if (error) {
      setMessage(`Error: ${error.message}`);
      setSaving(false);
      return;
    }

    router.push("/search");
    router.refresh();
  }

  if (authLoading || !user || loading) {
    return <section className="card">Loading recipe...</section>;
  }

  return (
    <section className="card stack">
      <div>
        <h2>Edit recipe</h2>
        <p className="muted">Update the saved recipe details and return to the main list.</p>
      </div>
      <RecipeForm
        formData={formData}
        setFormData={setFormData}
        saving={saving}
        message={message}
        onSubmit={handleSubmit}
        onCancel={() => router.push("/search")}
        submitLabel="Save Changes"
      />
    </section>
  );
}
