# 9. TRAITER LES LIGNES AVEC INTO, ASSIGNING ET REFERENCE INTO

## 9.A RÉSULTAT ATTENDU

- Comprendre les trois modes principaux d’accès à une ligne
- Distinguer copie, affectation directe et référence
- Modifier efficacement des lignes pendant un parcours
- Éviter les modifications involontaires
- Choisir le mode adapté au traitement

## 9.B INTO : COPIER LA LIGNE

```abap
" Exemple à éviter : comparer avec la correction décrite après le bloc.
LOOP AT lt_products INTO DATA(ls_product).
  ls_product-stock = ls_product-stock + 1.
ENDLOOP.
```

`ls_product` est une copie. La table n’est pas modifiée par cette seule affectation.

Pour répercuter la modification :

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_products INTO DATA(ls_product).
  ls_product-stock = ls_product-stock + 1.
  MODIFY lt_products FROM ls_product INDEX sy-tabix.
ENDLOOP.
```

## 9.C ASSIGNING : ACCÈS DIRECT

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_products ASSIGNING FIELD-SYMBOL(<ls_product>).
  <ls_product>-stock = <ls_product>-stock + 1.
ENDLOOP.
```

Le symbole de champ désigne directement la ligne courante. Aucun `MODIFY` supplémentaire n’est nécessaire pour les composants modifiables.

```mermaid
flowchart LR
    A["Ligne de la table"] -->|"INTO"| B["Copie dans une zone de travail"]
    A -->|"ASSIGNING"| C["Accès direct par symbole de champ"]
    A -->|"REFERENCE INTO"| D["Référence vers la ligne"]
```

## 9.D REFERENCE INTO

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_products REFERENCE INTO DATA(lr_product).
  lr_product->stock = lr_product->stock + 1.
ENDLOOP.
```

La variable de référence pointe vers la ligne de la table.

## 9.E COMPARAISON

| Mode             | Copie de la ligne | Modification directe | Usage principal                              |
| ---------------- | ----------------: | -------------------: | -------------------------------------------- |
| `INTO`           |               Oui |                  Non | Lecture isolée ou traitement d’une copie     |
| `ASSIGNING`      |               Non |                  Oui | Parcours et modification directe             |
| `REFERENCE INTO` |               Non |                  Oui | Conserver ou transmettre une référence typée |

## 9.F COMPOSANTS DE CLÉ

Modifier un composant appartenant à une clé triée ou hachée peut invalider l’organisation de la table. ABAP interdit ou limite ces modifications selon le contexte.

Approche sûre :

1. lire ou copier la ligne ;
2. supprimer l’ancienne ligne si la clé doit changer ;
3. modifier la clé dans la copie ;
4. réinsérer la ligne ;
5. contrôler le résultat de l’insertion.

## 9.G DÉSASSIGNATION

Après la fin du parcours, ne pas supposer qu’un symbole de champ reste utilisable pour représenter une ligne métier courante.

```abap
UNASSIGN <ls_product>.
```

Cette instruction rend explicite la fin de l’utilisation du symbole.

## 9.H EXEMPLE COMPLET

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_products ASSIGNING FIELD-SYMBOL(<ls_product>)
     WHERE stock < 0.
  <ls_product>-stock = 0.
  <ls_product>-status = 'BLOCKED'.
ENDLOOP.
```

## 9.I CRITÈRE DE CHOIX

```mermaid
flowchart TD
    A["Traiter une ligne"] --> B{"Modifier la table ?"}
    B -->|""Non""| C["INTO"]
    B -->|""Oui""| D{"Référence à conserver ?"}
    D -->|""Non""| E["ASSIGNING"]
    D -->|""Oui""| F["REFERENCE INTO"]
```

## 9.J VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 9.K ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Utiliser une table standard pour des recherches massives par clé sans mesure.
- Modifier une copie de ligne alors que la table devait être mise à jour.

## 9.L SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_products INTO DATA(ls_product).
  ls_product-stock = ls_product-stock + 1.
  MODIFY lt_products FROM ls_product INDEX sy-tabix.
ENDLOOP.
```

## 9.M TERMES DU LEXIQUE

- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Field-symbol](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## 9.N RÉFÉRENCES OFFICIELLES SAP

- [Using Field Symbols to Process Internal Tables — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-field-symbols-to-process-internal-tables_f1855f41-00d3-4f8d-9a2c-663a321c6637)
- [LOOP AT itab, result — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPLOOP_AT_ITAB_RESULT.html)
- [Modifying Internal Tables in a Loop — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENITAB_LOOP_CHANGE.html)


---

[Chapitre suivant — MODIFIER DES LIGNES](<./10 ├── MODIFIER DES LIGNES.md>)
