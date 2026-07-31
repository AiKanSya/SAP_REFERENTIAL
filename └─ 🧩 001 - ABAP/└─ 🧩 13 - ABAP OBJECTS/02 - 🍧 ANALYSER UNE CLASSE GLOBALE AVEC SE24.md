# 🌸 ANALYSER UNE CLASSE GLOBALE AVEC SE24

## 🌺 OBJECTIFS

- Ouvrir une classe globale existante.
- Identifier son API publique, ses dépendances et ses implémentations.
- Retrouver les appels d’une méthode avant une modification.
- Vérifier les propriétés techniques d’une classe.

## 🌺 CAS D’USAGE

Un incident est signalé dans une méthode `ZCL_MM_STOCK_SERVICE=>GET_STOCK`. Avant de modifier le code, il faut comprendre qui appelle la classe, quelles exceptions sont déclarées et si la méthode est redéfinie dans des sous-classes.

## 🌺 PROCÉDURE D’ANALYSE

1. Saisir `/nSE24`.
2. Entrer le nom exact de la classe.
3. Choisir **Afficher**.
4. Consulter les propriétés générales : description, package, instanciation, classe finale ou abstraite.
5. Ouvrir l’onglet **Méthodes** et identifier les méthodes publiques.
6. Vérifier pour chaque méthode les paramètres `IMPORTING`, `EXPORTING`, `CHANGING`, `RETURNING` et `RAISING`.
7. Consulter les attributs et leur visibilité.
8. Consulter les interfaces implémentées.
9. Vérifier la superclasse et les éventuelles redéfinitions.
10. Ouvrir l’implémentation de la méthode ciblée.
11. Utiliser la **liste des utilisations** sur la classe ou la méthode.
12. Consulter la documentation de la classe si elle existe.

> [!NOTE]
> Les libellés exacts des boutons peuvent varier selon la release et le mode du Class Builder. Les mêmes objets sont également accessibles dans `SE80`.

## 🌺 LECTURE DE L’API PUBLIQUE

L’API publique est le contrat visible par les consommateurs. Elle comprend principalement :

- les méthodes publiques ;
- les types et constantes publics ;
- les événements publics ;
- les interfaces implémentées ;
- les exceptions déclarées.

Une modification de cette API peut casser des programmes consommateurs. Une modification privée reste généralement interne, mais doit néanmoins être testée.

## 🌺 RECHERCHE DES UTILISATIONS

Avant de renommer ou supprimer une méthode :

1. positionner le curseur sur la méthode ;
2. appeler la liste des utilisations depuis le menu du Workbench ;
3. sélectionner les catégories pertinentes ;
4. analyser les programmes, classes, interfaces et objets générés ;
5. vérifier les appels dynamiques, qui peuvent ne pas être trouvés statiquement.

## 🌺 FICHE D’ANALYSE À COPIER

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

## 🌺 VÉRIFICATION

L’analyse est complète lorsque vous pouvez répondre sans lire tout le code :

- quel service la classe rend ;
- comment l’appeler ;
- quelles erreurs elle peut produire ;
- quels objets seront impactés par une modification.

## 🌺 ERREURS FRÉQUENTES

- Modifier une méthode sans consulter la liste des utilisations.
- Se limiter au code de la méthode sans vérifier les méthodes redéfinies.
- Ignorer les interfaces qui constituent le véritable contrat public.
- Considérer qu’une classe non instanciée directement n’est pas utilisée : elle peut être créée par une fabrique ou un framework.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Class Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/a602ff71a47c441bb3000504ec938fea/cac035baa6c611d1b4790000e8a52bed.html)
- [Introduction to the Class Builder — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/12aa7f056c531014aa5bca7aee037e55/eee440a670a111d1b44c0000e8a52bed.html)

---

➡️ [Chapitre suivant — CRÉER UNE PREMIÈRE CLASSE GLOBALE AVEC SE24](<./03 - 🍧 CREER UNE PREMIERE CLASSE GLOBALE AVEC SE24.md>)
