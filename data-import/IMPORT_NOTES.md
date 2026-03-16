# ChatGPT Recipe Import Notes

## What was found

- Export source: `chatgpt-export/`
- Candidate Recipes project identifier: `g-p-69534c4a2bd881918d461401f82ff136`
- Conversations in that project: 22
- Extracted recipe records: 39
- Multi-recipe conversations: yes

## Output files

- `data-import/recipes-project-conversations.json`
  Conversation inventory from the Recipes project.
- `data-import/recipes-project-extracted.json`
  Expanded structured extract with source conversation metadata and raw recipe text.
- `data-import/recipes-project-expanded.csv`
  CSV version of the expanded extract.
- `data-import/recipes-project-current-schema.json`
  A rough compatibility export for the current `public.recipes` table.
- `data-import/recipes-project-current-schema.csv`
  CSV version of the rough compatibility export.

## Important caveats

- Some conversations contain more than one recipe, so one conversation may produce multiple rows.
- Some conversations are follow-up tweaks on an earlier recipe. The extractor tries to select the main recipe response, but this still needs review.
- Some recipes were copied from external websites, so the raw text should be reviewed before final import.
- Not every recipe includes clean servings, timing, or nutrition metadata.

## Recommended new recipe fields

Based on the extracted data, the most useful additions are:

- `servings`
  Often present as a range like `2` or `3-4`.
- `time_text`
  Timing is present, but usually as free text like `~20-25 minutes` rather than a clean integer.
- `calories_text`
  Present in many breakfast and side recipes as approximate ranges.
- `protein_text`
  Present in many high-protein recipes.
- `source_conversation_id`
  Lets you trace each imported recipe back to the export.
- `source_conversation_title`
  Useful for auditing and deduping.
- `source_type`
  For this import, likely `chatgpt_export`.
- `raw_import_text`
  Preserves the full source recipe text for later cleanup.

## Recommended import strategy

1. Load the expanded CSV into a staging table first.
2. Review and clean obvious duplicates or malformed rows there.
3. Decide which new fields you want in the main `public.recipes` table.
4. Insert reviewed rows from staging into `public.recipes`.

## Immediate next decision

Before final import, decide whether you want:

- a quick import into the current simple schema, or
- a safer staged import with a few new columns added first

The staged import is the better option.
