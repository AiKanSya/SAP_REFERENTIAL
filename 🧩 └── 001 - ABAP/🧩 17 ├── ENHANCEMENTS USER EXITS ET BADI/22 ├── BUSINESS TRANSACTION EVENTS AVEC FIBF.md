# BUSINESS TRANSACTION EVENTS AVEC `FIBF`

## RÉSULTAT ATTENDU

- Comprendre le principe des Business Transaction Events
- Identifier processus, interface et produit
- Implémenter un module fonction sans modifier l’application

## PRINCIPE

Un BTE est un événement métier auquel une application permet de rattacher un module fonction client. Cette technologie est notamment rencontrée dans les domaines financiers.

```mermaid
flowchart LR
    A["Événement métier SAP"] --> B["Interface BTE"]
    B --> C["Produit client actif"]
    C --> D["Module fonction client"]
```

SAP fournit généralement un module exemple décrivant l’interface. Le module client doit reprendre exactement cette interface.

## DÉMARCHE

1. Ouvrir `FIBF`.
2. Rechercher le processus ou l’événement approprié.
3. Analyser le module exemple fourni par SAP.
4. Copier l’interface vers un module fonction client.
5. Implémenter la logique en déléguant à une classe.
6. Créer et activer le produit client.
7. Affecter le module au processus selon le Customizing prévu.
8. Tester le scénario complet et le contexte transactionnel.

## PRÉCAUTIONS

- distinguer événements de publication et processus avec valeur de retour ;
- respecter l’interface du module exemple ;
- ne pas exécuter de commit ;
- vérifier si plusieurs produits peuvent être actifs ;
- contrôler le mandant et le transport du Customizing ;
- documenter l’ordre d’exécution observé.

## PROCESS

### ÉTAPE 1 — IDENTIFIER L’ÉVÉNEMENT BTE

Dans `FIBF`, utiliser l’environnement d’information pour rechercher l’événement correspondant au processus FI. Lire sa documentation et relever s’il s’agit d’un événement de type publication ou processus, ainsi que le module exemple fourni.

### ÉTAPE 2 — ANALYSER L’INTERFACE D’EXEMPLE

Ouvrir le module exemple dans `SE37`. Relever les paramètres, tables, exceptions et commentaires. Utiliser la liste d’utilisation ou un breakpoint pour confirmer que l’événement est déclenché dans le scénario S/4HANA concerné.

### ÉTAPE 3 — CRÉER LE MODULE CLIENT

Copier l’interface vers un module fonction Z dans un groupe client, sans modifier la signature attendue. Implémenter une adaptation légère puis déléguer à une classe Z. Ne pas exécuter de commit si l’événement appartient à la LUW standard.

### ÉTAPE 4 — DÉFINIR ET ACTIVER LE PRODUIT

Dans les vues de paramétrage FIBF prévues, créer ou réutiliser un produit client Z avec une description et un statut maîtrisés. Affecter l’événement au module Z pour le périmètre requis. Enregistrer le paramétrage dans la demande appropriée.

### ÉTAPE 5 — CONFIRMER L’APPEL AU RUNTIME

Activer le module et le produit, poser un breakpoint dans le module Z puis reproduire le document FI. Relever l’événement, les paramètres, le nombre d’appels et le moment par rapport à la validation du document.

### ÉTAPE 6 — TESTER LE PÉRIMÈTRE ET LE TRANSPORT

Tester le cas cible, une société ou opération hors périmètre, une erreur contrôlée et l’annulation de la transaction. Vérifier le transport du module, de la classe et du paramétrage produit. Refaire le test dans le système cible avec le produit actif.

## VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

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

- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## RÉFÉRENCES OFFICIELLES SAP

- [BTE - Business Transaction Event — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525100.html)
- [Events, Business Transaction Events — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/e200555127f24878bed8d1481c9d5a0b/9601c5536a51204be10000000a174cb4.html)
- [Defining a Business Transaction Event — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/c30311a28bc24fe08bd47eafbf3fd930/59cc7fd2927f477bb965c77b3b71060f.html)

---

[Chapitre suivant — TRANSPORT, DEBUG, UPGRADE ET BONNES PRATIQUES](<./23 └── TRANSPORT DEBUG UPGRADE ET BONNES PRATIQUES.md>)
