# PRÉPARER UN PROGRAMME ABAP POUR LE BATCH

## OBJECTIFS

- Rendre un programme exécutable sans interaction SAP GUI
- Adapter les sorties et les erreurs
- Tester séparément le mode dialogue et le mode batch

## CONTRAINTES

Un programme exécuté en arrière-plan ne doit pas dépendre d’une interaction utilisateur pendant son traitement.

À éviter :

- `CL_GUI_FRONTEND_SERVICES` ;
- boîtes de dialogue ou popups ;
- dynpros nécessitant une saisie ;
- fichiers locaux du poste utilisateur ;
- contrôle frontend ALV ou conteneur GUI ;
- attente d’une confirmation manuelle.

## DÉTECTER LE CONTEXTE

```abap
IF sy-batch = abap_true.
  " Comportement compatible arrière-plan
ELSE.
  " Comportement dialogue éventuel
ENDIF.
```

`sy-batch` vaut `X` lors d’une exécution en arrière-plan. Ce test ne doit pas servir à dupliquer toute la logique métier. Isoler le traitement dans une classe ou une procédure commune, puis adapter uniquement l’entrée et la sortie.

## SORTIES

- écrire les résultats métier dans des tables ou fichiers serveur maîtrisés ;
- produire un journal applicatif si une exploitation opérationnelle est requise ;
- utiliser une liste classique uniquement si un spool est utile ;
- lever ou propager des erreurs de manière contrôlée ;
- éviter les messages interactifs dépendant d’un écran.

## EXEMPLE D’ORGANISATION

```abap
START-OF-SELECTION.
  TRY.
      NEW zcl_dev_batch_service( )->run(
        iv_date = p_date ).

      WRITE: / 'Traitement terminé'.
    CATCH zcx_dev_batch INTO DATA(lx_batch).
      MESSAGE lx_batch->get_text( ) TYPE 'E'.
  ENDTRY.
```

## PROCÉDURE PAS À PAS

1. Saisir `/nATC` ou utiliser l’entrée ATC disponible dans le système.
2. Choisir une variante de contrôle autorisée.
3. Lancer le contrôle sur l’objet, le package ou l’ordre de transport.
4. Classer les findings par priorité et corriger d’abord les erreurs bloquantes.
5. Demander une exemption uniquement avec justification, propriétaire et échéance.
6. Relancer le contrôle avant libération.

## VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
IF sy-batch = abap_true.
  " Comportement compatible arrière-plan
ELSE.
  " Comportement dialogue éventuel
ENDIF.
```

## TERMES DU LEXIQUE

- [ABAP](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Job](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP System Fields — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/f68e489816e043f1add91d69a6842931/7bfb96c8882811d295a90000e8353423.html)
- [Background Work Processes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b3c3e8eb51780e10000000a42189c.html)


---

[Chapitre suivant — VARIANTES ET PARAMÈTRES DE SÉLECTION](<./05 ├── VARIANTES ET PARAMETRES DE SELECTION.md>)
