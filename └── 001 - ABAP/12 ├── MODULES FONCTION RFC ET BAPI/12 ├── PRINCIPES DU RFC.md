# PRINCIPES DU RFC

## OBJECTIFS

- Comprendre la frontière de communication RFC
- Distinguer appel local et appel distant
- Identifier client, serveur et destination
- Connaître les principales variantes du RFC

## DÉFINITION

Le **Remote Function Call** permet d’appeler un module fonction distant depuis un système SAP, un autre système ou un programme externe compatible.

```mermaid
flowchart LR
    A["Client RFC"] --> B["Destination et connexion"]
    B --> C["Serveur RFC"]
    C --> D["Module fonction distant"]
    D --> E["Réponse ou statut"]
```

## RÔLES

| Rôle        | Description                                    |
| ----------- | ---------------------------------------------- |
| Client RFC  | Initie l’appel                                 |
| Destination | Décrit la cible et les paramètres de connexion |
| Serveur RFC | Reçoit et exécute la demande                   |
| RFM         | Module fonction marqué comme distant           |

Le même système peut être client et serveur selon le scénario.

## FRONTIÈRE DISTRIBUÉE

Un appel RFC implique potentiellement :

- réseau ;
- authentification ;
- autorisations ;
- conversion de données ;
- indisponibilité de la cible ;
- temps de réponse variable ;
- erreurs de communication ;
- transaction répartie.

Ne pas traiter un RFC comme un simple appel local plus lent.

## VARIANTES

| Variante | Caractéristique générale                                          |
| -------- | ----------------------------------------------------------------- |
| sRFC     | Appel synchrone, attente du résultat                              |
| aRFC     | Appel asynchrone, résultat éventuellement reçu plus tard          |
| tRFC     | Appel transactionnel enregistré pour exécution fiable             |
| qRFC     | tRFC ordonné dans une file                                        |
| bgRFC    | Infrastructure plus récente pour certains traitements asynchrones |

Le choix dépend du besoin de réponse, d’ordre, de fiabilité et de reprise.

## RFC ET BAPI

Une BAPI est généralement implémentée par un module fonction compatible RFC, mais tout module RFC n’est pas une BAPI. La BAPI ajoute un contrat métier standardisé et une gouvernance d’API.

## PROCÉDURE PAS À PAS

1. Saisir `/nSE37`.
2. Entrer le nom du module fonction puis choisir **Afficher**, **Modifier** ou **Créer** selon l’autorisation.
3. Analyser les onglets Import, Export, Changing, Tables et Exceptions.
4. Lire la documentation et le code source avant tout appel.
5. Utiliser **Test/Exécuter** avec des données non destructives.
6. Pour un module Z, contrôler, activer puis tester les cas nominal et d’erreur.

## VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## ERREURS FRÉQUENTES

- Appeler un module fonction sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

## TERMES DU LEXIQUE

- [Module fonction](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-rfc>)
- [BAPI](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bapi>)
- [Destination RFC](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#destination-rfc>)

## RÉFÉRENCES OFFICIELLES SAP

- [RFC Calls — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/753088fc00704d0a80e7fbd6803c8adb/48920827feb35ed2e10000000a42189d.html)
- [Calling RFC Function Modules in ABAP — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/753088fc00704d0a80e7fbd6803c8adb/48a0f18641bc062de10000000a42189d.html)
- [Describing Remote Function Calls and BAPIs — SAP Learning](https://learning.sap.com/courses/technical-implementation-and-operation-i-of-sap-s-4hana-and-sap-business-suite/describing-remote-function-calls-and-bapis)


---

[Chapitre suivant — MODULES FONCTION DISTANTS ET CONTRAINTES](<./13 ├── MODULES FONCTION DISTANTS ET CONTRAINTES.md>)
