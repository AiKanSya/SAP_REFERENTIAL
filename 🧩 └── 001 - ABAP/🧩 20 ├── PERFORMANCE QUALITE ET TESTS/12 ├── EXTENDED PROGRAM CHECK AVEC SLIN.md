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

## PROCESS

### ÉTAPE 1 — ACTIVER UNE VERSION SYNTACTIQUEMENT VALIDE

Contrôler et activer le programme et ses includes. SLIN analyse le code disponible, mais ne remplace pas le contrôle syntaxique. Relever la version et le système utilisés.

### ÉTAPE 2 — LANCER SLIN SUR LE BON PÉRIMÈTRE

Saisir `/nSLIN` ou utiliser l’entrée de contrôle étendu de l’éditeur. Renseigner le programme, la classe ou l’objet supporté puis sélectionner les groupes de contrôles nécessaires. Exécuter sans élargir inutilement à tout le système.

### ÉTAPE 3 — CLASSER LES MESSAGES

Regrouper les findings par flux de données, interface, exception, instruction dangereuse ou code inaccessible. Ouvrir la documentation de chaque règle. Commencer par les erreurs susceptibles de produire un défaut runtime.

### ÉTAPE 4 — NAVIGUER VERS LA SOURCE

Ouvrir la ligne indiquée et analyser le chemin d’exécution complet. Vérifier les types, valeurs initiales et appels. Ne pas neutraliser le finding par un pragma ou pseudo-commentaire avant d’avoir prouvé son absence d’impact.

### ÉTAPE 5 — CORRIGER ET TESTER LE CAS SIGNALÉ

Modifier le code, ajouter un test reproduisant la condition puis exécuter le périmètre fonctionnel. Pour un finding considéré faux positif, conserver la preuve et appliquer uniquement le mécanisme d’exemption autorisé.

### ÉTAPE 6 — RELANCER SLIN ET ATC

Vérifier la disparition du message et l’absence de nouveaux findings. Exécuter ensuite la variante ATC ou SCI du projet, plus large que SLIN, avant livraison.

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
