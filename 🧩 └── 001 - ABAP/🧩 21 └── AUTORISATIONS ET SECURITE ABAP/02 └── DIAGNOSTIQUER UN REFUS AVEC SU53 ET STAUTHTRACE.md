# DIAGNOSTIQUER UN REFUS AVEC `SU53` ET `STAUTHTRACE`

## RÉSULTAT ATTENDU

Identifier l’objet d’autorisation, les champs et les valeurs responsables d’un refus d’accès.

## CHOISIR L’OUTIL

| Situation | Outil |
|---|---|
| Le refus vient de se produire pour l’utilisateur courant | `SU53` |
| Le contrôle fautif n’apparaît pas clairement dans `SU53` | `STAUTHTRACE` |
| Le traitement s’exécute avec un autre utilisateur ou sur plusieurs serveurs | `STAUTHTRACE`, selon autorisations |
| Une trace technique plus large est requise | Outil décidé avec l’équipe Basis/sécurité |

## ANALYSE RAPIDE AVEC `SU53`

1. Reproduire exactement l’action refusée.
2. Ouvrir immédiatement `SU53`.
3. Relever l’objet en échec.
4. Relever chaque champ et chaque valeur demandée.
5. Comparer ces valeurs avec le besoin fonctionnel et le rôle utilisateur.
6. Transmettre le diagnostic à l’équipe sécurité sans demander un rôle plus large que nécessaire.

## TRACE CIBLÉE AVEC `STAUTHTRACE`

1. Ouvrir `STAUTHTRACE` avec les autorisations requises.
2. Limiter la trace à l’utilisateur et au scénario concernés.
3. Activer la trace juste avant la reproduction.
4. Reproduire une seule fois le refus.
5. Désactiver immédiatement la trace.
6. Évaluer les contrôles en échec et les contrôles réussis pertinents.
7. Relever l’objet, les champs, les valeurs et le programme appelant.

## CONTRÔLE

Le diagnostic est complet uniquement s’il contient :

- l’utilisateur d’exécution réel ;
- la date et l’heure du test ;
- la transaction ou le programme exécuté ;
- l’objet d’autorisation ;
- les champs et valeurs contrôlés ;
- le résultat attendu fonctionnellement ;
- la correction retenue dans le code ou dans le rôle.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| `SU53` montre un autre contrôle | Une action ultérieure a remplacé le contexte | Reproduire puis ouvrir `SU53` immédiatement |
| La trace est vide | Mauvais utilisateur, serveur ou intervalle | Contrôler le filtre et le périmètre de trace |
| Trop de résultats | Trace laissée active trop longtemps | Tracer un scénario court et ciblé |
| Le rôle est élargi excessivement | Diagnostic limité au nom de l’objet | Fournir les champs et valeurs exacts |
| Le test passe avec un administrateur | Utilisateur de test trop autorisé | Utiliser un utilisateur représentatif du rôle cible |

## SÉCURITÉ

- Ne pas utiliser `SAP_ALL` comme correction d’un refus.
- Limiter la durée et le périmètre des traces.
- Ne pas publier de captures contenant des utilisateurs, valeurs organisationnelles ou données sensibles.
- La modification d’un rôle appartient au processus de gouvernance des autorisations.

## COMPATIBILITÉ S/4HANA

- `SU53` et `STAUTHTRACE` restent des outils de diagnostic des systèmes ABAP S/4HANA.
- Leur disponibilité et leur périmètre dépendent des autorisations et de l’administration du système.

## RÉFÉRENCES OFFICIELLES SAP

- [How to Check STAUTHTRACE, SU53 and SLG1 in SAP ABAP-Based Systems — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/datasphere/4518522125.html)
- [Authorization Checks — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c6e6d078ab99452db94ed7b3b7bbcccf/4ca0ac7a68243b9ee10000000a42189b.html)
