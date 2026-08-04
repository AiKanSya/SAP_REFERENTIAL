# LIRE UNE CDS PROTÉGÉE ET UTILISER `WITH PRIVILEGED ACCESS`

## RÉSULTAT ATTENDU

Lire une entité CDS avec son contrôle d’accès DCL actif, puis utiliser `WITH PRIVILEGED ACCESS` uniquement lorsqu’un traitement explicitement autorisé doit ignorer ce filtrage.

## POINT DE CLARIFICATION

`WITH PRIVILEGED ACCESS` n’est pas une fonction de `SE80`. Il s’agit d’une addition ABAP SQL placée après la source CDS dans un `SELECT`. `SE80` ou l’éditeur utilisé ne modifie pas son comportement à l’exécution.

## RISQUE DE SÉCURITÉ

Une lecture ABAP SQL normale d’une entité CDS protégée évalue implicitement son contrôle d’accès. L’addition `WITH PRIVILEGED ACCESS` désactive ce contrôle pour l’accès concerné.

Elle ne doit pas être ajoutée pour « récupérer les lignes manquantes ». Son utilisation exige une justification métier, une autorisation explicite dans le programme, une sélection bornée et des tests négatifs.

## LECTURE NORMALE À PRIVILÉGIER

Cet exemple fictif lit directement une entité CDS protégée. Le résultat reste limité par la DCL applicable à l’utilisateur courant.

```abap
PARAMETERS p_bukrs TYPE bukrs OBLIGATORY.

SELECT FROM zi_sales_order
  FIELDS SalesOrder,
         CompanyCode,
         CreatedByUser
  WHERE CompanyCode = @p_bukrs
  INTO TABLE @DATA(lt_visible_orders).
```

`ZI_SALES_ORDER` et ses éléments sont des noms d’exemple. Ils doivent être remplacés par l’entité et les éléments réellement disponibles sur le système.

## LECTURE PRIVILÉGIÉE À JUSTIFIER

L’objet `Z_CDS_PRIV` et le champ `ZBUKRS` sont fictifs. Ils représentent le contrôle applicatif compensatoire décidé avec l’équipe sécurité ; ils ne sont pas imposés automatiquement par `WITH PRIVILEGED ACCESS`.

```abap
PARAMETERS p_bukrs TYPE bukrs OBLIGATORY.

CONSTANTS gc_activity_display TYPE activ_auth VALUE '03'.

" Autorisation explicite requise avant de contourner le filtrage DCL.
AUTHORITY-CHECK OBJECT 'Z_CDS_PRIV'
  ID 'ACTVT' FIELD gc_activity_display
  ID 'ZBUKRS' FIELD p_bukrs.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_security) WITH p_bukrs.
ENDIF.

SELECT FROM zi_sales_order WITH PRIVILEGED ACCESS
  FIELDS SalesOrder,
         CompanyCode,
         CreatedByUser
  WHERE CompanyCode = @p_bukrs
  INTO TABLE @DATA(lt_privileged_orders).
```

Le `WHERE` reste obligatoire pour limiter le périmètre fonctionnel. Le contournement de la DCL ne justifie ni `SELECT *` ni une lecture non bornée.

## PROCESS

### ÉTAPE 1 — IDENTIFIER L’ENTITÉ ET SON CONTRÔLE D’ACCÈS

Relever le nom de l’entité CDS directement utilisée par le programme, son annotation `@AccessControl.authorizationCheck` et la DCL active qui la protège. Vérifier les champs et autorisations PFCG référencés par cette DCL.

Le contrôle d’accès d’une entité sous-jacente n’est pas automatiquement hérité par toutes les entités CDS consommatrices. Examiner l’entité réellement présente dans le `FROM`.

### ÉTAPE 2 — EXÉCUTER D’ABORD UNE LECTURE NORMALE

Créer le `SELECT` sans addition privilégiée, avec une liste de champs explicite et un `WHERE` métier. Tester avec un utilisateur représentatif puis conserver les critères et le nombre de lignes visibles.

Si le résultat est incorrect, vérifier d’abord la DCL, les valeurs PFCG, le mandant et les paramètres de sélection. Ne pas utiliser l’accès privilégié comme correction d’un rôle incomplet.

### ÉTAPE 3 — FORMALISER LA JUSTIFICATION DU CONTOURNEMENT

Décrire pourquoi le traitement doit lire des lignes que l’utilisateur courant ne voit pas normalement : traitement technique central, contrôle transversal ou service explicitement administré.

Faire valider le périmètre, l’utilisateur d’exécution, les données exposées et le contrôle compensatoire selon le processus de sécurité du projet.

