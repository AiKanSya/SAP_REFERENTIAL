# 16. TRFC, QRFC ET SURVEILLANCE

## 16.A RÉSULTAT ATTENDU

- Distinguer tRFC et qRFC
- Comprendre l’enregistrement transactionnel
- Identifier les moniteurs `SM58`, `SMQ1` et `SMQ2`
- Éviter les retraitements destructifs

## 16.B TRFC

Le transactional RFC enregistre l’unité d’appel afin qu’elle puisse être exécutée de manière fiable lorsque la cible est disponible.

```mermaid
flowchart LR
    A["Appel tRFC"] --> B["Enregistrement de la LUW RFC"]
    B --> C["Tentative d envoi"]
    C -->|"Succès"| D["Confirmation"]
    C -->|"Échec"| E["Nouvelle tentative ou analyse SM58"]
```

L’appelant ne reçoit pas un résultat métier comme dans un sRFC. Le traitement est conçu autour de l’envoi fiable.

## 16.C QRFC

Le qRFC ajoute une file et un ordre d’exécution. Il est utilisé lorsque deux unités concernant le même objet ne doivent pas être exécutées dans un ordre différent.

Exemple conceptuel :

1. création d’un objet ;
2. modification de cet objet ;
3. clôture de cet objet.

Une file commune préserve l’ordre.

## 16.D MONITEURS

| Transaction | Rôle                         |
| ----------- | ---------------------------- |
| `SM58`      | Surveillance des appels tRFC |
| `SMQ1`      | Files qRFC sortantes         |
| `SMQ2`      | Files qRFC entrantes         |

Selon le paysage, d’autres transactions et schedulers peuvent intervenir.

## 16.E ANALYSE D UNE ERREUR

Vérifier :

- destination ;
- message d’erreur ;
- date et heure ;
- utilisateur ;
- fonction appelée ;
- disponibilité de la cible ;
- blocage de file ;
- erreur applicative dans l’unité précédente ;
- cohérence d’un retraitement.

## 16.F RETRAITEMENT

Ne jamais supprimer ou relancer une unité sans comprendre :

- si le traitement a déjà été exécuté partiellement ;
- si l’opération est idempotente ;
- si l’ordre doit être conservé ;
- si une unité précédente bloque volontairement les suivantes ;
- si la suppression entraîne une perte définitive.

## 16.G LIMITE

Les garanties exactes de livraison et d’ordre dépendent du mécanisme et du scénario. Ne pas résumer tRFC ou qRFC à une promesse générale sans analyser l’implémentation de l’application.

## 16.H PROCESS

### 16.H.1 Étape 1 — Définir la garantie nécessaire

Choisir tRFC pour une exécution transactionnelle différée sans ordre entre unités indépendantes. Choisir qRFC lorsque l’ordre d’exécution dans une file constitue une exigence métier.

### 16.H.2 Étape 2 — Préparer un module compatible

Vérifier l’attribut RFC et les types d’interface. Le module distant doit être idempotent ou protéger les doublons selon le contrat, car une reprise technique peut répéter la tentative.

### 16.H.3 Étape 3 — Enregistrer l’unité

Pour tRFC, appeler `IN BACKGROUND TASK DESTINATION ...`. Pour qRFC, définir d’abord le nom de file selon l’API prévue, puis enregistrer l’appel. La LUW appelante déclenche l’envoi au commit.

### 16.H.4 Étape 4 — Surveiller

Après commit, rechercher l’unité dans `SM58` pour tRFC et dans les moniteurs qRFC entrants/sortants appropriés. Relever destination, transaction ID, file, horodatage et texte d’erreur.

### 16.H.5 Étape 5 — Corriger avant reprise

Corriger réseau, destination, autorisation ou donnée métier avant de relancer. Vérifier dans la cible qu’aucun document n’existe déjà. Le flux est validé lorsque l’unité disparaît du moniteur après succès et produit un seul effet métier.

## 16.I VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 16.J ERREURS FRÉQUENTES

- Appeler un module fonction sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

## 16.K TERMES DU LEXIQUE

- [tRFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-trfc>)
- [qRFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-qrfc>)
- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-rfc>)
- [BAPI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bapi>)

## 16.L RÉFÉRENCES OFFICIELLES SAP

- [RFC in SAP Systems — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/108f625f6c53101491e88dc4cf51a6cc/48920827feb35ed2e10000000a42189d.html)
- [Transactional RFC and Queued RFC Monitor — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/10905b976c53101487c0c95187a63f9a/8bceea3b31aac554e10000000a114084.html)
- [SMQ1 and SMQ2 — SAP Help Portal](https://help.sap.com/saphelp_snc70/helpdata/EN/76/e12041c877f623e10000000a155106/content.htm)

---

[Chapitre suivant — SÉCURITÉ ET AUTORISATIONS RFC](<./17 ├── SECURITE ET AUTORISATIONS RFC.md>)
