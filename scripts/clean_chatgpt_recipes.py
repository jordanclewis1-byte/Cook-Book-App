# -*- coding: utf-8 -*-
import csv
import json
import re
from pathlib import Path

ROOT = Path.cwd()
EXPORT_DIR = ROOT / 'chatgpt-export'
OUT_DIR = ROOT / 'data-import'
TARGET_GIZMO = 'g-p-69534c4a2bd881918d461401f82ff136'

APPROVED_NORMALIZED_TITLES = {
    'fish and chickpea stew',
    'oven-baked creamy lemon-garlic cod (or halibut)',
    'easy miso butter cod (serves 2)',
    'greek yogurt protein oatmeal',
    'cottage cheese "cheesecake" oatmeal',
    'creamy cod with leeks & mushrooms (weeknight-friendly)',
    'protein pancakes recipe',
    'dump-and-bake broccoli, chickpea & feta quinoa bake',
    'dump-and-bake white bean, spinach & tomato casserole',
    'dump-and-bake red lentil coconut curry (ultra lazy edition)',
    'crispy miso-maple tofu with garlicky greens',
    'gochujang sheet-pan tofu & veggies',
    'creamy miso-ginger tofu skillet',
    'sticky gochujang tofu (20-minute skillet)',
    'creamy lemon-garlic red lentils (mediterranean style)',
    'smoky harissa red lentils',
    'coconut-miso red lentil mash (ultra cozy)',
    'high-protein savory miso broth oatmeal',
    'restaurant-style miso-ginger tuna (nobu inspired)',
    'ginger-scallion cauliflower rice (bright + umami)',
    'lemon-garlic herb cauliflower rice (mediterranean)',
    'miso-butter cauliflower rice (deep umami)',
    'smoky tomato-paprika cauliflower rice',
    'crispy oven-roasted brussels sprouts',
    'one-pot shrimp, black bean & cauliflower rice stew',
    'creamy greek yogurt & dill fish stew',
    'coconut lemongrass fish & cauliflower rice stew',
}

HOLD_NORMALIZED_TITLES = {
    'one-pan halibut with leeky brown rice',
    'egg-white oatmeal (creamy, not eggy)',
    'high protein oatmeal ideas',
    'high-protein egg white crepes with ricotta & berries',
    'why this recipe works',
    'fish',
    'bake the fish',
    'whipped ricotta breakfast bowl (dessert-style)',
}

REJECT_NORMALIZED_TITLES = {
    'low-carb sides for eggs',
}

TITLE_OVERRIDES = {
    'dump-and-bake broccoli, chickpea & feta quinoa bake': 'Dump-and-Bake Broccoli, Chickpea & Feta Quinoa Bake',
    'dump-and-bake white bean, spinach & tomato casserole': 'Dump-and-Bake White Bean, Spinach & Tomato Casserole',
    'dump-and-bake red lentil coconut curry (ultra lazy edition)': 'Dump-and-Bake Red Lentil Coconut Curry (Ultra Lazy Edition)',
    'crispy miso-maple tofu with garlicky greens': 'Crispy Miso-Maple Tofu with Garlicky Greens',
    'gochujang sheet-pan tofu & veggies': 'Gochujang Sheet-Pan Tofu & Veggies',
    'creamy miso-ginger tofu skillet': 'Creamy Miso-Ginger Tofu Skillet',
    'restaurant-style miso-ginger tuna (nobu inspired)': 'Restaurant-Style Miso-Ginger Tuna (Nobu Inspired)',
    'cottage cheese "cheesecake" oatmeal': 'Cottage Cheese "Cheesecake" Oatmeal',
}

