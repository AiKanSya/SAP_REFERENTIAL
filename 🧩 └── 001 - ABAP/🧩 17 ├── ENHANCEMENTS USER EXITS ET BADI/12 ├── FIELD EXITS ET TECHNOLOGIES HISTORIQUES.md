# FIELD EXITS ET TECHNOLOGIES HISTORIQUES

## RÉSULTAT ATTENDU

- Reconnaître un field exit dans une application existante
- Comprendre ses limites
- Éviter son utilisation comme choix par défaut

## FIELD EXIT

Un field exit est une ancienne technologie liée à un champ de saisie d’écran, généralement par l’intermédiaire de son élément de données. Il permet d’exécuter une logique de contrôle ou de transformation lors de la saisie.

## LIMITES

- technologie historique ;
- effet potentiellement global sur tous les écrans utilisant l’élément de données ;
- contexte applicatif limité ;
- dépendance à l’activation système ;
- diagnostic difficile lorsqu’un même champ est utilisé dans plusieurs transactions ;
- alternatives plus explicites souvent disponibles : BAdI, validation applicative, screen exit ou enhancement framework.

## MAINTENANCE

Lorsqu’un field exit existe :

1. identifier le module fonction associé ;
2. rechercher tous les écrans concernés ;
3. vérifier les conditions limitant son exécution ;
4. analyser les effets lors des traitements batch ou interfaces ;
5. documenter sa stratégie de remplacement éventuelle.

## AUTRES TECHNOLOGIES HISTORIQUES

Les modifications directes, routines client spécifiques à une application et exits non documentés doivent être analysés comme du patrimoine à maintenir, pas comme des modèles de nouveau développement.

## PROCESS

### ÉTAPE 1 — CONFIRMER QU’UN FIELD EXIT EXISTE

Relever le champ écran et son élément de données dans les informations techniques. Rechercher le module de field exit associé et son activation dans le système. Distinguer un contrôle de domaine, une aide de recherche et un field exit réel.

### ÉTAPE 2 — MESURER LE PÉRIMÈTRE GLOBAL

Rechercher toutes les utilisations de l’élément de données et les écrans susceptibles de déclencher le contrôle. Un field exit peut affecter plusieurs transactions sans lien fonctionnel direct. Lister ces consommateurs avant toute modification.

### ÉTAPE 3 — REPRODUIRE L’APPEL

Placer un breakpoint dans le module existant et tester le scénario cible puis un autre écran utilisant le même élément. Relever la valeur d’entrée, la valeur retournée, les messages et la pile. Vérifier si un suffixe ou une affectation spécifique limite le périmètre.

### ÉTAPE 4 — ÉVALUER UNE ALTERNATIVE PLUS LOCALE

Rechercher une BAdI, un customer exit, un contrôle PAI ou une validation applicative limitée au processus. Pour un nouveau besoin, retenir le mécanisme offrant le contrat et le périmètre les plus explicites. Ne prolonger la technologie historique que si la compatibilité l’impose.

### ÉTAPE 5 — MODIFIER AVEC TESTS DE NON-RÉGRESSION

Si la maintenance du field exit est obligatoire, isoler la nouvelle règle derrière des conditions précises et préserver les comportements existants. Tester toutes les transactions recensées, pas seulement celle ayant déclenché la demande.

### ÉTAPE 6 — DOCUMENTER ACTIVATION ET RETRAIT

Conserver le module, l’élément de données, le périmètre, le paramétrage d’activation et les résultats de test. Définir comment désactiver ou remplacer le mécanisme lors d’une future migration sans laisser de validation en double.

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

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## RÉFÉRENCES OFFICIELLES SAP

- [Field Exits — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525738.html)
- [Enhancement Technologies — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/7063da4023a28631e10000000a1550b0.html)
- [Enhancement Framework — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/e322becd165844e5868e590bc8efafaf/949cdc40132a8531e10000000a1550b0.html)

---

[Chapitre suivant — PRINCIPES DES BAdI](<./13 ├── PRINCIPES DES BADI.md>)
