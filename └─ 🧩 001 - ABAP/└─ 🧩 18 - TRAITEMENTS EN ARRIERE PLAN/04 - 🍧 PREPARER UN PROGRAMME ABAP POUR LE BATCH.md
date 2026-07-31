# 🌸 PRÉPARER UN PROGRAMME ABAP POUR LE BATCH

## 🌺 OBJECTIFS

- Rendre un programme exécutable sans interaction SAP GUI
- Adapter les sorties et les erreurs
- Tester séparément le mode dialogue et le mode batch

## 🌺 CONTRAINTES

Un programme exécuté en arrière-plan ne doit pas dépendre d’une interaction utilisateur pendant son traitement.

À éviter :

- `CL_GUI_FRONTEND_SERVICES` ;
- boîtes de dialogue ou popups ;
- dynpros nécessitant une saisie ;
- fichiers locaux du poste utilisateur ;
- contrôle frontend ALV ou conteneur GUI ;
- attente d’une confirmation manuelle.

## 🌺 DÉTECTER LE CONTEXTE

```abap
IF sy-batch = abap_true.
  " Comportement compatible arrière-plan
ELSE.
  " Comportement dialogue éventuel
ENDIF.
```

`sy-batch` vaut `X` lors d’une exécution en arrière-plan. Ce test ne doit pas servir à dupliquer toute la logique métier. Isoler le traitement dans une classe ou une procédure commune, puis adapter uniquement l’entrée et la sortie.

## 🌺 SORTIES

- écrire les résultats métier dans des tables ou fichiers serveur maîtrisés ;
- produire un journal applicatif si une exploitation opérationnelle est requise ;
- utiliser une liste classique uniquement si un spool est utile ;
- lever ou propager des erreurs de manière contrôlée ;
- éviter les messages interactifs dépendant d’un écran.

## 🌺 EXEMPLE D’ORGANISATION

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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP System Fields — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/f68e489816e043f1add91d69a6842931/7bfb96c8882811d295a90000e8353423.html)
- [Background Work Processes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b3c3e8eb51780e10000000a42189c.html)

---

➡️ [Chapitre suivant — VARIANTES ET PARAMETRES DE SELECTION](<./05 - 🍧 VARIANTES ET PARAMETRES DE SELECTION.md>)