PROTEIN_OVERRIDES = {
    'greek yogurt protein oatmeal': 'Other',
    'cottage cheese "cheesecake" oatmeal': 'Other',
    'protein pancakes recipe': 'Other',
    'creamy lemon-garlic red lentils (mediterranean style)': 'Beans',
    'smoky harissa red lentils': 'Beans',
    'coconut-miso red lentil mash (ultra cozy)': 'Beans',
    'high-protein savory miso broth oatmeal': 'Other',
    'ginger-scallion cauliflower rice (bright + umami)': 'Other',
    'lemon-garlic herb cauliflower rice (mediterranean)': 'Other',
    'miso-butter cauliflower rice (deep umami)': 'Other',
    'smoky tomato-paprika cauliflower rice': 'Other',
}

DESCRIPTION_OVERRIDES = {
    'fish and chickpea stew': 'One-pot tomato, chickpea, fish, and rice stew.',
    'oven-baked creamy lemon-garlic cod (or halibut)': 'Oven-baked cod or halibut in a creamy lemon-garlic sauce.',
    'easy miso butter cod (serves 2)': 'Quick baked cod glazed with miso butter.',
    'greek yogurt protein oatmeal': 'Protein oatmeal with Greek yogurt, berries, and cinnamon.',
    'cottage cheese "cheesecake" oatmeal': 'High-protein oatmeal with cottage cheese, vanilla, and fruit.',
    'creamy cod with leeks & mushrooms (weeknight-friendly)': 'Weeknight cod with leeks and mushrooms in a creamy skillet sauce.',
    'protein pancakes recipe': 'Blender oat pancakes with Greek yogurt and eggs.',
    'dump-and-bake broccoli, chickpea & feta quinoa bake': 'Quinoa bake with broccoli, chickpeas, and feta.',
    'dump-and-bake white bean, spinach & tomato casserole': 'White bean and spinach casserole with tomatoes and mozzarella.',
    'dump-and-bake red lentil coconut curry (ultra lazy edition)': 'Baked red lentil curry with coconut milk and vegetables.',
    'crispy miso-maple tofu with garlicky greens': 'Pan-crisped tofu glazed with miso-maple sauce and greens.',
    'gochujang sheet-pan tofu & veggies': 'Sheet-pan tofu and vegetables with a gochujang glaze.',
    'creamy miso-ginger tofu skillet': 'Tofu skillet with a creamy miso-ginger sauce.',
    'sticky gochujang tofu (20-minute skillet)': 'Crispy tofu tossed in a sticky gochujang glaze.',
    'creamy lemon-garlic red lentils (mediterranean style)': 'Creamy red lentils finished with lemon, garlic, and olive oil.',
    'smoky harissa red lentils': 'Red lentils with smoky spices, harissa, and lemon.',
    'coconut-miso red lentil mash (ultra cozy)': 'Soft red lentils finished with coconut milk, miso, and lime.',
    'high-protein savory miso broth oatmeal': 'Savory oatmeal cooked in miso broth with eggs and toppings.',
    'restaurant-style miso-ginger tuna (nobu inspired)': 'Quick-seared tuna with a miso-ginger sauce.',
    'ginger-scallion cauliflower rice (bright + umami)': 'Cauliflower rice with ginger, garlic, soy, and scallions.',
    'lemon-garlic herb cauliflower rice (mediterranean)': 'Mediterranean cauliflower rice with lemon, garlic, and herbs.',
    'miso-butter cauliflower rice (deep umami)': 'Cauliflower rice finished with miso butter and scallions.',
    'smoky tomato-paprika cauliflower rice': 'Smoky cauliflower rice with tomato paste, paprika, and herbs.',
    'crispy oven-roasted brussels sprouts': 'Roasted Brussels sprouts with crisp edges and optional lemon or balsamic.',
    'one-pot shrimp, black bean & cauliflower rice stew': 'Shrimp and black bean stew with cauliflower rice.',
    'creamy greek yogurt & dill fish stew': 'Fish stew with Greek yogurt, dill, lemon, and cauliflower rice.',
    'coconut lemongrass fish & cauliflower rice stew': 'Thai-inspired fish stew with coconut broth and cauliflower rice.',
}

