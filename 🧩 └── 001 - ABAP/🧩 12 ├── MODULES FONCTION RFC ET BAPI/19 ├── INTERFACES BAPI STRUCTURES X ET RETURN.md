# INTERFACES BAPI, STRUCTURES X ET RETURN

## RÉSULTAT ATTENDU

- Lire une interface BAPI complexe
- Comprendre les structures de données et structures `X`
- Interpréter `BAPIRET2`
- Déterminer le succès métier avant le commit

## STRUCTURES MÉTIER

Les BAPI utilisent souvent des structures DDIC dédiées. Leur nom reflète généralement l’objet et l’opération, mais seule la documentation fait foi.

Exemples de catégories :

- données d’en-tête ;
- postes ;
- partenaires ;
- textes ;
- extensions ;
- messages de retour.

## STRUCTURES X

Certaines BAPI de modification utilisent une structure parallèle dite **X**. Elle indique quels champs doivent être pris en compte.

Exemple conceptuel :

```abap
ls_data-description  = 'Nouvelle description'.
ls_datax-description = abap_true.
```

Une valeur fournie sans indicateur peut être ignorée. Un indicateur fourni avec une valeur initiale peut signifier que le champ doit être effacé. Vérifier la documentation de la BAPI.

## RETOUR BAPIRET2

Une structure `BAPIRET2` contient notamment :

| Champ                       | Rôle                                |
| --------------------------- | ----------------------------------- |
| `TYPE`                      | Gravité du message                  |
| `ID`                        | Classe de messages                  |
| `NUMBER`                    | Numéro du message                   |
| `MESSAGE`                   | Texte formaté                       |
| `MESSAGE_V1` à `V4`         | Variables du message                |
| `PARAMETER`, `ROW`, `FIELD` | Localisation éventuelle de l’erreur |

## TYPES DE MESSAGE

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

## EXTENSIONIN ET EXTENSIONOUT

Certaines BAPI proposent des conteneurs d’extension pour des champs clients. Leur remplissage dépend de structures prévues et de mécanismes d’extension spécifiques. Ne pas sérialiser arbitrairement des données sans respecter la documentation.

## DIAGNOSTIC

Conserver tous les messages utiles et pas uniquement le premier. Pour chaque message, enregistrer au minimum :

- type ;
- classe et numéro ;
- texte ;
- paramètre ou ligne ;
- clé métier ;
- corrélation du traitement.

## PROCÉDURE PAS À PAS

1. Saisir `/nSE37`.
2. Entrer le nom du module fonction puis choisir **Afficher**, **Modifier** ou **Créer** selon l’autorisation.
3. Analyser les onglets Import, Export, Changing, Tables et Exceptions.
4. Lire la documentation et le code source avant tout appel.
5. Utiliser **Test/Exécuter** avec des données non destructives.
6. Pour un module Z, contrôler, activer puis tester les cas nominal et d’erreur.

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Appeler un module fonction sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA(lv_has_error) = xsdbool(
  line_exists( lt_return[ type = 'E' ] ) OR
  line_exists( lt_return[ type = 'A' ] ) ).
```

## TERMES DU LEXIQUE

- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [BAPI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bapi>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-rfc>)

## RÉFÉRENCES OFFICIELLES SAP

- [Describing Remote Function Calls and BAPIs — SAP Learning](https://learning.sap.com/courses/technical-implementation-and-operation-i-of-sap-s-4hana-and-sap-business-suite/describing-remote-function-calls-and-bapis)
- [Transaction Model for Developing BAPIs — SAP Help Portal](https://help.sap.com/docs/SAP_ERP/67ae2d27aed945b7bd0ad1d2185ec217/4d5b102ba1483d8fe10000000a42189e.html)
- [Purchasing BAPIs — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/spmm/3362167428.html)


---

[Chapitre suivant — APPELER UNE BAPI ET GÉRER LA TRANSACTION](<./20 ├── APPELER UNE BAPI ET GERER LA TRANSACTION.md>)
