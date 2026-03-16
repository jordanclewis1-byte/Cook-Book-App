# Next Steps

## Current state

Jordan's Cookbook is currently a simple Next.js + Supabase app with basic recipe maintenance.

What it does now:

- Shows recipes from the `recipes` table.
- Supports keyword search across recipe text.
- Supports filtering by protein.
- Lets you add recipes from a form.
- Lets you edit existing recipes.
- Lets you delete recipes.

Current architecture:

- Frontend: Next.js App Router
- Database/backend: Supabase
- Data access: browser-side Supabase client
- Main table: `public.recipes`

Known limitations:

- No authentication
- No tags or richer categories
- No recipe photos
- Public read/insert/update/delete policies are still very open for an MVP

## Recommended next features

1. Add tags or better categories
2. Improve the add recipe form
3. Improve the recipe card UI
4. Add recipe photos
5. Add authentication later if needed

## Suggested immediate next task

The most practical next step is to add tags or better categories so recipes can be grouped beyond protein alone.

## Session note

When a major milestone is completed, add a short dated note here and a fuller explanation in `PROJECT_HISTORY.md` so future sessions can recover context from the repo instead of searching Codex session logs.
