# 24. CHECKLIST QUALITE AVANT LIVRAISON

## 24.A RÉSULTAT ATTENDU

Vérifier qu’un développement ABAP est techniquement prêt avant la libération de son transport.

## 24.B Code et activation

- [ ] Tous les objets sont actifs.
- [ ] Aucun code temporaire, breakpoint ou donnée de test ne subsiste.
- [ ] Les noms, commentaires et interfaces sont compréhensibles.
- [ ] Les exceptions et codes retour sont traités.
- [ ] Les autorisations et données sensibles ont été examinées.

## 24.C Qualité statique

- [ ] Contrôle syntaxique sans erreur.
- [ ] `SLIN` exécuté lorsque pertinent.
- [ ] Contrôle `SCI` ou `ATC` avec la variante projet.
- [ ] Findings prioritaires corrigés.
- [ ] Exemptions limitées, justifiées et approuvées.

## 24.D Tests

- [ ] Tests unitaires exécutés avec succès.
- [ ] Cas nominaux, erreurs et limites couverts.
- [ ] Tests d’intégration documentés.
- [ ] Test de non-régression ajouté pour les défauts corrigés.
- [ ] Données de test et nettoyage maîtrisés.

## 24.E Performance

- [ ] Volumétrie représentative utilisée.
- [ ] Aucun accès SQL dans une boucle sans justification mesurée.
- [ ] Colonnes et lignes SQL limitées au besoin.
- [ ] Catégories et clés des tables internes adaptées.
- [ ] `SAT`, `ST05`, `SQLM` ou `SWLT` utilisés si le risque le justifie.
- [ ] Mesure avant/après conservée pour toute optimisation.

## 24.F Exploitation

- [ ] Messages et journaux permettent le diagnostic.
- [ ] Batch, reprise et idempotence validés si applicables.
- [ ] Verrous et LUW sont cohérents.
- [ ] Documentation technique et procédure de test mises à jour.
- [ ] Contenu du transport contrôlé avant libération.

## 24.G Critère final

La livraison ne repose pas sur « le programme fonctionne sur mon cas ». Elle repose sur des résultats reproductibles, des contrôles traçables et une compréhension explicite des risques résiduels.

## 24.H Références SAP officielles

- [SAP Help Portal — ATC Quality Checking](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec1a1126e391014adc9fffe4e204223.html)
- [SAP Help Portal — Code Inspector](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/49205531d0fc14cfe10000000a42189b.html)
- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)
- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)

## 24.I PROCESS

### 24.I.1 ÉTAPE 1 — FIGER LE PÉRIMÈTRE LIVRÉ

Lister tous les objets de la demande, dépendances DDIC, classes, programmes, messages et paramétrages. Vérifier qu’ils sont actifs et transportables. Comparer cette liste au besoin et aux objets réellement modifiés.

### 24.I.2 ÉTAPE 2 — EXÉCUTER LES CONTRÔLES STATIQUES

Lancer syntaxe, activation, SLIN et la variante ATC/SCI obligatoire sur le périmètre final. Corriger les findings bloquants. Vérifier les exemptions, leur approbation, leur propriétaire et leur échéance.

### 24.I.3 ÉTAPE 3 — EXÉCUTER LES TESTS AUTOMATIQUES

Lancer ABAP Unit au niveau de l’objet puis du package. Ouvrir chaque échec et éliminer les dépendances d’ordre ou de données. Contrôler la couverture des branches critiques avec SCOV lorsque requise.

### 24.I.4 ÉTAPE 4 — EXÉCUTER LA NON-RÉGRESSION FONCTIONNELLE

Tester cas cible, cas hors périmètre, limites, erreurs, autorisations et rollback avec des données identifiées. Vérifier interfaces, jobs, journaux et spools concernés. Conserver les preuves et résultats attendus.

### 24.I.5 ÉTAPE 5 — VALIDER LA PERFORMANCE

Pour tout scénario sensible, comparer la mesure finale à la référence avec le même volume et le même contexte. Contrôler SQL, mémoire et temps. Ne pas accepter une dégradation non expliquée parce que les tests fonctionnels sont verts.

### 24.I.6 ÉTAPE 6 — CONTRÔLER LE TRANSPORT ET LE RETOUR ARRIÈRE

Vérifier ordre d’import, prérequis, variantes et procédure de validation dans le système cible. Définir la remise en cohérence si le déploiement échoue après des changements non réversibles. Libérer uniquement lorsque les preuves sont rattachées au périmètre final.

## 24.J VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 24.K ERREURS FRÉQUENTES

- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 24.L FICHE DE CONTRÔLE À COPIER

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

## 24.M TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
