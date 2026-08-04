# 8. CHECKLIST SÉCURITÉ AVANT LIVRAISON

## 8.A RÉSULTAT ATTENDU

Bloquer la livraison d’un développement ABAP qui expose une action ou une donnée sans contrôle suffisant.

## 8.B CHECKLIST

- Toutes les actions métier sensibles exécutent un `AUTHORITY-CHECK` et traitent immédiatement son résultat.
- Les contrôles couvrent les dimensions métier, pas seulement `S_TCODE`.
- Les entrées externes sont validées en type, longueur, domaine et volume.
- Les noms dynamiques proviennent d’une liste blanche.
- Chaque `WITH PRIVILEGED ACCESS` est justifié, précédé d’un contrôle explicite et limité aux lignes et colonnes nécessaires.
- Aucun secret, mot de passe ou jeton n’est codé en dur ou écrit dans les journaux.
- Aucun chemin de fichier externe n’est utilisé directement.
- Les appels RFC, HTTP et SOAP appliquent des contrôles dans le système cible.
- Les messages utilisateur ne révèlent pas de détails internes inutiles.
- Les données personnelles et financières ne sont pas dupliquées dans les traces.
- Les contrôles `ATC`, `SCI` et les variantes de sécurité du projet sont exécutés.
- Un test négatif prouve le refus pour chaque action protégée.
- `STAUTHTRACE` confirme que les valeurs contrôlées correspondent au concept de rôles.

## 8.C PROCESS

### 8.C.1 Étape 1 — Recenser les surfaces exposées

Lister les transactions, rapports, modules RFC, services HTTP, traitements en arrière-plan, fichiers et interfaces accessibles. Pour chaque point d’entrée, identifier les actions et les données sensibles.

La revue doit couvrir le code appelé indirectement, pas seulement le programme de démarrage.

### 8.C.2 Étape 2 — Cartographier les entrées externes

Relever chaque valeur provenant d’un écran, d’un fichier, d’un appel distant, d’un paramétrage ou d’une base de données. Vérifier son type, sa longueur, son domaine, son volume maximal et son usage dynamique éventuel.

Toute valeur utilisée comme nom de table, champ, classe, méthode, fonction, programme ou transaction doit provenir d’une liste d’autorisation fermée.

### 8.C.3 Étape 3 — Vérifier les décisions d’autorisation

Pour chaque action sensible, confirmer :

- l’objet et l’activité contrôlés ;
- les dimensions organisationnelles ;
- l’emplacement du contrôle avant l’opération ;
- le traitement immédiat de `SY-SUBRC` ;
- l’utilisateur réel pour les jobs, workflows et RFC ;
- les lectures CDS qui désactivent la DCL avec `WITH PRIVILEGED ACCESS`.

Tracer un scénario représentatif avec `STAUTHTRACE` et comparer les valeurs au concept de rôles.

Pour chaque lecture CDS privilégiée, comparer le résultat normal au résultat privilégié et vérifier qu’un utilisateur refusé n’atteint jamais le `SELECT`.

### 8.C.4 Étape 4 — Exécuter les contrôles statiques

Lancer `ATC` ou `SCI` avec les variantes obligatoires du projet, notamment les contrôles de sécurité disponibles sur le système. Corriger ou justifier formellement chaque résultat selon le processus qualité.

Compléter l’analyse automatique par une revue du code dynamique, des autorisations, des fichiers, des appels distants et de la gestion des erreurs.

### 8.C.5 Étape 5 — Vérifier les données sensibles et les secrets

Inspecter le code, les variantes, les tables de paramétrage, les messages et les journaux. Supprimer les mots de passe, jetons et clés codés en dur. Limiter les traces aux données nécessaires au support.

Contrôler également les fichiers temporaires, les exports et les pièces jointes produits par le traitement.

### 8.C.6 Étape 6 — Exécuter les tests négatifs

Pour chaque action protégée, prouver au minimum :

1. le succès avec les droits exacts ;
2. le refus sans l’activité ;
3. le refus avec une autre valeur organisationnelle ;
4. le rejet d’une entrée invalide ;
5. le rejet d’un nom dynamique non autorisé ;
6. l’absence de fuite d’information dans le message retourné.

Les tests réalisés avec `SAP_ALL` ne démontrent pas la sécurité du scénario.

### 8.C.7 Étape 7 — Constituer la preuve de livraison

Conserver avec la demande de transport :

- les résultats `ATC` ou `SCI` ;
- les cas de test positifs et négatifs ;
- la liste des objets d’autorisation ;
- la validation de l’équipe sécurité lorsque requise ;
- les anomalies restantes et leur décision formelle.

La livraison doit être bloquée lorsqu’une action sensible reste accessible sans contrôle ou lorsqu’un défaut critique demeure ouvert.

## 8.D CRITÈRE DE SORTIE

Aucune anomalie de sécurité ouverte ne peut être compensée par la seule restriction d’accès à la transaction.

## 8.E RÉFÉRENCES OFFICIELLES SAP

- [Authorization Checks in Your Own Developments — SAP SE, SAP S/4HANA](https://help.sap.com/docs/ABAP_PLATFORM_NEW/88c6b8647c8d40b39eb554e2d7b6bda1/5267167f439b11d1896f0000e8322d00.html)
- [File Authorization — SAP SE, SAP S/4HANA 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/dc545b5a743047b6b468bbadd0085ce2.html)
- [RFC Authorizations — SAP SE, SAP NetWeaver AS ABAP](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c495ada972d045b2be2869f5573af8e7/488de31b81cd0e27e10000000a421937.html)
- [Access Control — SAP SE, SAP S/4HANA 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/67e4075c942e43d4a9f6f891a8dafcf4/85cb9cf7c3eb442b82451a8294747785.html)

## 8.F CHAPITRE ASSOCIÉ

- [Lire une CDS protégée et utiliser WITH PRIVILEGED ACCESS](<../🧩 08 ├── OPEN SQL/19 └── LIRE UNE CDS PROTEGEE ET UTILISER WITH PRIVILEGED ACCESS.md>)
