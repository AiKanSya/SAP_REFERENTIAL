# 6. MÉTHODES D’INSTANCE ET PARAMÈTRES

## 6.A RÉSULTAT ATTENDU

- Définir une méthode d’instance[^terme-methode-instance] dans `SE24`[^terme-class-builder-se24].
- Choisir les catégories de paramètres.
- Concevoir une signature compréhensible et stable.

## 6.B CATÉGORIES DE PARAMÈTRES

| Catégorie   | Usage recommandé                               |
| ----------- | ---------------------------------------------- |
| `IMPORTING` | Donnée fournie à la méthode                    |
| `RETURNING` | Résultat principal unique                      |
| `EXPORTING` | Résultats supplémentaires                      |
| `CHANGING`  | Donnée réellement modifiée par la méthode      |
| `RAISING`   | Exceptions de classe[^terme-classe] que l’appelant doit gérer |

Une méthode fonctionnelle courte privilégie souvent `IMPORTING` et un seul `RETURNING`. `CHANGING` doit rester explicite : l’appelant doit comprendre que sa donnée peut être modifiée.

## 6.C PROCESS

### 6.C.1 Étape 1 — Définir le contrat

Décider que `CALCULATE_TOTAL` reçoit une table d’articles et retourne un montant. Identifier le type de ligne, le type de table et le type de montant avant d’ouvrir la signature.

### 6.C.2 Étape 2 — Créer la méthode

Dans **Méthodes**, créer `CALCULATE_TOTAL`, niveau instance, visibilité[^terme-visibilite] publique. Ouvrir immédiatement les paramètres et ne pas activer une méthode vide dont la signature n’a pas encore été définie. Vérifier que le nom décrit le résultat du calcul sans exposer son implémentation.

### 6.C.3 Étape 3 — Créer la signature complète

Ajouter `IT_ITEMS` dans `IMPORTING` avec le type de table exact. Ajouter `RV_TOTAL` dans `RETURNING`, passage par valeur, avec le type montant prévu. Dans `RAISING`, ajouter la classe d’exception[^terme-exception] utilisée pour une ligne invalide.

### 6.C.4 Étape 4 — Implémenter avec l’état d’instance nécessaire

Valider les lignes, utiliser uniquement les attributs privés appartenant au calcul puis affecter `RV_TOTAL` sur tous les chemins normaux. Lever l’exception avant de retourner un total partiel.

### 6.C.5 Étape 5 — Activer et tester

Tester table valide, table vide et ligne invalide. Vérifier le montant et la classe d’exception. La méthode est validée lorsque sa signature suffit à comprendre entrées, sortie et erreur.

## 6.D CAS D’USAGE

Calculer le total d’une liste de lignes de commande sans modifier la table fournie.

## 6.E CODE À ADAPTER

Signature publique à créer dans `SE24` :

```abap
METHODS calculate_total
  IMPORTING
    it_items TYPE zdev_item_tab
  RETURNING
    VALUE(rv_total) TYPE zdev_amount.
```

`ZDEV_ITEM_TAB` doit être un type de table dont la ligne expose le composant `AMOUNT` de type compatible avec `ZDEV_AMOUNT`.

Implémentation de la méthode :

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
METHOD calculate_total.
  rv_total = REDUCE zdev_amount(
    INIT total = CONV zdev_amount( 0 )
    FOR item IN it_items
    NEXT total = total + item-amount ).
ENDMETHOD.
```

Appel depuis un consommateur disposant d’une référence `LO_SERVICE` et d’une table `LT_ITEMS` correctement typées :

```abap
DATA(lv_total) = lo_service->calculate_total( lt_items ).
```

## 6.F PASSAGE PAR VALEUR ET PAR RÉFÉRENCE

La configuration exacte dépend de la catégorie de paramètre et de la release. Un paramètre de retour est transmis par valeur. Pour les gros volumes, éviter les copies inutiles, mais ne pas sacrifier la clarté de l’interface sans mesure réelle.

## 6.G CONTRÔLE

- La méthode ne modifie pas `IT_ITEMS`.
- Le résultat est déterministe pour une même entrée.
- Les cas vides et les montants invalides sont couverts.
- La signature ne contient pas de paramètres inutilisés.

## 6.H ERREURS FRÉQUENTES

- Utiliser plusieurs `EXPORTING` alors qu’une structure de résultat serait plus claire.
- Modifier indirectement un objet fourni sans que l’interface le signale.
- Retourner `sy-subrc` au lieu d’une exception ou d’un résultat métier explicite.

## 6.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP[^terme-abap] classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 6.J RÉFÉRENCES OFFICIELLES SAP

- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)
- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)

---

[Chapitre suivant — MÉTHODES STATIQUES ET COMPOSANTS DE CLASSE](<./07 ├── METHODES STATIQUES ET COMPOSANTS DE CLASSE.md>)

[^terme-methode-instance]: **MÉTHODE D’INSTANCE.** Méthode appelée sur une instance avec l’opérateur `->` et pouvant accéder à son état. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode-instance>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
