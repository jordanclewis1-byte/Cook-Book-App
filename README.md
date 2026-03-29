# Jordan's Cookbook

A personal cookbook app built with Next.js and Supabase for browsing, cleaning up, and maintaining recipes imported from a ChatGPT recipe project plus manually added recipes.

## Project Memory

If you are resuming work after a gap, start with:

- `PROJECT_HISTORY.md`
- `NEXT_STEPS.md`

Those files are the durable session memory for this repo.

## Current App Status

The app is past the original MVP and now supports:

1. Browsing recipes from Supabase on the home page
2. Keyword search across recipe title, description, ingredients, and instructions
3. Meal-category filtering with `Lunch/Dinner`, `Side Dish`, `Breakfast`, and `Dessert`
4. Protein-type filtering with multi-select metadata
5. Fish subtype filtering for seafood recipes
6. Adding new recipes
7. Editing existing recipes
8. Deleting recipes
9. Cleaner rendering of imported recipes with parsed ingredients, instructions, and metadata pills

The app still has no authentication and still uses a simple browser-side Supabase client for CRUD.

## Current Data Model

The main table is `public.recipes`.

Important fields currently used by the app:

- Core recipe fields: `title`, `description`, `ingredients`, `instructions`
- Legacy compatibility field: `protein`
- Structured metadata fields: `category`, `protein_types`, `fish_subtypes`
- Imported metadata fields: `servings`, `time_text`, `calories_text`, `protein_text`
- Import audit fields: `source_type`, `source_conversation_id`, `raw_import_text`

The app prefers the structured metadata fields when they exist and falls back to shared inference logic for older rows.

There is also a staging/audit table, `public.recipe_imports`, used during the ChatGPT recipe import workflow.

## Project Structure

- `app/page.tsx`
  Home page that loads recipes, applies search/filter state, and renders cleaned recipe cards.

- `app/add-recipe/page.tsx`
  Add form for creating recipes with category, protein type, and optional fish subtype metadata.

- `app/edit-recipe/[id]/page.tsx`
  Edit form for updating recipes and structured metadata.

- `app/layout.tsx`
  Shared page shell and navigation.

- `app/globals.css`
  Global styling for the app.

- `lib/supabase.ts`
  Shared browser-side Supabase client.

- `lib/types.ts`
  Shared TypeScript recipe types.

- `lib/recipe-metadata.ts`
  Shared cleanup, parsing, and classification helpers for imported and manually entered recipes.

- `supabase/schema.sql`
  Base schema and setup SQL for the cookbook app.

- `supabase/recipe_metadata_backfill.sql`
  Backfill SQL for adding and populating structured metadata on existing live rows.

- `supabase/recipe_imports_load.sql`
  Helper SQL for loading staged recipe-import rows.

- `supabase/recipe_imports_load_approved.sql`
  Helper SQL for loading the approved import set into staging.

- `data-import/`
  Checked-in import artifacts, review outputs, approved recipe sets, and hold-resolution files.

- `scripts/dev-status.ps1`
  Checks whether the local dev server is healthy, stale, or missing.

- `scripts/dev-reset.ps1`
  Stops stale processes on port `3000`, clears `.next`, and starts a clean dev server.

## Local Setup

### 1. Install dependencies

```bash
npm install
```

### 2. Configure Supabase

Create a Supabase project, then run the SQL from `supabase/schema.sql` in the Supabase SQL Editor.

If you already have the cookbook project set up, keep using that same project and schema.

### 3. Add environment variables

Copy `.env.local.example` to `.env.local` and set:

```bash
NEXT_PUBLIC_SUPABASE_URL=your-real-project-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-real-anon-key
```

Use the publishable/anon key here, not a secret service-role key.

### 4. Start the app

```bash
npm run dev
```

Then open [http://localhost:3000](http://localhost:3000).

If the dev server looks unhealthy or stale, use:

```bash
npm run dev:status
```

If needed, reset it with:

```bash
npm run dev:reset
```

## Import Workflow Notes

The repo includes a staged ChatGPT recipe import workflow. Important points:

- Reviewed and approved import artifacts live in `data-import/`
- The staging table is `public.recipe_imports`
- Approved rows are loaded into `public.recipes`
- Two hold recipes are still unresolved because their extracted steps were incomplete

The current app already displays imported recipes much more cleanly than the raw source text, but some live rows may still need manual cleanup.

## Known Limitations

- No authentication
- Public CRUD policies are still very open for MVP convenience
- Some older live rows still depend on UI fallback heuristics until `supabase/recipe_metadata_backfill.sql` is run
- Some imported rows may still contain duplicated raw text in `ingredients` and `instructions`
- No recipe photos yet
- Supabase MCP is configured locally but not authenticated in Codex right now

## Recommended Next Steps

1. Run `supabase/recipe_metadata_backfill.sql` in Supabase.
2. Spot-check breakfast and seafood recipes after the backfill.
3. Clean up imported rows whose ingredients and instructions still duplicate raw blobs.
4. Keep `PROJECT_HISTORY.md` and `NEXT_STEPS.md` updated at each major milestone.
