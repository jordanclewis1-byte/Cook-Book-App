# Staged Import Review - 2026-03-20

Source reviewed: `data-import/recipes-project-cleaned-current-schema.json`

## Summary

- Total candidate rows reviewed: 36
- Approve after cleanup: 27
- Hold for manual split/reconstruction: 8 rows across 6 grouped issues
- Reject: 1

## Approve After Cleanup

1. Fish and chickpea stew
2. Oven-Baked Creamy Lemon-Garlic Cod (or Halibut)
3. Easy Miso Butter Cod (serves 2)
4. Greek Yogurt Protein Oatmeal
5. Cottage Cheese "Cheesecake" Oatmeal
6. Creamy Cod with Leeks & Mushrooms (Weeknight-Friendly)
7. Protein Pancakes Recipe
8. Dump-and-Bake Broccoli, Chickpea & Feta Quinoa Bake
9. Dump-and-Bake White Bean, Spinach & Tomato Casserole
10. Dump-and-Bake Red Lentil Coconut Curry (Ultra Lazy Edition)
11. Crispy Miso-Maple Tofu with Garlicky Greens
12. Gochujang Sheet-Pan Tofu & Veggies
13. Creamy Miso-Ginger Tofu Skillet
14. Sticky Gochujang Tofu (20-Minute Skillet)
15. Creamy Lemon-Garlic Red Lentils (Mediterranean Style)
16. Smoky Harissa Red Lentils
17. Coconut-Miso Red Lentil Mash (Ultra Cozy)
18. High-Protein Savory Miso Broth Oatmeal
19. Restaurant-Style Miso-Ginger Tuna (Nobu Inspired)
20. Ginger-Scallion Cauliflower Rice (Bright + Umami)
21. Lemon-Garlic Herb Cauliflower Rice (Mediterranean)
22. Miso-Butter Cauliflower Rice (Deep Umami)
23. Smoky Tomato-Paprika Cauliflower Rice
24. Crispy Oven-Roasted Brussels Sprouts
25. One-Pot Shrimp, Black Bean & Cauliflower Rice Stew
26. Creamy Greek Yogurt & Dill Fish Stew
27. Coconut Lemongrass Fish & Cauliflower Rice Stew

Cleanup needed before import:
- Remove ChatGPT CTA tails like "If you want, I can..."
- Normalize titles by removing list numbering and emoji where present.
- Fix mojibake / encoding artifacts where they remain.
- Correct obviously wrong `protein` classifications on breakfast, lentil, and side-dish rows.
- Strip serving suggestions, upgrade ideas, and macro coaching from `description` when they are not recipe summaries.

## Hold For Manual Split Or Reconstruction

1. One-Pan Halibut with Leeky Brown Rice
Reason: ingredients exist but instructions are missing from the extracted row.
Recommended action: recover the full source conversation or leave out for now.

2. Egg-White Oatmeal (Creamy, Not Eggy)
Reason: this row actually contains three oatmeal variants in one record.
Recommended action: split into separate recipes if you want all three.

3. High Protein Oatmeal Ideas
Reason: this is a 5-day meal plan, not a single recipe.
Recommended action: either reject or manually split the five variants into individual recipes later.

4. High-Protein Egg White Crepes with Ricotta & Berries
Reason: the extracted row appears truncated before the cooking steps finish.
Recommended action: recover the full source conversation before import.

5. Miso-Tahini Fish Recipe fragments (`Why this recipe works`, `Fish`, `Bake the fish`)
Reason: this is one recipe split across three bad rows.
Recommended action: reconstruct into one cleaned recipe and reject the fragment rows afterward.

6. Whipped Ricotta Breakfast Bowl (Dessert-Style)
Reason: this row contains a second recipe (`Ricotta-Stuffed French Toast`) plus extra tip text.
Recommended action: split into two recipes if both are worth keeping.

## Reject

1. Low-Carb Sides for Eggs
Reason: this is cooking advice about when to add cottage cheese to eggs, not a recipe record.

## Hold Resolution Update

- Recoverable hold rows have been converted into 10 clean candidate recipes in data-import/recipes-project-hold-resolved-candidates.json.
- The only still-unresolved hold rows are One-Pan Halibut with Leeky Brown Rice and High-Protein Egg White Crepes with Ricotta & Berries because both are missing the later instructions.

## Best Next Actions

1. Review data-import/recipes-project-hold-resolved-candidates.json and decide which of those 10 should be merged into the approved import set.
2. Leave the halibut and crepe rows out unless you want to recover their missing steps from the original export.
3. If the resolved hold candidates look good, merge them into the approved current-schema import file next.
4. Then load the final approved set into Supabase staging or the live recipes table.

