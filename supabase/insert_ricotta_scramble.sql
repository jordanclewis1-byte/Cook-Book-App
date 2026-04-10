-- Ricotta Scramble with Spinach & Herbs
-- Category: Breakfast | Protein: Eggs, Dairy
-- Run this in the Supabase SQL editor to add the recipe.

insert into public.recipes (
  title,
  protein,
  description,
  ingredients,
  instructions,
  category,
  protein_types,
  fish_subtypes
)
values (
  'Ricotta Scramble with Spinach & Herbs',
  'Other',
  'Soft scrambled eggs folded with creamy ricotta, wilted spinach, and fresh herbs. A quick, protein-rich breakfast.',
  E'- 3 eggs + 1/2 cup egg whites\n- 1/2 cup ricotta\n- Big handful spinach\n- Garlic, scallions, dill or chives',
  E'1. Sauté garlic and spinach until wilted.\n2. Add eggs and egg whites, scramble gently on low heat.\n3. Fold in ricotta at the end — do not overmix.\n4. Finish with herbs, salt, and pepper.',
  'Breakfast',
  array['Eggs', 'Dairy']::text[],
  '{}'::text[]
);
