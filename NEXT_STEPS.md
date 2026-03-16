# Next Steps

## Current state

Jordan's Cookbook is a simple Next.js + Supabase app with basic recipe maintenance and a first staged recipe import workflow.

What it does now:

- Shows recipes from the `recipes` table.
- Supports keyword search across recipe text.
- Supports filtering by protein.
- Lets you add recipes from a form.
- Lets you edit existing recipes.
- Lets you delete recipes.
- Stores staged ChatGPT recipe imports in `public.recipe_imports` for review.
- Stores imported recipe metadata in `public.recipes` with nullable import fields.

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
- Imported recipe text still contains markdown and cleanup artifacts in some rows
- 15 staged import rows still need manual review
- Protein filtering does not yet reflect a pescatarian-friendly categorization
- Public read/insert/update/delete policies are still very open for an MVP

## What We Learned

- A staged import flow is much safer than importing ChatGPT-exported recipe content directly into the live recipes table.
- The ChatGPT export includes mixed-quality recipe data: some full recipes, some multi-recipe conversations, and some follow-up fragments or tweaks.
- Python is useful on this machine for repeatable extraction and cleanup work.
- The current UI is functional, but imported markdown-style recipe text needs display cleanup to be pleasant to read.
- Protein-only categorization is too limited for how you actually cook and eat.

## What Was Completed

- Preserved the last known-good app state with a GitHub commit before import work.
- Added edit and delete recipe support to the cookbook app.
- Installed Python locally.
- Parsed the ChatGPT export and isolated the recipe project conversations.
- Created cleaned import artifacts in `data-import/`.
- Created and loaded the `public.recipe_imports` staging table in Supabase.
- Expanded `public.recipes` with nullable metadata fields:
  - `servings`
  - `time_text`
  - `calories_text`
  - `protein_text`
  - `source_type`
  - `source_conversation_id`
  - `raw_import_text`
- Reviewed the staged rows and imported 16 approved ChatGPT-export recipes into `public.recipes`.
- Left 15 staged rows in `public.recipe_imports` with `review_status = 'needs_review'` for follow-up.

## Recommended Next Steps

1. Review the 15 remaining staged rows in `public.recipe_imports` and decide which to approve, edit, or reject.
2. Clean up recipe display text in the UI by stripping markdown artifacts like `#`, `*`, and leftover CTA text from imported rows.
3. Update the filtering model to reflect your pescatarian preferences instead of a generic meat-first protein taxonomy.
4. Improve recipe readability in the UI by rendering ingredients and instructions as cleaner lists and surfacing metadata like servings, time, calories, and protein.
5. Add broader recipe classification fields such as tags, meal type, or course so the cookbook is more useful than protein-only filtering.

## Suggested Immediate Next Task

The best next task is to review the 15 remaining staged import rows and then clean up imported recipe text rendering in the UI.

## Session note

When a major milestone is completed, add a dated summary to both `PROJECT_HISTORY.md` and `NEXT_STEPS.md`, and always include these sections:

- `What We Learned`
- `What Was Completed`
- `Recommended Next Steps`
