# APPEL D’UN RAPPORT AVEC SUBMIT

## RÉSULTAT ATTENDU

- Appeler un programme exécutable depuis ABAP
- Transmettre des paramètres et critères
- Revenir au programme appelant
- Utiliser une variante ou une table de sélection
- Maîtriser les risques des appels dynamiques

## APPEL SIMPLE

```abap
SUBMIT zdev_target
  WITH p_carr = p_carr
  AND RETURN.
```

`AND RETURN` restitue le contrôle au programme appelant après l’exécution du programme cible.

Sans cette addition, l’appel se comporte comme un remplacement du programme courant dans la chaîne d’appel.

## TRANSMETTRE UN SELECT-OPTIONS

```abap
SUBMIT zdev_target
  WITH s_carr IN s_carr
  AND RETURN.
```

Les noms `p_carr` et `s_carr` à gauche correspondent aux éléments de sélection du programme cible.

## UTILISER UNE VARIANTE

```abap
SUBMIT zdev_target
  USING SELECTION-SET 'Z_DAILY_RUN'
  AND RETURN.
```

La variante doit appartenir au programme appelé et rester compatible avec son écran de sélection.

## TABLE DE SÉLECTION DYNAMIQUE

La structure standard `RSPARAMS` permet de construire une interface de sélection dynamique.

```abap
DATA lt_selection TYPE STANDARD TABLE OF rsparams WITH EMPTY KEY.

APPEND VALUE #(
  selname = 'P_CARR'
  kind    = 'P'
  low     = 'LH'
) TO lt_selection.

APPEND VALUE #(
  selname = 'S_CONN'
  kind    = 'S'
  sign    = 'I'
  option  = 'BT'
  low     = '0400'
  high    = '0500'
) TO lt_selection.

SUBMIT zdev_target
  WITH SELECTION-TABLE lt_selection
  AND RETURN.
```

## AFFICHER L’ÉCRAN DU PROGRAMME CIBLE

L’addition `VIA SELECTION-SCREEN` demande le traitement de l’écran de sélection du programme appelé.

```abap
SUBMIT zdev_target
  VIA SELECTION-SCREEN
  AND RETURN.
```

Cette forme impose une interaction utilisateur et n’est pas adaptée à tous les contextes.

## SORTIE DE LISTE

`SUBMIT` permet aussi d’exporter une liste classique vers la mémoire ABAP ou le spool avec des additions dédiées. Cette technique est spécifique aux listes classiques.

Pour échanger des données structurées, préférer une interface de procédure ou de classe explicitement typée.

## APPEL DYNAMIQUE

Un nom de programme peut être déterminé dynamiquement. Ne jamais exécuter directement une valeur fournie par un utilisateur ou une source externe.

```mermaid
flowchart TD
    A["Nom de programme demandé"] --> B["Présent dans une liste autorisée ?"]
    B -->|"Non"| C["Refus"]
    B -->|"Oui"| D["SUBMIT contrôlé"]
```

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lt_selection TYPE STANDARD TABLE OF rsparams WITH EMPTY KEY.

APPEND VALUE #(
  selname = 'P_CARR'
  kind    = 'P'
  low     = 'LH'
) TO lt_selection.

APPEND VALUE #(
  selname = 'S_CONN'
  kind    = 'S'
  sign    = 'I'
  option  = 'BT'
  low     = '0400'
  high    = '0500'
) TO lt_selection.

SUBMIT zdev_target
  WITH SELECTION-TABLE lt_selection
  AND RETURN.
```

## TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## RÉFÉRENCES OFFICIELLES SAP

- [SUBMIT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSUBMIT_SHORTREF.html)
- [SUBMIT, Selection Screen Interface — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSUBMIT_INTERFACE.html)
- [CALL SELECTION-SCREEN — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_816_index_htm/8.16/en-US/ABAPCALL_SELECTION_SCREEN.html)


---

[Chapitre suivant — SORTIE D’UN PROGRAMME EXÉCUTABLE](<./16 ├── SORTIE D UN PROGRAMME EXECUTABLE.md>)
