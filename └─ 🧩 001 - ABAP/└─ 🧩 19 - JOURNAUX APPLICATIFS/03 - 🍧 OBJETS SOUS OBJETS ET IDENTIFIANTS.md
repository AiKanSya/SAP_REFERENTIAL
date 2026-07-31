# 🌸 OBJETS, SOUS-OBJETS ET IDENTIFIANTS

## 🌺 OBJECTIFS

- Définir une nomenclature stable
- Utiliser correctement l’objet, le sous-objet et le numéro externe
- Éviter la multiplication incontrôlée des objets de journal

## 🌺 OBJET

L’objet représente un domaine fonctionnel ou une application durable, par exemple :

- `ZMM_MOBILE` pour une application logistique mobile ;
- `ZFI_IMPORT` pour des imports financiers ;
- `ZINT_CPI` pour des traitements d’intégration.

L’objet ne doit pas correspondre à un numéro de ticket, une version ou un programme temporaire.

## 🌺 SOUS-OBJET

Le sous-objet distingue des processus cohérents au sein du domaine :

| Objet        | Sous-objet  | Usage                       |
| ------------ | ----------- | --------------------------- |
| `ZMM_MOBILE` | `CREATE_PR` | Création de demande d’achat |
| `ZMM_MOBILE` | `REASSORT`  | Lecture du réassort         |
| `ZINT_CPI`   | `PRODUCTS`  | Extraction produits         |
| `ZINT_CPI`   | `ORDERS`    | Extraction commandes        |

## 🌺 NUMÉRO EXTERNE

Le champ `EXTNUMBER` doit permettre de retrouver un traitement sans connaître son numéro technique. Il peut contenir :

- un numéro de document ;
- un identifiant d’exécution ;
- un nom de fichier ;
- un identifiant de message d’interface ;
- une combinaison courte et stable.

```abap
ls_log-extnumber = |IMPORT_PRODUCTS_{ sy-datum }_{ sy-uzeit }|.
```

## 🌺 RÈGLES

- garder la même sémantique pour un objet dans tous les programmes ;
- ne pas mettre de données sensibles dans l’identifiant externe ;
- éviter les identifiants trop longs ou impossibles à rechercher ;
- documenter la convention de nommage dans le dépôt technique ;
- réutiliser un objet existant si le domaine et les autorisations sont identiques.

## 🌺 CAS D’USAGE

Dans un contexte où un traitement automatique doit produire un historique exploitable par le support avec contexte, messages et identifiants, le besoin consiste à **utiliser objets, sous-objets et identifiants pour produire un journal applicatif retrouvable et exploitable par le support**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
ls_log-extnumber = |IMPORT_PRODUCTS_{ sy-datum }_{ sy-uzeit }|.
```

## 🌺 TERMES DU LEXIQUE

- [Application Log](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-bal>)
- [Job](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **utiliser objets, sous-objets et identifiants pour produire un journal applicatif retrouvable et exploitable par le support**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)
- [Analyze Logs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21048535d44180e10000000a15822b.html)


---

➡️ [Chapitre suivant — CRÉER UN OBJET AVEC SLG0](<./04 - 🍧 CREER UN OBJET AVEC SLG0.md>)
