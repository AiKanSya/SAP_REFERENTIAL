# 2. DÉBOGUER ET GÉRER LES CACHES

## 2.A RÉSULTAT ATTENDU

Atteindre l’implémentation exécutée et ne vider un cache qu’après avoir prouvé un metadata obsolète.

## 2.B PRÉREQUIS

- Utilisateur technique effectif de l’appel.
- Système backend et classe DPC_EXT identifiés.
- URI reproductible dans Gateway Client.
- Autorisation de placer un breakpoint externe.

## 2.C BREAKPOINT EXTERNE

Un breakpoint de session ne suffit pas lorsque l’appel HTTP utilise une autre session. Le breakpoint externe doit appartenir à l’utilisateur qui exécute le code backend. Dans un hub, il est placé dans le système backend.

## 2.D PROCESS

### 2.D.1 ÉTAPE 1 — LOCALISER LA MÉTHODE

1. Identifier l’utilisateur technique réel de la requête.
2. Placer un point d’arrêt externe dans la redéfinition `DPC_EXT`.

### 2.D.2 ÉTAPE 2 — REJOUER

3. Rejouer la requête avec ce même utilisateur.
4. Si le point d’arrêt n’est pas atteint, vérifier alias, backend, utilisateur et méthode générée.

### 2.D.3 ÉTAPE 3 — INSPECTER

5. Examiner les clés et options de requête avant l’appel métier.
6. Ne pas modifier les données pendant un simple diagnostic de lecture.

## 2.E CACHES

Un metadata différent entre le projet actif et la réponse HTTP peut provenir d’un cache Gateway ou backend. Comparer d’abord les versions et l’enregistrement. Utiliser ensuite les outils d’administration de cache adaptés à la version et au déploiement. Une invalidation globale ne doit pas remplacer l’identification de la cause.

Ordre de diagnostic : projet actif, runtime artifacts, service/version enregistrés, backend sélectionné, metadata HTTP, puis cache. Invalider uniquement la couche et le service concernés lorsque l’outil de la version le permet.

## 2.F CONTRÔLE

- Le point d’arrêt est atteint dans le système attendu.
- Le metadata HTTP correspond au modèle actif.
- Une seconde requête sans debugger produit le même résultat fonctionnel.
- L’invalidation n’a pas masqué un mauvais alias ou une mauvaise version de service.

## 2.G ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Breakpoint ignoré | Mauvais utilisateur ou système | Breakpoint externe dans le backend |
| Ancien metadata persistant | Projet non actif, mauvaise version ou cache | Contrôler dans cet ordre |
| Correction temporaire après purge | Cause structurelle non corrigée | Reprendre enregistrement et génération |
| Session bloquée | Breakpoint sur utilisateur partagé | Utiliser un compte de test dédié |

## 2.H COMPATIBILITÉ S/4HANA

Les transactions et fonctions d’invalidation varient selon `SAP_GWFND`. Utiliser la documentation du système cible et éviter toute purge globale non justifiée.

## 2.I RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [SAP Gateway Error Logs — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapconn/3354079390.html)
