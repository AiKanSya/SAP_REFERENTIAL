# 11. INTERFACES GLOBALES AVEC SE24

## 11.A RÉSULTAT ATTENDU

- Créer une interface globale[^terme-interface-globale] dans `SE24`[^terme-class-builder-se24].
- Définir un contrat indépendant d’une implémentation.
- Implémenter l’interface dans une classe globale[^terme-classe-globale].

## 11.B CAS D’USAGE

Un service de notification peut envoyer un message par e-mail, journal applicatif ou système externe. Les consommateurs doivent dépendre d’un contrat `ZIF_DEV_NOTIFIER`, pas d’une classe concrète.

## 11.C PROCESS

### 11.C.1 Étape 1 — Définir le contrat minimal

Décider ce que `SEND` reçoit, retourne et peut lever. Exclure les paramètres propres à une technologie d’implémentation particulière.

### 11.C.2 Étape 2 — Créer l’interface

Ouvrir `SE24`, saisir `ZIF_DEV_NOTIFIER`, choisir le type interface puis affecter package[^terme-package] et tâche de transport[^terme-tache-transport].

### 11.C.3 Étape 3 — Définir la signature complète

Créer `SEND`. Ajouter les `IMPORTING`, éventuel `RETURNING` et classes `RAISING` avec des types stables. Contrôler et activer l’interface.

### 11.C.4 Étape 4 — Ajouter l’interface à la classe

Ouvrir la classe d’implémentation, ajouter l’interface dans l’onglet correspondant puis ouvrir `ZIF_DEV_NOTIFIER~SEND`. Implémenter sans modifier le contrat.

### 11.C.5 Étape 5 — Tester par l’interface

Déclarer une référence `TYPE REF TO zif_dev_notifier`, affecter l’instance et appeler `SEND`. La conception est validée lorsque l’appelant ne dépend pas de la classe concrète.

## 11.D DÉFINITION DU CONTRAT

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
INTERFACE zif_dev_notifier PUBLIC.
  METHODS send
    IMPORTING
      iv_recipient TYPE string
      iv_message   TYPE string
    RAISING
      zcx_dev_notification.
ENDINTERFACE.
```

## 11.E IMPLÉMENTATION

```abap
METHOD zif_dev_notifier~send.
  " Implémentation fictive : remplacer par le canal réel.
  IF iv_recipient IS INITIAL.
    RAISE EXCEPTION TYPE zcx_dev_notification.
  ENDIF.
ENDMETHOD.
```

## 11.F UTILISATION

```abap
" Construire les dépendances avant d’exécuter le traitement.
DATA lo_notifier TYPE REF TO zif_dev_notifier.
lo_notifier = NEW zcl_dev_mail_notifier( ).
lo_notifier->send(
  iv_recipient = 'user@example.invalid'
  iv_message   = 'Traitement terminé' ).
```

## 11.G RÈGLES DE CONCEPTION

- L’interface exprime ce que le consommateur attend.
- Elle ne doit pas exposer les détails techniques d’une implémentation.
- Les types publics utilisés doivent être stables et disponibles.
- Une interface trop large doit être découpée en contrats plus ciblés.

## 11.H CONTRÔLE

Remplacer `ZCL_DEV_MAIL_NOTIFIER` par une autre classe implémentant la même interface sans modifier le code consommateur, hors composition[^terme-composition] de l’objet.

## 11.I ERREURS FRÉQUENTES

- Créer une interface contenant des dizaines de méthodes sans cohésion.
- Ajouter un paramètre spécifique à une seule implémentation.
- Typer les consommateurs avec la classe concrète malgré l’existence de l’interface.

## 11.J COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP[^terme-abap] classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport[^terme-ordre-transport] du projet.

## 11.K RÉFÉRENCES OFFICIELLES SAP

- [Defining Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/defining-interfaces_ab3c7c07-bb66-424b-ba06-6cfa7cc39439)
- [Using Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-interfaces_e45af9bb-46e5-457b-88ef-d5ad6b0d38d7)
- [Class Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/a602ff71a47c441bb3000504ec938fea/cac035baa6c611d1b4790000e8a52bed.html)

---

[Chapitre suivant — POLYMORPHISME PAR INTERFACE](<./12 ├── POLYMORPHISME PAR INTERFACE.md>)

[^terme-interface-globale]: **INTERFACE GLOBALE.** Interface ABAP Objects enregistrée comme objet Repository et réutilisable par plusieurs classes et programmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#interface-globale>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-classe-globale]: **CLASSE GLOBALE.** Classe Repository réutilisable dans le système ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#classe-globale>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-tache-transport]: **TÂCHE DE TRANSPORT.** Sous-conteneur affecté à un utilisateur dans un ordre de transport. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#tache-transport>).
[^terme-composition]: **COMPOSITION.** Relation dans laquelle une classe réalise son comportement en contenant ou en utilisant d’autres objets spécialisés. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#composition>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
