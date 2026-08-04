# TABLE DE SORTIE ET CATALOGUE DE CHAMPS

## RÉSULTAT ATTENDU

- Construire une table de sortie stable
- Définir un catalogue `LVC_T_FCAT`
- Gérer textes, références et propriétés de colonnes

## TABLE DE SORTIE

La table affichée doit représenter le contrat entre le programme et l’ALV. Éviter d’afficher directement une table de base lorsqu’une structure dédiée permet de :

- renommer les champs ;
- ajouter des indicateurs ;
- calculer des valeurs ;
- stocker styles et couleurs ;
- isoler le modèle d’affichage du modèle persistant.

## CATALOGUE MANUEL

```abap
DATA:
  gt_fieldcat TYPE lvc_t_fcat,
  gs_fieldcat TYPE lvc_s_fcat.

CLEAR gs_fieldcat.
gs_fieldcat-fieldname = 'CARRID'.
gs_fieldcat-coltext   = 'Compagnie'.
gs_fieldcat-key       = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.

CLEAR gs_fieldcat.
gs_fieldcat-fieldname  = 'PRICE'.
gs_fieldcat-coltext    = 'Prix'.
gs_fieldcat-ref_table  = 'SFLIGHT'.
gs_fieldcat-ref_field  = 'PRICE'.
gs_fieldcat-cfieldname = 'CURRENCY'.
gs_fieldcat-do_sum     = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.
```

## PROPRIÉTÉS IMPORTANTES

| Champ                      | Fonction                     |
| -------------------------- | ---------------------------- |
| `FIELDNAME`                | Champ de la table de sortie  |
| `REF_TABLE`, `REF_FIELD`   | Référence DDIC               |
| `COLTEXT`                  | Texte de colonne             |
| `KEY`                      | Colonne clé                  |
| `EDIT`                     | Colonne modifiable           |
| `HOTSPOT`                  | Zone cliquable               |
| `CHECKBOX`                 | Affichage case à cocher      |
| `ICON`                     | Interprétation comme icône   |
| `NO_OUT`                   | Colonne masquée initialement |
| `TECH`                     | Colonne technique            |
| `DO_SUM`                   | Totalisation                 |
| `CFIELDNAME`, `QFIELDNAME` | Devise ou unité associée     |

## GÉNÉRATION AUTOMATIQUE

Lorsque la table de sortie correspond à une structure DDIC, `I_STRUCTURE_NAME` peut éviter un catalogue manuel. Ne fournir un catalogue explicite que lorsque des propriétés doivent être adaptées.

## PROCESS

### Étape 1 — Définir la structure finale de sortie

Créer un type ou une structure DDIC contenant exactement les colonnes affichées. Séparer cette structure des tables de base afin de ne pas exposer des champs inutiles.

### Étape 2 — Alimenter la table avant l’appel ALV

Récupérer et transformer les données dans la table de sortie. Calculer les textes et statuts en dehors des gestionnaires d’événements de la grille.

### Étape 3 — Choisir entre métadonnées DDIC et catalogue manuel

Utiliser `I_STRUCTURE_NAME` lorsque la table suit une structure DDIC adaptée. Construire `LVC_T_FCAT` lorsqu’il faut contrôler explicitement les colonnes ou lorsque la structure est locale.

### Étape 4 — Décrire chaque colonne manuelle

Renseigner au minimum `FIELDNAME` avec le nom exact du composant. Ajouter les références DDIC, textes, longueur, clé, visibilité, unité ou devise selon la sémantique du champ.

### Étape 5 — Valider le catalogue avant l’affichage

Rechercher les noms inconnus, doublons et références d’unité ou devise absentes. Le catalogue doit décrire la table réellement transmise à `SET_TABLE_FOR_FIRST_DISPLAY`.

### Étape 6 — Tester le rendu des conversions

Vérifier les dates, quantités, montants, unités, devises, zéros initiaux et colonnes techniques. Comparer chaque valeur affichée à la structure de sortie.

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA:
  gt_fieldcat TYPE lvc_t_fcat,
  gs_fieldcat TYPE lvc_s_fcat.

CLEAR gs_fieldcat.
gs_fieldcat-fieldname = 'CARRID'.
gs_fieldcat-coltext   = 'Compagnie'.
gs_fieldcat-key       = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.

CLEAR gs_fieldcat.
gs_fieldcat-fieldname  = 'PRICE'.
gs_fieldcat-coltext    = 'Prix'.
gs_fieldcat-ref_table  = 'SFLIGHT'.
gs_fieldcat-ref_field  = 'PRICE'.
gs_fieldcat-cfieldname = 'CURRENCY'.
gs_fieldcat-do_sum     = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.
```

## TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## RÉFÉRENCES OFFICIELLES SAP

- [The Field Catalog — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebaa38d251e56a4e10000000a421937.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)

---

[Chapitre suivant — LAYOUT ET VARIANTES DU GRID](<./13 ├── LAYOUT ET VARIANTES DU GRID.md>)
