# ANALYSER UNE CLASSE GLOBALE AVEC SE24

## RÉSULTAT ATTENDU

- Ouvrir une classe globale existante.
- Identifier son API publique, ses dépendances et ses implémentations.
- Retrouver les appels d’une méthode avant une modification.
- Vérifier les propriétés techniques d’une classe.

## CAS D’USAGE

Un incident est signalé dans une méthode `ZCL_MM_STOCK_SERVICE=>GET_STOCK`. Avant de modifier le code, il faut comprendre qui appelle la classe, quelles exceptions sont déclarées et si la méthode est redéfinie dans des sous-classes.

## PROCESS

### Étape 1 — Confirmer l’identité de la classe

Ouvrir `SE24`, saisir le nom exact et choisir **Afficher**. Relever description, package, responsable, statut actif, mode d’instanciation et indicateurs abstrait/final. Si l’outil propose de créer, annuler et vérifier le nom.

### Étape 2 — Cartographier l’API publique

Dans **Méthodes**, filtrer ou repérer les composants publics. Pour chaque méthode utile, ouvrir la signature et relever `IMPORTING`, `EXPORTING`, `CHANGING`, `RETURNING`, passage par valeur et `RAISING`. Une méthode ne doit pas être appelée avant que paramètres obligatoires et exceptions soient connus.

### Étape 3 — Examiner l’état

Dans **Attributs**, distinguer instance/classe et public/protected/private. Identifier les méthodes autorisées à modifier les attributs privés et les invariants que ces méthodes maintiennent.

### Étape 4 — Examiner les contrats hérités

Ouvrir interfaces, superclasse et redéfinitions. Pour une méthode héritée, comparer la définition d’origine et l’implémentation redéfinie afin de savoir quel contrat reste imposé.

### Étape 5 — Lire l’implémentation ciblée

Ouvrir uniquement la méthode liée au scénario. Relever appels externes, accès aux données, exceptions et effets de bord. Utiliser la liste d’utilisation pour trouver des appelants représentatifs.

### Étape 6 — Valider l’analyse

Construire un appel minimal dans un report ou test. L’analyse est terminée lorsque instanciation, signature, erreurs, dépendances et effet de la méthode peuvent être décrits sans supposition.

> [!NOTE]
> Les libellés exacts des boutons peuvent varier selon la release et le mode du Class Builder. Les mêmes objets sont également accessibles dans `SE80`.

## LECTURE DE L’API PUBLIQUE

L’API publique est le contrat visible par les consommateurs. Elle comprend principalement :

- les méthodes publiques ;
- les types et constantes publics ;
- les événements publics ;
- les interfaces implémentées ;
- les exceptions déclarées.

Une modification de cette API peut casser des programmes consommateurs. Une modification privée reste généralement interne, mais doit néanmoins être testée.

## RECHERCHE DES UTILISATIONS

Avant de renommer ou supprimer une méthode :

1. positionner le curseur sur la méthode ;
2. appeler la liste des utilisations depuis le menu du Workbench ;
3. sélectionner les catégories pertinentes ;
4. analyser les programmes, classes, interfaces et objets générés ;
5. vérifier les appels dynamiques, qui peuvent ne pas être trouvés statiquement.

## FICHE D’ANALYSE À COPIER

```text
Classe              :
Package              :
Responsabilité       :
Superclasse          :
Interfaces           :
Méthodes publiques   :
Exceptions           :
Dépendances          :
Principaux appelants :
Ordre de transport   :
Risque de régression :
```

## CONTRÔLE

L’analyse est complète lorsque vous pouvez répondre sans lire tout le code :

- quel service la classe rend ;
- comment l’appeler ;
- quelles erreurs elle peut produire ;
- quels objets seront impactés par une modification.

## ERREURS FRÉQUENTES

- Modifier une méthode sans consulter la liste des utilisations.
- Se limiter au code de la méthode sans vérifier les méthodes redéfinies.
- Ignorer les interfaces qui constituent le véritable contrat public.
- Considérer qu’une classe non instanciée directement n’est pas utilisée : elle peut être créée par une fabrique ou un framework.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Class Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/a602ff71a47c441bb3000504ec938fea/cac035baa6c611d1b4790000e8a52bed.html)
- [Introduction to the Class Builder — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/12aa7f056c531014aa5bca7aee037e55/eee440a670a111d1b44c0000e8a52bed.html)

---

[Chapitre suivant — CRÉER UNE PREMIÈRE CLASSE GLOBALE AVEC SE24](<./03 ├── CREER UNE PREMIERE CLASSE GLOBALE AVEC SE24.md>)