### ÉTAPE 4 — IMPLÉMENTER L’AUTORISATION EXPLICITE

Exécuter un `AUTHORITY-CHECK` adapté avant le `SELECT`. Tester immédiatement `SY-SUBRC` et interrompre le traitement en cas de refus.

L’objet, l’activité et les dimensions organisationnelles doivent correspondre au besoin validé. L’autorisation de lancer le programme ou la transaction ne suffit pas à autoriser une lecture privilégiée.

### ÉTAPE 5 — AJOUTER WITH PRIVILEGED ACCESS SUR LA SOURCE CDS

Placer l’addition immédiatement après l’entité concernée dans le `FROM`. Effectuer un contrôle syntaxique sur la version S/4HANA cible avant activation, car la disponibilité exacte dépend de la version ABAP Platform.

Ne pas appliquer l’addition à une source qui n’est pas protégée par une DCL sans motif documenté.

### ÉTAPE 6 — BORNER LA LECTURE

Sélectionner uniquement les colonnes nécessaires et conserver des conditions `WHERE` restrictives. Pour un traitement de masse, définir une stratégie de pagination, de journalisation et de limitation du volume.

Éviter d’exposer directement la table résultante dans un export, un spool, un fichier ou une réponse RFC sans contrôle supplémentaire du destinataire.

### ÉTAPE 7 — TESTER LES QUATRE SCÉNARIOS

Exécuter au minimum :

1. lecture normale avec un utilisateur autorisé sur une partie des données ;
2. lecture normale avec un utilisateur ne voyant aucune ligne ;
3. lecture privilégiée refusée par le contrôle explicite ;
4. lecture privilégiée autorisée, limitée au périmètre métier du `WHERE`.

Comparer les clés retournées, pas seulement le nombre de lignes.

### ÉTAPE 8 — CONTRÔLER ET DOCUMENTER L’USAGE

Exécuter les variantes ATC ou SCI de sécurité disponibles, rechercher les autres usages de `WITH PRIVILEGED ACCESS` dans le package et soumettre le code à une revue sécurité.

Documenter dans le chapitre technique ou le code la justification, l’objet d’autorisation compensatoire et le propriétaire fonctionnel du traitement.

## CONTRÔLE

- Sans `WITH PRIVILEGED ACCESS`, le résultat respecte la DCL de l’entité directement lue.
- Avec l’addition, la lecture ne s’exécute qu’après le contrôle applicatif explicite.
- Les colonnes et lignes restent limitées au besoin validé.
- Un utilisateur non autorisé n’atteint jamais le `SELECT` privilégié.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Des lignes attendues sont absentes | DCL ou rôle PFCG restrictif | Diagnostiquer la DCL et le rôle avant tout contournement |
| Toutes les lignes deviennent visibles | `WITH PRIVILEGED ACCESS` ajouté sans filtre suffisant | Retirer l’addition ou ajouter contrôle explicite et périmètre métier |
| Le contrôle semble inactif sur une vue supérieure | Absence d’héritage automatique de la DCL sous-jacente | Vérifier la DCL de l’entité directement consommée |
| Le code ne compile pas | Addition indisponible ou position syntaxique incorrecte sur la version cible | Consulter la documentation ABAP du système et contrôler la syntaxe |
| `S_TCODE` est considéré comme suffisant | Démarrage confondu avec accès aux données | Ajouter un objet d’autorisation adapté au traitement privilégié |
| Résultat exporté sans restriction | Contrôle du lecteur final absent | Autoriser et filtrer avant fichier, spool, RFC ou e-mail |

## COMPATIBILITÉ S/4HANA

- Statut : mécanisme ABAP SQL disponible selon la version ABAP Platform du système S/4HANA.
- Vérifier la syntaxe dans le système cible avant de recopier l’exemple.
- La création et la maintenance des CDS et DCL dans ADT appartiennent au futur dossier CDS ; ce chapitre couvre leur consommation depuis du code ABAP classique.

## RÉFÉRENCES OFFICIELLES SAP

- [Access Control — SAP SE, SAP S/4HANA 2025 FPS01, février 2026](https://help.sap.com/docs/ABAP_PLATFORM_NEW/67e4075c942e43d4a9f6f891a8dafcf4/85cb9cf7c3eb442b82451a8294747785.html)
- [Accessing CDS Objects — SAP SE, ABAP Development Tools, version cross-product](https://help.sap.com/docs/abap-cloud/abap-development-tools-user-guide/accessing-cds-objects)
- [Access Controls — SAP SE, ABAP Development Tools, SAP S/4HANA 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/7072ee4d6bf41014b5040bee4e204223.html)
