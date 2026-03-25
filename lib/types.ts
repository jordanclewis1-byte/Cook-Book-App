export type Recipe = {
  id: string;
  title: string;
  protein: string;
  description: string;
  ingredients: string;
  instructions: string;
  category: string | null;
  protein_types: string[] | null;
  fish_subtypes: string[] | null;
  servings: string | null;
  time_text: string | null;
  calories_text: string | null;
  protein_text: string | null;
  source_type: string | null;
  source_conversation_id: string | null;
  raw_import_text: string | null;
  created_at: string;
};

export type RecipeFormData = Pick<
  Recipe,
  | "title"
  | "protein"
  | "description"
  | "ingredients"
  | "instructions"
  | "category"
  | "protein_types"
  | "fish_subtypes"
>;
