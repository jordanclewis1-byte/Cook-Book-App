"use client";

import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth-context";

interface FavoriteButtonProps {
  recipeId: string;
  // When provided (search page), skips the initial fetch.
  // When omitted (recipe page), fetches own state on mount.
  initialFavorited?: boolean;
  onToggle?: (recipeId: string, newFavorited: boolean) => void;
}

export default function FavoriteButton({
  recipeId,
  initialFavorited,
  onToggle
}: FavoriteButtonProps) {
  const { user } = useAuth();
  const [favorited, setFavorited] = useState(initialFavorited ?? false);
  const [busy, setBusy] = useState(false);

  // Fetch own state only when initialFavorited is not provided (recipe page).
  useEffect(() => {
    if (!user || initialFavorited !== undefined) {
      return;
    }

    supabase
      .from("favorites")
      .select("recipe_id")
      .eq("user_id", user.id)
      .eq("recipe_id", recipeId)
      .maybeSingle()
      .then(({ data }) => setFavorited(!!data));
  }, [user, recipeId, initialFavorited]);

  if (!user) {
    return null;
  }

  async function handleToggle() {
    if (!user || busy) {
      return;
    }

    const nextFavorited = !favorited;
    setFavorited(nextFavorited); // optimistic
    setBusy(true);

    let error;

    if (nextFavorited) {
      ({ error } = await supabase
        .from("favorites")
        .insert({ user_id: user.id, recipe_id: recipeId }));
    } else {
      ({ error } = await supabase
        .from("favorites")
        .delete()
        .eq("user_id", user.id)
        .eq("recipe_id", recipeId));
    }

    if (error) {
      setFavorited(!nextFavorited); // revert on error
    } else {
      onToggle?.(recipeId, nextFavorited);
    }

    setBusy(false);
  }

  return (
    <button
      className={`button favorite-button${favorited ? " favorite-button--active" : ""}`}
      type="button"
      disabled={busy}
      onClick={handleToggle}
      aria-label={favorited ? "Remove from favorites" : "Add to favorites"}
      title={favorited ? "Remove from favorites" : "Add to favorites"}
    >
      {favorited ? "♥" : "♡"}
    </button>
  );
}
