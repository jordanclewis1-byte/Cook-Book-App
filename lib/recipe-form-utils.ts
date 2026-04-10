import { getLegacyProteinValue } from "@/lib/recipe-metadata";
import type { RecipeFormData } from "@/lib/types";

export const emptyForm: RecipeFormData = {
  title: "",
  protein: "Other",
  description: "",
  ingredients: "",
  instructions: "",
  category: "Lunch/Dinner",
  protein_types: [],
  fish_subtypes: []
};

export function toggleValue(values: string[], value: string): string[] {
  return values.includes(value) ? values.filter((item) => item !== value) : [...values, value];
}

export function normalizeFormPayload(
  formData: RecipeFormData,
  showsFishSubtypeField: boolean
): RecipeFormData {
  const selectedProteinTypes = formData.protein_types ?? [];
  const selectedFishSubtypes = formData.fish_subtypes ?? [];
  const normalizedProteinTypes =
    selectedProteinTypes.length > 0 ? selectedProteinTypes : ["None/Vegetable"];
  const normalizedFishSubtypes =
    showsFishSubtypeField && selectedFishSubtypes.length > 0 ? selectedFishSubtypes : [];

  return {
    ...formData,
    protein: getLegacyProteinValue(normalizedProteinTypes),
    protein_types: normalizedProteinTypes,
    fish_subtypes: normalizedFishSubtypes
  };
}