TAIL_PATTERNS = [
    r'\n+If you want, I can[\s\S]*$',
    r'\n+If you\'d like, I can[\s\S]*$',
    r'\n+Just say the word[\s\S]*$',
    r'\n+Just tell me your priority[\s\S]*$',
    r'\n+Want me to turn this into[\s\S]*$',
    r'\n+Since you cook[\s\S]*$',
    r'\n+If you want, I can also[\s\S]*$',
    r'\n+If you\'d like, I can also[\s\S]*$',
    r'\n+### Want to optimize further\?[\s\S]*$',
    r'\n+### Want a direction\?[\s\S]*$',
    r'\n+### Flavor Upgrades \(Still Light\)[\s\S]*$',
    r'\n+### Optional Easy Upgrades[\s\S]*$',
    r'\n+### What to Serve It With[\s\S]*$',
    r'\n+### Simple sides that fit your cooking style[\s\S]*$',
    r'\n+### Estimated nutrition[\s\S]*$',
    r'\n+### Nutrition \(approx\.\)[\s\S]*$',
    r'\n+### Approx macros[\s\S]*$',
    r'\n+### Approximate nutrition \(per serving\)[\s\S]*$',
    r'\n+### Calories \(approximate\)[\s\S]*$',
    r'\n+\u2705[\s\S]*$',
    r'\n+\U0001f4a1[\s\S]*$',
]

SECTION_DROP_PATTERNS = [
    r'\n+### Key oven tweaks \(why they matter\)[\s\S]*?(?=\n---|$)',
    r'\n+### Optional broiler finish \(restaurant-y touch\)[\s\S]*?(?=\n---|$)',
    r'\n+### What to watch out for[\s\S]*?(?=\n---|$)',
    r'\n+### Make-ahead friendly\?[\s\S]*?(?=\n---|$)',
    r'\n+### Easy variations[\s\S]*?(?=\n---|$)',
    r'\n+### How to serve it[\s\S]*?(?=\n---|$)',
    r'\n+### Tips[\s\S]*?(?=\n---|$)',
]

REPLACEMENTS = {
    ''.join(chr(c) for c in (226, 128, 153)): "'",
    ''.join(chr(c) for c in (226, 128, 152)): "'",
    ''.join(chr(c) for c in (226, 128, 156)): '"',
    ''.join(chr(c) for c in (226, 128, 157)): '"',
    ''.join(chr(c) for c in (226, 128, 148)): '-',
    ''.join(chr(c) for c in (226, 128, 147)): '-',
    ''.join(chr(c) for c in (226, 128, 162)): '-',
    ''.join(chr(c) for c in (226, 134, 146)): '->',
    ''.join(chr(c) for c in (194, 189)): '1/2',
    ''.join(chr(c) for c in (194, 188)): '1/4',
    ''.join(chr(c) for c in (194, 190)): '3/4',
    ''.join(chr(c) for c in (194, 176)): ' degrees',
    ''.join(chr(c) for c in (194,)): '',
}


def fix_mojibake(text):
    if not isinstance(text, str):
        return text
    fixed = text
    for bad, good in REPLACEMENTS.items():
        fixed = fixed.replace(bad, good)
    fixed = re.sub(r'\u00f0\u0178[^\s]*', '', fixed)
    return fixed


def clean_text(text):
    text = fix_mojibake(text or '')
    text = re.sub(r'\ue200[^\ue201]*\ue201', '', text)
    text = re.sub(r'image_group\{[^\n]*\}', '', text)
    text = text.replace('\r', '')
    text = re.sub(r'\n{3,}', '\n\n', text)
    return text.strip()


def normalize_title(text):
    text = clean_text(text)
    text = re.sub(r'^#+\s*', '', text)
    text = re.sub(r'^\d+[.)]\s*', '', text)
    text = re.sub(r'^[^A-Za-z0-9]+', '', text)
    text = text.strip(' *-_')
    text = text.replace('“', '"').replace('”', '"').replace('–', '-').replace('—', '-')
    return text.strip()


