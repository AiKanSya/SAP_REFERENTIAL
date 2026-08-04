# 22. API BAL CLASSIQUE, API OBJET ET CODE HISTORIQUE

## 22.A RÉSULTAT ATTENDU

- Distinguer les familles d’API
- Choisir selon la version et le contexte du système
- Reconnaître le code historique

## 22.B API CLASSIQUE BAL

Les modules fonction `BAL_*` sont largement disponibles dans les systèmes ABAP classiques :

- `BAL_LOG_CREATE` ;
- `BAL_LOG_MSG_ADD` ;
- `BAL_LOG_EXCEPTION_ADD` ;
- `BAL_DSP_LOG_DISPLAY` ;
- `BAL_DB_SAVE` ;
- `BAL_DB_SEARCH` ;
- `BAL_DB_LOAD`.

Ils constituent la base de ce dossier car ils sont accessibles et vérifiables dans `SE37` depuis SAP GUI.

## 22.C API ORIENTÉE OBJET

Les versions récentes de l’ABAP Platform proposent des classes et interfaces `CL_BALI_*` / `IF_BALI_*`. Elles encapsulent la création, les éléments du journal et la persistance.

Leur disponibilité dépend de la version du système et du modèle de développement. Vérifier dans `SE24` et dans la documentation correspondant exactement à la release.

## 22.D CODE HISTORIQUE

Les fonctions `APPL_LOG_*` appartiennent à une API plus ancienne. SAP indique que les fonctions `BAL_*`, introduites ultérieurement, sont plus flexibles.

Pour un nouveau développement classique :

1. privilégier l’API recommandée et disponible dans la version cible ;
2. encapsuler l’API pour réduire le couplage ;
3. conserver `APPL_LOG_*` uniquement lors de la maintenance d’un programme existant ;
4. ne pas mélanger plusieurs familles d’API dans le même composant sans raison.

## 22.E PROCESS

### 22.E.1 ÉTAPE 1 — IDENTIFIER LA RELEASE ET LE MODÈLE DE DÉVELOPPEMENT

Relever la version ABAP Platform, le périmètre classique SAP GUI et les API réellement disponibles. Vérifier les modules `BAL_*` dans `SE37` et les classes `CL_BALI_*` ou interfaces `IF_BALI_*` dans `SE24` sans supposer leur présence.

### 22.E.2 ÉTAPE 2 — ANALYSER LE CODE EXISTANT

Rechercher les appels `APPL_LOG_*`, `BAL_*` et `CL_BALI_*` dans le composant. Cartographier création, ajout, affichage, sauvegarde et nettoyage. Ne pas remplacer une API historique avant d’avoir compris sa LUW et son format de journal.

### 22.E.3 ÉTAPE 3 — CHOISIR UNE FAMILLE UNIQUE PAR ADAPTATEUR

Pour un développement classique compatible avec le système cible, retenir l’API supportée qui couvre création, messages, exceptions et persistance. Ne pas mélanger plusieurs familles à l’intérieur d’un même cycle de log sans besoin prouvé.

### 22.E.4 ÉTAPE 4 — CRÉER UNE INTERFACE Z DE JOURNALISATION

Définir des méthodes métier telles que démarrer, ajouter un message, ajouter une exception, sauvegarder et obtenir l’identifiant. Cacher handles et structures BAL derrière l’implémentation. L’appelant décide encore de poursuivre, rollback ou statut métier.

### 22.E.5 ÉTAPE 5 — IMPLÉMENTER ET TESTER L’ADAPTATEUR

Brancher l’API choisie et contrôler toutes ses erreurs. Utiliser une implémentation factice pour les tests du code métier. Tester succès, erreur d’objet `SLG0`, log plein, échec de sauvegarde et plusieurs journaux concurrents.

### 22.E.6 ÉTAPE 6 — MIGRER PROGRESSIVEMENT LE CODE HISTORIQUE

Remplacer les appels directs derrière l’interface Z par scénario, sans changer simultanément le comportement transactionnel. Comparer le contenu `SLG1`, les identifiants, les autorisations et la rétention avant de retirer l’ancienne API.

## 22.F VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 22.G ERREURS FRÉQUENTES

- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 22.H FICHE DE CONTRÔLE À COPIER

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

## 22.I TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 22.J RÉFÉRENCES OFFICIELLES SAP

- [Create Application Log — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/1090027b6c5310149844b23fcc030a11/2afa0216493111d182b70000e829fbfe.html)
- [Create a New Application Log — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/f7c20f7b2fce4fbaba79ae0c5182d869.html)
- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)

---

[Chapitre suivant — PROGRAMMES DE DÉMONSTRATION, TESTS ET DIAGNOSTIC](<./23 ├── PROGRAMMES DE DEMONSTRATION TESTS ET DIAGNOSTIC.md>)
