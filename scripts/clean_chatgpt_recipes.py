# -*- coding: utf-8 -*-
import csv
import json
import re
from pathlib import Path

ROOT = Path.cwd()
EXPORT_DIR = ROOT / 'chatgpt-export'
OUT_DIR = ROOT / 'data-import'
TARGET_GIZMO = 'g-p-69534c4a2bd881918d461401f82ff136'


def b(*codes):
    return ''.join(chr(c) for c in codes)


REPLACEMENTS = {
    b(226, 128, 153): "'",
    b(226, 128, 152): "'",
    b(226, 128, 156): '"',
    b(226, 128, 157): '"',
    b(226, 128, 148): '-',
    b(226, 128, 147): '-',
    b(226, 128, 162): '-',
    b(226, 134, 146): '->',
    b(194, 189): '1/2',
    b(194, 188): '1/4',
    b(194, 190): '3/4',
    b(194, 176): ' degrees',
    b(194,): '',
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


def normalize_title(text):
    text = clean_text(text)
    text = re.sub(r'^#+\s*', '', text)
    text = re.sub(r'^\d+[.)]\s*', '', text)
    text = re.sub(r'^([^A-Za-z0-9]+)', '', text)
    return text.strip(' *-_')


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
    title = record['title'].strip()
    body = record['raw_text'].lower()
    if title.lower().startswith('quick protein rules'):
        continue
    if 'would you like me to' in body and 'ingredients' not in body and 'instructions' not in body and 'how to make' not in body and 'method' not in body:
        continue
    key = (title.lower(), record['source_conversation_id'])
    if key in seen:
        continue
    seen.add(key)
    filtered.append(record)

compat_rows = [
    {
        'title': r['title'],
        'protein': r['protein'],
        'description': r['description'][:240],
        'ingredients': 'TO REVIEW: extracted from ChatGPT export\n\n' + r['raw_text'],
        'instructions': 'TO REVIEW: parse final recipe steps from extracted text\n\n' + r['raw_text'],
    }
    for r in filtered
]

(OUT_DIR / 'recipes-project-cleaned.json').write_text(json.dumps(filtered, indent=2, ensure_ascii=False), encoding='utf-8')
write_csv(OUT_DIR / 'recipes-project-cleaned.csv', filtered, ['title', 'protein', 'description', 'servings', 'time', 'calories', 'protein_note', 'source_conversation_id', 'source_conversation_title', 'raw_text'])
(OUT_DIR / 'recipes-project-cleaned-current-schema.json').write_text(json.dumps(compat_rows, indent=2, ensure_ascii=False), encoding='utf-8')
write_csv(OUT_DIR / 'recipes-project-cleaned-current-schema.csv', compat_rows, ['title', 'protein', 'description', 'ingredients', 'instructions'])

summary = {
    'conversation_count': len(conversations),
    'cleaned_recipe_count': len(filtered),
    'with_servings': sum(1 for r in filtered if r['servings']),
    'with_time': sum(1 for r in filtered if r['time']),
    'with_calories': sum(1 for r in filtered if r['calories']),
    'with_protein_note': sum(1 for r in filtered if r['protein_note']),
}
print(json.dumps(summary, indent=2, ensure_ascii=False))
