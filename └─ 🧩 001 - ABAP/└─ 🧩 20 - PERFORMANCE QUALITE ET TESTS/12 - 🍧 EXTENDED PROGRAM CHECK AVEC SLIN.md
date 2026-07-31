# 🍧 EXTENDED PROGRAM CHECK AVEC SLIN

## 🎯 Objectif

Exécuter les contrôles approfondis de la transaction `SLIN` sur des sources actives.

## 🛠️ Exécution

- appeler directement `SLIN` ;
- ou utiliser le menu **Programme > Vérifier > Vérification étendue du programme** dans l’éditeur ABAP ;
- sélectionner le programme et les groupes de contrôles ;
- lancer l’analyse ;
- ouvrir chaque message et naviguer vers la source.

## 🔍 Catégories rencontrées

Les options exactes dépendent de la release. Elles peuvent couvrir :

- erreurs et avertissements statiques ;
- interfaces de procédures ;
- conversions et accès mémoire ;
- sécurité ;
- package et dépendances ;
- instructions problématiques.

## 📌 Source active

La vérification étendue s’appuie sur la version active. Activer les objets avant l’analyse, sinon les résultats peuvent ne pas correspondre au code en cours de modification.

## 🧭 Traiter un message

1. Comprendre la règle et le scénario détecté.
2. Vérifier si le chemin est réellement possible.
3. Corriger la cause.
4. Relancer le contrôle.
5. Documenter toute suppression autorisée.

## ⚠️ SLIN n’est pas un test fonctionnel

Il détecte des problèmes reconnaissables statiquement. Il ne valide ni le résultat métier ni la qualité des données produites.

## 🔗 Références SAP officielles

- [ABAP Keyword Documentation — Extended Program Check](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXTENDED_PROGRAM_CHECK_GUIDL.html)

---

➡️ [Chapitre suivant : CODE INSPECTOR AVEC SCI](<13 - 🍧 CODE INSPECTOR AVEC SCI.md>)
