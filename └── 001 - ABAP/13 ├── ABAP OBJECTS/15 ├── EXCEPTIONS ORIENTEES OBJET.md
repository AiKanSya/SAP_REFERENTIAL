# EXCEPTIONS ORIENTÉES OBJET

## RÉSULTAT ATTENDU

- Déclarer et lever une exception depuis une méthode.
- Créer une classe d’exception globale.
- Propager une cause précédente.
- Fournir un contrat d’erreur exploitable.

## CAS D’USAGE

Une classe de repository ne trouve pas un objet demandé. Elle ne doit ni afficher un message, ni retourner silencieusement une structure vide si l’absence est une erreur métier. Elle lève `ZCX_DEV_NOT_FOUND`.

## PROCÉDURE DE CRÉATION

1. Ouvrir `SE24`.
2. Créer une classe `ZCX_*` héritant d’une catégorie adaptée de `CX_STATIC_CHECK`, `CX_DYNAMIC_CHECK` ou `CX_NO_CHECK` selon le contrat retenu.
3. Définir les textes d’exception, idéalement intégrés à une classe de messages si le projet l’exige.
4. Activer la classe d’exception.
5. Ajouter l’exception dans `RAISING` de la méthode métier.
6. Lever l’exception avec les informations de contexte.
7. La capturer à une frontière appropriée : report, job, service ou contrôleur.

## CODE À ADAPTER

```abap
METHOD get_by_id.
  SELECT SINGLE *
    FROM zdev_entity
    WHERE entity_id = @iv_id
    INTO @rs_entity.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE zcx_dev_not_found
      EXPORTING
        entity_id = iv_id.
  ENDIF.
ENDMETHOD.
```

Consommateur :

```abap
TRY.
    DATA(ls_entity) = lo_repository->get_by_id( p_id ).
  CATCH zcx_dev_not_found INTO DATA(lx_not_found).
    MESSAGE lx_not_found->get_text( ) TYPE 'E'.
ENDTRY.
```

## PROPAGER LA CAUSE

Lorsqu’une exception technique est convertie en exception métier, conserver la cause précédente si la classe le permet. Cela facilite le diagnostic sans exposer toute la technique à l’appelant.

## CONTRÔLE

- La méthode ne produit aucun message d’écran.
- L’appelant sait quelles erreurs gérer grâce à la signature.
- L’exception contient l’identifiant ou le contexte utile.
- Le journal technique conserve la cause initiale lorsque nécessaire.

## ERREURS FRÉQUENTES

- Capturer `CX_ROOT` puis ignorer l’erreur.
- Lever une exception `NO_CHECK` pour toute validation métier.
- Mélanger message utilisateur, journalisation et création de l’exception dans chaque couche.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Working with Exception Classes — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/working-with-exception-classes_acd9568c-be4e-445a-a454-14c6f2cfcd2e)
- [Exception Categories — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXCEPTION_CATEGORIES.html)

---

[Chapitre suivant — ÉVÉNEMENTS ET GESTIONNAIRES](<./16 ├── EVENEMENTS ET GESTIONNAIRES.md>)
