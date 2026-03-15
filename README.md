# Jordan's Cookbook

A very simple personal cookbook app built with Next.js and Supabase.

## What this app does

This MVP does only 3 things:

1. Shows your recipes
2. Lets you search and filter recipes, especially by protein
3. Lets you add new recipes

There is no authentication, no AI search, and no extra architecture yet.

## Project structure

- `app/layout.tsx`
  The main page shell. This adds the site title and top navigation.

- `app/page.tsx`
  The home page. This loads recipes from Supabase and lets you search/filter them.

- `app/add-recipe/page.tsx`
  The add recipe page. This has a simple form that saves a recipe to Supabase.

- `app/globals.css`
  Basic styling for the whole app.

- `lib/supabase.ts`
  Creates the Supabase client so the app can talk to your database.

- `lib/types.ts`
  A small TypeScript type for recipes.

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

This keeps things very simple:

- no auth
- no server actions
- no API routes
- no separate backend code

## Beginner notes

- The app uses the Next.js App Router because it is the default in modern Next.js.
- Both pages are marked with `"use client"` because they use React state and browser-side Supabase calls.
- This is not locked down for production yet, because you asked for the simplest MVP first.

## Good next steps after the MVP

When you are ready, the next useful upgrades would be:

1. Edit and delete recipes
2. Add tags like `Dinner`, `Meal Prep`, `Quick`
3. Add recipe photos
4. Add authentication later
