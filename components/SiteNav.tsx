"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { recipeWritesEnabled } from "@/lib/app-config";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth-context";

export default function SiteNav() {
  const { user, loading } = useAuth();
  const router = useRouter();

  async function handleSignOut() {
    await supabase.auth.signOut();
    router.push("/");
    router.refresh();
  }

  return (
    <nav className="nav-links">
      <Link href="/search">Recipes</Link>
      {recipeWritesEnabled && user ? <Link href="/add-recipe">Add Recipe</Link> : null}
      {loading ? null : user ? (
        <button className="button button-secondary nav-signout" type="button" onClick={handleSignOut}>
          Sign out
        </button>
      ) : (
        <Link href="/login">Sign in</Link>
      )}
    </nav>
  );
}
