# Next Steps

## Start-of-session reminder

- Git is installed but not on the PowerShell PATH inside Codex.
- For cookbook work, use C:\Program Files\Git\cmd\git.exe unless the user has added Git to PATH and restarted Codex.
- Supabase MCP is now configured and authenticated in `C:\Users\jorda\.claude\settings.json`. Use it for database work.
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

## 2026-03-29: Read-only production launch on Vercel

The cookbook is now deployed as a mobile-friendly read-only site, and the parser has been hardened enough that several real-world imported recipe edge cases no longer render broken ingredient/instruction splits.

### What We Learned

- A read-only production mode is the safest path to get the cookbook live quickly before auth exists.
- The real security boundary is Supabase RLS, not just hiding buttons in the UI.
- Vercel will block deployment of vulnerable Next.js releases, so dependency patching can become a deployment prerequisite.
- Imported recipe text needs section-aware parsing because headings like `Step-by-Step Instructions`, `Finish`, and component ingredient sections appear in the same recipe blob.

### What Was Completed

- Added a deployment flag, `NEXT_PUBLIC_ENABLE_RECIPE_WRITES`, to control whether production shows write UI.
- Hid add/edit/delete actions and replaced direct write pages with read-only messaging when writes are disabled.
- Updated `supabase/schema.sql` to make anonymous users read-only and move writes to `authenticated`.
- Replaced the older Node-backed dev helper commands with PowerShell versions that work more reliably in this environment.
- Fixed parser edge cases affecting recipes like:
  - `Berry Cheesecake Oats`
  - `Banana Bread Oats`
  - `High-Protein Egg White Crepes with Ricotta & Berries`
  - `High-Protein Savory Miso Broth Oatmeal`
  - `Miso-Tahini Fish with Caramelized Onions`
- Refreshed `README.md` to document the current app and deployment workflow.
- Upgraded Next.js to `15.2.8` so Vercel would accept the deployment.
- Deployed the app successfully to:
  - `https://cook-book-app-six.vercel.app/`

### Recommended Next Steps

1. Confirm the live Supabase project has the updated read-only anonymous policies applied.
2. Run a short production QA pass on phone and desktop, focusing on imported recipes with multi-section formatting.
3. Add basic production polish:
   - favicon/app icon
   - improved site metadata
   - any obvious mobile spacing/readability fixes
4. Choose the next major milestone:
   - auth for safe production editing
   - full PWA support
   - paste-and-parse recipe intake
5. Keep local `.env.local` at `NEXT_PUBLIC_ENABLE_RECIPE_WRITES=true` for development if you still want local editing, while keeping production set to `false`.

## Current state

Jordan's Cookbook is now live on Vercel as a read-only mobile-friendly website, while local development can still stay writable through an environment flag.

What it does now:

- Shows recipes from the `recipes` table.
- Supports keyword search across recipe text.
- Supports meal-category filtering with `Lunch/Dinner`, `Side Dish`, `Breakfast`, and `Dessert`.
- Supports `Protein Type` filtering, including multi-protein tagging in the UI.
- Supports fish subtype filtering for seafood recipes.
- Supports add/edit/delete locally when `NEXT_PUBLIC_ENABLE_RECIPE_WRITES=true`.
- Supports safer read-only production mode when `NEXT_PUBLIC_ENABLE_RECIPE_WRITES=false`.
- Saves structured `category`, `protein_types`, and `fish_subtypes` metadata for newly added or edited recipes.
- Stores reviewed import rows in `public.recipe_imports` as staging and audit data.
- Stores imported metadata in `public.recipes`, including `servings`, `time_text`, `calories_text`, `protein_text`, `source_type`, `source_conversation_id`, and `raw_import_text`.
- Includes a generated approved import set in `data-import/recipes-project-approved.*`.
- Includes resolved-hold candidate files in `data-import/recipes-project-hold-resolved-candidates.*`.

Current architecture:

- Frontend: Next.js App Router
- Database/backend: Supabase
- Data access: browser-side Supabase client
- Hosting: Vercel
- Main table: `public.recipes`
- Staging table: `public.recipe_imports`

