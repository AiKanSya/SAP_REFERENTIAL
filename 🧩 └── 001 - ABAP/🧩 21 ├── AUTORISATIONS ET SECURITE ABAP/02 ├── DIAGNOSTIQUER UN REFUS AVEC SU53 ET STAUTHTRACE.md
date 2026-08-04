# 2. DIAGNOSTIQUER UN REFUS AVEC `SU53` ET `STAUTHTRACE`

## 2.A RÉSULTAT ATTENDU

Identifier l’objet d’autorisation, les champs et les valeurs responsables d’un refus d’accès.

## 2.B CHOISIR L’OUTIL

| Situation                                                                   | Outil                                     |
| --------------------------------------------------------------------------- | ----------------------------------------- |
| Le refus vient de se produire pour l’utilisateur courant                    | `SU53`                                    |
| Le contrôle fautif n’apparaît pas clairement dans `SU53`                    | `STAUTHTRACE`                             |
| Le traitement s’exécute avec un autre utilisateur ou sur plusieurs serveurs | `STAUTHTRACE`, selon autorisations        |
| Une trace technique plus large est requise                                  | Outil décidé avec l’équipe Basis/sécurité |

## 2.C PROCESS

### 2.C.1 Étape 1 — Identifier le contexte d’exécution réel

Relever avant le test :

- l’utilisateur qui exécute réellement le traitement ;
- la transaction, le programme ou le service appelé ;
- le système et le mandant ;
- la date et l’heure de reproduction ;
- l’action fonctionnelle attendue.

Pour un traitement RFC, un workflow ou un job, l’utilisateur technique peut différer de l’utilisateur connecté à l’écran.

### 2.C.2 Étape 2 — Reproduire une seule fois le refus

Exécuter exactement l’action qui échoue. Ne lancer aucune autre fonction avant l’analyse, car un contrôle ultérieur peut remplacer les informations visibles dans `SU53`.

Noter le message, l’écran et la valeur métier utilisée pendant le test.

### 2.C.3 Étape 3 — Analyser immédiatement `SU53`

Ouvrir `SU53` dans la même session utilisateur. Relever l’objet d’autorisation, chaque champ, chaque valeur demandée et le résultat du contrôle.

Comparer ces valeurs avec :

- le besoin fonctionnel ;
- le contrôle présent dans le code ;
- les valeurs attribuées dans le rôle.

Si `SU53` montre clairement le contrôle responsable, le diagnostic peut continuer directement à l’étape 7.

### 2.C.4 Étape 4 — Préparer une trace ciblée lorsque `SU53` est insuffisant

Ouvrir `STAUTHTRACE` avec les autorisations requises. Limiter le filtre à l’utilisateur, au serveur d’application et à l’intervalle nécessaires au scénario.

Ne pas lancer une trace globale sans justification. Elle produit trop de résultats et peut exposer des informations techniques inutiles.

### 2.C.5 Étape 5 — Activer, reproduire puis arrêter la trace

Activer la trace juste avant le test, reproduire le refus une seule fois puis désactiver immédiatement la trace.

Vérifier que la trace couvre le serveur et l’utilisateur réels. Une trace vide indique souvent un filtre, un serveur ou un contexte d’exécution incorrect.

### 2.C.6 Étape 6 — Évaluer les contrôles enregistrés

Rechercher les contrôles en échec autour de l’heure exacte. Examiner aussi les contrôles réussis pertinents afin de distinguer le contrôle attendu d’un contrôle secondaire.

Pour chaque ligne utile, relever :

- l’objet ;
- les champs et valeurs ;
- le code retour ;
- le programme ou l’unité appelante ;
- l’utilisateur d’exécution.

### 2.C.7 Étape 7 — Déterminer la correction au bon endroit

Corriger le code si l’objet, l’activité, la valeur ou le moment du contrôle est erroné. Corriger le rôle si le contrôle est conforme au besoin mais que l’autorisation nécessaire manque.

Ne pas demander `SAP_ALL`, une valeur `*` ou un rôle plus large comme solution de diagnostic.

### 2.C.8 Étape 8 — Rejouer le test complet

Après correction, répéter le cas autorisé et au moins un cas refusé. La validation est terminée lorsque le comportement fonctionnel, le code et le rôle produisent la même décision.

## 2.D CONTRÔLE

Le diagnostic est complet uniquement s’il contient :

- l’utilisateur d’exécution réel ;
- la date et l’heure du test ;
- la transaction ou le programme exécuté ;
- l’objet d’autorisation ;
- les champs et valeurs contrôlés ;
- le résultat attendu fonctionnellement ;
- la correction retenue dans le code ou dans le rôle.

## 2.E ERREURS FRÉQUENTES

| Symptôme                             | Cause probable                               | Correction                                          |
| ------------------------------------ | -------------------------------------------- | --------------------------------------------------- |
| `SU53` montre un autre contrôle      | Une action ultérieure a remplacé le contexte | Reproduire puis ouvrir `SU53` immédiatement         |
| La trace est vide                    | Mauvais utilisateur, serveur ou intervalle   | Contrôler le filtre et le périmètre de trace        |
| Trop de résultats                    | Trace laissée active trop longtemps          | Tracer un scénario court et ciblé                   |
| Le rôle est élargi excessivement     | Diagnostic limité au nom de l’objet          | Fournir les champs et valeurs exacts                |
| Le test passe avec un administrateur | Utilisateur de test trop autorisé            | Utiliser un utilisateur représentatif du rôle cible |

## 2.F SÉCURITÉ

- Ne pas utiliser `SAP_ALL` comme correction d’un refus.
- Limiter la durée et le périmètre des traces.
- Ne pas publier de captures contenant des utilisateurs, valeurs organisationnelles ou données sensibles.
- La modification d’un rôle appartient au processus de gouvernance des autorisations.

## 2.G COMPATIBILITÉ S/4HANA

- `SU53` et `STAUTHTRACE` restent des outils de diagnostic des systèmes ABAP S/4HANA.
- Leur disponibilité et leur périmètre dépendent des autorisations et de l’administration du système.

## 2.H RÉFÉRENCES OFFICIELLES SAP

- [How to Check STAUTHTRACE, SU53 and SLG1 in SAP ABAP-Based Systems — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/datasphere/4518522125.html)
- [Authorization Checks — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c6e6d078ab99452db94ed7b3b7bbcccf/4ca0ac7a68243b9ee10000000a42189b.html)
