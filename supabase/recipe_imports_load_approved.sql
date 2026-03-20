-- Load the approved ChatGPT recipe rows into public.recipe_imports
-- Run chatgpt_recipe_import_staging.sql first.
-- These rows are pre-reviewed and set to review_status = 'approved'.
insert into public.recipe_imports (
  title, protein, description, servings, time_text, calories_text, protein_text,
  source_type, source_conversation_id, source_conversation_title, raw_import_text, review_status
) values
  (
    'Apple Pie Oats',
    'Other',
    'High-protein oatmeal with apple, cinnamon, and nutmeg.',
    NULL,
    NULL,
    NULL,
    '~35g protein',
    'chatgpt_export',
    '69939793-0c40-8329-9858-2a494cf2dff8',
    'High Protein Oatmeal Ideas',
    '### Base
- 1/2 cup rolled oats
- 1 cup unsweetened soy milk
- 1/2 cup liquid egg whites
- 1/2 cup nonfat Greek yogurt

Base method: cook oats in soy milk, stir in egg whites on low heat, remove from heat, then stir in Greek yogurt.

### Add-ins
- Diced apple
- Cinnamon
- Nutmeg
- Pinch of salt

### Finish
Cook the apple first if you want it softer, then stir into the finished oats.',
    'approved'
  ),
  (
    'Banana Bread Oats',
    'Other',
    'High-protein oatmeal with mashed banana, cinnamon, and vanilla.',
    NULL,
    NULL,
    NULL,
    '~35-38g protein',
    'chatgpt_export',
    '69939793-0c40-8329-9858-2a494cf2dff8',
    'High Protein Oatmeal Ideas',
    '### Base
- 1/2 cup rolled oats
- 1 cup unsweetened soy milk
- 1/2 cup liquid egg whites
- 1/2 cup nonfat Greek yogurt

Base method: cook oats in soy milk, stir in egg whites on low heat, remove from heat, then stir in Greek yogurt.

### Add-ins
- 1/2 mashed banana
- Cinnamon
- Vanilla
- Optional: extra 1/4 cup Greek yogurt on top

### Finish
Stir the banana into the oats and serve warm.',
    'approved'
  ),
  (
    'Berry Cheesecake Oats',
    'Other',
    'High-protein oatmeal with berries, vanilla, and cinnamon.',
    NULL,
    NULL,
    NULL,
    '~35g protein',
    'chatgpt_export',
    '69939793-0c40-8329-9858-2a494cf2dff8',
    'High Protein Oatmeal Ideas',
    '### Base
- 1/2 cup rolled oats
- 1 cup unsweetened soy milk
- 1/2 cup liquid egg whites
- 1/2 cup nonfat Greek yogurt

Base method: cook oats in soy milk, stir in egg whites on low heat, remove from heat, then stir in Greek yogurt.

### Add-ins
- Frozen mixed berries
- Vanilla extract
- Cinnamon
- Optional: 1 tsp maple syrup

### Finish
Top with berries and serve warm.',
    'approved'
  ),
  (
    'Coconut Lemongrass Fish & Cauliflower Rice Stew',
    'Fish',
    'Thai-inspired fish stew with coconut broth and cauliflower rice.',
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
   - Stir in soy sauce, lime juice and cilantro.',
    'approved'
  ),
  (
    'Coconut-Miso Red Lentil Mash (Ultra Cozy)',
    'Beans',
    'Soft red lentils finished with coconut milk, miso, and lime.',
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

This becomes almost like a savory purée under crispy salmon.',
    'approved'
  ),
  (
    'Cottage Cheese "Cheesecake" Oatmeal',
    'Other',
    'High-protein oatmeal with cottage cheese, vanilla, and fruit.',
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

Tastes way better than it sounds—very filling.',
    'approved'
  ),
  (
    'Creamy Cod with Leeks & Mushrooms (Weeknight-Friendly)',
    'Fish',
    'Weeknight cod with leeks and mushrooms in a creamy skillet sauce.',
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
   Add a small squeeze of lemon if you want brightness.',
    'approved'
  ),
  (
    'Creamy Greek Yogurt & Dill Fish Stew',
    'Fish',
    'Fish stew with Greek yogurt, dill, lemon, and cauliflower rice.',
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
   - Add dill and greens if using.',
    'approved'
  ),
  (
    'Creamy Lemon-Garlic Red Lentils (Mediterranean Style)',
    'Beans',
    'Creamy red lentils finished with lemon, garlic, and olive oil.',
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

👉 Pair with simple roasted salmon (olive oil + paprika + lemon).',
    'approved'
  ),
  (
    'Creamy Miso-Ginger Tofu Skillet',
    'Tofu',
    'Tofu skillet with a creamy miso-ginger sauce.',
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

### Want a direction
- **More protein-maxed** I can tweak these to pair with edamame or lentils  
- **Crispier tofu** I’ll give you my foolproof cornstarch trick  
- **Korean-leaning weekend bowl** I’ll turn one into a full bibimbap-style situation',
    'approved'
  ),
  (
    'Crispy Miso-Maple Tofu with Garlicky Greens',
    'Tofu',
    'Pan-crisped tofu glazed with miso-maple sauce and greens.',
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
**Optional upgrade:** sprinkle sesame seeds or chili crisp',
    'approved'
  ),
  (
    'Crispy Oven-Roasted Brussels Sprouts',
    'Other',
    'Roasted Brussels sprouts with crisp edges and optional lemon or balsamic.',
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
   - Optional but recommended: drizzle **a little lemon juice or balsamic** right after roasting.',
    'approved'
  ),
  (
    'Dump-and-Bake Broccoli, Chickpea & Feta Quinoa Bake',
    'Beans',
    'Quinoa bake with broccoli, chickpeas, and feta.',
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
(Boost it further by serving with Greek yogurt or adding extra feta.)',
    'approved'
  ),
  (
    'Dump-and-Bake Red Lentil Coconut Curry (Ultra Lazy Edition)',
    'Beans',
    'Baked red lentil curry with coconut milk and vegetables.',
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

### Want to optimize further
I can:
- Push these to **30–35g protein** per serving  
- Make them **higher fiber / lower calorie**
- Convert one into a **sheet-pan version**
- Customize for **meal prep (4–5 days fridge-friendly)**',
    'approved'
  ),
  (
    'Dump-and-Bake White Bean, Spinach & Tomato Casserole',
    'Beans',
    'White bean and spinach casserole with tomatoes and mozzarella.',
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
Serve with whole-grain toast or spoon over farro.',
    'approved'
  ),
  (
    'Easy Miso Butter Cod (serves 2)',
    'Fish',
    'Quick baked cod glazed with miso butter.',
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
6. Switch to **broil for 1–2 minutes** to caramelize the top (watch closely!).',
    'approved'
  ),
  (
    'Fish and chickpea stew',
    'Fish',
    'One-pot tomato, chickpea, fish, and rice stew.',
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

Would you like me to give you an **even faster “sheet pan” version** (fish + chickpeas + tomatoes roasted together in the oven)',
    'approved'
  ),
  (
    'Ginger-Scallion Cauliflower Rice (Bright + Umami)',
    'Other',
    'Cauliflower rice with ginger, garlic, soy, and scallions.',
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

✔ Perfect with **salmon, tuna steak, or shrimp**.',
    'approved'
  ),
  (
    'Gochujang Sheet-Pan Tofu & Veggies',
    'Tofu',
    'Sheet-pan tofu and vegetables with a gochujang glaze.',
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
**Optional:** drizzle with sesame oil after baking',
    'approved'
  ),
  (
    'Greek Yogurt Protein Oatmeal',
    'Other',
    'Protein oatmeal with Greek yogurt, berries, and cinnamon.',
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

**Why it works:** yogurt adds creaminess + protein without blowing calories.',
    'approved'
  ),
  (
    'High-Protein Savory Miso Broth Oatmeal',
    'Other',
    'Savory oatmeal cooked in miso broth with eggs and toppings.',
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
2. **Shrimp Miso Oatmeal** – add 3–4 quick sautéed shrimp on top (adds ~10g protein)',
    'approved'
  ),
  (
    'Lemon-Garlic Herb Cauliflower Rice (Mediterranean)',
    'Other',
    'Mediterranean cauliflower rice with lemon, garlic, and herbs.',
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

✔ Great with **cod, halibut, or miso fish**.',
    'approved'
  ),
  (
    'Miso-Butter Cauliflower Rice (Deep Umami)',
    'Other',
    'Cauliflower rice finished with miso butter and scallions.',
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

✔ Incredible with **salmon, sablefish, or shrimp**.',
    'approved'
  ),
  (
    'Miso-Tahini Fish with Caramelized Onions',
    'Fish',
    'Baked fish topped with caramelized onions and lemon tahini sauce.',
    NULL,
    NULL,
    '~450-500 calories',
    '~40 g protein',
    'chatgpt_export',
    '69b0231b-4e1c-832b-90cb-75de846d67b7',
    'Miso-Tahini Fish Recipe',
    '### Why this works
- Deep sweetness from slow caramelized onions
- Creamy richness from tahini sauce
- Brightness from lemon and herbs
- Savory depth from cumin and garlic

### Ingredients (2 servings)
- 2 fillets cod, halibut, or sablefish (5-6 oz each)
- 1 tsp olive oil
- Salt and black pepper

### Caramelized onions
- 2 medium yellow onions, thinly sliced
- 1 tbsp olive oil
- 1/2 tsp cumin
- Pinch of salt

### Lemon tahini sauce
- 2 tbsp tahini
- 2 tbsp Greek yogurt (optional)
- Juice of 1/2 lemon
- 1 small garlic clove, grated
- 2-3 tbsp warm water
- Pinch of salt

### Finish
- Chopped parsley or dill
- Chili flakes
- Lemon zest

### Instructions
1. Heat 1 tbsp olive oil over medium-low. Add onions, cumin, and a pinch of salt. Cook 25-30 minutes until deeply golden, soft, and jammy.
2. Heat oven to 400?F (205?C). Place fish in a baking dish, drizzle with olive oil, and season with salt and pepper.
3. Bake fish 10-12 minutes until flaky.
4. Whisk tahini, Greek yogurt, lemon juice, garlic, warm water, and salt until smooth and pourable.
5. Plate fish, spoon warm onions over the top, and drizzle generously with lemon tahini sauce.
6. Finish with herbs, chili flakes, and lemon zest.',
    'approved'
  ),
  (
    'One-Pot Shrimp, Black Bean & Cauliflower Rice Stew',
    'Fish',
    'Shrimp and black bean stew with cauliflower rice.',
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

Finish with lime juice and cilantro.',
    'approved'
  ),
  (
    'Oven-Baked Creamy Lemon-Garlic Cod (or Halibut)',
    'Fish',
    'Oven-baked cod or halibut in a creamy lemon-garlic sauce.',
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
9. Finish with lemon juice, cracked pepper, and a drizzle of olive oil or knob of butter.',
    'approved'
  ),
  (
    'Protein Pancakes Recipe',
    'Other',
    'Blender oat pancakes with Greek yogurt and eggs.',
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
    'approved'
  ),
  (
    'Restaurant-Style Miso-Ginger Tuna (Nobu Inspired)',
    'Fish',
    'Quick-seared tuna with a miso-ginger sauce.',
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
- chili flakes',
    'approved'
  ),
  (
    'Savory Miso Scallion Oats',
    'Other',
    'Savory high-protein oatmeal with miso, scallions, and black pepper.',
    NULL,
    NULL,
    NULL,
    '~35-40g protein',
    'chatgpt_export',
    '69939793-0c40-8329-9858-2a494cf2dff8',
    'High Protein Oatmeal Ideas',
    '### Base
- 1/2 cup rolled oats
- 1 cup unsweetened soy milk
- 1/2 cup liquid egg whites
- 1/2 cup nonfat Greek yogurt

Base method: cook oats in soy milk, stir in egg whites on low heat, remove from heat, then stir in Greek yogurt.

### Add-ins
- 1 tsp white miso
- Scallions
- Black pepper
- Optional: soft-boiled egg or tofu cubes

### Finish
Stir the miso into the oats at the end and top with scallions and black pepper.',
    'approved'
  ),
  (
    'Savory Oats with Egg Whites and Whole Egg',
    'Other',
    'Savory oatmeal with egg whites, a whole egg, scallions, and chili crisp.',
    NULL,
    NULL,
    '~450-500 calories',
    '~30-35g protein',
    'chatgpt_export',
    '69603e72-2d7c-8331-882e-f90c2409f5b2',
    'Pescatarian High-Protein Breakfasts',
    '### Ingredients
- 1/2 cup rolled oats
- Water or vegetable broth, as needed for cooking
- 1/2 to 3/4 cup liquid egg whites
- 1 soft-boiled or fried egg
- Scallions
- Chili crisp
- Soy sauce

### Instructions
1. Cook the oats in water or vegetable broth until creamy.
2. Stir in the egg whites and cook gently until set.
3. Top with a soft-boiled or fried egg.
4. Finish with scallions, chili crisp, and soy sauce.',
    'approved'
  ),
  (
    'Smoky Harissa Red Lentils',
    'Beans',
    'Red lentils with smoky spices, harissa, and lemon.',
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

This gives cozy, rich energy without feeling heavy.',
    'approved'
  ),
  (
    'Smoky Tomato-Paprika Cauliflower Rice',
    'Other',
    'Smoky cauliflower rice with tomato paste, paprika, and herbs.',
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
    'approved'
  ),
  (
    'Sticky Gochujang Tofu (20-Minute Skillet)',
    'Tofu',
    'Crispy tofu tossed in a sticky gochujang glaze.',
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
This becomes a literal “throw in pan, sauce, eat” dinner.',
    'approved'
  ),
  (
    'Whipped Ricotta Breakfast Bowl',
    'Other',
    'Whipped ricotta and Greek yogurt breakfast bowl with berries and toasted oats.',
    NULL,
    NULL,
    '~320-350 calories',
    '~35 g protein',
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
4. Top with berries and oats.',
    'approved'
  );