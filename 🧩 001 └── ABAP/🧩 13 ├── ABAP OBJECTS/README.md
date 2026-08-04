# ABAP OBJECTS DANS `SE24`

## UTILISER CE CHAPITRE

| Besoin | Fichier |
|---|---|
| Créer une première classe globale | [Créer une classe avec SE24](<./03 ├── CREER UNE PREMIERE CLASSE GLOBALE AVEC SE24.md>) |
| Comprendre une classe existante | [Analyser une classe globale](<./02 ├── ANALYSER UNE CLASSE GLOBALE AVEC SE24.md>) |
| Définir attributs et visibilités | [Visibilité, types, constantes et attributs](<./05 ├── VISIBILITE TYPES CONSTANTES ET ATTRIBUTS.md>) |
| Définir une méthode | [Méthodes d’instance et paramètres](<./06 ├── METHODES D INSTANCE ET PARAMETRES.md>) |
| Initialiser un objet | [Constructeurs et initialisation](<./08 ├── CONSTRUCTEURS ET INITIALISATION.md>) |
| Définir un contrat | [Interfaces globales](<./11 ├── INTERFACES GLOBALES AVEC SE24.md>) |
| Remplacer une implémentation | [Polymorphisme par interface](<./12 ├── POLYMORPHISME PAR INTERFACE.md>) |
| Spécialiser une classe | [Héritage et redéfinition](<./13 ├── HERITAGE REDEFINITION ET SUPER.md>) |
| Lever une erreur métier | [Exceptions orientées objet](<./15 ├── EXCEPTIONS ORIENTEES OBJET.md>) |
| Publier une notification | [Événements et gestionnaires](<./16 ├── EVENEMENTS ET GESTIONNAIRES.md>) |
| Centraliser la création d’objets | [Factory Method et Simple Factory](<./17 ├── FACTORY METHOD ET SIMPLE FACTORY.md>) |
| Injecter un service testable | [Injection de dépendances](<./20 ├── INJECTION DE DEPENDANCES.md>) |
| Choisir un pattern | [Strategy, Adapter et Façade](<./21 ├── PATTERNS STRATEGY ADAPTER ET FACADE.md>) |
| Tester et déboguer une classe | [Documentation, test et debug](<./23 ├── DOCUMENTATION TEST ET DEBUG AVEC SE24.md>) |

## ORDRE DE LECTURE RAPIDE

1. Classes, attributs, méthodes et constructeurs : fichiers 01 à 10.
2. Contrats et polymorphisme : fichiers 11 à 16.
3. Création et composition : fichiers 17 à 21.
4. Organisation, tests et livraison : fichiers 22 à 24.

## RÈGLES DE CONCEPTION

- Toute implémentation `METHOD ... ENDMETHOD` doit être accompagnée de sa déclaration `METHODS` ou `CLASS-METHODS` avec les types, les catégories de paramètres et les exceptions.
- Tout appel isolé doit identifier le type statique de la référence appelante et l’origine des données transmises.
- Les types fictifs `ZDEV_*` doivent être décrits par les composants utilisés dans le snippet.
- Garder l’état interne privé.
- Exposer une API publique minimale.
- Utiliser une interface lorsque plusieurs implémentations ou un remplacement de test sont nécessaires.
- Préférer la composition à l’héritage pour une relation « utilise ».
- Injecter les dépendances obligatoires par constructeur.
- Éviter l’état global et les Singletons sans contrainte d’unicité réelle.
- Couvrir les comportements publics avec ABAP Unit.
- Contrôler le package, le transport et les utilisations avant toute modification d’API publique.