def normalized_key(text):
    text = normalize_title(text)
    text = text.replace('”', '"').replace('“', '"').replace('–', '-').replace('—', '-')
    text = re.sub(r'\s+', ' ', text)
    return text.lower().strip()


def strip_chatgpt_tail(text):
    text = clean_text(text)
    for pattern in SECTION_DROP_PATTERNS:
        text = re.sub(pattern, '', text, flags=re.I)
    for pattern in TAIL_PATTERNS:
        text = re.sub(pattern, '', text, flags=re.I)
    text = re.sub(r'\n---\s*$', '', text)
    text = re.sub(r'\n{3,}', '\n\n', text)
    return text.strip()


def read_conversations():
    conversations = []
    for path in sorted(EXPORT_DIR.glob('conversations-*.json')):
        conversations.extend(json.loads(path.read_text(encoding='utf-8')))
    return conversations


def walk_thread(conv):
    mapping = conv.get('mapping', {})
    current = conv.get('current_node')
    chain = []
    seen = set()
    while current and current not in seen and current in mapping:
        seen.add(current)
        node = mapping[current]
        message = node.get('message')
        if message:
            chain.append(message)
        current = node.get('parent')
    chain.reverse()
    return chain


def message_text(message):
    content = (message or {}).get('content') or {}
    content_type = content.get('content_type')
    if content_type in {'text', 'multimodal_text'}:
        parts = []
        for part in content.get('parts') or []:
            if isinstance(part, str):
                parts.append(part)
            elif isinstance(part, dict) and isinstance(part.get('text'), str):
                parts.append(part['text'])
        return clean_text('\n'.join(parts))
    if content_type == 'code':
        return clean_text(content.get('text') or '')
    return ''


def is_recipe_like(text):
    low = text.lower()
    structure = any(token in low for token in ['ingredients', 'instructions', 'how to make', 'method'])
    food = any(token in low for token in ['recipe', 'fish', 'cod', 'halibut', 'tuna', 'shrimp', 'tofu', 'oat', 'lentil', 'bean', 'rice', 'breakfast', 'sprouts', 'quinoa', 'cauliflower'])
    return structure and food


def score_recipe_message(text):
    low = text.lower()
    score = len(text)
    for token, weight in [
        ('ingredients', 800),
        ('instructions', 800),
        ('how to make', 600),
        ('method', 500),
        ('serves', 300),
        ('prep:', 200),
        ('cook:', 200),
        ('total:', 200),
    ]:
        if token in low:
            score += weight
    for token, penalty in [
        ('nutrition information', 1500),
        ('soften the butter', 1500),
        ('best time to add', 1200),
        ("what's the best way", 1200),
    ]:
        if token in low:
            score -= penalty
    return score


def select_primary_recipe_text(conv):
    assistant_texts = [
        message_text(m)
        for m in walk_thread(conv)
        if (m.get('author') or {}).get('role') == 'assistant'
    ]
    assistant_texts = [t for t in assistant_texts if t]
    candidates = [t for t in assistant_texts if is_recipe_like(t)]
    if not candidates:
        return assistant_texts[-1] if assistant_texts else ''
    return sorted(candidates, key=score_recipe_message, reverse=True)[0]


def split_multi_recipe_sections(text):
    lines = text.split('\n')
    sections = []
    current = None
    for raw in lines:
        line = raw.strip()
        if line.startswith('#'):
            heading = normalize_title(line)
            if re.search(r'(recipe|oatmeal|crepes|stew|bake|tofu|fish|rice|sprouts|breakfast|quinoa|cauliflower|lentil|tuna|cod|halibut)', heading, re.I):
                if current:
                    sections.append(current)
                current = {'heading': heading, 'lines': []}
                continue
        if current:
            current['lines'].append(raw)
    if current:
        sections.append(current)
    return [s for s in sections if re.search(r'(ingredients|instructions|how to make|method)', '\n'.join(s['lines']), re.I)]


