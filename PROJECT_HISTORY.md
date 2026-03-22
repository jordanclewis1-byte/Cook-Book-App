# Project History

## 2026-03-10: Original cookbook concept

You wanted a cookbook app that could organize recipes from your ChatGPT "Recipies" project, categorize them by protein source, place vegetable side dishes under `vegetables`, place breakfast dishes under `breakfast`, show calories for all dishes, show protein for main dishes, and support keyword search.

An early version of that idea was scaffolded as a simple browser app with local sample data and a JSON import path, intended to work even before a backend was in place.

## 2026-03-15: Jordan's Cookbook MVP

The project evolved into a small Next.js + Supabase app called `jordans-cookbook` in this repo.

### What We Learned

- A working web app needs more than code alone: it also needs dependencies, environment variables, a backend connection, and version control.
- Public browser apps should use the publishable/anon Supabase key, not a secret key in `NEXT_PUBLIC_*` variables.
- A simple product can still be full-stack if the frontend talks directly to a managed backend like Supabase.

### What Was Completed

- Created a simple App Router structure for the MVP.
- Added a home page to list recipes and filter/search them.
- Added an add-recipe page to insert new recipes.
- Added a shared Supabase client.
- Added a SQL schema to create the `recipes` table and seed sample data.
- Installed dependencies and confirmed the app could build.
- Upgraded Node to a modern version because the original runtime was too old.
- Connected the app to your existing Supabase project using public environment variables.
- Avoided using a secret key in `NEXT_PUBLIC_*`.
- Created the database table and policies in Supabase.
- Verified the backend connection and sample data.
- Got the local dev server running cleanly.
- Initialized git, made the first commit, connected GitHub, and pushed the project.

### Recommended Next Steps

- Add edit/delete recipe support.
- Improve recipe categories or tags.
- Clean up the add recipe form.
- Make the recipe cards easier to read.

## 2026-03-16: Recipe maintenance flow

The app was checked against the repo docs and confirmed to match the documented MVP: list recipes, search/filter by protein, and add new recipes through Supabase.

### What We Learned

- The MVP implementation matched the project docs closely enough that the next feature could be added without rework.
- Edit/delete support is the minimum feature set needed to make the cookbook maintainable over time.

### What Was Completed

- Added edit buttons from the main recipe list.
- Added a dedicated edit page for updating recipe fields.
- Added delete buttons from the main recipe list.
- Added Supabase update/delete policies to match the new UI.
- Updated the repo notes so future sessions can recover this new state quickly.

### Recommended Next Steps

- Add better categories or tags.
- Improve the add recipe form.
- Improve the recipe card UI.
- Add recipe photos later if useful.

## 2026-03-16: ChatGPT recipe import staging and first live import

A ChatGPT export zip was unpacked and analyzed to find the recipe project conversations. A likely recipe project wrapper was identified, the recipe conversations were extracted, cleaned, staged, and partially imported.

### What We Learned

- ChatGPT export recipe data is mixed quality: some rows are full recipes, some are multi-recipe conversations, and some are only tweaks or fragments.
- A staging table is the right pattern for this kind of import because it lets you review and filter rows before they reach the live table.
- Python is now installed locally and is useful for repeatable extraction and cleanup work in this repo.
- The imported recipe text needs UI cleanup because markdown-style symbols and assistant follow-up text do not display well in the app.
- Protein-only filtering is too narrow for a pescatarian cookbook.

### What Was Completed

- Preserved the last known-good app state with a GitHub commit before touching the export.
- Installed Python locally.
- Parsed the ChatGPT export and isolated 22 recipe-project conversations.
- Generated cleaned import artifacts in `data-import/`.
- Created and loaded `public.recipe_imports` in Supabase as a staging table.
- Expanded `public.recipes` with nullable metadata fields:
  - `servings`
  - `time_text`
  - `calories_text`
  - `protein_text`
  - `source_type`
  - `source_conversation_id`
  - `raw_import_text`
- Reviewed staged rows and approved a filtered subset for live import.
- Imported 16 approved ChatGPT-export recipes into `public.recipes`.
- Left 15 staged rows in `public.recipe_imports` with `review_status = 'needs_review'` for next time.

### Recommended Next Steps

1. Review the 15 remaining staged rows and decide which to approve, edit, or reject.
2. Clean up the recipe UI so imported markdown artifacts like `#` and `*` do not show in the app.
3. Update the filtering model to better reflect your pescatarian eating pattern.
4. Improve recipe readability by rendering cleaner lists and showing servings/time/calorie/protein metadata.
5. Add broader classification fields like tags, meal type, or course.

## 2026-03-20: Approved import set, hold resolution, and deduped live import

The staged ChatGPT import rows were reviewed in detail, converted into a cleaner approved set, and then loaded into the live recipes table with title-based deduplication.

### What We Learned

