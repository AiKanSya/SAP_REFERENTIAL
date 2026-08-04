# 15. EXCEPTIONS ORIENTÉES OBJET

## 15.A RÉSULTAT ATTENDU

- Déclarer et lever une exception[^terme-exception] depuis une méthode[^terme-methode].
- Créer une classe[^terme-classe] d’exception globale.
- Propager une cause précédente.
- Fournir un contrat d’erreur exploitable.

## 15.B CAS D’USAGE

Une classe de repository ne trouve pas un objet demandé. Elle ne doit ni afficher un message, ni retourner silencieusement une structure vide si l’absence est une erreur métier. Elle lève `ZCX_DEV_NOT_FOUND`.

## 15.C PROCESS

### 15.C.1 Étape 1 — Choisir la catégorie

Utiliser `CX_STATIC_CHECK` si l’appelant doit traiter l’erreur, `CX_DYNAMIC_CHECK` pour un contrôle d’exécution non déclaré obligatoirement, et `CX_NO_CHECK` seulement si la gestion locale n’a pas de sens.

### 15.C.2 Étape 2 — Créer la classe ZCX

Dans `SE24`[^terme-class-builder-se24], créer la classe avec la superclasse choisie. Ajouter les attributs nécessaires au contexte sans stocker de donnée sensible inutile.

### 15.C.3 Étape 3 — Définir les textes

Créer les text IDs ou les rattacher à la classe de messages prévue. Vérifier la substitution des attributs et activer.

### 15.C.4 Étape 4 — Déclarer puis lever

Ajouter la classe dans `RAISING` lorsque requis. Lever au point où la cause est connue ; lors d’une conversion, transmettre l’exception d’origine dans `PREVIOUS`.

### 15.C.5 Étape 5 — Intercepter à la frontière

Capturer dans le report, job[^terme-job], service ou contrôleur capable de décider message, journal ou reprise. Tester texte, attributs et cause précédente pour chaque branche.

## 15.D CODE À ADAPTER

Signature publique du repository :

```abap
METHODS get_by_id
  IMPORTING iv_id TYPE zdev_entity_id
  RETURNING VALUE(rs_entity) TYPE zdev_entity
  RAISING   zcx_dev_not_found.
```

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
METHOD get_by_id.
  SELECT SINGLE entity_id,
                description,
                status
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

## 15.E PROPAGER LA CAUSE

Lorsqu’une exception technique est convertie en exception métier, conserver la cause précédente si la classe le permet. Cela facilite le diagnostic sans exposer toute la technique à l’appelant.

## 15.F CONTRÔLE

- La méthode ne produit aucun message d’écran.
- L’appelant sait quelles erreurs gérer grâce à la signature.
- L’exception contient l’identifiant ou le contexte utile.
- Le journal technique conserve la cause initiale lorsque nécessaire.

## 15.G ERREURS FRÉQUENTES

- Capturer `CX_ROOT` puis ignorer l’erreur.
- Lever une exception `NO_CHECK` pour toute validation métier.
- Mélanger message utilisateur, journalisation et création de l’exception dans chaque couche.

## 15.H COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP[^terme-abap] classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 15.I RÉFÉRENCES OFFICIELLES SAP

- [Working with Exception Classes — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/working-with-exception-classes_acd9568c-be4e-445a-a454-14c6f2cfcd2e)
- [Exception Categories — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXCEPTION_CATEGORIES.html)

---

[Chapitre suivant — ÉVÉNEMENTS ET GESTIONNAIRES](<./16 ├── EVENEMENTS ET GESTIONNAIRES.md>)

[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