Known limitations:

- No authentication
- Production editing is intentionally disabled until auth exists
- No recipe photos
- Some imported recipes may still need manual cleanup even after the newer parser fixes
- 2 hold recipes still remain unresolved because their extracted steps are incomplete
- Need to verify the live Supabase project is using the safer read-only anonymous policies
- Supabase MCP is configured locally but not authenticated yet

## What We Learned

- A read-only production launch is a practical bridge before authentication work.
- Parser quality matters a lot for imported recipes because section boundaries vary more than expected.
- Vercel deployment policy can force dependency upgrades even when local builds pass.
- Supabase env vars and RLS are the two most critical pieces of deployment correctness.

## What Was Completed

- Hardened recipe parsing for several imported-recipe edge cases.
- Added deployment-safe read-only mode controlled by environment variable.
- Updated the Supabase schema policies for anonymous read-only access.
- Refreshed the README and deployment notes.
- Upgraded Next.js to a patched release and deployed the app to Vercel.

## Recommended Next Steps

1. Verify the live Supabase project has the intended read-only anonymous RLS policies.
2. Do a production QA pass on phone and desktop, especially for parser-sensitive imported recipes.
3. Add basic production polish like favicon/app icon and better metadata.
4. Decide whether the next milestone is auth, full PWA support, or paste-and-parse intake.
5. Revisit Supabase MCP auth later only if it will materially help future schema/data work.

## 2026-04-05: Production hardening and parser fixes

RLS policies were verified live, a production QA pass was completed, and several parser bugs were fixed and deployed.

### What We Learned

- Supabase MCP is now authenticated via `C:\Users\jorda\.claude\settings.json` — use it for future database work.
- The `isIgnoredLine` check in `parseInstructionItems` was running against the full raw line (e.g. `"1. Blend the batter"`) rather than the extracted step text, so numbered section headers were slipping through.
- The `°` degree symbol was corrupted to `?` in imported data; a targeted regex fix in `normalizeImportedText` handles it display-side without touching the database.

### What Was Completed

- Verified live Supabase RLS policies match the intended schema: `anon` read-only, `authenticated` write.
- Ran production QA pass on the live Vercel site for imported recipes.
- Fixed `°F`/`°C` display corruption in `normalizeImportedText`.
- Fixed Egg White Crepes ingredient subsection headers ("Crepe batter", "Filling", "For the pan") appearing as bullet items.
- Fixed Egg White Crepes instruction section headers ("Blend the batter", "Heat the pan") appearing as numbered steps.
- Deployed fixes to production via GitHub → Vercel.
- Created a `cookbook-briefing` skill for session recaps.

### Recommended Next Steps

See the 5-step roadmap below.

## Roadmap (agreed 2026-04-05)

These are the next 5 milestones in priority order:

### Step 1: Favicon + polish
- Add a favicon/app icon
- Improve `<meta>` title, description, and og tags
- Fix any obvious mobile spacing or readability issues

### Step 2: Individual recipe pages + shareable links
- Add a dynamic `/recipes/[id]` route for each recipe
- Each recipe card on the homepage links to its own page
- Shareable URL per recipe

### Step 3: Homepage/search results redesign
- Homepage becomes a clean landing page with search
- Recipe list moves to a search/results page
- Results link through to individual recipe pages

### Step 4: Auth
- Add Supabase auth (login/logout)
- Re-enable add/edit/delete in production behind authentication
- Protect write routes so only the authenticated user can modify recipes

### Step 5: Favorite recipes
- Allow marking recipes as favorites (requires auth + recipe pages)
- Persist favorites per user in Supabase
- Add a favorites filter or view

## Suggested Immediate Next Task

Start with Step 1 (favicon + polish) — it's a quick win and makes the app look finished before shareable links go out.

## Session note

When a major milestone is completed, add a dated summary to both `PROJECT_HISTORY.md` and `NEXT_STEPS.md`, and always include these sections:

- `What We Learned`
- `What Was Completed`
- `Recommended Next Steps`
