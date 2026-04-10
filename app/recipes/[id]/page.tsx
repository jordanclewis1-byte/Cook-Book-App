import Link from "next/link";
import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { supabase } from "@/lib/supabase";
import {
  getFishSubtypes,
  getIngredientItems,
  getInstructionItems,
  getMetaItems,
  getProteinTypes,
  getRecipeCategory,
  normalizeImportedText
} from "@/lib/recipe-metadata";
import RecipeActions from "@/components/RecipeActions";
import FavoriteButton from "@/components/FavoriteButton";

interface Props {
  params: Promise<{ id: string }>;
}

async function fetchRecipe(id: string) {
  const { data, error } = await supabase.from("recipes").select("*").eq("id", id).single();

  if (error || !data) {
    return null;
  }

  return data;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { id } = await params;
  const recipe = await fetchRecipe(id);

  if (!recipe) {
    return { title: "Recipe not found — Jordan's Cookbook" };
  }

  return {
    title: `${recipe.title} — Jordan's Cookbook`,
    description: normalizeImportedText(recipe.description),
    openGraph: {
      title: `${recipe.title} — Jordan's Cookbook`,
      description: normalizeImportedText(recipe.description),
      type: "article"
    }
  };
}

export default async function RecipePage({ params }: Props) {
  const { id } = await params;
  const recipe = await fetchRecipe(id);

  if (!recipe) {
    notFound();
  }

  const ingredientItems = getIngredientItems(recipe);
  const instructionItems = getInstructionItems(recipe);
  const metaItems = getMetaItems(recipe);
  const recipeCategory = getRecipeCategory(recipe);
  const proteinTypes = getProteinTypes(recipe);
  const fishSubtypes = getFishSubtypes(recipe);

  return (
    <div className="stack">
      <div className="button-row">
        <Link className="button button-secondary" href="/">
          ← Back to recipes
        </Link>
      </div>

      <article className="card stack">
        <div className="recipe-card-header">
          <div className="tag-row">
            <div className="category-pill">Category: {recipeCategory}</div>
            {proteinTypes.map((proteinType) => (
              <div key={proteinType} className="protein-pill">
                Protein: {proteinType}
              </div>
            ))}
            {(proteinTypes.includes("Fish") || proteinTypes.includes("Shrimp"))
              ? fishSubtypes.map((fishSubtype) => (
                  <div key={fishSubtype} className="fish-type-pill">
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

        <h2>{recipe.title}</h2>
        <p>{normalizeImportedText(recipe.description)}</p>

        <div className="two-column">
          <div>
            <h3>Ingredients</h3>
            <ul className="recipe-list">
              {ingredientItems.map((item, index) => (
                <li key={index}>{item}</li>
              ))}
            </ul>
          </div>
          <div>
            <h3>Instructions</h3>
            <ol className="recipe-list recipe-steps">
              {instructionItems.map((item, index) => (
                <li key={index}>{item}</li>
              ))}
            </ol>
          </div>
        </div>

        <div className="button-row">
          <FavoriteButton recipeId={recipe.id} />
          <RecipeActions recipeId={recipe.id} />
        </div>
      </article>
    </div>
  );
}
