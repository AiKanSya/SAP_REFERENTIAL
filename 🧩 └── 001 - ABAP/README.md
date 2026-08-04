# DÉVELOPPEMENT ABAP CLASSIQUE SUR SAP S/4HANA

## PÉRIMÈTRE

Ce dossier est une aide pratique consacrée au développement ABAP classique sur SAP S/4HANA depuis SAP GUI.

Il couvre notamment les transactions de développement et de diagnostic classiques, les programmes exécutables, ABAP Objects, le Dictionnaire ABAP, ABAP SQL, les modules fonction, RFC, BAPI, ALV, les enhancements, les traitements de fond, les journaux applicatifs, les performances et les tests.

ABAP Cloud, Clean Core, CDS, RAP et les autres modèles de développement disposent ou disposeront de dossiers distincts.

## BASE DE COMPATIBILITÉ DU CODE

- Cible minimale : SAP S/4HANA et ABAP Platform associée.
- Les exemples de nouveau code utilisent la syntaxe d’expression disponible sur S/4HANA : déclarations inline, variables hôte `@`, appels de méthodes fonctionnels et opérateurs `NEW`, `VALUE`, `CONV` et `CORRESPONDING` lorsque le contexte s’y prête.
- Une déclaration explicite reste préférée lorsque le type fait partie du contrat, améliore la lecture ou doit survivre à plusieurs branches du traitement.
- Les syntaxes classiques restent présentes uniquement lorsqu’elles sont nécessaires à une API SAP classique ou constituent le sujet du chapitre : `FORM`, `PERFORM`, modules fonction, exceptions classiques, Dynpro et fonctions `REUSE_ALV`.
- Toute syntaxe historique montrée pour la maintenance doit être explicitement qualifiée comme telle et ne doit pas être présentée comme modèle pour un nouveau développement.
- L’aide `F1` du système cible reste l’autorité pour une release S/4HANA précise.

## OBJECTIF ÉDITORIAL

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

## CRITÈRES D’UNE SOLUTION TECHNIQUE IMMÉDIATE

Une page opérationnelle est considérée exploitable lorsqu’elle contient :

- un résultat attendu observable ;
- les objets, transactions et autorisations nécessaires ;
- une procédure exécutable dans l’ordre ;
- un snippet minimal complet ou clairement identifié comme fragment ;
- des commentaires ABAP expliquant les décisions importantes, sans paraphraser chaque instruction ;
- les noms, types et valeurs à remplacer ;
- un contrôle positif et un contrôle d’échec ;
- les erreurs fréquentes avec leur correction ;
- le statut de compatibilité S/4HANA ;
- une référence SAP directement liée à la solution.

Les pages de lexique et les procédures exclusivement administratives ne doivent pas recevoir de code artificiel. Elles doivent fournir un chemin de diagnostic, des valeurs à relever et un critère de sortie.

## CONVENTION DES TITRES

| Niveau Markdown | Usage |
|---|---|
| `#` | Titre unique de la page |
| `##` | Section principale |
| `###` | Sous-section opérationnelle |
| `####` | Détail ponctuel, uniquement si nécessaire |

Règles :

- Un seul titre `#` par fichier.
- Les sections principales utilisent `##`.
- Les sous-sections utilisent `###` seulement lorsqu’elles structurent réellement une section principale.
- Aucune icône décorative ne doit être utilisée dans les titres ou le corps du texte.
- Les sous-dossiers commencent par `🧩` afin de rester identifiables dans l’interface GitHub.
- Les noms intermédiaires de l’arborescence utilisent `├──`.
- Le dernier élément d’un niveau utilise `└──`.
- Les marqueurs d’arborescence sont placés après le numéro : `🧩 08 ├── OPEN SQL` et `🧩 21 └── AUTORISATIONS ET SECURITE ABAP`.
- Les titres décrivent une action ou un résultat concret.

## MODÈLE D’UN TUTORIEL PRATIQUE

```markdown
# ACTION À RÉALISER

## RÉSULTAT ATTENDU

Description directe du résultat.

## PRÉREQUIS

- Version ou composant requis.
- Autorisation ou objet nécessaire.

## PROCÉDURE RAPIDE

1. Ouvrir la transaction.
2. Renseigner les valeurs.
3. Activer et exécuter.

## CODE PRÊT À ADAPTER

Code minimal complet ou fragment explicitement identifié.

## POINTS À REMPLACER

| Élément | Remplacement attendu |
| ------- | -------------------- |
| `Z...`  | Objet client         |

## CONTRÔLE

- Contrôle syntaxique.
- Résultat fonctionnel attendu.
- Valeurs de `SY-SUBRC` ou exceptions pertinentes.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
| -------- | -------------- | ---------- |
| ...      | ...            | ...        |

## COMPATIBILITÉ S/4HANA

- Statut : recommandé, compatible ou historique.
- Limites connues.

## RÉFÉRENCES OFFICIELLES SAP
```

## RÈGLES DE CONTENU

- Commencer par le résultat attendu.
- Conserver uniquement la théorie nécessaire à l’exécution correcte.
- Fournir du code compilable lorsque le sujet le permet.
- Identifier explicitement tout fragment non autonome.
- Ne jamais proposer une modification directe d’une table applicative standard.
- Documenter les effets transactionnels, les autorisations, `SY-SUBRC` et les exceptions pertinentes.
- Qualifier les techniques historiques au lieu de les supprimer lorsqu’elles restent nécessaires à la maintenance.
- Terminer par des références SAP directement liées au sujet.
