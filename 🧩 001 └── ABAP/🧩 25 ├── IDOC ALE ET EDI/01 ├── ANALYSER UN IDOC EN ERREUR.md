# 1. ANALYSER UN IDOC EN ERREUR

## 1.A RÉSULTAT ATTENDU

Identifier la cause exacte d’un IDoc[^terme-idoc] entrant ou sortant en erreur, corriger la cause puis retraiter sans créer de doublon métier.

## 1.B PRÉREQUIS

- Numéro de l’IDoc ou intervalle précis de création.
- Sens du flux : entrant ou sortant.
- Message type, partenaire et système émetteur/récepteur attendus.
- Autorisations d’affichage `WE02`[^outil-we02], de configuration `WE20`[^outil-we20]/`WE21`[^outil-we21] et, si nécessaire, de retraitement `BD87`[^outil-bd87].

## 1.C DONNÉES À RELEVER DANS WE02

| Zone | Valeur à relever | Utilité |
|---|---|---|
| Control record | Direction `1` ou `2` | Distinguer outbound et inbound |
| Basic type | Type IDoc | Valider la structure attendue |
| Extension | Extension client | Vérifier les segments supplémentaires |
| Message type | Message métier | Retrouver la configuration |
| Sender/receiver | Type, numéro, rôle, port | Contrôler les partenaires |
| Current status | Code et texte long | Localiser l’étape en défaut |
| Segments | Segment, occurrence, valeur | Identifier la donnée fautive |

## 1.D PROCESS

### 1.D.1 ÉTAPE 1 — OUVRIR L’IDOC ET FIGER LE CONTEXTE

Rechercher l’IDoc dans `WE02` ou `WE05`[^outil-we05] avec son numéro ou un intervalle précis. Relever le sens, le message type, le basic type, l’extension, les partenaires, la date, l’heure et le statut courant.

### 1.D.2 ÉTAPE 2 — LIRE LE PREMIER STATUT QUI EXPLIQUE L’ÉCHEC

Ouvrir les statuts dans leur ordre chronologique et lire le texte long du premier défaut pertinent. Déterminer si l’erreur apparaît avant la transmission, pendant la syntaxe IDoc ou après l’entrée dans l’application métier.

### 1.D.3 ÉTAPE 3 — CONTRÔLER LE CONTROL RECORD ET LES SEGMENTS

Comparer les valeurs du control record à l’interface attendue. Examiner ensuite le segment signalé, sa hiérarchie, son occurrence et ses champs sans modifier directement `EDIDC`, `EDID4` ou `EDIDS`.

### 1.D.4 ÉTAPE 4 — VÉRIFIER LA CONFIGURATION DU FLUX

Pour un outbound, contrôler dans `WE20` le profil partenaire et dans `WE21` le port ; vérifier aussi le process code et le modèle de distribution si ALE est utilisé. Pour un inbound, relever le process code, son mode de traitement et le module fonction[^terme-module-fonction] ou workflow associé.

### 1.D.5 ÉTAPE 5 — CLASSER ET CORRIGER LA CAUSE

Corriger à la source la donnée métier, le Customizing[^terme-customizing], le partenaire, le port ou le code responsable. Ne pas retraiter tant que la même cause produit encore le même statut.

### 1.D.6 ÉTAPE 6 — RECHERCHER UN EFFET MÉTIER EXISTANT

Avant toute répétition, rechercher le document créé, les relations IDoc-document et les écritures partielles. Cette vérification détermine si le retraitement est sûr ou risque de créer un doublon.

### 1.D.7 ÉTAPE 7 — RETRAITER DE MANIÈRE CIBLÉE

Utiliser `BD87` uniquement pour les IDocs dont le statut et le processus autorisent le retraitement. Limiter la sélection au numéro contrôlé et conserver le journal de l’opération.

### 1.D.8 ÉTAPE 8 — VALIDER LE RÉSULTAT FINAL

