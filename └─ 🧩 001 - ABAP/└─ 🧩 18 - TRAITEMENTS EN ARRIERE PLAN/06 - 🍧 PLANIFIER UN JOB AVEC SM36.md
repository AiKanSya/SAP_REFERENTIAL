# 🌸 PLANIFIER UN JOB AVEC `SM36`

## 🌺 OBJECTIFS

- Créer un job classique dans SAP GUI
- Définir ses étapes et sa condition de démarrage
- Vérifier qu’il est effectivement libéré

## 🌺 PROCÉDURE

1. lancer `SM36` ;
2. saisir un nom de job explicite ;
3. choisir la classe appropriée ;
4. définir au moins une étape ;
5. sélectionner le programme ABAP et sa variante ;
6. définir la condition de démarrage ;
7. enregistrer ;
8. contrôler le job dans `SM37`.

```mermaid
flowchart LR
    A["Nom et classe"] --> B["Étapes"]
    B --> C["Condition de démarrage"]
    C --> D["Enregistrement"]
    D --> E["Contrôle dans SM37"]
```

## 🌺 NOM DU JOB

Le nom doit permettre de retrouver rapidement :

- le domaine fonctionnel ;
- le traitement ;
- la fréquence ou le déclencheur ;
- éventuellement l’interface ou le système consommateur.

Éviter les noms génériques comme `TEST`, `JOB1` ou `TRAITEMENT`.

## 🌺 ASSISTANT DE PLANIFICATION

`SM36` propose également un assistant guidé. Il simplifie la saisie, mais ne remplace pas la compréhension des étapes, des variantes, des utilisateurs d’exécution et des conditions de démarrage.

## 🌺 CONTRÔLE FINAL

Un job enregistré mais non libéré ne démarrera pas. Vérifier le statut, l’heure prévue, l’utilisateur, le programme, la variante et le serveur cible éventuel.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)
- [Job Scheduling Wizard — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bbf7b4c594ba2e10000000a42189c.html)

---

➡️ [Chapitre suivant — CONDITIONS DE DEMARRAGE](<./07 - 🍧 CONDITIONS DE DEMARRAGE.md>)
