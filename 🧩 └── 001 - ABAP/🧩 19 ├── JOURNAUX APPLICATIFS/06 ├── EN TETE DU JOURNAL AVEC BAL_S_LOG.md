# EN-TÊTE DU JOURNAL AVEC BAL_S_LOG

## RÉSULTAT ATTENDU

- Renseigner les données utiles de l’en-tête
- Définir l’identifiant externe et la rétention
- Éviter les champs redondants ou sensibles

## STRUCTURE PRINCIPALE

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

Les noms exacts des champs disponibles doivent être contrôlés dans `SE11` sur la version du système. Les champs essentiels restent l’objet, le sous-objet et l’identifiant externe.

## DATE D’EXPIRATION

Le journal peut posséder :

- une date après laquelle il devient supprimable ;
- un indicateur interdisant sa suppression avant cette date.

Cette information ne supprime pas automatiquement le journal. Elle alimente la stratégie de nettoyage exécutée avec `SLG2`, les programmes de suppression ou l’archivage.

## STATUT ET CONTEXTE

L’en-tête peut aussi porter :

- un statut informatif ;
- un contexte applicatif ;
- des paramètres de détail ;
- le programme appelant.

Ne pas dupliquer dans l’en-tête toutes les informations déjà présentes dans les messages. L’en-tête doit permettre d’identifier l’exécution, pas reproduire son contenu complet.

## PROCESS

### ÉTAPE 1 — VALIDER OBJET ET SOUS-OBJET

Vérifier dans `SLG0` la combinaison à utiliser. Centraliser ces valeurs dans des constantes. Ne pas construire dynamiquement un sous-objet à partir d’une donnée métier non configurée.

### ÉTAPE 2 — CRÉER LA STRUCTURE D’EN-TÊTE

Déclarer une structure `BAL_S_LOG` et l’initialiser pour chaque nouvelle exécution. Ne pas réutiliser un en-tête conservant l’identifiant ou l’expiration d’un traitement précédent.

### ÉTAPE 3 — RENSEIGNER LES CHAMPS DE RECHERCHE

Affecter `OBJECT`, `SUBOBJECT`, `EXTNUMBER` et `ALPROG` avec des valeurs stables. Utiliser `sy-repid` uniquement si le programme courant représente réellement le point d’entrée opérationnel. Construire `EXTNUMBER` sans donnée sensible.

### ÉTAPE 4 — DÉFINIR LE CYCLE DE VIE

Renseigner la date d’expiration ou les autres attributs uniquement selon la politique de rétention du domaine. Éviter une valeur arbitraire différente des règles d’exploitation et de conformité.

### ÉTAPE 5 — CRÉER LE LOG ET CONTRÔLER LE RETOUR

Passer l’en-tête à `BAL_LOG_CREATE`, récupérer `BALLOGHNDL` et traiter `LOG_HEADER_INCONSISTENT`. Interrompre ou basculer vers un mécanisme de secours explicite si aucun handle valide n’est obtenu.

### ÉTAPE 6 — VÉRIFIER L’EN-TÊTE PERSISTÉ

Ajouter un message, sauvegarder le handle puis rechercher le journal dans `SLG1`. Comparer objet, sous-objet, identifiant externe, programme, utilisateur et expiration au contrat défini.

## VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA ls_log TYPE bal_s_log.

ls_log-object    = 'ZDEV_LOG'.
ls_log-subobject = 'IMPORT'.
ls_log-extnumber = |PRODUCTS_{ sy-datum }_{ sy-uzeit }|.
ls_log-alprog     = sy-repid.
ls_log-date_del   = sy-datum + 90.
ls_log-del_before = abap_true.
```

## TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## RÉFÉRENCES OFFICIELLES SAP

- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)
- [Set Header Information — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/b962eb9ce95048eea479e6e7b38fb481.html)

---

[Chapitre suivant — CRÉER UN JOURNAL AVEC BAL_LOG_CREATE](<./07 ├── CREER UN JOURNAL AVEC BAL_LOG_CREATE.md>)
