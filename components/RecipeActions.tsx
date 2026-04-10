"use client";

import { useRouter } from "next/navigation";
import Link from "next/link";
import { recipeWritesEnabled } from "@/lib/app-config";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth-context";
import { useState } from "react";

interface RecipeActionsProps {
  recipeId: string;
}

export default function RecipeActions({ recipeId }: RecipeActionsProps) {
  const router = useRouter();
  const { user } = useAuth();
  const [deleting, setDeleting] = useState(false);
  const [error, setError] = useState("");

  if (!recipeWritesEnabled || !user) {
    return null;
  }

  async function handleDelete() {
    const shouldDelete = window.confirm("Delete this recipe?");

    if (!shouldDelete) {
      return;
    }

    setDeleting(true);
    setError("");

    const { error } = await supabase.from("recipes").delete().eq("id", recipeId);

    if (error) {
      setError(error.message);
      setDeleting(false);
      return;
    }

    router.push("/");
    router.refresh();
  }

  return (
    <>
      <Link className="button button-secondary" href={`/edit-recipe/${recipeId}`}>
        Edit
      </Link>
      <button
        className="button button-danger"
        type="button"
        disabled={deleting}
        onClick={handleDelete}
      >
        {deleting ? "Deleting..." : "Delete"}
      </button>
      {error ? <p className="muted">{error}</p> : null}
    </>
  );
}
