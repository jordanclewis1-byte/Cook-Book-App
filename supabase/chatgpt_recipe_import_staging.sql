create table if not exists public.recipe_imports (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  protein text,
  description text,
  servings text,
  time_text text,
  calories_text text,
  protein_text text,
  source_type text not null default 'chatgpt_export',
  source_conversation_id text,
  source_conversation_title text,
  raw_import_text text,
  review_status text not null default 'pending',
  created_at timestamptz not null default now()
);

alter table public.recipe_imports enable row level security;

drop policy if exists "Allow public read recipe imports" on public.recipe_imports;
drop policy if exists "Allow public insert recipe imports" on public.recipe_imports;
drop policy if exists "Allow public update recipe imports" on public.recipe_imports;
drop policy if exists "Allow public delete recipe imports" on public.recipe_imports;

create policy "Allow public read recipe imports"
on public.recipe_imports
for select
to anon
using (true);

create policy "Allow public insert recipe imports"
on public.recipe_imports
for insert
to anon
with check (true);

create policy "Allow public update recipe imports"
on public.recipe_imports
for update
to anon
using (true)
with check (true);

create policy "Allow public delete recipe imports"
on public.recipe_imports
for delete
to anon
using (true);

-- After review, you can move cleaned records into the main recipes table with a query like this:
-- insert into public.recipes (title, protein, description, ingredients, instructions)
-- select
--   title,
--   coalesce(protein, 'Other'),
--   coalesce(description, title),
--   raw_import_text,
--   raw_import_text
-- from public.recipe_imports
-- where review_status = 'approved';
