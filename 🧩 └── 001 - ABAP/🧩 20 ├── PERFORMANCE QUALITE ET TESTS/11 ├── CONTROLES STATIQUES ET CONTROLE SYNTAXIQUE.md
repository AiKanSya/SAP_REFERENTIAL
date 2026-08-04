# CONTROLES STATIQUES ET CONTROLE SYNTAXIQUE

## RÉSULTAT ATTENDU

Distinguer les vérifications immédiates de l’éditeur des analyses statiques plus approfondies.

## Niveaux de contrôle

| Contrôle               | Portée                                          |
| ---------------------- | ----------------------------------------------- |
| Contrôle syntaxique    | grammaire, typage et incohérences immédiates    |
| Activation             | génération de la version active et dépendances  |
| Extended Program Check | erreurs statiquement détectables plus coûteuses |
| Code Inspector / ATC   | règles regroupées dans une variante de contrôle |
| ABAP Unit              | comportement exécuté                            |

Le contrôle syntaxique doit être exécuté avant l’activation. Une activation réussie ne signifie pas que le programme respecte les règles de sécurité, de performance ou de maintenabilité.

## Exemples de défauts statiques

- variable jamais utilisée ;
- conversion dangereuse ;
- accès non sécurisé ;
- code inaccessible ;
- exception ignorée ;
- instruction obsolète ;
- problème de package ou d’API selon la variante.

## Pseudo-commentaires et pragmas

Ils peuvent supprimer certains messages, mais ne corrigent pas la cause. Leur usage doit être exceptionnel, documenté et compatible avec la gouvernance ATC du projet.

## Routine développeur

1. Contrôle syntaxique après chaque unité cohérente.
2. Activation de tous les objets dépendants.
3. Contrôle local `ATC` ou `SCI`.
4. Exécution des tests.
5. Contrôle officiel avant libération du transport.

## Références SAP officielles

- [ABAP Keyword Documentation — Extended Program Check](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXTENDED_PROGRAM_CHECK_GUIDL.html)
- [SAP Help Portal — Code Inspector](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/49205531d0fc14cfe10000000a42189b.html)
- [SAP Help Portal — ATC Quality Checking](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec1a1126e391014adc9fffe4e204223.html)

## PROCÉDURE PAS À PAS

1. Saisir `/nSCI`.
2. Créer ou sélectionner une variante de contrôles approuvée par le projet.
3. Créer une inspection sur le package, l’objet ou l’ensemble de transport visé.
4. Exécuter l’inspection.
5. Analyser chaque finding, corriger la cause ou documenter l’exception selon la gouvernance.
6. Relancer jusqu’à obtenir le niveau de qualité attendu.

## VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## ERREURS FRÉQUENTES

- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## FICHE DE CONTRÔLE À COPIER

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

## TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
