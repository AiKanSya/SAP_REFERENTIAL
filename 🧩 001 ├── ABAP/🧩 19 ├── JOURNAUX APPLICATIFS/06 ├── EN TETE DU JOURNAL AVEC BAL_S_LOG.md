# 6. EN-TÊTE DU JOURNAL AVEC BAL_S_LOG

## 6.A RÉSULTAT ATTENDU

- Renseigner les données utiles de l’en-tête
- Définir l’identifiant externe et la rétention
- Éviter les champs redondants ou sensibles

## 6.B STRUCTURE PRINCIPALE

L’en-tête transmis à `BAL_LOG_CREATE` utilise la structure `BAL_S_LOG`.

```abap
DATA ls_log TYPE bal_s_log.

ls_log-object    = 'ZDEV_LOG'.
ls_log-subobject = 'IMPORT'.
ls_log-extnumber = |PRODUCTS_{ sy-datum }_{ sy-uzeit }|.
ls_log-alprog     = sy-repid.
ls_log-date_del   = sy-datum + 90.
ls_log-del_before = abap_true.
```

Les noms exacts des champs disponibles doivent être contrôlés dans `SE11`[^outil-se11] sur la version du système. Les champs essentiels restent l’objet, le sous-objet et l’identifiant externe.

## 6.C DATE D’EXPIRATION

Le journal peut posséder :

- une date après laquelle il devient supprimable ;
- un indicateur interdisant sa suppression avant cette date.

Cette information ne supprime pas automatiquement le journal. Elle alimente la stratégie de nettoyage exécutée avec `SLG2`[^outil-slg2], les programmes de suppression ou l’archivage.

## 6.D STATUT ET CONTEXTE

L’en-tête peut aussi porter :

- un statut informatif ;
- un contexte applicatif ;
- des paramètres de détail ;
- le programme appelant.

Ne pas dupliquer dans l’en-tête toutes les informations déjà présentes dans les messages. L’en-tête doit permettre d’identifier l’exécution, pas reproduire son contenu complet.

## 6.E PROCESS

### 6.E.1 ÉTAPE 1 — VALIDER OBJET ET SOUS-OBJET

Vérifier dans `SLG0`[^outil-slg0] la combinaison à utiliser. Centraliser ces valeurs dans des constantes. Ne pas construire dynamiquement un sous-objet à partir d’une donnée métier non configurée.

### 6.E.2 ÉTAPE 2 — CRÉER LA STRUCTURE D’EN-TÊTE

Déclarer une structure `BAL_S_LOG` et l’initialiser pour chaque nouvelle exécution. Ne pas réutiliser un en-tête conservant l’identifiant ou l’expiration d’un traitement précédent.

### 6.E.3 ÉTAPE 3 — RENSEIGNER LES CHAMPS DE RECHERCHE

Affecter `OBJECT`, `SUBOBJECT`, `EXTNUMBER` et `ALPROG` avec des valeurs stables. Utiliser `sy-repid` uniquement si le programme courant représente réellement le point d’entrée opérationnel. Construire `EXTNUMBER` sans donnée sensible.

### 6.E.4 ÉTAPE 4 — DÉFINIR LE CYCLE DE VIE

Renseigner la date d’expiration ou les autres attributs uniquement selon la politique de rétention du domaine. Éviter une valeur arbitraire différente des règles d’exploitation et de conformité.

### 6.E.5 ÉTAPE 5 — CRÉER LE LOG ET CONTRÔLER LE RETOUR

Passer l’en-tête à `BAL_LOG_CREATE`, récupérer `BALLOGHNDL` et traiter `LOG_HEADER_INCONSISTENT`. Interrompre ou basculer vers un mécanisme de secours explicite si aucun handle valide n’est obtenu.

### 6.E.6 ÉTAPE 6 — VÉRIFIER L’EN-TÊTE PERSISTÉ

Ajouter un message, sauvegarder le handle puis rechercher le journal dans `SLG1`[^outil-slg1]. Comparer objet, sous-objet, identifiant externe, programme, utilisateur et expiration au contrat défini.

## 6.F VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package[^terme-package] attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## 6.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 6.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA ls_log TYPE bal_s_log.

ls_log-object    = 'ZDEV_LOG'.
ls_log-subobject = 'IMPORT'.
ls_log-extnumber = |PRODUCTS_{ sy-datum }_{ sy-uzeit }|.
ls_log-alprog     = sy-repid.
ls_log-date_del   = sy-datum + 90.
ls_log-del_before = abap_true.
```

## 6.I TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 6.J RÉFÉRENCES OFFICIELLES SAP

- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)
- [Set Header Information — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/b962eb9ce95048eea479e6e7b38fb481.html)

---

[Chapitre suivant — CRÉER UN JOURNAL AVEC BAL_LOG_CREATE](<./07 ├── CREER UN JOURNAL AVEC BAL_LOG_CREATE.md>)

[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-se11]: **SE11.** Transaction de l’ABAP Dictionary utilisée pour analyser et maintenir les objets DDIC. Voir [le chapitre associé](<../🧩 07 ├── DICTIONNAIRE ABAP/02 ├── NAVIGATION ET ANALYSE AVEC SE11.md>).
[^outil-slg2]: **SLG2.** Transaction de suppression planifiée ou contrôlée des journaux applicatifs persistés. Voir [le chapitre associé](<20 ├── RETENTION SUPPRESSION ET ARCHIVAGE.md>).
[^outil-slg0]: **SLG0.** Transaction de définition des objets et sous-objets de journal applicatif. Voir [le chapitre associé](<04 ├── CREER UN OBJET AVEC SLG0.md>).
[^outil-slg1]: **SLG1.** Transaction de recherche et d’affichage des journaux applicatifs persistés. Voir [le chapitre associé](<05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>).
