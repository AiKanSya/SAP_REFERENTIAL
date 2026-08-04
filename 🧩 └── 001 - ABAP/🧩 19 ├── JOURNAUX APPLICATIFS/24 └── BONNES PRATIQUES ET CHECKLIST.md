# 24. BONNES PRATIQUES ET CHECKLIST

## 24.A RÉSULTAT ATTENDU

- Standardiser l’implémentation
- Produire des journaux exploitables
- Limiter la volumétrie et les risques de sécurité

## 24.B CHECKLIST DE CONCEPTION

- [ ] L’objet et le sous-objet existent dans `SLG0`.
- [ ] Leur découpage correspond aux autorisations attendues.
- [ ] L’identifiant externe permet de retrouver l’exécution.
- [ ] Une classe de messages `SE91` contient les messages stables.
- [ ] Les messages indiquent l’action, l’objet concerné et la cause.
- [ ] Le traitement produit un résumé final.
- [ ] Le volume maximal de messages est maîtrisé.
- [ ] La date d’expiration est définie selon la politique de rétention.
- [ ] Aucune donnée sensible inutile n’est journalisée.
- [ ] Tous les `sy-subrc` critiques sont contrôlés.
- [ ] La stratégie de sauvegarde respecte la SAP LUW.
- [ ] Le programme batch écrit la référence `SLG1` dans son journal de job.
- [ ] Les rôles `S_APPL_LOG` ont été testés.
- [ ] Une procédure `SLG2` ou d’archivage est prévue.

## 24.C PRINCIPES DE QUALITÉ

| Principe       | Application                                                             |
| -------------- | ----------------------------------------------------------------------- |
| Corrélation    | Identifiant externe partagé avec le document, fichier ou message source |
| Synthèse       | Résultat global lisible sans parcourir tous les détails                 |
| Actionnabilité | Le message indique quoi vérifier ou corriger                            |
| Stabilité      | Objets et numéros de messages pérennes                                  |
| Sobriété       | Pas de succès unitaire inutile en masse                                 |
| Sécurité       | Masquage des données sensibles                                          |
| Exploitabilité | Recherche rapide dans `SLG1`                                            |
| Maintenance    | Encapsulation dans une classe dédiée                                    |

## 24.D ARCHITECTURE RECOMMANDÉE

```mermaid
flowchart LR
    A["Programme métier"] --> B["Classe de journalisation"]
    B --> C["API BAL"]
    C --> D["SLG1"]
    B --> E["Résumé métier"]
```

La classe de journalisation doit rester un adaptateur. Elle ne doit pas décider seule du rollback, de la poursuite ou du statut métier du traitement.

## 24.E PROCESS

### 24.E.1 ÉTAPE 1 — VALIDER LA CONFIGURATION ET LA NOMENCLATURE

Contrôler objet et sous-objets dans `SLG0`, descriptions, package, transports et séparation des autorisations. Vérifier que l’identifiant externe relie le log au document, fichier, job ou message d’origine.

### 24.E.2 ÉTAPE 2 — CONTRÔLER L’ADAPTATEUR DE JOURNALISATION

Vérifier que le code métier passe par une classe Z, que les handles restent internes et que toutes les erreurs BAL sont traitées. Confirmer que la classe de log ne décide pas du commit ou du statut métier à la place de l’orchestrateur.

### 24.E.3 ÉTAPE 3 — CONTRÔLER LA QUALITÉ DES MESSAGES

Examiner gravité, T100, variables, classe de problème, détail, tri et contexte. Chaque erreur doit indiquer l’unité, la cause et l’action possible. Supprimer les succès unitaires répétitifs et les textes génériques non actionnables.

### 24.E.4 ÉTAPE 4 — CONTRÔLER LUW, BATCH ET REPRISE

Tester sauvegarde sur succès, erreur gérée et rollback. Pour un job, vérifier le résumé dans `SM37` et la référence `SLG1`. Rejouer le même lot et confirmer l’idempotence ainsi que la création d’un log distinct corrélé.

### 24.E.5 ÉTAPE 5 — CONTRÔLER SÉCURITÉ ET VOLUMÉTRIE

Tester `S_APPL_LOG` avec des rôles représentatifs. Rechercher secrets, données personnelles et payloads dans tous les types de message. Mesurer le nombre maximal de messages, la durée de sauvegarde et la lisibilité dans `SLG1`.

### 24.E.6 ÉTAPE 6 — CONTRÔLER LE CYCLE DE VIE

Vérifier expiration, sélection `SLG2`, job de suppression ou archivage `BC_SBAL`. Tester la conservation d’un log non expiré et le retrait d’un log expiré. Documenter propriétaire, fréquence et preuve du dernier nettoyage.

## 24.F VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 24.G ERREURS FRÉQUENTES

- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 24.H FICHE DE CONTRÔLE À COPIER

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

## 24.I TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 24.J RÉFÉRENCES OFFICIELLES SAP

- [Application Log – Guidelines for Developers — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/addb96cd90c945dfb3182865363bbc47/4e21000f35d44180e10000000a15822b.html)
- [Application Log – User Guidelines — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/f63dd39a28bb4b90adbf9e608aff58ea/4e23ac220771417fe10000000a15822b.html)
- [Application Logging — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/864321b9b3dd487d94c70f6a007b0397/c769bcc9f36611d3a6510000e835363f.html)
