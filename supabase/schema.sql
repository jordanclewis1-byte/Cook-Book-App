create extension if not exists "pgcrypto";

create table if not exists public.recipes (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  protein text not null,
  description text not null,
  ingredients text not null,
  instructions text not null,
  category text,
  protein_types text[] not null default '{}'::text[],
  fish_subtypes text[] not null default '{}'::text[],
  servings text,
  time_text text,
  calories_text text,
  protein_text text,
  source_type text,
  source_conversation_id text,
  raw_import_text text,
  created_at timestamptz not null default now()
);

alter table public.recipes
  add column if not exists category text,
  add column if not exists protein_types text[] not null default '{}'::text[],
  add column if not exists fish_subtypes text[] not null default '{}'::text[],
  add column if not exists servings text,
  add column if not exists time_text text,
  add column if not exists calories_text text,
  add column if not exists protein_text text,
  add column if not exists source_type text,
  add column if not exists source_conversation_id text,
  add column if not exists raw_import_text text;

alter table public.recipes enable row level security;

drop policy if exists "Allow public read recipes" on public.recipes;
drop policy if exists "Allow public insert recipes" on public.recipes;
drop policy if exists "Allow public update recipes" on public.recipes;
drop policy if exists "Allow public delete recipes" on public.recipes;

create policy "Allow public read recipes"
on public.recipes
for select
to anon
using (true);

create policy "Allow public insert recipes"
on public.recipes
for insert
to anon
with check (true);

create policy "Allow public update recipes"
on public.recipes
for update
to anon
using (true)
with check (true);

create policy "Allow public delete recipes"
on public.recipes
for delete
to anon
using (true);

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
values
  (
    'Chicken Tacos',
    'Chicken',
    'Quick tacos for weeknights.',
    '- 1 lb chicken' || E'\n' || '- 1 taco seasoning packet' || E'\n' || '- Tortillas' || E'\n' || '- Toppings you like',
    '1. Cook the chicken.' || E'\n' || '2. Add seasoning.' || E'\n' || '3. Fill tortillas and serve.',
    'Lunch/Dinner',
    array['Chicken']::text[],
    '{}'::text[]
  ),
  (
    'Bean Chili',
    'Beans',
    'Simple vegetarian chili.',
    '- 2 cans beans' || E'\n' || '- 1 onion' || E'\n' || '- 1 can tomatoes' || E'\n' || '- Chili powder',
    '1. Cook onion.' || E'\n' || '2. Add everything else.' || E'\n' || '3. Simmer for 20 minutes.',
    'Lunch/Dinner',
    array['Beans/Lentils']::text[],
    '{}'::text[]
  )
on conflict do nothing;
