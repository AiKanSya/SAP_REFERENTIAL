# 🌸 TYPES DE MESSAGES ET COMPORTEMENT

## 🌺 OBJECTIFS

- Connaître les types `S`, `I`, `W`, `E`, `A` et `X`
- Comprendre que le comportement dépend du contexte
- Choisir un type selon l’effet attendu
- Éviter l’usage abusif des messages d’arrêt
- Distinguer comportement et apparence

## 🌺 TABLEAU DE SYNTHÈSE

| Type | Signification générale | Effet principal                            |
| ---- | ---------------------- | ------------------------------------------ |
| `S`  | Succès ou statut       | Poursuite normale                          |
| `I`  | Information            | Affichage d’une information puis poursuite |
| `W`  | Avertissement          | Réaction dépendante du contexte            |
| `E`  | Erreur                 | Retour ou arrêt dépendant du contexte      |
| `A`  | Abandon                | Interruption du traitement en cours        |
| `X`  | Erreur fatale          | Erreur d’exécution et dump                 |

Le type ne représente pas uniquement une icône. Il influence le flux du programme.

## 🌺 TYPE S

```abap
MESSAGE s003(zdev_msg) WITH lv_count.
```

Le traitement continue normalement. Le message est généralement présenté dans la barre de statut du prochain écran pertinent.

## 🌺 TYPE I

```abap
MESSAGE i004(zdev_msg).
```

Le message est présenté comme une information. Après validation par l’utilisateur, le traitement continue après l’instruction `MESSAGE`.

Un message modal rend un traitement dépendant de l’interaction SAP GUI. Il est donc inadapté à un programme destiné à l’arrière-plan.

## 🌺 TYPES W ET E

Le comportement exact dépend du contexte :

- écran de sélection ;
- dynpro classique ;
- traitement de liste ;
- bloc événementiel ;
- procédure appelée.

Un type `E` sur un écran de sélection peut maintenir l’utilisateur sur l’écran afin qu’il corrige la valeur. Le même type dans un autre contexte peut interrompre le bloc courant ou revenir à un écran antérieur.

Il faut toujours vérifier la documentation du contexte d’exécution.

## 🌺 TYPE A

Le type `A` signale qu’un traitement ne peut pas continuer. Il provoque une interruption contrôlée par le runtime ABAP.

Il ne doit pas être utilisé pour une validation fonctionnelle ordinaire. Une erreur de saisie doit permettre une correction.

## 🌺 TYPE X

```abap
MESSAGE x005(zdev_msg).
```

Le type `X` force une erreur d’exécution, généralement visible dans `ST22` avec le contexte du programme.

Son usage doit rester exceptionnel. Il ne remplace ni une exception de classe ni un message fonctionnel.

## 🌺 COMPORTEMENT DÉPENDANT DU CONTEXTE

```mermaid
flowchart TD
    A["Instruction MESSAGE"] --> B["Type du message"]
    B --> C["Contexte d’exécution"]
    C --> D["Affichage et contrôle du flux"]
```

Le même type peut être traité différemment dans un écran, une liste ou un traitement sans interface.

## 🌺 RÈGLE DE CHOIX

- `S` : confirmation non bloquante ;
- `I` : information nécessitant une lecture immédiate en dialogue ;
- `W` : situation corrigible mais risquée ;
- `E` : donnée ou action invalide empêchant la poursuite ;
- `A` : impossibilité de poursuivre le traitement courant ;
- `X` : état technique fatal qui doit produire un dump.

## 🌺 CAS D’USAGE

Dans un contexte où un import doit signaler clairement les erreurs, permettre leur traitement et éviter les arrêts non maîtrisés, le besoin consiste à **gérer une situation d’erreur avec types de messages et comportement et produire une information exploitable par l’appelant ou l’utilisateur**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un message technique incompréhensible à l’utilisateur.
- Attraper une exception sans action ni propagation.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
MESSAGE s003(zdev_msg) WITH lv_count.
```

## 🌺 TERMES DU LEXIQUE

- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [Dump ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **gérer une situation d’erreur avec types de messages et comportement et produire une information exploitable par l’appelant ou l’utilisateur**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Message Types — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/c238d694b825421f940829321ffa326a/4ec24da36e391014adc9fffe4e204223.html)
- [MESSAGE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPMESSAGE_SHORTREF.html)
- [Messages in List Processing — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_MESSAGE_LIST_PROCESSING.html)


---

➡️ [Chapitre suivant — VARIABLES ET CHAMPS SYSTÈME DE MESSAGE](<./05 - 🍧 VARIABLES ET CHAMPS SYSTEME DE MESSAGE.md>)
