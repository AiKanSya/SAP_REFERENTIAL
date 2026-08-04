# EXTENDED PROGRAM CHECK AVEC SLIN

## RÉSULTAT ATTENDU

Exécuter les contrôles approfondis de la transaction `SLIN` sur des sources actives.

## Exécution

- appeler directement `SLIN` ;
- ou utiliser le menu **Programme > Vérifier > Vérification étendue du programme** dans l’éditeur ABAP ;
- sélectionner le programme et les groupes de contrôles ;
- lancer l’analyse ;
- ouvrir chaque message et naviguer vers la source.

## Catégories rencontrées

Les options exactes dépendent de la release. Elles peuvent couvrir :

- erreurs et avertissements statiques ;
- interfaces de procédures ;
- conversions et accès mémoire ;
- sécurité ;
- package et dépendances ;
- instructions problématiques.

## Source active

La vérification étendue s’appuie sur la version active. Activer les objets avant l’analyse, sinon les résultats peuvent ne pas correspondre au code en cours de modification.

## Traiter un message

1. Comprendre la règle et le scénario détecté.
2. Vérifier si le chemin est réellement possible.
3. Corriger la cause.
4. Relancer le contrôle.
5. Documenter toute suppression autorisée.

## SLIN n’est pas un test fonctionnel

Il détecte des problèmes reconnaissables statiquement. Il ne valide ni le résultat métier ni la qualité des données produites.

## Références SAP officielles

- [ABAP Keyword Documentation — Extended Program Check](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXTENDED_PROGRAM_CHECK_GUIDL.html)

## PROCÉDURE PAS À PAS

1. Lire la définition et identifier les prérequis du chapitre.
2. Choisir un objet Z ou un scénario de démonstration sans impact métier.
3. Reproduire l’exemple dans un système de développement et relever les données d’entrée.
4. Contrôler la syntaxe ou la configuration avant activation/exécution.
5. Comparer le résultat observé avec la section **Vérification**.
6. Documenter toute différence liée à la release, aux autorisations ou au paramétrage du système.

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
