-- Adds structured metadata fields to public.recipes and backfills them
-- using the same broad heuristics now shared by the app UI.

alter table public.recipes
  add column if not exists category text,
  add column if not exists protein_types text[] not null default '{}'::text[],
  add column if not exists fish_subtypes text[] not null default '{}'::text[];

with recipe_text as (
  select
    id,
    lower(coalesce(title, '')) as title_text,
    lower(coalesce(description, '')) as description_text,
    lower(coalesce(ingredients, '')) as ingredients_text,
    lower(coalesce(protein, '')) as protein_text_value
  from public.recipes
),
classified as (
  select
    id,
    case
      when concat_ws(' ', title_text, description_text) ~ '(dessert|dessert style|cheesecake mousse|mousse)' then 'Dessert'
      when title_text ~ '(oats|oatmeal|pancake|breakfast|crepes|breakfast bowl)' then 'Breakfast'
      when title_text ~ '(fish|shrimp|prawn|tuna|cod|salmon|halibut|pollock|sablefish|chicken|tofu)' then 'Lunch/Dinner'
      when title_text ~ '(cauliflower rice|brussels sprouts|lentil mash)' then 'Side Dish'
      when title_text ~ '\bred lentils\b' and title_text !~ '(stew|curry|bake|casserole)' then 'Side Dish'
      when concat_ws(' ', title_text, description_text) ~ '(side dish|side ideas|serve alongside)' then 'Side Dish'
      else 'Lunch/Dinner'
    end as category,
    array_remove(array[
      case
        when concat_ws(' ', title_text, ingredients_text) ~ '\b(shrimp|prawn|prawns)\b' then 'Shrimp'
      end,
      case
        when concat_ws(' ', title_text, ingredients_text) ~ '(fish|cod|salmon|halibut|tuna|pollock|sablefish|seafood)' then 'Fish'
      end,
      case
        when concat_ws(' ', title_text, ingredients_text) ~ '\btofu\b' or protein_text_value = 'tofu' then 'Tofu'
      end,
      case
        when concat_ws(' ', title_text, ingredients_text) ~ '\bchicken\b' or protein_text_value = 'chicken' then 'Chicken'
      end,
      case
        when concat_ws(' ', title_text, ingredients_text) ~ '(lentils|chickpeas|white bean|black bean|cannellini|butter beans|beans\b)'
          or protein_text_value = 'beans'
        then 'Beans/Lentils'
      end,
      case
        when concat_ws(' ', title_text, ingredients_text) ~ '(egg white|egg whites|whole egg|eggs\b|crepes)' then 'Eggs'
      end,
      case
        when concat_ws(' ', title_text, description_text, ingredients_text) ~
          '(dessert style|breakfast bowl|ricotta|cottage cheese|greek yogurt|yogurt|cheesecake|feta|mozzarella)'
        then 'Dairy'
      end
    ], null) as protein_types,
    array_remove(array[
      case when concat_ws(' ', title_text, ingredients_text) ~ '\bcod\b' then 'Cod' end,
      case when concat_ws(' ', title_text, ingredients_text) ~ '\bsalmon\b' then 'Salmon' end,
      case when concat_ws(' ', title_text, ingredients_text) ~ '\bhalibut\b' then 'Halibut' end,
      case when concat_ws(' ', title_text, ingredients_text) ~ '\btuna\b' then 'Tuna' end,
      case when concat_ws(' ', title_text, ingredients_text) ~ '\bpollock\b' then 'Pollock' end,
      case when concat_ws(' ', title_text, ingredients_text) ~ '\b(sablefish|black cod)\b' then 'Sablefish' end,
      case
        when concat_ws(' ', title_text, ingredients_text) ~ '\b(shrimp|prawn|prawns)\b' then 'Shrimp'
      end,
      case
        when concat_ws(' ', title_text, ingredients_text) ~ '\b(fish|white fish)\b'
          and concat_ws(' ', title_text, ingredients_text) !~ '\b(cod|salmon|halibut|tuna|pollock|sablefish|black cod)\b'
        then 'Generic Fish'
      end
    ], null) as fish_subtypes
  from recipe_text
)
update public.recipes as recipes
set
  category = classified.category,
  protein_types = case
    when cardinality(classified.protein_types) = 0 then array['None/Vegetable']::text[]
    else classified.protein_types
  end,
  fish_subtypes = case
    when cardinality(classified.protein_types) = 0 then '{}'::text[]
    when classified.protein_types && array['Fish', 'Shrimp']::text[] then
      case
        when cardinality(classified.fish_subtypes) = 0 and classified.protein_types @> array['Fish']::text[] then array['Generic Fish']::text[]
        when cardinality(classified.fish_subtypes) = 0 and classified.protein_types @> array['Shrimp']::text[] then array['Shrimp']::text[]
        else classified.fish_subtypes
      end
    else '{}'::text[]
  end,
  protein = case
    when classified.protein_types @> array['Chicken']::text[] then 'Chicken'
    when classified.protein_types && array['Fish', 'Shrimp']::text[] then 'Fish'
    when classified.protein_types @> array['Tofu']::text[] then 'Tofu'
    when classified.protein_types @> array['Beans/Lentils']::text[] then 'Beans'
    else 'Other'
  end
from classified
where recipes.id = classified.id;
