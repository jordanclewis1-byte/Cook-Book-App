-- Load cleaned ChatGPT recipe export rows into public.recipe_imports
-- Run chatgpt_recipe_import_staging.sql first, then run this file.
insert into public.recipe_imports (
  title, protein, description, servings, time_text, calories_text, protein_text,
  source_type, source_conversation_id, source_conversation_title, raw_import_text, review_status
) values
  (
    'Fish and chickpea stew',
    'Fish',
    'Perfect — here’s a **one-pot tomato, chickpea & fish rice stew** you can make start to finish in the same pan:',
    '3–4)',
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '68bda0a0-14fc-8331-b41e-c1fa1d750be2',
    'Fish and chickpea stew',
    'Perfect — here’s a **one-pot tomato, chickpea & fish rice stew** you can make start to finish in the same pan:

---

### 📝 Ingredients (serves 3–4)

- ~1 lb pollock (or other white fish), cut into 2-inch pieces  
- 1 can (15 oz) chickpeas, drained and rinsed  
- 1 can (14–15 oz) crushed tomatoes  
- 1 small onion, diced  
- 2–3 garlic cloves, minced  
- 2 tbsp olive oil  
- 1 cup uncooked long-grain rice (white or basmati cooks best in one pot)  
- 2½ cups water or broth (chicken or veggie)  
- 1 tsp smoked paprika (or regular)  
- ½ tsp cumin (optional but good)  
- Salt & pepper  
- Pinch of chili flakes or cayenne (optional)  
- ½ lemon or a splash of vinegar to finish  
- Fresh parsley/cilantro if you have it  

---

### 👩‍🍳 Method  

1. **Sauté base:**  
   In a deep skillet or Dutch oven, heat olive oil over medium heat. Sauté onion until soft (3–4 min). Add garlic and cook another 30 sec.

2. **Add spices:**  
   Stir in paprika, cumin, chili flakes, salt and pepper. Let them toast 30 sec.

3. **Add rice & chickpeas:**  
   Pour in the uncooked rice and chickpeas. Stir for 1 min so rice is coated in oil/spices.

4. **Add tomatoes & liquid:**  
   Stir in crushed tomatoes and the broth/water. Bring to a boil, then reduce to a gentle simmer. Cover and cook 12–15 min, stirring once or twice, until the rice is mostly tender and liquid mostly absorbed.

5. **Add fish:**  
   Nestle pollock pieces on top of the rice mixture. Spoon a little sauce over the fish, cover again, and cook another 5–8 min until the fish is opaque and flakes easily and rice is fully done. (Add a splash more water if it looks dry.)

6. **Finish:**  
   Squeeze lemon juice over everything, adjust salt/pepper, and sprinkle with fresh herbs.

---

### 🍽 Tips  
- If you only have brown rice, start it separately or cook it longer with more liquid (it needs ~35–40 min before adding fish).  
- You can also stir in a handful of spinach or frozen peas at the end for extra color/veg.  

Would you like me to give you an **even faster “sheet pan” version** (fish + chickpeas + tomatoes roasted together in the oven)?',
    'pending'
  ),
  (
    'Oven-Baked Creamy Lemon-Garlic Cod (or Halibut)',
    'Fish',
    'If you want a little color:',
    NULL,
    '** ~20–25 minutes',
    NULL,
    NULL,
    'chatgpt_export',
    '69489054-a6f4-832d-b34a-77fffb5dd6a5',
    'One-pan creamy fish recipe',
    '**Best vessel:** oven-safe skillet *or* shallow baking dish  
**Oven temp:** 400°F / 205°C  
**Total time:** ~20–25 minutes

---

### Ingredients (same as before, with 2 small tweaks)
- 1–1.25 lb cod or halibut fillets  
- Salt & black pepper  
- 1 tbsp olive oil or butter  
- 3 cloves garlic, minced  
- ½ tsp paprika  
- ½ tsp dried thyme or Italian seasoning  
- ½ cup fish or vegetable broth  
- ¾ cup heavy cream or half-and-half  
- Zest of ½ lemon + juice to taste  
- 1–2 cups spinach **or** thinly sliced leeks  
- Optional: 2–3 tbsp grated parmesan  

---

### Oven Method (super simple)
1. **Preheat oven** to 400°F.  
2. Lightly oil an oven-safe skillet or baking dish.  
3. Season fish with salt & pepper and lay it in the dish.  
4. In a bowl, whisk together garlic, paprika, thyme, broth, cream, lemon zest, and parmesan (if using).  
5. Scatter spinach or leeks around (and slightly under) the fish.  
6. Pour the cream mixture over everything.  
7. Cover loosely with foil and bake **12–15 minutes**.  
8. Uncover and bake another **5–8 minutes**, until fish flakes easily and sauce thickens slightly.  
9. Finish with lemon juice, cracked pepper, and a drizzle of olive oil or knob of butter.

---

### Key oven tweaks (why they matter)
- **Cover first, uncover later** → keeps fish tender, then lets sauce concentrate  
- **Slightly thicker cream ratio** → ovens don’t reduce liquid like stovetops  
- **Leeks shine here** → they soften beautifully without sautéing  

---

### Optional broiler finish (restaurant-y touch)
If you want a little color:
- Sprinkle extra parmesan or breadcrumbs  
- Broil **1–2 minutes max** — keep a close eye on it

---

### What to watch out for
- Don’t overbake — cod is done at ~130–135°F internal  
- Halibut can go closer to 140°F but dries out fast past that  
- If sauce looks thin right out of the oven, rest it **5 minutes** — it thickens as it cools

---

### Make-ahead friendly?
Yes:
- Assemble everything up to 12 hours ahead  
- Cover + refrigerate  
- Add **3–5 extra minutes** to bake time

If you want, I can:
- Adjust this for a **sheet-pan version**
- Make it **dairy-free but still creamy**
- Add **potatoes or beans** so it’s truly one-and-done

Just tell me the direction 👍',
    'pending'
  ),
  (
    'One-Pan Halibut with Leeky Brown Rice 🍋🐟',
    'Fish',
    'One-Pan Halibut Skillet',
    '** 2',
    '** ~40 minutes',
    NULL,
    NULL,
    'chatgpt_export',
    '6952aed6-96b8-832c-870c-f48b5a52c721',
    'One-Pan Halibut Skillet',
    '**Serves:** 2  
**Time:** ~40 minutes  
**Pan:** Oven-safe skillet or shallow Dutch oven with a lid (or foil)

### Ingredients
- 2 halibut fillets (5–6 oz each)
- 1 cup **brown rice**  
  - *Shortcut:* use **parboiled or microwave-ready brown rice** for true one-pan ease
- 1 medium **leek**, thinly sliced (white + light green parts)
- 2¼ cups **vegetable or chicken broth**
- 2 tbsp **olive oil**
- 2 cloves **garlic**, minced
- ½ tsp **salt** (more to taste)
- ¼ tsp **black pepper**
- ½ tsp **smoked paprika** or regular paprika
- Optional but great:
  - Zest of ½ lemon
  - Splash of white wine
  - Fresh parsley or dill
  - Small pat of butter

---

### Instructions',
    'pending'
  ),
  (
    'Easy Miso Butter Cod (serves 2)',
    'Fish',
    'In a small bowl, mix together:',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69582daf-49dc-832f-8fad-3c60cf99e44b',
    'Easy Miso Butter Cod',
    '### Ingredients
- 2 cod fillets (about 5–6 oz each)
- 2 tbsp **unsalted butter**, softened  
- 1½ tbsp **white miso**
- 1 tsp **soy sauce** (or tamari)
- 1 tsp **honey or maple syrup**
- 1 small clove **garlic**, grated (optional but great)
- Black pepper
- Optional garnish: scallions, sesame seeds, squeeze of lemon

---

### Quick Miso Butter
In a small bowl, mix together:
- Butter  
- White miso  
- Soy sauce  
- Honey  
- Garlic  

You want a smooth, spreadable paste.

---

### Method (Oven + Broiler = Best Texture)

1. **Heat oven to 425°F (220°C).**
2. Pat cod dry and place on a foil- or parchment-lined sheet pan.
3. Lightly pepper the fish (no salt — miso’s salty).
4. Spread a generous layer of miso butter over the top of each fillet.
5. **Bake 10–12 minutes**, until cod flakes easily.
6. Switch to **broil for 1–2 minutes** to caramelize the top (watch closely!).

---

### Optional Easy Upgrades
- **Ginger twist:** add ½ tsp grated fresh ginger to the butter  
- **Extra richness:** finish with a tiny pat of plain butter on top  
- **Crispy edge:** roast on a preheated sheet pan for more browning  
- **Pan-sear version:** sear cod in oil 2–3 min per side, then add miso butter and baste

---

### What to Serve It With
- Steamed rice or coconut rice  
- Sautéed bok choy, spinach, or green beans  
- Roasted broccoli or asparagus  
- Cauliflower rice if you want it lighter

If you want, I can:
- Turn this into a **one-pan veggie + cod** situation  
- Adjust for **air fryer**  
- Scale it up for meal prep  
- Make it **slightly spicy** (gochujang lovers 👀)

Just say the word.',
    'pending'
  ),
  (
    'Greek Yogurt Protein Oatmeal',
    'Other',
    'Pescatarian High-Protein Breakfasts',
    NULL,
    NULL,
    '500 cal',
    '35g protein',
    'chatgpt_export',
    '69603e72-2d7c-8331-882e-f90c2409f5b2',
    'Pescatarian High-Protein Breakfasts',
    '**~450–500 cal | ~32–35g protein**

**How to make**
- ½ cup rolled oats (dry)  
- Cook with water or unsweetened soy milk  
- Stir in **¾–1 cup nonfat Greek yogurt** after cooking  
- Top with berries + cinnamon  

**Why it works:** yogurt adds creaminess + protein without blowing calories.

---',
    'pending'
  ),
  (
    'Cottage Cheese “Cheesecake” Oatmeal',
    'Other',
    'Tastes way better than it sounds—very filling.',
    NULL,
    NULL,
    '550 cal',
    '34g protein',
    'chatgpt_export',
    '69603e72-2d7c-8331-882e-f90c2409f5b2',
    'Pescatarian High-Protein Breakfasts',
    '**~500–550 cal | ~30–34g protein**

**How to make**
- ½ cup rolled oats  
- Stir in **1 cup low-fat cottage cheese** (blend first if texture bugs you)  
- Add vanilla, cinnamon  
- Top with berries or sliced pear  

Tastes way better than it sounds—very filling.

---',
    'pending'
  ),
  (
    'Egg-White Oatmeal (Creamy, Not Eggy)',
    'Fish',
    'Tip: keep heat low and stir constantly → creamy, not scrambled.',
    NULL,
    NULL,
    '~450 cal',
    '35g protein',
    'chatgpt_export',
    '69603e72-2d7c-8331-882e-f90c2409f5b2',
    'Pescatarian High-Protein Breakfasts',
    '**~450 cal | ~32–35g protein**

**How to make**
- ½ cup rolled oats cooked in water  
- Slowly stir in **¾ cup liquid egg whites** on low heat  
- Finish with cinnamon + banana slices  

Tip: keep heat low and stir constantly → creamy, not scrambled.

---

## SAVORY OPTIONS 🥚🐟

### 4. Savory Oats with Egg Whites + Whole Egg  
**~450–500 cal | ~30–35g protein**

**How to make**
- ½ cup rolled oats cooked in water or veg broth  
- Stir in **½–¾ cup egg whites**  
- Top with 1 soft-boiled or fried egg  
- Add scallions, chili crisp, soy sauce  

Basically risotto vibes, breakfast macros.

---

### 5. Savory Oats with Smoked Salmon & Yogurt  
**~500–550 cal | ~30–34g protein**

**How to make**
- ½ cup oats cooked in water  
- Stir in **½ cup nonfat Greek yogurt**  
- Top with 2–3 oz **smoked salmon**, dill, capers, black pepper  

Unexpectedly excellent if you like savory breakfasts.

---',
    'pending'
  ),
  (
    'Creamy Cod with Leeks & Mushrooms (Weeknight-Friendly)',
    'Fish',
    'Pat dry and season both sides with salt and pepper.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '696ee47e-bab8-832a-9b69-f3ab1dfd5f41',
    'Creamy Cod with Leeks',
    '### Why this works
- Leeks + mushrooms = deep, savory, cold-weather vibes  
- Cod stays tender while soaking up a creamy, herby sauce  
- Done in ~30 minutes, all in one pan

---

### Ingredients (2 servings)
**Main**
- 2 cod fillets (about 5–6 oz each)
- 2 leeks, white & light green parts only, sliced
- 6–8 oz mushrooms, sliced (cremini or button)

**Staples**
- 2 tbsp olive oil or butter (or a mix)
- 2 cloves garlic, minced
- ½ cup broth (veg or chicken)
- ½ cup cream (heavy cream or half-and-half)
- 1 tsp Dijon mustard (optional but great)
- ½ tsp dried thyme (or fresh if you have it)
- Salt & black pepper
- Lemon (optional, for finishing)

---

### Instructions
1. **Prep the cod**  
   Pat dry and season both sides with salt and pepper.

2. **Sear the cod**  
   Heat 1 tbsp oil/butter in a large skillet over medium-high.  
   Sear cod 2–3 minutes per side until lightly golden (it does *not* need to be cooked through).  
   Remove to a plate.

3. **Cook the veggies**  
   Lower heat to medium. Add remaining oil/butter.  
   Add leeks + mushrooms with a pinch of salt.  
   Cook 6–8 minutes until soft, lightly caramelized, and cozy-looking.

4. **Build the sauce**  
   Add garlic and thyme; cook 30 seconds.  
   Deglaze with broth, scraping up browned bits.  
   Stir in cream + Dijon. Simmer 2–3 minutes until slightly thickened.

5. **Finish the cod**  
   Nestle cod back into the skillet.  
   Simmer gently 4–6 minutes until cod flakes easily and sauce coats the back of a spoon.

6. **Finish & serve**  
   Taste for salt/pepper.  
   Add a small squeeze of lemon if you want brightness.

---

### How to serve it
- Over **mashed potatoes** or **polenta** (elite winter move)
- With **crusty bread** to mop up the sauce
- Alongside **farro or rice**
- Add frozen peas or spinach at the end for extra green

---

### Easy variations
- **Extra cozy:** swap half the cream for crème fraîche  
- **Lighter:** use all broth + a splash of milk  
- **More depth:** add ¼ cup white wine before the broth  
- **Protein boost:** stir in a can of cannellini beans at the end

If you want, I can:
- Convert this to a **baked/oven version**
- Make it **dairy-free**
- Or dial it toward **French bistro** vs **Nordic winter stew** vibes',
    'pending'
  ),
  (
    'Protein Pancakes Recipe',
    'Other',
    'Here’s the **full recipe (ingredients + instructions)** from the *Sweet As Honey* article for **Protein Pancakes Without Protein Powder** — scanned directly from the site:',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '6973db3f-3bb8-8326-a80f-e547947c1447',
    'Protein Pancakes Recipe',
    'Here’s the **full recipe (ingredients + instructions)** from the *Sweet As Honey* article for **Protein Pancakes Without Protein Powder** — scanned directly from the site: 

---

## 🥞 **Protein Pancakes Without Protein Powder**  
**Servings:** 2 (3 pancakes per serving)  
**Prep:** 15 min • **Cook:** 15 min • **Total:** 30 min 

### **Ingredients**
(All measurements in US Customary)

- ½ cup Greek Yogurt  
- ½ cup Milk of choice  
- 2 large Eggs  
- 1 ¼ cup Old-Fashioned Oats  
- 1 tablespoon Granulated Sweetener (e.g., sugar, allulose, etc.)  
- 2 teaspoons Baking Powder  
- ¼ teaspoon Salt  
- 1 teaspoon Vanilla Extract (optional) 

---

### **Instructions**

1. **Blend the batter:**  
   In a high-speed blender, add all ingredients — eggs, milk, Greek yogurt, oats, sweetener, baking powder, salt, and vanilla (if using). 

2. **Puree until smooth:**  
   Blend on high speed until the batter is liquid and smooth. 

3. **Rest the batter:**  
   Transfer the batter to a mixing bowl and let it rest for about **10 minutes** — this thickens it as the oats absorb liquid. 

4. **Heat the pan:**  
   Warm a pancake griddle or non-stick skillet over **medium heat**. Grease lightly with cooking spray or oil. 

5. **Cook the pancakes:**  
   Pour about **¼ cup** of batter per pancake onto the hot surface. Cook **2–3 minutes** until bubbles form on top. 

6. **Flip and finish:**  
   Flip and cook **another 1 minute** on the second side until golden. 

7. **Serve:**  
   Serve 3 pancakes per person. Top with your favorite syrup, fresh fruit, and/or extra yogurt. 

---

### **Storage**
- **Fridge:** Store leftovers in an airtight container for up to 3 days.  
- **Freezer:** Freeze in zip-lock bags for up to 1 month (thaw in fridge overnight). 

---

If you’d like, I can also summarize the *nutrition info* or suggest topping ideas!',
    'pending'
  ),
  (
    '1. Dump-and-Bake Broccoli, Chickpea & Feta Quinoa Bake',
    'Beans',
    '(Boost it further by serving with Greek yogurt or adding extra feta.)',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '6974f4a0-65cc-8329-91bd-2e4f5e59c82f',
    'Healthy Dump-and-Bake Recipes',
    '**Protein boost:** quinoa + chickpeas + feta  
**Vibe:** cozy, Mediterranean, great leftovers

### Ingredients
- 1 cup **dry quinoa**, rinsed
- 1 can **chickpeas**, drained & rinsed
- 2 cups **broccoli florets** (fresh or frozen)
- ½ cup **crumbled feta**
- 2½ cups **vegetable broth**
- 2 tbsp **olive oil**
- 1 tsp **garlic powder**
- 1 tsp **smoked paprika**
- Salt & pepper

### Instructions
1. Heat oven to **375°F (190°C)**.
2. Dump *everything* into a 9×13 baking dish. Stir well.
3. Cover tightly with foil.
4. Bake **40 minutes**, uncover, stir.
5. Bake uncovered **10–15 more minutes** until liquid is absorbed.
6. Optional: squeeze of lemon or drizzle of olive oil.

**Protein:** ~20–22g per serving  
(Boost it further by serving with Greek yogurt or adding extra feta.)

---',
    'pending'
  ),
  (
    '2. Dump-and-Bake White Bean, Spinach & Tomato Casserole',
    'Beans',
    'Serve with whole-grain toast or spoon over farro.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '6974f4a0-65cc-8329-91bd-2e4f5e59c82f',
    'Healthy Dump-and-Bake Recipes',
    '**Protein boost:** white beans + mozzarella  
**Vibe:** Italian comfort, very weeknight-friendly

### Ingredients
- 2 cans **cannellini or butter beans**, drained
- 1 can **crushed tomatoes**
- 2 cups **baby spinach** (no chopping)
- 1 cup **shredded mozzarella** (or part-skim)
- 2 tbsp **olive oil**
- 1 tsp **Italian seasoning**
- ½ tsp **red pepper flakes** (optional)
- Salt & pepper

### Instructions
1. Oven to **375°F**.
2. Dump everything into a baking dish and gently mix.
3. Bake uncovered **30–35 minutes** until bubbly.
4. Optional: broil 2–3 minutes for a golden top.

**Protein:** ~22–25g per serving  
Serve with whole-grain toast or spoon over farro.

---',
    'pending'
  ),
  (
    '3. Dump-and-Bake Red Lentil Coconut Curry (Ultra Lazy Edition)',
    'Beans',
    'Excellent over brown rice or eaten straight from a bowl.',
    NULL,
    NULL,
    NULL,
    '35g protein',
    'chatgpt_export',
    '6974f4a0-65cc-8329-91bd-2e4f5e59c82f',
    'Healthy Dump-and-Bake Recipes',
    '**Protein boost:** red lentils  
**Vibe:** warming, protein-dense, no stirring required

### Ingredients
- 1 cup **dry red lentils**, rinsed
- 1 can **light coconut milk**
- 1½ cups **vegetable broth**
- 1 cup **frozen cauliflower or sweet potato cubes**
- 1 tbsp **curry powder**
- ½ tsp **turmeric**
- Salt to taste

### Instructions
1. Oven to **375°F**.
2. Dump all ingredients into a baking dish and stir.
3. Cover tightly with foil.
4. Bake **45–50 minutes**, stir once halfway if you remember.
5. Uncover last 10 minutes if you want it thicker.

**Protein:** ~23–26g per serving  
Excellent over brown rice or eaten straight from a bowl.

---

### Want to optimize further?
I can:
- Push these to **30–35g protein** per serving  
- Make them **higher fiber / lower calorie**
- Convert one into a **sheet-pan version**
- Customize for **meal prep (4–5 days fridge-friendly)**

Just tell me your priority 👌',
    'pending'
  ),
  (
    '1️⃣ Crispy Miso-Maple Tofu with Garlicky Greens',
    'Tofu',
    'Weekend Tofu Recipes',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '697e5e01-bc00-8325-b543-4af513bd1226',
    'Weekend Tofu Recipes',
    '**Savory, lightly sweet, very weekend-y**

### Ingredients
- 1 block extra-firm tofu, pressed & cubed
- 1½ tbsp white miso
- 1 tbsp maple syrup (or honey)
- 1 tbsp soy sauce or tamari
- 1 tsp rice vinegar or lemon juice
- 1–2 tbsp olive oil
- 2 cloves garlic, sliced
- Optional: spinach, kale, or green beans

### How
1. **Mix sauce:** miso, maple syrup, soy sauce, vinegar.
2. Heat oil in a skillet over medium-high. Pan-fry tofu 8–10 min until golden on most sides.
3. Lower heat, add garlic, cook 30 seconds.
4. Add sauce + splash of water. Toss until glossy and caramelized.
5. Toss in greens until just wilted.

**Serve with:** rice, quinoa, or over soba noodles  
**Optional upgrade:** sprinkle sesame seeds or chili crisp

---',
    'pending'
  ),
  (
    '2️⃣ Gochujang Sheet-Pan Tofu & Veggies',
    'Tofu',
    'Weekend Tofu Recipes',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '697e5e01-bc00-8325-b543-4af513bd1226',
    'Weekend Tofu Recipes',
    '**Low effort, high reward**

### Ingredients
- 1 block extra-firm tofu, torn into chunks
- 2 tbsp gochujang
- 1 tbsp soy sauce
- 1 tbsp maple syrup or brown sugar
- 1 tbsp oil
- 1 tsp rice vinegar or lime juice
- Any veggies you have: broccoli, carrots, peppers, onion, mushrooms

### How
1. Heat oven to **425°F / 220°C**.
2. Mix gochujang, soy sauce, maple, oil, vinegar.
3. Toss tofu + veggies with sauce.
4. Roast 25–30 min, flipping once, until edges are crisp and sticky.

**Serve with:** rice + a fried egg, or stuff into lettuce wraps  
**Optional:** drizzle with sesame oil after baking

---',
    'pending'
  ),
  (
    '3️⃣ Creamy Miso-Ginger Tofu Skillet',
    'Tofu',
    'Just say the word 😄',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '697e5e01-bc00-8325-b543-4af513bd1226',
    'Weekend Tofu Recipes',
    '**Comfort-food vibes, great for a slow Sunday**

### Ingredients
- 1 block extra-firm tofu, sliced
- 1½ tbsp white miso
- ½ cup coconut milk or regular milk/cream
- 1 tsp grated ginger (or ground ginger)
- 1 clove garlic, minced
- 1 tbsp soy sauce
- 1 tbsp oil

### How
1. Pan-sear tofu in oil until golden; remove and set aside.
2. Lower heat. Add garlic + ginger, cook 30 seconds.
3. Whisk miso with coconut milk + soy sauce, add to pan.
4. Simmer gently 3–5 min until slightly thick.
5. Return tofu, spoon sauce over, warm through.

**Serve with:** rice, mashed potatoes, or sautéed mushrooms  
**Optional:** add scallions or black pepper on top

---

### Want a direction?
- **More protein-maxed?** I can tweak these to pair with edamame or lentils  
- **Crispier tofu?** I’ll give you my foolproof cornstarch trick  
- **Korean-leaning weekend bowl?** I’ll turn one into a full bibimbap-style situation  

Just say the word 😄',
    'pending'
  ),
  (
    'Low-Carb Sides for Eggs',
    'Fish',
    'Great little detail to dial in—this actually makes a noticeable difference in texture and taste.',
    'protein quality** (and the fresh, slightly tangy flavor)',
    'to add cottage cheese to scrambled eggs',
    NULL,
    NULL,
    'chatgpt_export',
    '69938cb0-93b4-832a-b829-9b431adfde9d',
    'Low-Carb Sides for Eggs',
    'Great little detail to dial in—this actually makes a noticeable difference in texture and taste.

## ✅ Best time to add cottage cheese to scrambled eggs
**Add it at the very end, when the eggs are just set and you’ve turned the heat off.**

### Why this works
- **Keeps eggs creamy** → cottage cheese gently melts and coats the curds  
- **Prevents grainy texture** → high heat can make cottage cheese weep/water  
- **Preserves protein quality** (and the fresh, slightly tangy flavor)  
- **Avoids rubbery eggs** from overcooking

---

## 👩‍🍳 30-second method (foolproof)
1. Cook your eggs low–medium heat until they’re **~90% done** (still a little glossy).  
2. **Turn the heat off.**  
3. Stir in the cottage cheese.  
4. Let residual heat warm it for **10–20 seconds.**  
5. Season and eat.

That’s it. You’ll get soft, creamy eggs without watery bits.

---

## Optional texture upgrades (depending on your preference)
- **Extra smooth:**  
  - Quickly blitz cottage cheese in a blender once for the week  
  - Stir in at the end → ricotta-like creaminess  
- **Curdy texture (more bite):**  
  - Add straight from the tub at the end

---

## What *not* to do (common mistake)
❌ Don’t add cottage cheese at the beginning or cook it hard  
→ it releases liquid + gets grainy + dulls flavor

---

## One tiny calorie-saving tip
If you’re minimizing oil, the cottage cheese at the end adds creaminess so you don’t need extra fat to make the eggs feel rich.

If you want, I can also share the **ideal timing for adding smoked salmon, kimchi, or feta** so each one hits peak flavor + texture with your scrambles.',
    'pending'
  ),
  (
    'High Protein Oatmeal Ideas',
    'Tofu',
    'Love it — here’s a **5-day, nut-free, high-protein oatmeal rotation** that keeps things interesting, hits **30–40g protein/day**, and stays roughly in the **350–450 calorie** zone. No protein powder, pescatarian-friendly.',
    NULL,
    NULL,
    '450 cal',
    '40g protein',
    'chatgpt_export',
    '69939793-0c40-8329-9858-2a494cf2dff8',
    'High Protein Oatmeal Ideas',
    'Love it — here’s a **5-day, nut-free, high-protein oatmeal rotation** that keeps things interesting, hits **30–40g protein/day**, and stays roughly in the **350–450 calorie** zone. No protein powder, pescatarian-friendly.

I’ll use the same **high-ROI base** all week so it’s easy to meal-prep:

**Base (each day)**
- ½ cup rolled oats  
- 1 cup unsweetened soy milk  
- ½ cup liquid egg whites  
- ½ cup nonfat Greek yogurt  
→ ~35–40g protein

> Cook oats in soy milk → stir in egg whites on low heat → remove from heat → stir in Greek yogurt.

---

## 🗓 5-Day High-Protein Oatmeal Plan (Nut-Free)

### **Monday – Berry Cheesecake Oats**
**Add:**
- Frozen mixed berries  
- Vanilla extract  
- Cinnamon  
- Optional: 1 tsp maple syrup  

**Why it slaps:** creamy + tart + dessert vibes  
**Protein:** ~35g

---

### **Tuesday – Apple Pie Oats**
**Add:**
- Diced apple (sauté first or microwave 1–2 min)  
- Cinnamon + nutmeg  
- Pinch of salt  

**Why it slaps:** warm, cozy, very filling  
**Protein:** ~35g

---

### **Wednesday – Banana Bread Oats (No Nuts)**
**Add:**
- ½ mashed banana  
- Cinnamon  
- Tiny splash vanilla  

**Optional protein bump:** extra ¼ cup Greek yogurt on top  
**Protein:** ~35–38g

---

### **Thursday – Tropical Cream Oats**
**Add:**
- Frozen mango or pineapple  
- 1 tbsp chia seeds  
- Coconut flakes (optional)  

**Why it slaps:** bright, not heavy  
**Protein:** ~32–35g

---

### **Friday – Savory Miso Scallion Oats**
**Add:**
- 1 tsp white miso  
- Scallions  
- Black pepper  
- Optional: soft-boiled egg or tofu cubes on top  

**Why it slaps:** congee vibes, super satisfying  
**Protein:** ~35–40g

---

## 🛒 One-Trip Grocery List (Nut-Free)
- Rolled oats  
- Unsweetened soy milk  
- Liquid egg whites  
- Nonfat Greek yogurt or skyr  
- Frozen berries  
- Apples  
- Bananas  
- Frozen mango or pineapple  
- Chia seeds  
- White miso + scallions  
- Cinnamon, vanilla extract

---

## ⏱ 10-Minute Meal Prep Hack (3 Days at Once)
- Cook **1½ cups oats + 3 cups soy milk**  
- Portion into containers  
- Reheat each morning, then stir in egg whites + yogurt fresh  
- Add flavor toppings day-of

---

## ⚖️ Macro Dial (Nut-Free)
| Goal | Tweak |
|------|------|
Max protein | Add ¼ cup more egg whites  
Lower calories | Use ¾ cup soy milk + ¼ cup water  
Creamier | Extra Greek yogurt or chia  
More fiber | Add berries or apple  

---

If you want, I can also give you:
- A **savory-only oatmeal week** (miso, mushroom, spinach, tofu)  
- Or a **cutting-friendly version** under 325 calories per bowl  
- Or a **make-ahead overnight oats version** with similar protein numbers',
    'pending'
  ),
  (
    'Sticky Gochujang Tofu (20-Minute Skillet)',
    'Tofu',
    'Heat olive oil in a hot skillet (medium-high). Add tofu cubes in a single layer.',
    '2 (or 1 very hungry person)**',
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '6994a7d9-a950-8333-9c02-1a684a14f47a',
    'Gochujang Tofu Recipe',
    '**Serves 2 (or 1 very hungry person)**  
**Protein:** ~35–40g total (depends on tofu brand)

### Ingredients
- 1 block extra-firm tofu (14–16 oz), pressed & cubed  
- 1 tbsp olive oil (or avocado oil)  
- 2 cloves garlic, minced  
- 1 tsp grated ginger (or ½ tsp ground)  
- 2 tbsp gochujang  
- 1 tbsp low-sodium soy sauce or tamari  
- 1 tbsp rice vinegar (or lime juice)  
- 1 tsp maple syrup or honey  
- 1 tsp sesame oil (optional but 🔥 for flavor)  
- 2–3 tbsp water  
- Optional heat: chili crisp or chili flakes  
- Optional garnish: scallions, sesame seeds (skip if allergic)

---

### How To Make It
1. **Crisp the tofu**  
   Heat olive oil in a hot skillet (medium-high). Add tofu cubes in a single layer.  
   Cook 6–8 min, flipping occasionally, until golden and crispy on edges.

2. **Build flavor**  
   Push tofu to one side. Add garlic + ginger to the pan. Sauté ~30 seconds.

3. **Sauce it up**  
   In a small bowl, whisk:
   - gochujang  
   - soy sauce  
   - vinegar  
   - maple syrup  
   - sesame oil  
   - water  

4. **Glaze**  
   Pour sauce into skillet. Toss tofu to coat.  
   Simmer 2–3 minutes until thick, glossy, and sticky.

5. **Finish**  
   Taste and adjust:  
   - More gochujang = spicier  
   - More vinegar = brighter  
   - More maple = sweeter

---

## 🍚 Fast Bowl Combos (Low Effort, High Reward)

**Low-carb option**
- Serve over sautéed cauliflower rice + cucumber + scallions

**Protein-boosted bowl**
- Add a soft-boiled egg or extra tofu  
- Serve with edamame (if soy is fine for you)

**Comfort bowl**
- White rice or farro  
- Add quick-sautéed broccoli or snap peas

---

## 🔁 Flavor Variations (Same Base, New Vibes)

**Smoky Gochujang Tofu**
- Add ½ tsp smoked paprika + tiny splash of liquid smoke

**Creamy Gochujang Tofu**
- Add 1–2 tbsp light coconut milk or Greek yogurt at the end  
- Turns into a spicy-creamy glaze

**Extra Crispy Air Fryer Method**
- Air fry tofu at 400°F (200°C) for 12–15 min  
- Toss with sauce in skillet after

---

## ⚡ 5-Minute Prep Hack
Cube tofu in advance and store in fridge for 2–3 days.  
This becomes a literal “throw in pan, sauce, eat” dinner.

---

Want me to turn this into a **meal-prep version for 3–4 lunches** or build a **gochujang tofu rice bowl with roasted veggies** for the week?',
    'pending'
  ),
  (
    'Creamy Lemon-Garlic Red Lentils (Mediterranean Style)',
    'Fish',
    '👉 Pair with simple roasted salmon (olive oil + paprika + lemon).',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69a1a61f-ab44-832b-91a4-8206f8b5c92c',
    'Red Lentil Side Ideas',
    '**Why this works for you:** Bright, olive-oil based, protein-dense, minimal effort.

### Ingredients (2–3 servings)
- 1 cup red lentils (rinsed)
- 2 cups vegetable broth (or water + bouillon)
- 2 cloves garlic, minced
- Zest + juice of ½–1 lemon
- 1 tbsp olive oil
- Salt, pepper
- Optional: chopped parsley, dill, or a spoon of Greek yogurt

### Instructions
1. Simmer lentils + broth 12–15 minutes until soft (they’ll get creamy).
2. Stir in garlic during the last 2 minutes.
3. Finish with olive oil, lemon zest + juice, salt, pepper.
4. Top with herbs or a small spoon of Greek yogurt.

👉 Pair with simple roasted salmon (olive oil + paprika + lemon).

---',
    'pending'
  ),
  (
    'Smoky Harissa Red Lentils',
    'Fish',
    'Simmer lentils → stir in spices + harissa at the end → finish with olive oil + lemon.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69a1a61f-ab44-832b-91a4-8206f8b5c92c',
    'Red Lentil Side Ideas',
    '**Flavor profile:** Slight heat, smoky depth — great if your salmon is simply seasoned.

### Ingredients
- 1 cup red lentils
- 2 cups broth
- 1 tsp smoked paprika
- ½ tsp cumin
- 1–2 tsp harissa (or chili paste)
- 1 tbsp olive oil
- Salt + squeeze of lemon

### Instructions
Simmer lentils → stir in spices + harissa at the end → finish with olive oil + lemon.

This gives cozy, rich energy without feeling heavy.

---',
    'pending'
  ),
  (
    'Coconut-Miso Red Lentil Mash (Ultra Cozy)',
    'Fish',
    'This becomes almost like a savory purée under crispy salmon.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69a1a61f-ab44-832b-91a4-8206f8b5c92c',
    'Red Lentil Side Ideas',
    '**Very your vibe** given your love of miso + coconut cream.

### Ingredients
- 1 cup red lentils
- 1½ cups broth
- ¼ cup light coconut milk (or coconut cream diluted)
- 1–2 tsp white miso
- Grated ginger (optional)
- Lime juice

### Instructions
1. Cook lentils until very soft.
2. Stir in coconut milk + miso (off heat so miso keeps flavor).
3. Add ginger + lime.

This becomes almost like a savory purée under crispy salmon.

---',
    'pending'
  ),
  (
    'High-Protein Savory Miso Broth Oatmeal',
    'Fish',
    'In a small saucepan combine:',
    'its flavor.',
    NULL,
    NULL,
    '~34 g protein',
    'chatgpt_export',
    '69a83061-1e0c-8331-a16d-65af9c1f580c',
    'Savory Miso Oatmeal Recipe',
    '### Nutrition (approx.)
- **Calories:** ~380–420  
- **Protein:** ~30–33 g  
- **Carbs:** ~30 g  
- **Fat:** ~12 g  

*(Great balance if you’re trying to cut a bit before summer but still want a filling breakfast.)*

---

# Ingredients (1 serving)

**Base**
- ½ cup **rolled oats**
- ¾ cup **vegetable broth** (or dashi if you have it)
- ¼ cup **unsweetened soy milk**
- 1 tsp **white or yellow miso paste**

**Protein**
- ¾ cup **liquid egg whites** (or whites from ~3 eggs)
- 1 large **whole egg**

**Umami & seasoning**
- 1 tsp **soy sauce**
- ½ tsp **sesame oil** *(optional but great flavor)*
- Black pepper

**Toppings (optional but recommended)**
- 1 tbsp **scallions**
- 1 tbsp **kimchi** *(optional but excellent)*
- ½ sheet **nori**, shredded
- Chili crisp or chili flakes

---

# Step-by-Step Instructions

### 1. Cook the oats in broth
In a small saucepan combine:

- ½ cup oats  
- ¾ cup broth  
- ¼ cup soy milk  

Bring to a **gentle simmer** over medium heat.

Cook **3–4 minutes**, stirring occasionally.

The broth adds umami so the oatmeal tastes more like **savory congee or ramen base**.

---

### 2. Add the miso (important step)
Reduce heat to **low**.

In a small bowl:
- Mix **1 tsp miso** with **1–2 tbsp hot broth from the pot**.

Stir this mixture back into the oats.

This prevents miso from clumping and preserves its flavor.

---

### 3. Add the egg whites (protein boost)
Slowly pour in **¾ cup egg whites** while stirring constantly.

Cook **1–2 minutes**.

They will **thicken the oats and turn them creamy**, almost like risotto.

---

### 4. Cook the whole egg
You have two good options:

**Option A (easiest):**
- Crack the egg directly into the oats.
- Cover and cook **1–2 minutes** until just set.

**Option B (my favorite):**
- Soft fry the egg separately in a small pan with **½ tsp olive oil**.
- Place it on top of the oatmeal.

---

### 5. Finish the bowl
Stir in:
- 1 tsp soy sauce  
- black pepper  
- sesame oil (optional)

Top with:
- scallions  
- kimchi  
- nori  
- chili crisp

Break the yolk and mix it in — it makes the oats **extra creamy and rich**.

---

# Why this works (nutritionally)
Protein sources:

| Ingredient | Protein |
|---|---|
Oats | ~5 g |
Soy milk | ~3 g |
Egg whites | ~20 g |
Whole egg | ~6 g |

**Total:** ~34 g protein

This keeps you full much longer than standard oatmeal.

---

# Super Fast Version (5 minutes)

If you''re busy in the morning:

1. Microwave oats + broth + soy milk **2 minutes**
2. Stir in miso  
3. Stir in egg whites  
4. Microwave **1 more minute**
5. Top with a soft egg or just mix another egg white in

Still **~30 g protein**.

---

💡 **Two optional upgrades I think you''d like based on your past recipes:**

1. **Miso-Mushroom Oatmeal** – sauté mushrooms first in olive oil, then add oats  
2. **Shrimp Miso Oatmeal** – add 3–4 quick sautéed shrimp on top (adds ~10g protein)

---

If you''d like, I can also show you **3 more savory high-protein oatmeal variations** that are excellent for rotation:

- **Kimchi-tofu oatmeal (very high protein)**
- **Mediterranean feta & spinach oatmeal**
- **Miso-mushroom oatmeal that tastes like ramen broth**.',
    'pending'
  ),
  (
    'Restaurant-Style Miso–Ginger Tuna (Nobu Inspired)',
    'Fish',
    'This gives you that **Nobu / upscale Japanese restaurant flavor** but takes **about 10 minutes total**.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69aae1b4-4fcc-832e-aa81-f5e886c969ab',
    'Tuna Steak Recipes',
    'This gives you that **Nobu / upscale Japanese restaurant flavor** but takes **about 10 minutes total**.

### Ingredients (2 servings)

**Tuna**
- 2 tuna steaks
- salt
- 1 tsp neutral oil or olive oil

**Miso ginger sauce**
- 1 tbsp white miso  
- 1 tbsp soy sauce  
- 1 tsp rice vinegar  
- 1 tsp honey or maple syrup  
- 1 tsp grated ginger  
- 1 tsp sesame oil (optional but excellent)

**Finish**
- sliced scallions  
- chili flakes or chili crisp (optional)

---

### Instructions

**1️⃣ Make the sauce**
Whisk together:
- miso  
- soy sauce  
- rice vinegar  
- honey  
- ginger  
- sesame oil

Add **1 tbsp warm water** to loosen it slightly.

---

**2️⃣ Season tuna**
Pat dry and lightly salt both sides.

---

**3️⃣ Sear**
Heat oil in a pan until **very hot**.

Cook tuna:

- **60–90 seconds per side**
- center should stay **pink / rare**

---

**4️⃣ Slice & plate**

Slice the tuna across the grain and drizzle with the sauce.

Top with:
- scallions  
- chili flakes

---

### Simple sides that fit your cooking style

Since you like **high-protein, lighter meals**, these work perfectly:

**Option 1 (lowest calories)**  
- sautéed mushrooms + spinach

**Option 2 (balanced meal)**  
- cauliflower rice with soy + garlic

**Option 3 (more filling)**  
- miso quinoa

---

### Estimated nutrition (per serving)

- Calories: ~380  
- Protein: ~40g  
- Carbs: ~10g  

---

💡 **Chef trick:**  
After slicing the tuna, sprinkle **a few flakes of finishing salt** (like Maldon) on top. It makes the flavor pop like restaurant tuna.

---

If you want, I can also show you **the single easiest tuna steak method that chefs use at home** — it only uses **3 ingredients and takes 6 minutes**, but tastes amazing.',
    'pending'
  ),
  (
    'High-Protein Egg White Crepes with Ricotta & Berries',
    'Other',
    '💡 **Important:** The batter should look **very thin—similar to heavy cream**.',
    '1 (2–3 crepes, ~30–35g protein)**',
    NULL,
    NULL,
    '35g protein',
    'chatgpt_export',
    '69ac6b89-4848-8328-baed-69298ceca5fe',
    'High Protein Sweet Breakfasts',
    '**Serves 1 (2–3 crepes, ~30–35g protein)**

### Ingredients

**Crepe batter**
- ½ cup **liquid egg whites**
- ¼ cup **rolled oats**
- 2 tbsp **soy milk** (or regular milk)
- ¼ tsp **vanilla extract**
- Pinch **salt**
- Optional: pinch **cinnamon**

**Filling**
- ½ cup **part-skim ricotta** *or* Greek yogurt  
- ½ cup **berries** (strawberries, blueberries, raspberries)  
- 1 tsp **honey or maple syrup**  
- Optional: lemon zest

**For the pan**
- ½ tsp **olive oil** or cooking spray

---

# Step-by-Step Instructions

### 1. Blend the batter
1. Add **oats to a blender first** and pulse until they become a fine flour.
2. Add:
   - egg whites  
   - soy milk  
   - vanilla  
   - salt  
   - cinnamon (optional)

3. Blend for **10–15 seconds** until smooth.

💡 **Important:** The batter should look **very thin—similar to heavy cream**.  
If it’s thicker than that, add **1–2 tbsp milk**.

---

### 2. Rest the batter (important)
Let the batter **sit for 3–5 minutes**.

This allows the oat flour to hydrate and prevents tearing when cooking.

---

### 3. Heat the pan
1. Use a **nonstick skillet (8–10 inches)**.
2. Heat on **medium-low**.
3. Add **½ tsp olive oil** and wipe excess with a paper towel.

You want the pan lightly coated but **not greasy**.

---',
    'pending'
  ),
  (
    'Why this recipe works',
    'Other',
    'The combination tastes almost **buttery**, even though the fat mostly comes from tahini.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69b0231b-4e1c-832b-90cb-75de846d67b7',
    'Miso-Tahini Fish Recipe',
    '- **Deep sweetness:** slow caramelized onions  
- **Creamy richness:** tahini sauce  
- **Brightness:** lemon + herbs  
- **Savory depth:** cumin + garlic  

The combination tastes almost **buttery**, even though the fat mostly comes from tahini.

---

# Ingredients (2 servings)',
    'pending'
  ),
  (
    'Fish',
    'Fish',
    'Heat olive oil over **medium-low**.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69b0231b-4e1c-832b-90cb-75de846d67b7',
    'Miso-Tahini Fish Recipe',
    '- 2 fillets **cod, halibut, or sablefish** (5–6 oz each)
- 1 tsp olive oil  
- Salt + black pepper  

### Caramelized onions
- 2 medium yellow onions, thinly sliced  
- 1 tbsp olive oil  
- ½ tsp cumin  
- pinch salt  

### Lemon tahini sauce
- 2 tbsp tahini  
- 2 tbsp Greek yogurt (optional but makes it extra creamy + protein)  
- juice of ½ lemon  
- 1 small garlic clove, grated  
- 2–3 tbsp warm water  
- pinch salt  

### Finish
- chopped parsley or dill  
- chili flakes  
- lemon zest

---

# Instructions

### 1. Slow-caramelize the onions
Heat olive oil over **medium-low**.

Add onions + salt + cumin and cook **25–30 minutes** until:

- deeply golden  
- soft and jammy  
- slightly sweet

This step is what makes the dish feel luxurious.

---',
    'pending'
  ),
  (
    'Bake the fish',
    'Fish',
    'Heat oven to **400°F (205°C)**.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69b0231b-4e1c-832b-90cb-75de846d67b7',
    'Miso-Tahini Fish Recipe',
    'Heat oven to **400°F (205°C)**.

Place fish in a baking dish:

- drizzle with olive oil  
- salt + pepper  

Bake **10–12 minutes** until flaky.

*(Great method for thicker cod or sablefish.)*

---

### 3. Make the tahini sauce
Whisk:

- tahini  
- Greek yogurt  
- lemon juice  
- garlic  

Slowly whisk in warm water until **smooth and pourable**.

---

### 4. Assemble
Plate like this:

1. Fish fillet  
2. Spoon **warm caramelized onions** on top  
3. Drizzle **lemon tahini sauce** generously  

Finish with herbs, chili flakes, and lemon zest.

---

# Approximate nutrition (per serving)

| Component | Amount |
|---|---|
Calories | ~450–500  
Protein | ~40 g  
Fat | ~25 g  
Carbs | ~15 g  

Very **satisfying but still lighter than cream-based fish dishes**.

---

💡 **Two upgrades that make this next-level**

**Add roasted tomatoes**  
Roast cherry tomatoes with olive oil for 15 minutes and add to the plate. The acidity balances the tahini perfectly.

**Serve over cauliflower rice**  
Since you often prefer **lower-carb meals**, this works beautifully and absorbs the sauce.

---

✅ If you want, I can also show you **one incredible trick chefs use to make caramelized onions in only 12 minutes instead of 30**—it’s a technique that works great for weeknight cooking.',
    'pending'
  ),
  (
    'Ginger-Scallion Cauliflower Rice (Bright + Umami)',
    'Fish',
    '✔ Perfect with **salmon, tuna steak, or shrimp**.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69b077bb-ff7c-8330-b76f-ec153529a3a0',
    'Low-Cal Cauliflower Rice Recipes',
    '**Calories:** ~130 per serving  
**Flavor profile:** Fresh, aromatic, slightly savory

### Ingredients
- 3 cups cauliflower rice  
- 1 tbsp olive oil  
- 1 tbsp grated ginger  
- 2 cloves garlic, minced  
- 3 scallions, sliced  
- 1 tbsp soy sauce  
- 1 tsp sesame oil  
- Optional: chili flakes

### Instructions
1. Heat **olive oil in a skillet over medium-high**.
2. Add **ginger + garlic**, cook 30–45 seconds until fragrant.
3. Add **cauliflower rice** and sauté **4–5 minutes** until moisture evaporates.
4. Stir in **soy sauce + sesame oil**.
5. Toss in **scallions** at the end and cook 30 seconds.

✔ Perfect with **salmon, tuna steak, or shrimp**.

---',
    'pending'
  ),
  (
    'Lemon-Garlic Herb Cauliflower Rice (Mediterranean)',
    'Fish',
    '✔ Great with **cod, halibut, or miso fish**.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69b077bb-ff7c-8330-b76f-ec153529a3a0',
    'Low-Cal Cauliflower Rice Recipes',
    '**Calories:** ~120 per serving  
**Flavor profile:** Bright, fresh, Mediterranean

### Ingredients
- 3 cups cauliflower rice  
- 1 tbsp olive oil  
- 2 cloves garlic, minced  
- Zest of ½ lemon  
- Juice of ½ lemon  
- 2 tbsp chopped parsley  
- Salt + pepper

### Instructions
1. Heat **olive oil in skillet** over medium heat.
2. Add **garlic** and cook 30 seconds.
3. Add **cauliflower rice** and cook **5–6 minutes**, stirring occasionally.
4. Stir in **lemon zest + lemon juice**.
5. Finish with **parsley, salt, and pepper**.

✔ Great with **cod, halibut, or miso fish**.

---',
    'pending'
  ),
  (
    'Miso-Butter Cauliflower Rice (Deep Umami)',
    'Fish',
    '✔ Incredible with **salmon, sablefish, or shrimp**.',
    NULL,
    NULL,
    NULL,
    NULL,
    'chatgpt_export',
    '69b077bb-ff7c-8330-b76f-ec153529a3a0',
    'Low-Cal Cauliflower Rice Recipes',
    '**Calories:** ~150 per serving  
**Flavor profile:** Savory, buttery, umami

### Ingredients
- 3 cups cauliflower rice  
- 1 tsp butter  
- 1 tsp olive oil  
- 1 tbsp white miso paste  
- 1 tbsp water  
- 1 scallion, sliced  
- Optional: sesame seeds

### Instructions
1. Heat **butter + olive oil** in a skillet.
2. Add **cauliflower rice** and cook **5 minutes** until lightly browned.
3. Mix **miso + water** into a paste.
4. Stir into the cauliflower rice and cook **1 minute**.
5. Top with **scallions and sesame seeds**.

✔ Incredible with **salmon, sablefish, or shrimp**.

---',
    'pending'
  ),
  (
    'Smoky Tomato-Paprika Cauliflower Rice',
    'Fish',
    '✔ Excellent with **shrimp, grilled fish, or tofu**.',
    NULL,
    NULL,
    '250 calories',
    NULL,
    'chatgpt_export',
    '69b077bb-ff7c-8330-b76f-ec153529a3a0',
    'Low-Cal Cauliflower Rice Recipes',
    '**Calories:** ~140 per serving  
**Flavor profile:** Smoky, slightly sweet, Spanish-style

### Ingredients
- 3 cups cauliflower rice  
- 1 tbsp olive oil  
- 2 tbsp tomato paste  
- 1 tsp smoked paprika  
- ½ tsp cumin  
- 1 clove garlic, minced  
- 2 tbsp chopped cilantro or parsley

### Instructions
1. Heat **olive oil** in skillet over medium heat.
2. Add **garlic + tomato paste** and cook **1 minute** to caramelize.
3. Stir in **smoked paprika + cumin**.
4. Add **cauliflower rice** and cook **5 minutes** until tender.
5. Finish with **herbs**.

✔ Excellent with **shrimp, grilled fish, or tofu**.

---

💡 **One trick that dramatically improves cauliflower rice texture (especially frozen):**

1. Cook it **on high heat**  
2. **Don’t cover the pan**  
3. Let moisture evaporate for **5–6 minutes**

This prevents the “steamed mush” effect.

---

✅ If you''d like, I can also show you **4 “restaurant-level” cauliflower rice recipes under 250 calories** (like **Thai basil, coconut-lime, green goddess, and crispy garlic cauliflower rice**) that taste way more indulgent but still fit your summer-cut goals.',
    'pending'
  ),
  (
    'Crispy Oven-Roasted Brussels Sprouts',
    'Other',
    '→ **~95 calories per serving (3 servings)**',
    NULL,
    NULL,
    '~160 calories',
    NULL,
    'chatgpt_export',
    '69b088a1-d98c-8328-a1cc-ed85777248f6',
    'Crispy Oven-Roasted Brussels Sprouts',
    '### Ingredients (2–3 servings)
- 1 lb Brussels sprouts  
- 1–1½ tbsp olive oil  
- ½ tsp kosher salt  
- ¼ tsp black pepper  
- Optional finish: squeeze of lemon **or** 1 tsp balsamic vinegar

### Instructions

1. **Preheat oven**
   - Set oven to **425°F (220°C)**.

2. **Prep the sprouts**
   - Trim the tough stem ends.
   - Cut each sprout **in half lengthwise**.

3. **Season**
   - Toss sprouts with:
     - olive oil  
     - salt  
     - pepper  

4. **Arrange for crispiness**
   - Place **cut side down** on a sheet pan.
   - Spread them out so they **aren’t crowded** (this is the key to browning).

5. **Roast**
   - Bake for **18–25 minutes**.
   - They’re done when:
     - the bottoms are **deep golden brown**
     - outer leaves are **crispy**

6. **Finish**
   - Optional but recommended: drizzle **a little lemon juice or balsamic** right after roasting.

---

### Calories (approximate)
- Brussels sprouts (1 lb): ~160 calories  
- 1 tbsp olive oil: ~120 calories  

**Total:** ~280 calories for the entire tray  
→ **~95 calories per serving (3 servings)**

Very high fiber and surprisingly filling.

---

### Flavor Upgrades (Still Light)

Since you like **big flavors in healthy dishes**, these additions work really well:

**1️⃣ Miso-Glazed Brussels**
- Toss roasted sprouts with **½ tsp white miso + 1 tsp warm water**.

**2️⃣ Garlic Soy**
- Add **1 minced garlic clove + 1 tsp soy sauce** during the last 5 minutes.

**3️⃣ Lemon Parmesan**
- Finish with **1 tbsp finely grated parmesan + lemon zest**.

---

✅ **Pro tip:** If you want **restaurant-level crispiness**, preheat the sheet pan in the oven before adding the sprouts. The hot pan immediately sears the cut side.

---

If you want, I can also show you **3 “next level” Brussels sprouts recipes (miso-maple, crispy chili, and balsamic caramelized)** that still stay under **200 calories per serving** but taste restaurant-quality.',
    'pending'
  ),
  (
    'One-Pot Shrimp, Black Bean & Cauliflower Rice Stew',
    'Fish',
    'This version is **lighter and more meal-prep friendly**. The cauliflower rice absorbs the broth and makes it almost like a **shrimp jambalaya or risotto vibe**.',
    NULL,
    NULL,
    '~450 calories',
    NULL,
    'chatgpt_export',
    '69b34504-b290-8326-b690-733c633eb070',
    'Shrimp and Black Bean Stew',
    'This version is **lighter and more meal-prep friendly**. The cauliflower rice absorbs the broth and makes it almost like a **shrimp jambalaya or risotto vibe**.

### Ingredients (2 servings)

- 10 oz shrimp  
- 2 cups cauliflower rice (frozen is fine)  
- 1 cup black beans  
- 1 small onion diced  
- 2 cloves garlic  
- 1 tbsp olive oil  
- 1 tsp cumin  
- ½ tsp smoked paprika  
- 1 cup diced tomatoes  
- ¾ cup vegetable broth  
- juice of ½ lime  
- handful cilantro

Optional flavor boosters

- ½ tsp oregano  
- dash hot sauce  
- 1 tsp soy sauce (adds umami)

---

### Instructions

**1. Cook aromatics**

Heat olive oil in a deep skillet.

Add onion and cook **4 minutes**.

Add garlic, cumin, paprika.

---

**2. Build the base**

Add:

- tomatoes  
- broth  
- black beans  

Simmer **5 minutes**.

---

**3. Add cauliflower rice**

Stir in cauliflower rice and cook **5–6 minutes**.

The mixture will **thicken as the rice absorbs broth**.

---

**4. Add shrimp**

Add shrimp and cook **3 minutes** until pink.

Finish with lime juice and cilantro.

---

### Nutrition (approx)

Per serving:

- Calories: ~330  
- Protein: ~40g  
- Carbs: ~20g  
- Fat: ~10g

Very close to the **high-protein / lower-carb dinners you’ve been experimenting with recently.**

---

💡 **Quick flavor trick for either recipe**

Add **½ tsp cocoa powder or a square of dark chocolate** to the chili version.  
It’s a classic trick used in Mexican chili that adds **depth without sweetness**.

---

✅ Since you cook shrimp and cauliflower rice pretty often, I can also show you **3 more shrimp + bean dishes that feel restaurant-level but stay under ~450 calories** (one of them is a *Spanish shrimp & white bean stew that’s incredible).',
    'pending'
  ),
  (
    'Creamy Greek Yogurt & Dill Fish Stew',
    'Fish',
    'Greek yogurt gives the stew a **luxuriously creamy texture** without the fat of cream, while cauliflower rice thickens the broth.',
    NULL,
    NULL,
    '~420 calories',
    '~40 g protein',
    'chatgpt_export',
    '69b59f21-0f58-832c-9cbd-70f8c323f761',
    'Low-Cal Fish Stew',
    '*(Bright, tangy, Mediterranean-style — great with cod, halibut, or sablefish)*

### Why this works
Greek yogurt gives the stew a **luxuriously creamy texture** without the fat of cream, while cauliflower rice thickens the broth.

### Ingredients (2 servings)
- 10–12 oz **cod, halibut, or sablefish**, cut into chunks  
- 1 ½ cups **frozen cauliflower rice**
- 1 tbsp **olive oil**
- 1 small **leek**, thinly sliced
- 2 cloves **garlic**, minced
- 1 cup **low-sodium vegetable or fish broth**
- ½ cup **plain Greek yogurt**
- zest + juice of **½ lemon**
- 1 tbsp **fresh dill** (or 1 tsp dried)
- ½ tsp **paprika**
- salt + pepper
- optional: handful **spinach or kale**

### Instructions
1. **Sauté aromatics**
   - Heat olive oil in a medium pot.
   - Cook leek with a pinch of salt for **4–5 minutes** until soft.
   - Add garlic and paprika and cook **30 seconds**.

2. **Build the stew**
   - Add broth and cauliflower rice.
   - Simmer **5 minutes** so the cauliflower softens and slightly thickens the liquid.

3. **Cook the fish**
   - Add fish pieces.
   - Simmer gently **4–6 minutes** until just cooked.

4. **Temper the yogurt**
   - In a bowl mix yogurt with lemon zest and juice.
   - Stir in **2–3 tablespoons hot broth** to warm it.

5. **Finish**
   - Reduce heat to low.
   - Stir yogurt mixture into stew.
   - Add dill and greens if using.

### Estimated nutrition (per serving)
- ~420 calories  
- ~40 g protein  
- ~18 g fat  
- very low carb

---',
    'pending'
  ),
  (
    'Coconut Lemongrass Fish & Cauliflower Rice Stew',
    'Fish',
    'A **small amount of coconut milk** gives a silky broth while broth keeps calories down. Cauliflower rice thickens the stew and absorbs flavor.',
    NULL,
    NULL,
    '~450 calories per serving',
    '40 g protein',
    'chatgpt_export',
    '69b59f21-0f58-832c-9cbd-70f8c323f761',
    'Low-Cal Fish Stew',
    '*(Thai-inspired, fragrant, deeply comforting)*

### Why this works
A **small amount of coconut milk** gives a silky broth while broth keeps calories down. Cauliflower rice thickens the stew and absorbs flavor.

### Ingredients (2 servings)
- 10–12 oz **cod, halibut, or shrimp**
- 1 ½ cups **frozen cauliflower rice**
- 1 tbsp **olive oil**
- 1 shallot or small onion, diced
- 2 cloves **garlic**
- 1 tsp **fresh grated ginger**
- 1 tsp **red curry paste**
- 1 cup **light coconut milk**
- 1 cup **vegetable or seafood broth**
- 1 tbsp **soy sauce or fish sauce**
- juice of **½ lime**
- handful **cilantro**
- optional heat: sliced chili or chili crisp

### Instructions
1. **Sauté aromatics**
   - Heat oil in a pot.
   - Cook shallot **3–4 minutes**.
   - Add garlic, ginger, curry paste and cook **1 minute**.

2. **Build broth**
   - Add coconut milk and broth.
   - Bring to a gentle simmer.

3. **Add cauliflower rice**
   - Stir in cauliflower rice.
   - Simmer **5 minutes** so it thickens slightly.

4. **Cook fish**
   - Add fish pieces.
   - Simmer **4–5 minutes** until just cooked.

5. **Finish**
   - Stir in soy sauce, lime juice and cilantro.

### Estimated nutrition
- ~450 calories per serving  
- ~35–40 g protein  
- very filling because of cauliflower rice

---

💡 **Small tricks that make these feel more decadent (without many calories):**

- Finish with **1 tsp olive oil drizzle**  
- Add **miso paste** (you already use this a lot) to deepen flavor  
- Stir in **a spoon of yogurt or coconut milk at the end** for extra creaminess  
- Top with **herbs + chili oil**

---

✅ If you''d like, I can also show you **3 additional variations** that fit your cooking style particularly well:

- **Miso-Coconut Cod Stew** (deep umami, extremely good with sablefish)  
- **Smoky Tomato Yogurt Fish Stew** (almost like a lighter bouillabaisse)  
- **Moroccan Spiced Fish & Cauliflower Stew**

They’re all **~400 calories and one pot**.',
    'pending'
  ),
  (
    'Whipped Ricotta Breakfast Bowl (Dessert-Style) 🍓',
    'Other',
    'This one feels like **cheesecake mousse** but is surprisingly macro-friendly.',
    NULL,
    NULL,
    NULL,
    '25g protein',
    'chatgpt_export',
    '69b5a267-6330-832d-9732-2855121ce712',
    'Ricotta Protein Breakfast Ideas',
    'This one feels like **cheesecake mousse** but is surprisingly macro-friendly.

### Ingredients (1 large serving)
- ½ cup ricotta  
- ½ cup Greek yogurt  
- ¼ cup egg whites *(optional but boosts protein)*  
- ¼ tsp vanilla  
- 1 tsp honey or maple syrup  
- Cinnamon pinch

**Toppings**
- Berries  
- 2 tbsp toasted oats or granola substitute  
- Lemon zest

### Instructions
1. If using egg whites: microwave them **30–40 sec** until just set and cool slightly.
2. Blend or whisk ricotta + yogurt + vanilla + honey until **light and fluffy**.
3. Fold in the cooked egg whites (they disappear into the mixture).
4. Top with berries and oats.

### Approx macros
- **Protein:** ~35 g  
- **Calories:** ~320–350

Very similar satisfaction to **cheesecake filling**.

---

# 3. Ricotta-Stuffed French Toast 🍞
This one feels like a brunch dish but can still stay fairly lean.

### Ingredients (2 servings)
- 3 slices high-protein bread  
- 2 eggs  
- ¼ cup egg whites  
- Cinnamon + vanilla

**Filling**
- ½ cup ricotta  
- ¼ cup Greek yogurt  
- 1 tsp honey  
- Lemon zest

### Instructions
1. Mix ricotta, yogurt, honey, and lemon zest.
2. Make sandwiches with bread + ricotta filling.
3. Whisk eggs, egg whites, cinnamon, vanilla.
4. Dip sandwiches and cook in skillet until golden.

### Approx macros (per serving)
- **Protein:** ~30–35 g  
- **Calories:** ~360–400

---

💡 **Quick Ricotta Trick (I think you’ll like this):**  
If you **blend ricotta + Greek yogurt**, it becomes **very similar to cheesecake filling**. It works as a topping for:

- oatmeal  
- crepes  
- pancakes  
- baked sweet potatoes  
- waffles

…and adds **15–25g protein instantly**.

---

✅ **If you''d like, I can also show you:**
- **3 ultra-high protein ricotta breakfasts (40–50g protein)**  
- **A ricotta crepe upgrade** that tastes like **cannoli filling but is still macro-friendly**.',
    'pending'
  );