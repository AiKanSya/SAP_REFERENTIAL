# 🌸 RECHERCHER UN POINT D’EXTENSION

## 🌺 OBJECTIFS

- Partir de la transaction ou du programme réellement exécuté
- Utiliser les outils du Repository plutôt qu’une recherche approximative
- Prouver le point d’appel par le débogage

## 🌺 DÉMARCHE

1. Reproduire le cas métier avec des données de test.
2. Identifier la transaction, le programme, la classe ou le groupe de fonctions.
3. Rechercher les BAdI, customer exits et enhancement spots du package.
4. Inspecter le code appelant et la documentation du point.
5. Placer un breakpoint dans l’interface candidate.
6. Vérifier les paramètres réellement disponibles.
7. Contrôler le moment de l’appel par rapport aux validations et au commit.

## 🌺 OUTILS SAP GUI

| Outil    | Usage                                                        |
| -------- | ------------------------------------------------------------ |
| `SE84`   | Repository Information System et recherche par package       |
| `SE80`   | Navigation dans les objets et Enhancement Information System |
| `SMOD`   | Recherche d’enhancements classiques                          |
| `SE18`   | Recherche et analyse des définitions BAdI                    |
| `SE19`   | Analyse des implémentations BAdI                             |
| `SE24`   | Analyse des interfaces et classes d’implémentation           |
| `SE37`   | Analyse des function module exits                            |
| Debugger | Preuve du point d’appel et du contexte                       |

## 🌺 RECHERCHE DANS LE CODE

Rechercher notamment :

```abap
CALL CUSTOMER-FUNCTION
GET BADI
CALL BADI
ENHANCEMENT-POINT
ENHANCEMENT-SECTION
```

Les routines historiques peuvent porter des noms tels que `USEREXIT_*`, mais le nom seul ne prouve ni leur activation ni leur pertinence.

## 🌺 VALIDATION

Un point d’extension n’est valide que si :

- il est exécuté dans le scénario cible ;
- les données nécessaires sont disponibles ;
- le résultat attendu peut être produit sans détourner le contrat ;
- l’implémentation ne crée pas de commit ou de verrou incohérent ;
- le point existe dans les versions cibles.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Ways to Find a User Exit — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525969.html)
- [Enhancement Information System — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_750/46a2cfc13d25463b8b9a3d2a3c3ba0d9/29503e423a95b36be10000000a155106.html)
- [Customer Exits (CMOD) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525722.html)

---

➡️ [Chapitre suivant — USER EXITS DANS LES PROGRAMMES STANDARD](<./04 - 🍧 USER EXITS DANS LES PROGRAMMES STANDARD.md>)
