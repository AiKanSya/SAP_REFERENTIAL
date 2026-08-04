# DÉVELOPPEMENT ABAP CLASSIQUE SUR SAP S/4HANA

## PÉRIMÈTRE

Ce dossier est une aide pratique consacrée au développement ABAP classique sur SAP S/4HANA depuis SAP GUI.

Il couvre notamment les transactions de développement et de diagnostic classiques, les programmes exécutables, ABAP Objects, le Dictionnaire ABAP, ABAP SQL, les modules fonction, RFC, BAPI, ALV, les enhancements, les traitements de fond, les journaux applicatifs, les performances, les tests, les dynpros, IDoc, formulaires, services BCS, mémoires SAP, batch input, workflow classique, archivage et accès SQL natif.

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

## CONVENTION DE RÉDACTION DES ÉTAPES

Une procédure ne doit pas se limiter à une liste d’actions générales. Chaque étape doit permettre au lecteur d’agir sans devoir déduire l’écran, la valeur ou le contrôle attendu.

Chaque étape opérationnelle doit préciser, lorsque le sujet le permet :

1. **Le point de départ** : transaction, programme, classe, objet du Repository ou écran à ouvrir.
2. **L’action exacte** : bouton, menu, champ, instruction ou méthode à utiliser.
3. **La valeur à fournir** : nom technique, type, format, exemple et origine de la valeur.
4. **Le résultat observable** : statut, message, objet créé, valeur de retour ou donnée affichée.
5. **L’interprétation** : ce que le résultat confirme ou exclut.
6. **La branche suivante** : étape à poursuivre selon un succès, une absence de résultat ou une erreur.
7. **Le critère de sortie** : preuve permettant de considérer l’action ou le diagnostic terminé.

Une formulation vague doit être remplacée par une instruction vérifiable.

| Formulation insuffisante | Formulation attendue |
|---|---|
| Vérifier la configuration | Ouvrir la transaction concernée, rechercher la clé exacte, contrôler les champs déterminants puis indiquer la correction selon la valeur observée |
| Contrôler les données | Nommer la table, la structure, le segment ou le conteneur, préciser les champs à relever et les valeurs attendues |
| Analyser le journal | Indiquer la transaction, les filtres, le message à ouvrir et la décision associée à chaque statut |
| Tester le programme | Définir les données du cas positif et du cas négatif, exécuter puis comparer le résultat observable |
| Corriger l’erreur | Identifier la cause prouvée, modifier l’objet responsable puis répéter uniquement l’étape qui valide la correction |

Pour un diagnostic comportant plusieurs causes possibles, utiliser des étapes distinctes et un tableau de décision. Ne pas mélanger dans une seule étape l’absence d’un événement, une erreur de traitement et un résultat fonctionnel incorrect.

Les pages de lexique et de référence ne doivent pas recevoir artificiellement une procédure. Elles doivent expliquer les notions, indiquer où les observer dans SAP et relier chaque notion aux chapitres opérationnels correspondants.

## CONVENTION DES TITRES

| Niveau Markdown | Numérotation | Usage |
|---|---|---|
| `#` | `10.` | Titre unique du chapitre `10` |
| `##` | `10.A`, `10.B`, ... | Section principale |
| `###` | `10.A.1`, `10.A.2`, ... | Sous-section opérationnelle |
| `####` | `10.A.1.A`, `10.A.1.B`, ... | Détail ponctuel, uniquement si nécessaire |

Règles :

- Un seul titre `#` par fichier.
- Le numéro du titre `#` reprend le numéro placé au début du nom du fichier, sans zéro initial : `01` devient `1.`.
- Chaque niveau supplémentaire alterne lettres majuscules et chiffres : `10.A`, `10.A.1`, `10.A.1.A`.
- Les lettres continuent après `Z` avec `AA`, `AB`, `AC`, etc.
- La numérotation recommence dans chaque fichier et suit l’ordre des titres dans le contenu.
- Les sections principales utilisent `##`.
- Les sous-sections utilisent `###` seulement lorsqu’elles structurent réellement une section principale.
- Aucune icône décorative ne doit être utilisée dans les titres ou le corps du texte.
- Les sous-dossiers commencent par `🧩` afin de rester identifiables dans l’interface GitHub.
- Les noms intermédiaires de l’arborescence utilisent `├──`.
- Le dernier élément d’un niveau utilise `└──`.
- Les marqueurs d’arborescence sont placés après le numéro : `🧩 08 ├── OPEN SQL` et `🧩 34 └── ADBC ET SQL NATIF`.
- Les titres décrivent une action ou un résultat concret.

## CONVENTION DES NOTES DE BAS DE PAGE

Les termes SAP et ABAP spécifiques sont expliqués à leur première occurrence utile dans chaque chapitre avec la syntaxe de note de bas de page prise en charge par GitHub.

```markdown
Le programme s’exécute dans le backend ABAP[^terme-backend].

[^terme-backend]: **BACKEND.** Système serveur qui exécute la logique ABAP et accède aux données. Voir l’entrée correspondante du lexique.
```

Règles :

- Une notion ne reçoit qu’une note par chapitre.
- La définition reste courte et compréhensible sans connaissance préalable du terme.
- La note pointe vers l’entrée stable du lexique lorsqu’elle existe.
- Un code de transaction, un moniteur ou un outil SAP pointe vers le chapitre qui détaille son usage.
- Une source SAP officielle est utilisée directement pour une notion absente du lexique.
- Les titres, les blocs de code et les liens existants ne reçoivent pas de marqueur de note.
- Un identifiant propre à l’exemple, comme `ZCL_...` ou `LV_...`, est expliqué par un commentaire ou par le texte du chapitre, pas par une note de vocabulaire.
- Un terme ambigu n’est annoté que dans un contexte technique explicite.
- Les pages du lexique ne reçoivent pas de notes circulaires : leurs sections constituent les définitions de référence.

## MODÈLE D’UN TUTORIEL PRATIQUE

```markdown
# 10. ACTION À RÉALISER

## 10.A RÉSULTAT ATTENDU

Description directe du résultat.

## 10.B PRÉREQUIS

- Version ou composant requis.
- Autorisation ou objet nécessaire.

## 10.C PROCESS

1. Ouvrir la transaction.
2. Renseigner les valeurs.
3. Activer et exécuter.

### 10.C.1 CONTRÔLER LE RÉSULTAT

Décrire le résultat observable et le critère de sortie.

## 10.D CODE PRÊT À ADAPTER

Code minimal complet ou fragment explicitement identifié.

## 10.E POINTS À REMPLACER

| Élément | Remplacement attendu |
| ------- | -------------------- |
| `Z...`  | Objet client         |

## 10.F CONTRÔLE

- Contrôle syntaxique.
- Résultat fonctionnel attendu.
- Valeurs de `SY-SUBRC` ou exceptions pertinentes.

## 10.G ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
| -------- | -------------- | ---------- |
| ...      | ...            | ...        |

## 10.H COMPATIBILITÉ S/4HANA

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
