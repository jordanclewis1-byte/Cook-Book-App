export type Recipe = {
  id: string;
  title: string;
  protein: string;
  description: string;
  ingredients: string;
  instructions: string;
  created_at: string;
};

export type RecipeFormData = Omit<Recipe, "id" | "created_at">;
