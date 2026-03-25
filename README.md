# Jordan's Cookbook

A very simple personal cookbook app built with Next.js and Supabase.

## Project memory

For recovered context from earlier sessions and a stable summary of where the project stands now, start with:

- `PROJECT_HISTORY.md`
- `NEXT_STEPS.md`

## What this app does

This MVP currently does 4 things:

1. Shows your recipes
2. Lets you search and filter recipes, especially by protein
3. Lets you add new recipes
4. Lets you edit or delete existing recipes

There is no authentication, no AI search, and no extra architecture yet.

## Project structure

- `app/layout.tsx`
  The main page shell. This adds the site title and top navigation.

- `app/page.tsx`
  The home page. This loads recipes from Supabase, lets you search/filter them, and now exposes edit/delete actions.

- `app/add-recipe/page.tsx`
  The add recipe page. This has a simple form that saves a recipe to Supabase.

- `app/edit-recipe/[id]/page.tsx`
  The edit recipe page. This loads one recipe, lets you update it, and saves changes to Supabase.

- `app/globals.css`
  Basic styling for the whole app.

- `lib/supabase.ts`
  Creates the Supabase client so the app can talk to your database.

- `lib/types.ts`
  Shared TypeScript types for recipes and recipe form data.

- `supabase/schema.sql`
  SQL you can paste into the Supabase SQL Editor to create your table and sample data.

- `.env.local.example`
  Example environment variables. Copy this to `.env.local` and add your real Supabase values.

## Step-by-step setup

### 1. Install packages

Open a terminal in this folder and run:

```bash
npm install
```

### 2. Create a Supabase project

In Supabase:

1. Create a new project
2. Open the SQL Editor
3. Paste everything from `supabase/schema.sql`
4. Run the SQL

This creates the `recipes` table and adds 2 sample recipes.

### 3. Add environment variables

Copy `.env.local.example` to `.env.local`.

Then add:

```bash
NEXT_PUBLIC_SUPABASE_URL=your-real-project-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-real-anon-key
```

You can find these in Supabase under Project Settings > API.

### 4. Start the app

Run:

```bash
npm run dev
```

If `localhost:3000` stops loading but a Node process is still hanging around, use:

```bash
npm run dev:reset
```

This clears the local `.next` build output, frees port `3000`, and starts a clean Next.js dev server.

To check whether the dev server is healthy without guessing, use:

```bash
npm run dev:status
```

It will tell you whether the app is healthy, stale, or not running and suggest the next command to use.

Then open:

```text
http://localhost:3000
```

## How the app works

### Viewing recipes

The home page reads from the `recipes` table and shows each recipe in a simple card.

### Searching recipes

The search box checks:

- title
- description
- ingredients

The protein dropdown lets you show only recipes with one protein type, like `Chicken` or `Fish`.

### Adding recipes

The add recipe page inserts a new row into the `recipes` table.

### Editing recipes

Each recipe card includes an `Edit` button that opens the edit page and updates that recipe in Supabase.

### Deleting recipes

Each recipe card includes a `Delete` button that removes that recipe from Supabase after confirmation.

This keeps things very simple:

- no auth
- no server actions
- no API routes
- no separate backend code

## Beginner notes

- The app uses the Next.js App Router because it is the default in modern Next.js.
- All recipe pages are marked with `"use client"` because they use React state and browser-side Supabase calls.
- This is not locked down for production yet, because you asked for the simplest MVP first.

## Good next steps after the MVP

When you are ready, the next useful upgrades would be:

1. Add tags like `Dinner`, `Meal Prep`, `Quick`
2. Add recipe photos
3. Add authentication later
