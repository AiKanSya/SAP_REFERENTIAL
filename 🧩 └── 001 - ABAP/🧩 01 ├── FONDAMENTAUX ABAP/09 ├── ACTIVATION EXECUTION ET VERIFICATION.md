# ACTIVATION, EXÉCUTION ET VÉRIFICATION

## RÉSULTAT ATTENDU

- Distinguer enregistrement, contrôle syntaxique et activation
- Comprendre quelle version est exécutée
- Exécuter correctement un programme exécutable
- Identifier les contrôles minimaux avant livraison
- Localiser les principales sources d’erreur

## VUE D’ENSEMBLE

```mermaid
flowchart LR
    A["Modifier"] --> B["Enregistrer"]
    B --> C["Contrôler"]
    C --> D["Activer"]
    D --> E["Exécuter"]
    E --> F["Tester"]
    F --> G["Contrôles qualité"]
```

## ENREGISTREMENT

L’enregistrement conserve les modifications dans le système. Il ne signifie pas nécessairement que l’objet est actif.

Une version inactive peut donc exister en parallèle de la version active.

> [!IMPORTANT]
> Enregistrer protège le travail en cours. Activer rend la nouvelle version utilisable comme version active.

## CONTRÔLE SYNTAXIQUE

Le contrôle syntaxique analyse le code sans exécuter le scénario fonctionnel.

Il peut détecter notamment :

- mot-clé incorrect ;
- bloc non fermé ;
- identifiant inconnu ;
- incompatibilité de type ;
- appel invalide ;
- erreur de contexte syntaxique.

Exemple invalide :

```abap
DATA gv_value TYPE i

gv_value = 'ABC'.
```

Problèmes :

- point manquant après la déclaration ;
- affectation incompatible susceptible d’échouer ou d’être refusée selon le contexte.

## ACTIVATION

L’activation :

1. contrôle l’objet ;
2. génère sa représentation exécutable ou active ;
3. publie la nouvelle version active ;
4. peut déclencher l’activation de dépendances ou révéler des erreurs dans les objets liés.

Une activation peut échouer si :

- le code contient une erreur ;
- une dépendance est inactive ou incompatible ;
- un objet du Dictionnaire est incohérent ;
- un verrou empêche une opération ;
- une autorisation manque.

## EXÉCUTION

Un programme exécutable peut être lancé depuis `SE38` ou `SE80`.

Séquence classique :

1. l’environnement d’exécution charge le programme ;
2. l’écran de sélection est traité s’il existe ;
3. les événements du programme sont déclenchés ;
4. le traitement produit un résultat ou un effet ;
5. les erreurs non gérées peuvent provoquer un arrêt ou un dump.

### EXÉCUTION DIRECTE

`F8` exécute le programme dans le contexte courant.

### EXÉCUTION EN MODE DEBUG

Le menu de test permet de démarrer le programme directement sous contrôle du Debugger.

## QUELLE VERSION EST UTILISÉE ?

L’exécution normale utilise la version active disponible.

```mermaid
flowchart TD
    A["Modification enregistrée"] --> B{"Activée ?"}
    B -->|"Non"| C["Version active précédente utilisée"]
    B -->|"Oui"| D["Nouvelle version active utilisée"]
```

C’est la cause classique d’un test qui semble ignorer une correction récente.

## TEST TECHNIQUE MINIMAL

Pour un programme simple :

- contrôle syntaxique sans erreur ;
- activation réussie ;
- exécution nominale ;
- valeurs limites ;
- absence de saisie si le champ est facultatif ;
- saisie invalide ;
- absence de données ;
- volume représentatif lorsque pertinent ;
- contrôle des autorisations ;
- contrôle de l’absence d’effet de bord non prévu.

## CONTRÔLES COMPLÉMENTAIRES

Selon le contexte :

| Outil                        | Usage                                                            |
| ---------------------------- | ---------------------------------------------------------------- |
| Contrôle étendu du programme | Recherche d’anomalies supplémentaires sur un programme classique |
| Code Inspector               | Contrôles statiques selon une variante                           |
| ABAP Test Cockpit            | Contrôles qualité centralisés selon la configuration du système  |
| ABAP Unit                    | Tests automatisés de code testable                               |
| Runtime Analysis             | Analyse du temps d’exécution                                     |
| SQL Trace                    | Analyse des accès SQL                                            |

Ces outils seront détaillés dans les dossiers consacrés à la qualité et à la performance.

## ERREURS D’EXÉCUTION

### MESSAGE APPLICATIF

Un message peut signaler une erreur gérée par le programme.

### DUMP ABAP

Une erreur d’exécution non gérée peut produire un dump analysable avec `ST22`.

Exemples de causes :

- conversion impossible ;
- accès à une référence non liée ;
- débordement numérique ;
- exception non gérée ;
- absence d’autorisation selon le traitement ;
- incohérence technique.

### JOURNAUX

Selon le programme, analyser également :

- journal applicatif ;
- spool ;
- journal de job ;
- messages système ;
- traces techniques adaptées.

## CHECKLIST AVANT TRANSPORT

- [ ] tous les objets modifiés sont activés ;
- [ ] le programme s’exécute sur les cas prévus ;
- [ ] les erreurs sont gérées ;
- [ ] les textes sont maintenus ;
- [ ] les objets dépendants sont transportés ;
- [ ] les contrôles qualité requis sont exécutés ;
- [ ] aucun objet sans rapport n’est présent dans la requête ;
- [ ] le test après import est défini.

## PROCÉDURE PAS À PAS

### Étape 1 — Créer une version inactive observable

Ouvrir un report Z actif dans `SE38`, modifier une valeur visible puis enregistrer sans activer. Vérifier l’indicateur de statut : le source sauvegardé doit être inactif tandis que l’ancienne version reste active.

### Étape 2 — Contrôler avant activation

Exécuter `Ctrl+F2`. Corriger les erreurs dans l’ordre indiqué. Si une erreur vient d’un objet dépendant, ouvrir cet objet et déterminer s’il doit être activé dans la même livraison.

### Étape 3 — Activer

Exécuter `Ctrl+F3` et examiner la liste des objets proposée. Activer uniquement le périmètre cohérent. En cas d’échec, relever l’objet et le message qui bloquent l’activation au lieu de relancer sans correction.

### Étape 4 — Prouver la version exécutée

Lancer avec `F8` et vérifier que la valeur modifiée apparaît. Si l’ancienne valeur persiste, confirmer le système, le programme et le statut actif.

### Étape 5 — Comparer si nécessaire

Utiliser la gestion des versions pour comparer la version active avec une version antérieure. Le contrôle est terminé lorsque le source sauvegardé et la version active attendue correspondent et que l’exécution produit le résultat prévu.

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Intervenir dans le mauvais système ou mandant.
- Confondre sauvegarde et activation.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA gv_value TYPE i

gv_value = 'ABC'.
```

## TERMES DU LEXIQUE

- [Système SAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#systeme-sap>)
- [Mandant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>)
- [SAP GUI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Repository ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#repository-abap>)
- [Package](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>)

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP Source Code Editor](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/9ac600a0fad14967aaf2964be5a21963.html)
- [Starting and Directly Debugging ABAP Programs](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/a95208086a6e448aa35f08357d958af5.html)
- [Running Local Quality Checks with the ATC](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/ca5e041535c0491db596d3ca6658cd7d.html)

---

[Chapitre suivant — ÉVÉNEMENTS D’UN PROGRAMME EXÉCUTABLE](<./10 ├── EVENEMENTS D UN PROGRAMME EXECUTABLE.md>)
