create extension if not exists "pgcrypto";

create table if not exists public.recipes (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  protein text not null,
  description text not null,
  ingredients text not null,
  instructions text not null,
  created_at timestamptz not null default now()
);

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

insert into public.recipes (title, protein, description, ingredients, instructions)
values
  (
    'Chicken Tacos',
    'Chicken',
    'Quick tacos for weeknights.',
    '- 1 lb chicken' || E'\n' || '- 1 taco seasoning packet' || E'\n' || '- Tortillas' || E'\n' || '- Toppings you like',
    '1. Cook the chicken.' || E'\n' || '2. Add seasoning.' || E'\n' || '3. Fill tortillas and serve.'
  ),
  (
    'Bean Chili',
    'Beans',
    'Simple vegetarian chili.',
    '- 2 cans beans' || E'\n' || '- 1 onion' || E'\n' || '- 1 can tomatoes' || E'\n' || '- Chili powder',
    '1. Cook onion.' || E'\n' || '2. Add everything else.' || E'\n' || '3. Simmer for 20 minutes.'
  );
