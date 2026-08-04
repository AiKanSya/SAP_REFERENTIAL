# 5. VISIBILITÉ, TYPES, CONSTANTES ET ATTRIBUTS

## 5.A RÉSULTAT ATTENDU

- Choisir entre visibilité[^terme-visibilite] publique, protégée et privée.
- Déclarer les types, constantes et attributs au bon niveau.
- Éviter l’exposition directe d’un état modifiable.

## 5.B VISIBILITÉS

| Visibilité  | Accessible depuis                                     |
| ----------- | ----------------------------------------------------- |
| `PUBLIC`    | Tous les consommateurs autorisés à utiliser la classe[^terme-classe] |
| `PROTECTED` | La classe et ses sous-classes                         |
| `PRIVATE`   | La classe elle-même et, selon le cas, ses amis        |

L’API publique[^terme-api-publique] doit rester minimale. Un attribut[^terme-attribut] interne est normalement privé. Une valeur destinée aux consommateurs peut être exposée par une méthode[^terme-methode] de lecture ou une constante publique.

## 5.C PROCESS

### 5.C.1 Étape 1 — Classer chaque composant

Avant `SE24`[^terme-class-builder-se24], décider si le composant appartient au contrat public, aux sous-classes ou uniquement à l’implémentation. Utiliser public, protected ou private selon ce consommateur réel.

### 5.C.2 Étape 2 — Créer un type

Dans **Types**, ajouter le nom et le type référencé, puis choisir la visibilité. Un type public devient une dépendance pour les appelants ; ne l’exposer que s’il fait partie de la signature externe.

### 5.C.3 Étape 3 — Créer la constante

Dans **Attributs**, créer une constante de niveau classe, lui affecter un type explicite et une valeur compatible. Choisir une visibilité publique uniquement si les consommateurs doivent partager cette valeur contractuelle.

### 5.C.4 Étape 4 — Créer l’état d’instance

Ajouter les attributs privés nécessaires. Initialiser dans la déclaration ou le constructeur, puis créer des méthodes publiques orientées métier plutôt que des setters permettant n’importe quel état.

### 5.C.5 Étape 5 — Tester les frontières

Depuis un report externe, vérifier que les composants publics sont accessibles et que les privés provoquent une erreur syntaxique. Tester ensuite que les méthodes publiques maintiennent les invariants. La visibilité est validée lorsque aucun appelant ne dépend de l’implémentation interne.

## 5.D CAS D’USAGE

Une classe représentant une limite de crédit doit empêcher un montant négatif. Si `MV_LIMIT` est public, tout appelant peut contourner la règle. L’attribut doit être privé et modifié uniquement par `SET_LIMIT`.

## 5.E CODE À ADAPTER

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
CLASS zcl_dev_credit_limit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES ty_amount TYPE p LENGTH 16 DECIMALS 2.

    CONSTANTS c_currency TYPE waers VALUE 'EUR'.

    METHODS constructor
      IMPORTING iv_limit TYPE ty_amount.

    METHODS get_limit
      RETURNING VALUE(rv_limit) TYPE ty_amount.

    METHODS set_limit
      IMPORTING iv_limit TYPE ty_amount
      RAISING   zcx_dev_invalid_amount.

  PRIVATE SECTION.
    DATA mv_limit TYPE ty_amount.
ENDCLASS.
```

## 5.F RÈGLES PRATIQUES

- Un type public fait partie du contrat et devient plus difficile à modifier.
- Une constante publique est adaptée à une valeur stable du contrat.
- Un attribut public modifiable crée un couplage fort et affaiblit les contrôles.
- Un attribut statique conserve une valeur partagée pour la session interne : l’utiliser uniquement si ce partage est intentionnel.

## 5.G CONTRÔLE

Tenter d’accéder à l’attribut privé depuis un report doit produire une erreur de syntaxe. La valeur doit être accessible uniquement via la méthode prévue.

## 5.H ERREURS FRÉQUENTES

- Utiliser `PUBLIC` par facilité.
- Déclarer des types publics qui ne servent qu’à l’implémentation.
- Employer un attribut statique pour stocker un état utilisateur sans maîtriser sa durée de vie.

## 5.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP[^terme-abap] classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 5.J RÉFÉRENCES OFFICIELLES SAP

- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)
- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)

---

[Chapitre suivant — MÉTHODES D’INSTANCE ET PARAMÈTRES](<./06 ├── METHODES D INSTANCE ET PARAMETRES.md>)

[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-api-publique]: **API PUBLIQUE.** Ensemble des composants publics qu’une classe expose à ses consommateurs : méthodes, événements, types, constantes et attributs publics. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#api-publique>).
[^terme-attribut]: **ATTRIBUT.** Composant de données déclaré dans une classe et appartenant soit à chaque instance, soit à la classe elle-même. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#attribut>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
