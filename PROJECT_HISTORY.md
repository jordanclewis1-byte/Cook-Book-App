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

## Repo convention going forward

For future major milestones, record a short dated entry in `PROJECT_HISTORY.md` and include these sections:

- `What We Learned`
- `What Was Completed`
- `Recommended Next Steps`
