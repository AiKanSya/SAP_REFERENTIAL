from __future__ import annotations
import re
import sys
import urllib.parse
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
errors=[]
warnings=[]

expected={1:'🌸',2:'🌺',3:'🍧',4:'💮'}
mds=list(ROOT.rglob('*.md'))
for p in mds:
    text=p.read_text(encoding='utf-8')
    in_fence=False
    h1=0
    for no,line in enumerate(text.splitlines(),1):
        if line.startswith('```'):
            in_fence=not in_fence
            continue
        if in_fence:
            continue
        m=re.match(r'^(#{1,4})\s+(.+)$',line)
        if m:
            level=len(m.group(1)); rest=m.group(2)
            is_lexicon = any('00 - LEXIQUE SAP ET ABAP' in part for part in p.parts)
            is_plain_document = p.name in {'README.md', 'CONTRIBUTING.md'}
            if not (is_lexicon or is_plain_document) and not rest.startswith(expected[level]+' '):
                errors.append(f'{p.relative_to(ROOT)}:{no}: icône attendue {expected[level]}')
            if level==1: h1+=1
    if p.name not in {'README.md','CONTRIBUTING.md'} and h1!=1:
        errors.append(f'{p.relative_to(ROOT)}: {h1} titre(s) H1')
    # liens relatifs Markdown entre chevrons ou parenthèses
    for m in re.finditer(r'\[[^\]]+\]\(<([^>#]+)(?:#[^>]*)?>\)|\[[^\]]+\]\((?!https?://|mailto:)([^)#]+)(?:#[^)]*)?\)',text):
        rel=(m.group(1) or m.group(2)).strip()
        if not rel or rel.startswith('#'): continue
        target=(p.parent/urllib.parse.unquote(rel)).resolve()
        if not target.exists():
            errors.append(f'{p.relative_to(ROOT)}: lien introuvable -> {rel}')
    # Mermaid : détecte les anciens motifs de génération invalides.
    for block in re.findall(r'```mermaid\n(.*?)```',text,re.S):
        for line in block.splitlines():
            s=line.strip()
            if re.search(r'-->\s+[A-Z][A-ZÀ-Ý][a-zà-ÿ]+\s',s):
                errors.append(f'{p.relative_to(ROOT)}: destination Mermaid sans délimiteur: {s}')
            if re.search(r'\b[A-Za-z][A-Za-z0-9_]*\[[^\]"]*[()?:;][^\]"]*\]',s):
                warnings.append(f'{p.relative_to(ROOT)}: libellé Mermaid non quoté: {s}')
            if re.search(r'\b[A-Za-z][A-Za-z0-9_]*\{[^\}"]+\}',s):
                warnings.append(f'{p.relative_to(ROOT)}: décision Mermaid non quotée: {s}')

# Convention de noms de l’arborescence ABAP
for p in ROOT.rglob('*'):
    if '#U' in p.name or '#L0' in p.name:
        errors.append(f'{p.relative_to(ROOT)}: séquence Unicode non décodée')

print(f'{len(mds)} fichiers Markdown contrôlés')
if warnings:
    print(f'{len(warnings)} avertissement(s)')
    for w in warnings[:30]: print('WARNING',w)
if errors:
    print(f'{len(errors)} erreur(s)')
    for e in errors[:100]: print('ERROR',e)
    sys.exit(1)
print('Validation réussie')
