# 🌸 ANALYSER LES VERROUS AVEC `SM12`

## 🌺 OBJECTIFS

- Rechercher une entrée de verrou
- Identifier son propriétaire et sa portée
- Supprimer un verrou uniquement après analyse

## 🌺 DONNÉES À EXAMINER

Dans `SM12`, filtrer par :

- utilisateur ;
- table ou argument de verrou ;
- mandant ;
- heure de création ;
- objet de verrouillage ;
- mode.

Une entrée permet généralement d’identifier le propriétaire, la clé verrouillée et le mode `S`, `E`, `X` ou `O`.

## 🌺 MÉTHODE DE DIAGNOSTIC

1. reproduire la collision ;
2. rechercher l’entrée dans `SM12` ;
3. identifier la session ou le traitement propriétaire ;
4. vérifier si la transaction est toujours active ;
5. examiner les erreurs associées dans `ST22`, `SM13`, jobs ou logs ;
6. supprimer uniquement si l’entrée est réellement orpheline et si l’impact métier est compris.

## 🌺 RISQUE DE SUPPRESSION MANUELLE

Supprimer un verrou ne restaure pas la cohérence des données. Le programme propriétaire peut encore poursuivre et écrire comme s’il détenait le verrou. La suppression manuelle est une opération d’administration, pas une solution applicative normale.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [SM12 - Lock Concept — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/basis/3354611556.html)
- [Select and Display Lock Entries — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/d0739d980ecf42ae9f3b4c19e21a4b6e/47ea3bcee97f486ee10000000a42189d.html)
- [Lock Table — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/6568469cf5a1460a8d85c58b83d21ec2/47daae4038793c85e10000000a42189c.html)

---

➡️ [Chapitre suivant — ARCHITECTURE DE LA MISE A JOUR SAP](<./13 - 🍧 ARCHITECTURE DE LA MISE A JOUR SAP.md>)
