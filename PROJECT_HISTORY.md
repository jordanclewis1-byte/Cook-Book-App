# Project History

## 2026-03-10: Original cookbook concept

You wanted a cookbook app that could organize recipes from your ChatGPT "Recipies" project, categorize them by protein source, place vegetable side dishes under `vegetables`, place breakfast dishes under `breakfast`, show calories for all dishes, show protein for main dishes, and support keyword search.

An early version of that idea was scaffolded as a simple browser app with local sample data and a JSON import path, intended to work even before a backend was in place.

## 2026-03-15: Jordan's Cookbook MVP

The project evolved into a small Next.js + Supabase app called `jordans-cookbook` in this repo.

What was accomplished:

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

Why this matters:

- The app became a working full-stack MVP instead of just a scaffold.
- The project now has code, dependencies, a backend connection, a schema, a local dev setup, and version control.

## Recovered beginner-friendly summary

This is the summary recovered from the earlier archived conversation:

> **What You Learned Today**
>
> You created your first real full-stack app foundation. The code in `C:\Users\jorda\Documents\Codex Stuff` is now a working Next.js project connected to a live Supabase database.
>
> You learned that a web app usually needs four basic pieces:
> - frontend code for the UI
> - dependencies installed with `npm`
> - a backend or database connection
> - version control with Git/GitHub
>
> You also learned what each part does:
> - `Next.js` runs the app and shows the pages
> - `Supabase` stores the recipe data
> - `.env.local` holds connection settings
> - `schema.sql` creates the database table
> - `git` tracks changes over time
> - `GitHub` stores the project online
>
> You saw why environment setup matters:
> - the right Node version is required
> - packages must be installed before the app can run
> - a dev server has to be started with `npm run dev`
> - if ports get stuck, restarting the server usually fixes it
>
> You learned an important security rule:
> - public browser apps should use a publishable/anon key
> - secret keys should never go in `NEXT_PUBLIC_*`
>
> You also completed an important developer workflow:
> 1. Build the app structure
> 2. Connect the database
> 3. Verify data loads
> 4. Run locally
> 5. Save the work to GitHub
>
> That sequence is the core of starting many software projects.
>
> Your project is now in a good place to keep building from. Next time, the best beginner-friendly product steps would probably be:
> - add edit/delete recipe support
> - improve recipe categories or tags
> - clean up the add recipe form
> - make the recipe cards look nicer

## 2026-03-16: Recipe maintenance flow

The app was checked against the repo docs and confirmed to match the documented MVP: list recipes, search/filter by protein, and add new recipes through Supabase.

Then the next feature milestone was added:

- Added edit buttons from the main recipe list.
- Added a dedicated edit page for updating recipe fields.
- Added delete buttons from the main recipe list.
- Added Supabase update/delete policies to match the new UI.
- Updated the repo notes so future sessions can recover this new state quickly.

Why this matters:

- The app is no longer write-once.
- Recipes can now be maintained over time without going into Supabase manually.
