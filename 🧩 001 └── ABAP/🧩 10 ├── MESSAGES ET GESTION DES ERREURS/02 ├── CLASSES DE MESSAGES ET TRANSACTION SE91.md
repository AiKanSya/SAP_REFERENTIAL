# 2. CLASSES DE MESSAGES ET TRANSACTION SE91

## 2.A RÉSULTAT ATTENDU

- Comprendre le rôle d’une classe[^terme-classe] de messages
- Créer et maintenir des messages avec `SE91`[^outil-se91]
- Utiliser les numéros et variables de message
- Préparer les traductions
- Éviter les textes codés en dur

## 2.B PRINCIPE

Les messages classiques ABAP[^terme-abap] sont stockés dans des **classes de messages**. Chaque entrée est identifiée par :

- une classe ;
- un numéro sur trois chiffres ;
- un texte dépendant de la langue de connexion.

Les messages sont enregistrés dans le référentiel de textes associé à la table `T100`.

```mermaid
flowchart LR
    A["Classe ZDEV_MSG"] --> B["Numéro 001"]
    B --> C["Texte traduit"]
    C --> D["Instruction MESSAGE"]
```

## 2.C PROCESS

### 2.C.1 Étape 1 — Définir le périmètre de la classe

Regrouper des messages appartenant au même composant ou service. Rechercher une classe client existante avant d’en créer une nouvelle et vérifier son package[^terme-package] et ses responsables.

### 2.C.2 Étape 2 — Créer la classe

Ouvrir `SE91`, saisir un nom client comme `ZDEV_MSG` et choisir **Créer**. Renseigner une description précise, puis affecter le package et la tâche de transport[^terme-tache-transport] du composant.

### 2.C.3 Étape 3 — Ajouter un message

Choisir un numéro libre, saisir un texte court et utiliser au maximum `&1` à `&4` pour les valeurs dynamiques. Le texte doit rester compréhensible après substitution et ne doit pas exposer de donnée sensible.

### 2.C.4 Étape 4 — Enregistrer et contrôler le transport

Enregistrer puis vérifier dans `SE10`[^outil-se10] que la classe et ses textes sont rattachés à l’ordre attendu. Contrôler que le numéro ajouté n’a pas été simultanément utilisé par un autre changement.

### 2.C.5 Étape 5 — Préparer les traductions

Identifier les langues supportées et transmettre les textes au processus de traduction prévu. Tester la classe dans chaque langue disponible plutôt que de supposer un fallback acceptable.

La maintenance peut également être atteinte depuis les outils du Workbench ABAP selon la version du système.

## 2.D NUMÉROS DE MESSAGE

Une classe peut contenir des numéros de `000` à `999`.

Exemple :

| Numéro | Texte                                  |
| ------ | -------------------------------------- |
| `001`  | Article & introuvable                  |
| `002`  | Quantité & invalide pour l’article &   |
| `003`  | Traitement terminé : & enregistrements |

Les `&` sont remplacés lors de l’appel du message. Un message T100 accepte jusqu’à quatre variables.

## 2.E TEXTE COURT

Le texte doit être :

- compréhensible sans accès au code ;
- précis sur l’objet concerné ;
- neutre et exploitable ;
- compatible avec les traductions ;
- dépourvu de détails techniques inutiles pour l’utilisateur.

Mauvais :

```text
Erreur traitement
```

Meilleur :

```text
Article 000123 introuvable dans la division 1000
```

## 2.F TEXTE LONG

Un message peut être associé à une documentation longue. Elle permet d’expliquer :

- la cause probable ;
- l’action attendue ;
- les données à vérifier ;
- les conséquences du problème.

Le texte court indique l’erreur. Le texte long aide à la résoudre.

## 2.G TRANSPORT ET TRADUCTION

Une classe de messages est un objet du Repository. Sa création et ses modifications doivent suivre les règles de package et de transport du projet.

La traduction ne doit pas être remplacée par des textes assemblés manuellement dans le code. Les variables doivent contenir les données, pas la structure grammaticale complète du message.

## 2.H CONVENTIONS CONSEILLÉES

- regrouper les messages par composant fonctionnel cohérent ;
- éviter une classe globale[^terme-classe-globale] contenant des messages sans relation ;
- réserver des plages de numéros si l’équipe en a besoin ;
- ne pas réutiliser un numéro avec une nouvelle signification ;
- conserver les messages stables lorsqu’ils constituent un contrat d’interface.

## 2.I PROCESS

### 2.I.1 Étape 1 — Appeler le message avec des paramètres typés

Créer un report de test et utiliser `MESSAGE` avec la classe, le numéro et le même nombre de paramètres que les placeholders. Fournir des valeurs dont la longueur permet de vérifier une éventuelle troncature.

### 2.I.2 Étape 2 — Tester le type de message dans son contexte

Tester le message dans le contexte réel : écran de sélection, traitement de fond, méthode[^terme-methode] ou dynpro[^terme-dynpro]. Les types `E`, `W`, `S`, `I`, `A` et `X` n’ont pas le même effet selon le contexte ; ne déduire pas leur comportement depuis un seul report.

### 2.I.3 Étape 3 — Vérifier le texte résolu

Exécuter dans la langue de connexion, contrôler substitutions, ordre des valeurs et lisibilité. Relancer dans une autre langue supportée.

La classe est validée lorsque le bon texte et le bon comportement apparaissent dans chaque contexte prévu, sans dump ni information sensible.

## 2.J VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 2.K ERREURS FRÉQUENTES

- Afficher un message technique incompréhensible à l’utilisateur.
- Attraper une exception[^terme-exception] sans action ni propagation.

## 2.L FICHE DE CONTRÔLE À COPIER

```text
Système / SID       :
Mandant             :
Utilisateur         :
Transaction / outil :
Objet technique     :
Jeu de données      :
Résultat attendu    :
Résultat observé    :
Horodatage          :
Ordre de transport  :
```

## 2.M TERMES DU LEXIQUE

- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Classe](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Exception](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)

## 2.N RÉFÉRENCES OFFICIELLES SAP

- [Messages and Message Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec242f66e391014adc9fffe4e204223.html)
- [Maintaining Messages — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/bd833c8355f34e96a6e83096b38bf192/d1801b3e454211d189710000e8322d00.html)
- [MESSAGE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPMESSAGE_SHORTREF.html)

---

[Chapitre suivant — INSTRUCTION MESSAGE](<./03 ├── INSTRUCTION MESSAGE.md>)

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-tache-transport]: **TÂCHE DE TRANSPORT.** Sous-conteneur affecté à un utilisateur dans un ordre de transport. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#tache-transport>).
[^terme-classe-globale]: **CLASSE GLOBALE.** Classe Repository réutilisable dans le système ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#classe-globale>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-dynpro]: **DYNPRO.** Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).

[^outil-se91]: **SE91.** Transaction de création et de maintenance des classes de messages SAP. Voir [le chapitre associé](<02 ├── CLASSES DE MESSAGES ET TRANSACTION SE91.md>).
[^outil-se10]: **SE10.** Transaction de l’Organisateur de transports utilisée pour consulter et gérer les ordres et tâches de transport. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/03 ├── PACKAGES ET ORDRES DE TRANSPORT.md>).