- `public.recipe_imports` is cumulative staging, so loading a new approved batch does not replace older approved rows.
- Title is the safest dedupe key for the current import because one `source_conversation_id` can legitimately produce multiple recipe rows.
- Hold rows fall into 2 clear buckets: recoverable editorial splits/merges and truly incomplete extracts that should stay out.
- The two still-incomplete hold rows are `One-Pan Halibut with Leeky Brown Rice` and `High-Protein Egg White Crepes with Ricotta & Berries` because their later steps are missing from the extract.
- Git and Python are both installed on this machine but are not reliably on the PowerShell PATH inside Codex, so explicit executable paths or inline Node scripts are safer during sessions.

### What Was Completed

- Reviewed the candidate import rows and documented decisions in `data-import/STAGING_REVIEW_2026-03-20.md`.
- Built a 34-recipe approved import set in `data-import/recipes-project-approved.*`.
- Kept the `Protein Pancakes Recipe` row in the approved set per user choice.
- Resolved most hold rows into clean candidate recipes in `data-import/recipes-project-hold-resolved-candidates.*`.
- Merged the reconstructed `Miso-Tahini Fish with Caramelized Onions` into the approved set.
- Merged `Whipped Ricotta Breakfast Bowl` into the approved set.
- Removed these resolved-hold recipes before merge, per user choice:
  - `Savory Oats with Smoked Salmon and Yogurt`
  - `Tropical Cream Oats`
  - `Egg-White Oatmeal (Creamy, Not Eggy)`
- Left only 2 unresolved hold rows in `data-import/recipes-project-hold-still-unresolved.json`.
- Generated `supabase/recipe_imports_load_approved.sql` for the approved staging load.
- Loaded the approved set into `public.recipe_imports`.
- Imported approved staging rows into `public.recipes` with a title-deduped insert so duplicate staging rows did not create duplicate live recipes.
- Verified there were 0 approved staging titles still missing from `public.recipes` after the import.

### Recommended Next Steps

1. Clean up the recipe UI so imported markdown artifacts and raw assistant formatting do not show in recipe cards.
2. Surface `servings`, `time_text`, `calories_text`, and `protein_text` in the app.
3. Update the filtering model to better match a pescatarian cookbook instead of the current protein-only taxonomy.
4. Decide later whether to manually recover the 2 unresolved hold rows from the original ChatGPT export.
5. Consider whether `public.recipe_imports` should be cleaned up or left as an audit log now that approved rows have been imported.

## 2026-03-22: UI cleanup, richer filtering, and deferred Supabase MCP setup

The home page was upgraded from raw imported text rendering into a cleaner recipe view with structured lists, metadata pills, and multi-dimensional filtering. We also tried wiring up the Supabase MCP server, but Codex still could not complete the auth handshake, so database work should continue through the previous manual path until that is revisited.

### What We Learned

- The live `public.recipes` rows contain noisier imported `protein` values than the reviewed import artifacts, so category and protein filtering cannot safely trust that single field anymore.
- Parsed ingredient text is a better signal than the full raw import blob when inferring protein types.
- Some recipes legitimately belong in multiple protein buckets, especially breakfast dishes that combine dairy and eggs and seafood mains that also include beans or lentils.
- Codex now has a saved Supabase MCP server entry in local config, but the current setup still returns `Auth required` during MCP initialization.

### What Was Completed

- Added cleaner imported recipe rendering on the home page with list-style ingredients and instructions.
- Surfaced saved recipe metadata like servings, time, calories, and protein in the UI.
- Reworked the browsing model from the earlier protein-only filter into explicit meal categories: `Lunch/Dinner`, `Side Dish`, `Breakfast`, and `Dessert`.
- Added a richer `Protein Type` filter with support for multiple protein tags per recipe.
- Split shrimp into its own protein type and kept fish-specific subtype filtering for seafood recipes.
- Added a checkpoint git commit before the newer filtering work: `c4f7ab0 Improve recipe parsing and filtering`.
- Saved a Supabase MCP server entry in `C:\Users\jorda\.codex\config.toml` using the hosted project-scoped URL in read-only mode.
- Confirmed the current MCP setup is not authenticated yet, so no database-side MCP work was performed.

### Recommended Next Steps

1. Add explicit database fields for `category`, `protein_types`, and optionally `fish_subtypes` so the app no longer depends on heuristics alone.
2. Backfill those new fields for the current recipes using the classification rules we developed in the UI.
3. Update the add/edit recipe flows so future recipes save structured category and protein metadata directly.
4. Revisit Supabase MCP auth in a future session only if it will materially speed up schema/data work; otherwise continue using the existing manual SQL path.
5. Decide whether a few edge-case recipes should be hand-tuned after the database fields exist.

## Repo convention going forward

For future major milestones, record a short dated entry in `PROJECT_HISTORY.md` and include these sections:

- `What We Learned`
- `What Was Completed`
- `Recommended Next Steps`
