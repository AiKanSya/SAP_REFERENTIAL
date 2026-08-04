# CLASSES LOCALES DANS UN CLASS POOL

## RÉSULTAT ATTENDU

- Positionner correctement les classes locales dans un développement centré sur `SE24`.
- Créer un helper privé ou une classe de test locale.
- Éviter de rendre locale une classe destinée à être réutilisée.

## POSITIONNEMENT

Les classes globales sont le choix principal pour les services réutilisables. Les classes locales restent pertinentes pour :

- un helper strictement interne au Class Pool ;
- une implémentation éphémère non exposée ;
- une classe de test ABAP Unit ;
- un double de test local.

## CAS D’USAGE

La classe globale `ZCL_DEV_CSV_IMPORTER` a besoin d’un parseur privé spécifique à son implémentation. Aucun autre objet ne doit l’utiliser. `LCL_CSV_PARSER` reste local au Class Pool.

## PROCÉDURE

1. Ouvrir la classe globale dans `SE24` ou `SE80`.
2. Accéder aux définitions locales du Class Pool.
3. Déclarer la classe locale avant son utilisation.
4. Placer son implémentation dans la zone locale prévue.
5. L’utiliser uniquement depuis la classe globale ou les autres classes locales du même pool.
6. Activer la classe globale complète.

## CODE À ADAPTER

```abap
CLASS lcl_csv_parser DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS parse_line
      IMPORTING iv_line TYPE string
      RETURNING VALUE(rt_columns) TYPE string_table.
ENDCLASS.

CLASS lcl_csv_parser IMPLEMENTATION.
  METHOD parse_line.
    SPLIT iv_line AT ';' INTO TABLE rt_columns.
  ENDMETHOD.
ENDCLASS.
```

## QUAND PROMOUVOIR LA CLASSE EN GLOBAL

Promouvoir la classe si :

- un deuxième objet Repository doit l’utiliser ;
- elle représente un concept métier stable ;
- son interface doit être documentée et transportée indépendamment ;
- elle doit être injectée depuis l’extérieur.

## CONTRÔLE

La liste des utilisations reste limitée au Class Pool. Aucun consommateur externe ne dépend d’un détail local.

## ERREURS FRÉQUENTES

- Définir localement toute l’architecture d’un report et empêcher la réutilisation.
- Utiliser une classe locale pour contourner les règles de package.
- Placer une responsabilité métier importante dans un helper invisible et non documenté.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Creating Local Definitions and Implementations — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/b5693ecb185011d5969b00a0c94260a5.html)
- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)

---

[Chapitre suivant — DOCUMENTATION, TEST ET DEBUG AVEC SE24](<./23 ├── DOCUMENTATION TEST ET DEBUG AVEC SE24.md>)
