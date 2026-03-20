# Next Steps

## Start-of-session reminder

- Git is installed but not on the PowerShell PATH inside Codex.
- For cookbook work, use C:\Program Files\Git\cmd\git.exe unless the user has added Git to PATH and restarted Codex.
- Remind Jordan about this at the beginning of the next cookbook session.

## Current state

Jordan's Cookbook is still a simple Next.js + Supabase app, but the ChatGPT import work is much farther along than before.

What it does now:

- Shows recipes from the `recipes` table.
- Supports keyword search across recipe text.
- Supports filtering by protein.
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
- No tags or richer categories yet
- No recipe photos
- The UI still renders imported recipe text as raw text blocks
- Imported markdown and assistant-style formatting still show in the app
- 2 hold recipes still remain unresolved because their extracted steps are incomplete
- Protein filtering does not yet reflect a pescatarian-friendly categorization model
- Public read/insert/update/delete policies are still very open for an MVP

## What We Learned

- Staging is cumulative: loading new approved rows into `public.recipe_imports` does not replace older approved rows.
- Title-based dedupe is the right import guard for the current dataset because a single conversation can legitimately generate multiple recipes.
- Most hold rows can be converted into good import candidates with editorial cleanup, but incomplete extracts should stay out.
- The approved staging import is now fully represented in `public.recipes`.

## What Was Completed

- Reviewed the staged import candidates and documented the decisions in `data-import/STAGING_REVIEW_2026-03-20.md`.
- Built a 34-recipe approved import set and corresponding current-schema files.
- Resolved most hold rows into clean candidate recipes and merged the keepers into the approved set.
- Left only 2 unresolved hold rows:
  - `One-Pan Halibut with Leeky Brown Rice`
  - `High-Protein Egg White Crepes with Ricotta & Berries`
- Generated `supabase/recipe_imports_load_approved.sql` and loaded the approved rows into staging.
- Imported the approved staging rows into `public.recipes` with title-based dedupe.
- Verified there are 0 approved staging titles still missing from `public.recipes`.

## Recommended Next Steps

1. Clean up imported recipe rendering in the UI by stripping markdown artifacts and assistant CTA text.
2. Show `servings`, `time_text`, `calories_text`, and `protein_text` in recipe cards or detail sections.
3. Replace or expand the current protein filter with a more useful pescatarian-friendly classification model.
4. Decide whether to recover the 2 unresolved hold rows from the original export later.
5. Decide whether to keep `public.recipe_imports` as a long-term audit log or prune duplicate approved staging rows.

## Suggested Immediate Next Task

The best next task is UI cleanup for imported recipes, followed by surfacing metadata and improving filtering.

## Session note

When a major milestone is completed, add a dated summary to both `PROJECT_HISTORY.md` and `NEXT_STEPS.md`, and always include these sections:

- `What We Learned`
- `What Was Completed`
- `Recommended Next Steps`
