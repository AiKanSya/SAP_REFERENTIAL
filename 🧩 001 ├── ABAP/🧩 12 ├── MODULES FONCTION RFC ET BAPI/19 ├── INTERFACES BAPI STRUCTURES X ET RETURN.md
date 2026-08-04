# 19. INTERFACES BAPI, STRUCTURES X ET RETURN

## 19.A RÉSULTAT ATTENDU

- Lire une interface BAPI[^terme-bapi] complexe
- Comprendre les structures de données et structures `X`
- Interpréter `BAPIRET2`
- Déterminer le succès métier avant le commit

## 19.B STRUCTURES MÉTIER

Les BAPI utilisent souvent des structures DDIC[^terme-acro-ddic] dédiées. Leur nom reflète généralement l’objet et l’opération, mais seule la documentation fait foi.

Exemples de catégories :

- données d’en-tête ;
- postes ;
- partenaires ;
- textes ;
- extensions ;
- messages de retour.

## 19.C STRUCTURES X

Certaines BAPI de modification utilisent une structure parallèle dite **X**. Elle indique quels champs doivent être pris en compte.

Exemple conceptuel :

```abap
ls_data-description  = 'Nouvelle description'.
ls_datax-description = abap_true.
```

Une valeur fournie sans indicateur peut être ignorée. Un indicateur fourni avec une valeur initiale peut signifier que le champ doit être effacé. Vérifier la documentation de la BAPI.

## 19.D RETOUR BAPIRET2

Une structure `BAPIRET2` contient notamment :

| Champ                       | Rôle                                |
| --------------------------- | ----------------------------------- |
| `TYPE`                      | Gravité du message                  |
| `ID`                        | Classe[^terme-classe] de messages                  |
| `NUMBER`                    | Numéro du message                   |
| `MESSAGE`                   | Texte formaté                       |
| `MESSAGE_V1` à `V4`         | Variables du message                |
| `PARAMETER`, `ROW`, `FIELD` | Localisation éventuelle de l’erreur |

## 19.E TYPES DE MESSAGE

Les conventions courantes utilisent :

- `S` : succès ;
- `I` : information ;
- `W` : avertissement ;
- `E` : erreur ;
- `A` : abandon.

Le succès technique de `CALL FUNCTION` ne signifie pas que l’opération métier a réussi. Il faut analyser `RETURN`.

```abap
DATA(lv_has_error) = xsdbool(
  line_exists( lt_return[ type = 'E' ] ) OR
  line_exists( lt_return[ type = 'A' ] ) ).
```

Adapter cette logique au contrat précis : certaines interfaces utilisent aussi d’autres indicateurs ou des exceptions.

## 19.F EXTENSIONIN ET EXTENSIONOUT

Certaines BAPI proposent des conteneurs d’extension pour des champs clients. Leur remplissage dépend de structures prévues et de mécanismes d’extension spécifiques. Ne pas sérialiser arbitrairement des données sans respecter la documentation.

## 19.G DIAGNOSTIC

Conserver tous les messages utiles et pas uniquement le premier. Pour chaque message, enregistrer au minimum :

- type ;
- classe et numéro ;
- texte ;
- paramètre ou ligne ;
- clé métier ;
- corrélation du traitement.

## 19.H PROCESS

### 19.H.1 Étape 1 — Aligner donnée et indicateur

Ouvrir la structure métier et sa structure `X`. Pour chaque champ à modifier, renseigner la valeur dans la structure métier et l’indicateur correspondant dans la structure `X`.

### 19.H.2 Étape 2 — Distinguer initial et non modifié

Pour effacer une valeur, transmettre sa valeur initiale et positionner l’indicateur `X`. Pour conserver la valeur existante, laisser l’indicateur vide. Tester explicitement cette différence.

### 19.H.3 Étape 3 — Alimenter les clés

Renseigner les clés dans les deux structures si l’interface l’exige. Pour les tables de positions, aligner chaque ligne métier avec sa ligne d’indicateurs par la même clé.

### 19.H.4 Étape 4 — Lire toute la table RETURN

Parcourir toutes les lignes, pas seulement la première. Classer `A`, `E`, `X` comme échec et conserver identifiant, numéro, variables et texte pour le diagnostic.

### 19.H.5 Étape 5 — Vérifier l’effet

Sans erreur bloquante, exécuter le commit prévu puis relire l’objet avec une API[^terme-api] officielle. Le test est validé lorsque seuls les champs marqués changent et qu’une erreur provoque un rollback.

## 19.I VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 19.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Appeler un module fonction[^terme-module-fonction] sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

## 19.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA(lv_has_error) = xsdbool(
  line_exists( lt_return[ type = 'E' ] ) OR
  line_exists( lt_return[ type = 'A' ] ) ).
```

## 19.L TERMES DU LEXIQUE

- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [BAPI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bapi>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-rfc>)

## 19.M RÉFÉRENCES OFFICIELLES SAP

- [Describing Remote Function Calls and BAPIs — SAP Learning](https://learning.sap.com/courses/technical-implementation-and-operation-i-of-sap-s-4hana-and-sap-business-suite/describing-remote-function-calls-and-bapis)
- [Transaction Model for Developing BAPIs — SAP Help Portal](https://help.sap.com/docs/SAP_ERP/67ae2d27aed945b7bd0ad1d2185ec217/4d5b102ba1483d8fe10000000a42189e.html)
- [Purchasing BAPIs — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/spmm/3362167428.html)

---

[Chapitre suivant — APPELER UNE BAPI ET GÉRER LA TRANSACTION](<./20 ├── APPELER UNE BAPI ET GERER LA TRANSACTION.md>)

[^terme-bapi]: **BAPI.** Interface métier publiée autour d’un Business Object SAP, généralement implémentée par un module fonction RFC. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#bapi>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-module-fonction]: **MODULE FONCTION.** Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>).