Rouvrir l’IDoc, vérifier le nouveau statut, le document métier attendu et l’absence de doublon. Rechercher d’autres IDocs bloqués par la même cause avant de clôturer l’incident.

## 1.E CLASSER LE STATUT

Les codes exacts doivent être interprétés avec leur texte et la documentation du système. La séparation opérationnelle reste :

- erreur de génération ou de détermination du partenaire ;
- erreur de transmission ou de port ;
- IDoc reçu mais non encore traité ;
- erreur de syntaxe ou de structure IDoc ;
- erreur applicative pendant la création du document ;
- traitement terminé avec succès.

## 1.F CONTRÔLE POSITIF

- Le statut final correspond à un traitement réussi pour le sens du flux.
- Le document applicatif attendu existe une seule fois.
- La relation entre IDoc et document métier est consultable.
- Aucun IDoc parallèle du même message reste en erreur pour la même cause.

## 1.G ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Aucun partenaire trouvé | Profil `WE20` absent ou clé différente | Comparer type, numéro, rôle et message du control record |
| Segment inconnu | Basic type ou extension incohérent | Vérifier `WE30`[^outil-we30], `WE31`[^outil-we31] et `WE82`[^outil-we82] |
| Erreur applicative | Donnée obligatoire absente ou Customizing incomplet | Lire le texte long et corriger la source |
| Même erreur après `BD87` | Cause non corrigée | Ne pas multiplier les retraitements |
| Doublon métier | Document créé avant l’erreur de statut | Rechercher le document avant retraitement |
| IDoc modifié directement | Intervention dans `EDIDC`, `EDID4` ou `EDIDS` | Utiliser les outils IDoc et corriger la source |

## 1.H COMPATIBILITÉ S/4HANA

Statut : compatible. Vérifier que le message et le basic type restent ceux officiellement prévus par l’application S/4HANA concernée.

## 1.I RÉFÉRENCES OFFICIELLES SAP

- [ALE Distribution — Transactions — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/erpscm/3362167812.html)

[^terme-idoc]: **IDOC.** Document intermédiaire SAP structuré en segments pour l’échange de messages métier. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#idoc>).
[^terme-module-fonction]: **MODULE FONCTION.** Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>).
[^terme-customizing]: **CUSTOMIZING.** Paramétrage permettant d’adapter le comportement standard SAP à l’organisation. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/09 ├── NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES.md#customizing>).

[^outil-we02]: **WE02.** Transaction de recherche et d’affichage des IDoc et de leurs statuts. Voir [le chapitre associé](<01 ├── ANALYSER UN IDOC EN ERREUR.md>).
[^outil-we20]: **WE20.** Transaction de maintenance des profils partenaires utilisés par les échanges IDoc. Voir [le chapitre associé](<01 ├── ANALYSER UN IDOC EN ERREUR.md>).
[^outil-we21]: **WE21.** Transaction de maintenance des ports utilisés par les IDoc. Voir [le chapitre associé](<01 ├── ANALYSER UN IDOC EN ERREUR.md>).
[^outil-bd87]: **BD87.** Transaction de sélection et de retraitement contrôlé des IDoc selon leur statut. Voir [le chapitre associé](<01 ├── ANALYSER UN IDOC EN ERREUR.md>).
[^outil-we05]: **WE05.** Transaction de liste et d’analyse des IDoc, proche de WE02. Voir [le chapitre associé](<01 ├── ANALYSER UN IDOC EN ERREUR.md>).
[^outil-we30]: **WE30.** Transaction de maintenance des types de base et extensions IDoc. Voir [le chapitre associé](<01 ├── ANALYSER UN IDOC EN ERREUR.md>).
[^outil-we31]: **WE31.** Transaction de maintenance des types de segments IDoc. Voir [le chapitre associé](<01 ├── ANALYSER UN IDOC EN ERREUR.md>).
[^outil-we82]: **WE82.** Transaction d’affectation entre types de messages et types de base IDoc. Voir [le chapitre associé](<01 ├── ANALYSER UN IDOC EN ERREUR.md>).
