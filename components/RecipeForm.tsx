"use client";

import {
  categoryOptions,
  fishSubtypeOptions,
  proteinTypeOptions
} from "@/lib/recipe-metadata";
import { toggleValue } from "@/lib/recipe-form-utils";
import type { RecipeFormData } from "@/lib/types";

interface RecipeFormProps {
  formData: RecipeFormData;
  setFormData: (data: RecipeFormData) => void;
  saving: boolean;
  message: string;
  onSubmit: (event: React.FormEvent<HTMLFormElement>) => void;
  onCancel?: () => void;
  submitLabel: string;
}

export default function RecipeForm({
  formData,
  setFormData,
  saving,
  message,
  onSubmit,
  onCancel,
  submitLabel
}: RecipeFormProps) {
  const selectedProteinTypes = formData.protein_types ?? [];
  const selectedFishSubtypes = formData.fish_subtypes ?? [];
  const showsFishSubtypeField =
    selectedProteinTypes.includes("Fish") || selectedProteinTypes.includes("Shrimp");

  return (
    <form className="stack" onSubmit={onSubmit}>
      <label className="field">
        Recipe name
        <input
          required
          value={formData.title}
          onChange={(event) => setFormData({ ...formData, title: event.target.value })}
        />
      </label>

      <label className="field">
        Category
        <select
          value={formData.category ?? "Lunch/Dinner"}
          onChange={(event) => setFormData({ ...formData, category: event.target.value })}
        >
          {categoryOptions.map((option) => (
            <option key={option} value={option}>
              {option}
            </option>
          ))}
        </select>
      </label>

      <fieldset className="field option-group">
        <legend>Protein types</legend>
        <div className="checkbox-grid">
          {proteinTypeOptions.map((option) => (
            <label key={option} className="checkbox-option">
              <input
                type="checkbox"
                checked={selectedProteinTypes.includes(option)}
                onChange={() => {
                  const nextProteinTypes = toggleValue(selectedProteinTypes, option);
                  const withoutNone =
                    option === "None/Vegetable" && !selectedProteinTypes.includes(option)
                      ? ["None/Vegetable"]
                      : nextProteinTypes.filter((item) => item !== "None/Vegetable");
                  const normalizedProteinTypes =
                    withoutNone.length === 0 ? [] : Array.from(new Set(withoutNone));
                  const keepsFishSubtype =
                    normalizedProteinTypes.includes("Fish") || normalizedProteinTypes.includes("Shrimp");

                  setFormData({
                    ...formData,
                    protein_types: normalizedProteinTypes,
                    fish_subtypes: keepsFishSubtype ? selectedFishSubtypes : []
                  });
                }}
              />
              <span>{option}</span>
            </label>
          ))}
        </div>
      </fieldset>

      {showsFishSubtypeField ? (
        <fieldset className="field option-group">
          <legend>Fish subtypes</legend>
          <div className="checkbox-grid">
            {fishSubtypeOptions.map((option) => (
              <label key={option} className="checkbox-option">
                <input
                  type="checkbox"
                  checked={selectedFishSubtypes.includes(option)}
                  onChange={() =>
                    setFormData({
                      ...formData,
                      fish_subtypes: toggleValue(selectedFishSubtypes, option)
                    })
                  }
                />
                <span>{option}</span>
              </label>
            ))}
          </div>
        </fieldset>
      ) : null}

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

      <div className="button-row">
        <button className="button" type="submit" disabled={saving}>
          {saving ? "Saving..." : submitLabel}
        </button>
        {onCancel ? (
          <button className="button button-secondary" type="button" onClick={onCancel}>
            Cancel
          </button>
        ) : null}
      </div>

      {message ? <p>{message}</p> : null}
    </form>
  );
}
