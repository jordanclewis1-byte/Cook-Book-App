"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { recipeWritesEnabled } from "@/lib/app-config";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth-context";
import { emptyForm, normalizeFormPayload } from "@/lib/recipe-form-utils";
import RecipeForm from "@/components/RecipeForm";
import type { RecipeFormData } from "@/lib/types";

export default function AddRecipePage() {
  const router = useRouter();
  const { user, loading } = useAuth();
  const [formData, setFormData] = useState<RecipeFormData>(emptyForm);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState("");

  useEffect(() => {
    if (!loading && (!user || !recipeWritesEnabled)) {
      router.replace("/login?from=/add-recipe");
    }
  }, [user, loading, router]);

  async function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setSaving(true);
    setMessage("");

    const selectedProteinTypes = formData.protein_types ?? [];
    const showsFishSubtypeField =
      selectedProteinTypes.includes("Fish") || selectedProteinTypes.includes("Shrimp");
    const payload = normalizeFormPayload(formData, showsFishSubtypeField);

    const { error } = await supabase.from("recipes").insert(payload);

    if (error) {
      setMessage(`Error: ${error.message}`);
      setSaving(false);
      return;
    }

    setMessage("Recipe saved.");
    setFormData(emptyForm);
    setSaving(false);
    router.push("/search");
    router.refresh();
  }

  if (loading || !user) {
    return <section className="card">Loading...</section>;
  }

  return (
    <section className="card stack">
      <div>
        <h2>Add a recipe</h2>
        <p className="muted">Keep this simple. Paste ingredients and instructions as plain text.</p>
      </div>
      <RecipeForm
        formData={formData}
        setFormData={setFormData}
        saving={saving}
        message={message}
        onSubmit={handleSubmit}
        submitLabel="Save Recipe"
      />
    </section>
  );
}