def infer_protein(title, body):
    low = f'{title}\n{body}'.lower()
    checks = [
        ('Fish', ['cod', 'halibut', 'fish', 'tuna', 'salmon', 'shrimp', 'seafood', 'pollock', 'smoked salmon']),
        ('Tofu', ['tofu']),
        ('Beans', ['bean', 'beans', 'lentil', 'lentils', 'chickpea', 'chickpeas']),
        ('Chicken', ['chicken']),
        ('Beef', ['beef', 'meatball']),
        ('Pork', ['pork']),
        ('Turkey', ['turkey']),
    ]
    for label, patterns in checks:
        if any(p in low for p in patterns):
            return label
    return 'Other'


def extract(regex, text):
    match = re.search(regex, text, re.I)
    return clean_text(match.group(1)) if match else None


def build_record(conv, title, body, idx, multi):
    description = None
    for line in body.split('\n'):
        stripped = line.strip()
        if stripped and not stripped.startswith(('-', '*', '#')) and not re.match(r'^\d+[.)]', stripped):
            description = stripped
            break
    return {
        'source_conversation_id': conv['id'],
        'source_conversation_title': clean_text(conv['title']),
        'source_gizmo_id': conv.get('gizmo_id'),
        'extracted_from_multi_recipe': multi,
        'recipe_index': idx,
        'title': clean_text(title),
        'description': clean_text(description or conv['title']),
        'protein': infer_protein(title, body),
        'servings': extract(r'serves\s*:?\s*([^\n]+)', body),
        'time': extract(r'(?:total time|time)\s*:?\s*([^\n]+)', body),
        'calories': extract(r'(~?\d+\s*(?:-|--)??\s*\d*\s*cal(?:ories)?(?:\s*per\s*serving)?)', body),
        'protein_note': extract(r'(~?\d+\s*(?:-|--)??\s*\d*\s*g\s*protein(?:\s*(?:per\s*serving|total|day))?)', body),
        'raw_text': clean_text(body),
    }


def conversation_to_records(conv):
    primary = select_primary_recipe_text(conv)
    sections = split_multi_recipe_sections(primary)
    records = []
    if sections:
        for idx, section in enumerate(sections, 1):
            heading = section['heading']
            body = clean_text('\n'.join(section['lines']))
            if heading.lower().startswith('quick protein rules'):
                continue
            records.append(build_record(conv, heading, body, idx, True))
    else:
        records.append(build_record(conv, conv['title'], primary, 1, False))
    return records


def normalize_record(record):
    key = normalized_key(record['title'])
    title = TITLE_OVERRIDES.get(key, normalize_title(record['title']))
    raw_text = strip_chatgpt_tail(record['raw_text'])
    description = DESCRIPTION_OVERRIDES.get(key, clean_text(record.get('description') or title))[:240]
    protein = PROTEIN_OVERRIDES.get(key, record['protein'])
    return {
        **record,
        'normalized_title': key,
        'title': title,
        'description': description,
        'protein': protein,
        'raw_text': raw_text,
        'review_status': 'approved' if key in APPROVED_NORMALIZED_TITLES else 'hold' if key in HOLD_NORMALIZED_TITLES else 'rejected' if key in REJECT_NORMALIZED_TITLES else 'unclassified',
    }


def to_current_schema(record):
    return {
        'title': record['title'],
        'protein': record['protein'],
        'description': record['description'],
        'ingredients': 'TO REVIEW: extracted from ChatGPT export\n\n' + record['raw_text'],
        'instructions': 'TO REVIEW: parse final recipe steps from extracted text\n\n' + record['raw_text'],
    }


