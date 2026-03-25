# Next Steps

## Start-of-session reminder

- Git is installed but not on the PowerShell PATH inside Codex.
- For cookbook work, use C:\Program Files\Git\cmd\git.exe unless the user has added Git to PATH and restarted Codex.
- Remind Jordan about this at the beginning of the next cookbook session.
- Make Supabase MCP setup/auth a deliberate action item next session before deciding whether it is worth finishing.
- A Supabase MCP server entry is saved locally in `C:\Users\jorda\.codex\config.toml`, but it still fails auth handshaking. For now, do database work the old way instead of assuming MCP access is available.
- If `localhost:3000` looks dead, try `npm run dev:reset` before deeper debugging. It clears stale `.next` output, frees port `3000`, and starts a fresh dev server.
- Use `npm run dev:status` to quickly check whether the local dev server is healthy, stale, or not running before restarting things.

## 2026-03-24: Structured recipe metadata wiring

The app now has a shared metadata layer for recipe classification, and the add/edit flows are wired to save the newer structured cookbook fields instead of only the old single `protein` value.

### What We Learned

- The homepage heuristics were stable enough to promote into a shared utility layer without changing the browsing behavior.
- Keeping the legacy `protein` column populated is the safest bridge while the database and UI transition to structured metadata.
- A manual SQL backfill script is the best fit for now because Supabase MCP still is not authenticated in this environment.

### What Was Completed

- Moved recipe text cleanup, parsing, and classification helpers into `lib/recipe-metadata.ts`.
- Updated the home page to prefer stored `category`, `protein_types`, and `fish_subtypes` values, while still falling back to inference for older rows.
- Updated the add recipe flow to save structured category, protein type, and fish subtype metadata.
- Updated the edit recipe flow to load inferred metadata for older rows and save the structured fields on update.
- Extended shared recipe types with `category`, `protein_types`, and `fish_subtypes`.
- Extended `supabase/schema.sql` with the new structured metadata columns.
- Added `supabase/recipe_metadata_backfill.sql` to backfill existing rows using the current cookbook heuristics.
- Fixed the homepage parser so imported recipes with duplicated raw blobs do not render ingredient lists as fake instructions.
- Added `npm run dev:reset` and `npm run dev:status` to make the local Next dev server more reliable across sessions.

### Recommended Next Steps

1. Run `supabase/recipe_metadata_backfill.sql` in Supabase so the live rows get the new structured fields.
2. Spot-check a handful of edge-case recipes after the backfill, especially breakfast and seafood recipes with multiple protein tags.
3. Do a pre-deploy cleanup pass on imported rows whose `ingredients` and `instructions` still store the same full raw recipe blob.
4. Refresh `README.md` so it reflects the current filtering and metadata model instead of the older MVP-only description.
5. Make Supabase MCP auth/setup the first explicit investigation item next session, then decide whether to keep using manual SQL or switch workflows.

## Current state

Jordan's Cookbook is still a simple Next.js + Supabase app, but the UI and filtering work are farther along than before.

What it does now:

- Shows recipes from the `recipes` table.
- Supports keyword search across recipe text.
- Supports meal-category filtering with `Lunch/Dinner`, `Side Dish`, `Breakfast`, and `Dessert`.
- Supports `Protein Type` filtering, including multi-protein tagging in the UI.
- Supports fish subtype filtering for seafood recipes.
- Lets you add recipes from a form.
- Lets you edit recipes.
- Lets you delete recipes.
- Saves structured `category`, `protein_types`, and `fish_subtypes` metadata for newly added or edited recipes.
- Stores reviewed import rows in `public.recipe_imports` as staging and audit data.
- Stores imported metadata in `public.recipes`, including `servings`, `time_text`, `calories_text`, `protein_text`, `source_type`, `source_conversation_id`, and `raw_import_text`.
- Includes a generated approved import set in `data-import/recipes-project-approved.*`.
- Includes resolved-hold candidate files in `data-import/recipes-project-hold-resolved-candidates.*`.

Current architecture:

- Frontend: Next.js App Router
- Database/backend: Supabase
- Data access: browser-side Supabase client
- Main table: `public.recipes`
- Staging table: `public.recipe_imports`

Known limitations:

- No authentication
- Existing live rows still need the structured metadata backfill applied in Supabase
- No recipe photos
- Filtering still falls back to UI heuristics for older rows until the database backfill is run
- Some imported live rows have noisy `protein` values that do not match the final UI behavior
- 2 hold recipes still remain unresolved because their extracted steps are incomplete
- Public read/insert/update/delete policies are still very open for an MVP
- Supabase MCP is configured locally but not authenticated yet

## What We Learned

- The live `public.recipes` data is noisier than the reviewed import artifacts, so the UI should not trust the old `protein` field for modern filtering.
- Multi-protein classification is useful for this cookbook because several recipes genuinely span dairy/eggs or seafood/beans.
- Parsed ingredients are a better source for protein inference than the full raw import text.
- Supabase MCP setup is partially in place, but until auth works it should not be counted on for schema/data work.

## What Was Completed

- Cleaned up imported recipe rendering in the UI.
- Surfaced saved metadata in recipe cards.
- Reworked browsing around the new meal categories.
- Added richer protein filtering, including a dedicated shrimp protein type and fish subtype filtering.
- Added support for multiple protein tags per recipe in the UI.
- Saved the current checkpoint in git before later filtering work.
- Attempted Supabase MCP setup and confirmed the current blocker is authentication, not missing config.

## Recommended Next Steps

1. Run the structured metadata backfill against the live Supabase project.
2. Hand-tune a few edge-case recipes after the backfill lands.
3. Do a pre-deploy cleanup pass for imported recipes whose ingredient and instruction fields still contain the same raw blob.
4. Refresh `README.md` to match the current app.
5. Revisit Supabase MCP auth next session as an explicit setup task; otherwise continue with manual SQL/database changes.

## Suggested Immediate Next Task

The best next task is applying the structured metadata backfill in Supabase and then spot-checking the recipes that are most likely to need manual cleanup.

## Session note

When a major milestone is completed, add a dated summary to both `PROJECT_HISTORY.md` and `NEXT_STEPS.md`, and always include these sections:

- `What We Learned`
- `What Was Completed`
- `Recommended Next Steps`
