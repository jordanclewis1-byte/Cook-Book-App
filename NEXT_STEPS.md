# Next Steps

## Start-of-session reminder

- Git is installed but not on the PowerShell PATH inside Codex.
- For cookbook work, use C:\Program Files\Git\cmd\git.exe unless the user has added Git to PATH and restarted Codex.
- Remind Jordan about this at the beginning of the next cookbook session.
- A Supabase MCP server entry is saved locally in `C:\Users\jorda\.codex\config.toml`, but it still fails auth handshaking. For now, do database work the old way instead of assuming MCP access is available.

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
- No stored structured fields yet for `category`, `protein_types`, or `fish_subtypes`
- No recipe photos
- Filtering still depends on UI heuristics because the live database rows do not yet store the newer structured classification fields
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

1. Add explicit database fields for `category`, `protein_types`, and optionally `fish_subtypes` in Supabase.
2. Backfill those fields for the existing recipes using the current UI rules as a starting point.
3. Update add/edit recipe flows to save structured category and protein metadata directly.
4. Revisit Supabase MCP auth only if it becomes worth the setup cost; otherwise continue with manual SQL/database changes.
5. Hand-tune a few edge-case recipes after the structured fields exist.

## Suggested Immediate Next Task

The best next task is moving the current UI classification rules into explicit database fields so filtering becomes stable and maintainable.

## Session note

When a major milestone is completed, add a dated summary to both `PROJECT_HISTORY.md` and `NEXT_STEPS.md`, and always include these sections:

- `What We Learned`
- `What Was Completed`
- `Recommended Next Steps`
