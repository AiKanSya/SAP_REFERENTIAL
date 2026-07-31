# 🍧 ANALYSER LES ACCES SQL AVEC ST05

## 🎯 Objectif

Tracer précisément les accès SQL exécutés pendant un scénario court et reproductible.

## 🛠️ Procédure sûre

1. Ouvrir `ST05`.
2. Activer la trace SQL pour le bon utilisateur ou contexte.
3. Exécuter immédiatement le scénario ciblé.
4. Désactiver la trace sans attendre.
5. Afficher la trace et regrouper les instructions identiques.

## 🔍 Informations à examiner

- durée totale et moyenne ;
- nombre d’exécutions ;
- lignes retournées ;
- paramètres transmis ;
- source ABAP appelante ;
- plan d’exécution lorsque disponible.

## 🚨 Signaux fréquents

| Signal                           | Hypothèse                      |
| -------------------------------- | ------------------------------ |
| même requête répétée             | SQL dans une boucle            |
| beaucoup de lignes retournées    | filtre insuffisant             |
| temps moyen élevé                | plan d’accès ou volumétrie     |
| nombreuses requêtes très courtes | coût cumulé des allers-retours |

```mermaid
flowchart LR
    A["Activer ST05"] --> B["Exécuter un scénario court"]
    B --> C["Désactiver la trace"]
    C --> D["Regrouper et analyser"]
```

## ⚠️ Discipline d’utilisation

La trace peut capturer des données techniques sensibles et produire un volume important. Cibler l’utilisateur, limiter la durée et désactiver la trace immédiatement après le scénario. Ne pas lancer une trace globale prolongée sans coordination avec l’administration.

## ✅ Après correction

Répéter exactement le même scénario et comparer le nombre d’accès, le temps cumulé et le volume retourné.

## 🔗 Références SAP officielles

- [SAP Help Portal — SQL Trace Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/d1801f89454211d189710000e8322d00.html)
- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)

---

➡️ [Chapitre suivant : SURVEILLER LES ACCES SQL AVEC SQLM](<09 - 🍧 SURVEILLER LES ACCES SQL AVEC SQLM.md>)