def write_csv(path, rows, columns):
    with path.open('w', encoding='utf-8', newline='') as fh:
        writer = csv.DictWriter(fh, fieldnames=columns)
        writer.writeheader()
        for row in rows:
            writer.writerow({k: row.get(k) for k in columns})


conversations = [c for c in read_conversations() if c.get('gizmo_id') == TARGET_GIZMO]
conversations.sort(key=lambda c: c.get('create_time') or 0)
records = []
for conv in conversations:
    records.extend(conversation_to_records(conv))

filtered = []
seen = set()
for record in records:
    title_key = normalized_key(record['title'])
    if title_key.startswith('quick protein rules'):
        continue
    key = (title_key, record['source_conversation_id'])
    if key in seen:
        continue
    seen.add(key)
    filtered.append(record)

normalized_records = [normalize_record(record) for record in filtered]
approved_records = [record for record in normalized_records if record['review_status'] == 'approved']
hold_records = [record for record in normalized_records if record['review_status'] == 'hold']
rejected_records = [record for record in normalized_records if record['review_status'] == 'rejected']
unclassified_records = [record for record in normalized_records if record['review_status'] == 'unclassified']

compat_rows = [to_current_schema(record) for record in normalized_records]
approved_compat_rows = [to_current_schema(record) for record in approved_records]

(OUT_DIR / 'recipes-project-cleaned.json').write_text(json.dumps(normalized_records, indent=2, ensure_ascii=False), encoding='utf-8')
write_csv(OUT_DIR / 'recipes-project-cleaned.csv', normalized_records, ['title', 'protein', 'description', 'servings', 'time', 'calories', 'protein_note', 'source_conversation_id', 'source_conversation_title', 'review_status', 'raw_text'])
(OUT_DIR / 'recipes-project-cleaned-current-schema.json').write_text(json.dumps(compat_rows, indent=2, ensure_ascii=False), encoding='utf-8')
write_csv(OUT_DIR / 'recipes-project-cleaned-current-schema.csv', compat_rows, ['title', 'protein', 'description', 'ingredients', 'instructions'])
(OUT_DIR / 'recipes-project-approved.json').write_text(json.dumps(approved_records, indent=2, ensure_ascii=False), encoding='utf-8')
write_csv(OUT_DIR / 'recipes-project-approved.csv', approved_records, ['title', 'protein', 'description', 'servings', 'time', 'calories', 'protein_note', 'source_conversation_id', 'source_conversation_title', 'review_status', 'raw_text'])
(OUT_DIR / 'recipes-project-approved-current-schema.json').write_text(json.dumps(approved_compat_rows, indent=2, ensure_ascii=False), encoding='utf-8')
write_csv(OUT_DIR / 'recipes-project-approved-current-schema.csv', approved_compat_rows, ['title', 'protein', 'description', 'ingredients', 'instructions'])
(OUT_DIR / 'recipes-project-hold.json').write_text(json.dumps(hold_records, indent=2, ensure_ascii=False), encoding='utf-8')
(OUT_DIR / 'recipes-project-rejected.json').write_text(json.dumps(rejected_records, indent=2, ensure_ascii=False), encoding='utf-8')
if unclassified_records:
    (OUT_DIR / 'recipes-project-unclassified.json').write_text(json.dumps(unclassified_records, indent=2, ensure_ascii=False), encoding='utf-8')

summary = {
    'conversation_count': len(conversations),
    'cleaned_recipe_count': len(normalized_records),
    'approved_count': len(approved_records),
    'hold_count': len(hold_records),
    'rejected_count': len(rejected_records),
    'unclassified_count': len(unclassified_records),
    'with_servings': sum(1 for r in approved_records if r['servings']),
    'with_time': sum(1 for r in approved_records if r['time']),
    'with_calories': sum(1 for r in approved_records if r['calories']),
    'with_protein_note': sum(1 for r in approved_records if r['protein_note']),
}
print(json.dumps(summary, indent=2, ensure_ascii=False))
