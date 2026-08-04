# 🌸 DÉVELOPPEMENT ABAP CLASSIQUE SUR SAP S/4HANA

## 🌺 PÉRIMÈTRE

Ce dossier est une aide pratique consacrée au développement ABAP classique sur SAP S/4HANA depuis SAP GUI.

Il couvre notamment les transactions de développement et de diagnostic classiques, les programmes exécutables, ABAP Objects, le Dictionnaire ABAP, ABAP SQL, les modules fonction, RFC, BAPI, ALV, les enhancements, les traitements de fond, les journaux applicatifs, les performances et les tests.

ABAP Cloud, Clean Core, CDS, RAP et les autres modèles de développement disposent ou disposeront de dossiers distincts.

## 🌺 OBJECTIF ÉDITORIAL

Chaque page doit permettre de réaliser ou de diagnostiquer une action précise sans parcourir un cours complet.

Une page doit répondre directement à ces questions :

1. Quel résultat sera obtenu ?
2. Quels sont les prérequis ?
3. Quelles actions faut-il exécuter dans SAP ?
4. Quel code faut-il adapter ?
5. Quelles valeurs doivent être remplacées ?
6. Comment contrôler le résultat ?
7. Comment corriger les erreurs courantes ?
8. Quel est le statut de la technique sur S/4HANA ?

## 🌺 CONVENTION DES ICÔNES ET DES TITRES

| Niveau Markdown | Icône  | Usage                                     |
| --------------- | ------ | ----------------------------------------- |
| `#`             | `🌸`   | Titre unique de la page                   |
| `##`            | `🌺`   | Section principale                        |
| `###`           | `🌻`   | Sous-section opérationnelle               |
| `####`          | aucune | Détail ponctuel, uniquement si nécessaire |

Règles :

- Un seul titre `# 🌸` par fichier.
- Les sections principales utilisent toujours `## 🌺`.
- Les sous-sections utilisent `### 🌻` seulement lorsqu’elles structurent réellement une section principale.
- Aucune icône décorative ne doit être ajoutée dans le corps du texte.
- L’icône `🍧` reste réservée aux noms de fichiers existants ; elle ne définit pas un niveau Markdown.
- Les titres décrivent une action ou un résultat concret.

## 🌺 MODÈLE D’UN TUTORIEL PRATIQUE

```markdown
# 🌸 ACTION À RÉALISER

## 🌺 RÉSULTAT ATTENDU

Description directe du résultat.

## 🌺 PRÉREQUIS

- Version ou composant requis.
- Autorisation ou objet nécessaire.

## 🌺 PROCÉDURE RAPIDE

1. Ouvrir la transaction.
2. Renseigner les valeurs.
3. Activer et exécuter.

## 🌺 CODE PRÊT À ADAPTER

Code minimal complet ou fragment explicitement identifié.

## 🌺 POINTS À REMPLACER

| Élément | Remplacement attendu |
| ------- | -------------------- |
| `Z...`  | Objet client         |

## 🌺 CONTRÔLE

- Contrôle syntaxique.
- Résultat fonctionnel attendu.
- Valeurs de `SY-SUBRC` ou exceptions pertinentes.

## 🌺 ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
| -------- | -------------- | ---------- |
| ...      | ...            | ...        |

## 🌺 COMPATIBILITÉ S/4HANA

- Statut : recommandé, compatible ou historique.
- Limites connues.

## 🌺 RÉFÉRENCES OFFICIELLES SAP
```

## 🌺 RÈGLES DE CONTENU

- Commencer par le résultat attendu.
- Conserver uniquement la théorie nécessaire à l’exécution correcte.
- Fournir du code compilable lorsque le sujet le permet.
- Identifier explicitement tout fragment non autonome.
- Ne jamais proposer une modification directe d’une table applicative standard.
- Documenter les effets transactionnels, les autorisations, `SY-SUBRC` et les exceptions pertinentes.
- Qualifier les techniques historiques au lieu de les supprimer lorsqu’elles restent nécessaires à la maintenance.
- Terminer par des références SAP directement liées au sujet.
