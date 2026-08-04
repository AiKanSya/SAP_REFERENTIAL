# FONCTIONS STANDARD DU SALV

## RÉSULTAT ATTENDU

- Activer les fonctions standards
- Comprendre l’objet `CL_SALV_FUNCTIONS_LIST`
- Distinguer fonctions génériques et fonctions personnalisées

## ACTIVER LES FONCTIONS

```abap
DATA lo_functions TYPE REF TO cl_salv_functions_list.

lo_functions = go_alv->get_functions( ).
lo_functions->set_all( abap_true ).
```

Cette configuration rend disponibles les fonctions génériques autorisées par le mode d’affichage, par exemple le tri, le filtre, l’export ou la gestion de mise en page.

## ACTIVATION CIBLÉE

Lorsqu’un besoin impose une interface réduite, activer seulement les fonctions utiles plutôt que toutes les fonctions. La disponibilité exacte dépend de la version et du mode d’affichage.

## FONCTIONS PERSONNALISÉES

Le mécanisme diffère selon le contexte :

- en conteneur, une fonction peut être ajoutée à l’objet de fonctions ;
- en plein écran, les fonctions personnalisées reposent généralement sur un statut GUI et `SET_SCREEN_STATUS`.

Une fonction personnalisée doit être associée à un gestionnaire de l’événement `ADDED_FUNCTION`.

## EXEMPLE DE STRUCTURE

```abap
DATA lo_events TYPE REF TO cl_salv_events_table.

lo_events = go_alv->get_event( ).
SET HANDLER lcl_handler=>on_added_function FOR lo_events.
```

Ne pas ajouter un bouton sans définir précisément :

- son code fonction ;
- les lignes auxquelles il s’applique ;
- les contrôles d’autorisation ;
- le comportement en cas de sélection vide.

## PROCESS

### Étape 1 — Récupérer l’objet des fonctions

Après `FACTORY`, appeler `GET_FUNCTIONS` sur l’instance SALV. Ne recréer ni la table ni l’instance pour activer les commandes.

### Étape 2 — Activer uniquement les fonctions requises

Utiliser `SET_ALL( ABAP_TRUE )` pour un rapport générique lorsque toutes les commandes standard sont acceptables. Sinon, activer séparément les fonctions nécessaires afin de limiter l’interface au besoin métier.

### Étape 3 — Ajouter une commande personnalisée avec un code unique

Définir un code de fonction non ambigu, un texte et une info-bulle. Vérifier que le mode d’affichage utilisé permet l’ajout de cette commande.

### Étape 4 — Enregistrer le gestionnaire d’événement

Récupérer l’objet d’événements, instancier la classe réceptrice puis exécuter `SET HANDLER`. La référence du gestionnaire doit rester vivante jusqu’à la fermeture de l’ALV.

### Étape 5 — Tester les commandes visibles et refusées

Vérifier chaque fonction standard activée, la commande personnalisée et le comportement lorsqu’aucune ligne n’est sélectionnée. Les actions métier déclenchées doivent exécuter leurs propres contrôles d’autorisation.

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
DATA lo_functions TYPE REF TO cl_salv_functions_list.

lo_functions = go_alv->get_functions( ).
lo_functions->set_all( abap_true ).
```

## TERMES DU LEXIQUE

- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [Using Self-Defined, Application-Specific Functions — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec39dbb88d22b90e10000000a42189d.html)
- [Main ALV Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1f117076868b8e10000000a42189e.html)

---

[Chapitre suivant — COLONNES ET ENTÊTES DU SALV](<./05 ├── COLONNES ET ENTETES DU SALV.md>)
