# 🌸 STRUCTURES APPEND ET EXTENSIONS

## 🌺 OBJECTIFS

- Étendre une table ou une structure sans modifier sa définition d’origine
- Distinguer append, include et modification
- Comprendre l’effet de l’activation
- Ajouter des champs, clés étrangères ou aides à la recherche
- Sécuriser une extension d’objet standard

## 🌺 PRINCIPE D’UN APPEND

Une structure append est affectée à une seule table ou structure cible.

Lors de l’activation, ses composants sont ajoutés à la définition active de l’objet cible.

```mermaid
flowchart LR
    A["Table standard"] --> C["Définition active étendue"]
    B["Structure append client"] --> C
    C --> D["Programmes et écrans consommateurs"]
```

Plusieurs structures append peuvent être affectées au même objet lorsque le système et la catégorie d’amélioration l’autorisent.

## 🌺 POSSIBILITÉS

Un append peut notamment :

- ajouter de nouveaux champs ;
- définir une clé étrangère sur certains champs existants ;
- affecter une aide à la recherche à certains champs existants.

Les éléments ajoutés appartiennent à l’append et sont transportés avec lui.

## 🌺 APPEND, INCLUDE ET MODIFICATION

| Mécanisme    | Usage                                                                |
| ------------ | -------------------------------------------------------------------- |
| Include      | Composer un objet que l’on maîtrise à partir d’une structure commune |
| Append       | Étendre un objet existant sans changer directement son original      |
| Modification | Changer directement un objet livré par SAP                           |

Pour une extension client, utiliser le mécanisme prévu par SAP. Une modification directe du standard complique les montées de version et doit être évitée.

## 🌺 CRÉATION

Depuis la table ou la structure dans `SE11` :

1. ouvrir la fonction d’append ;
2. créer une structure append dans l’espace client ;
3. définir les composants ;
4. utiliser des éléments de données adaptés ;
5. maintenir la catégorie d’amélioration de l’append si nécessaire ;
6. activer l’append ;
7. contrôler l’activation de l’objet cible et ses dépendances.

## 🌺 CATÉGORIE D’AMÉLIORATION

La catégorie d’amélioration indique quels types de composants peuvent être ajoutés.

Elle protège notamment les usages qui exigent une structure plate ou sans types particuliers.

Ne pas choisir une catégorie plus permissive que nécessaire uniquement pour supprimer un avertissement.

## 🌺 IMPACT TECHNIQUE

L’ajout d’un champ à une table persistante modifie sa structure en base. L’activation peut déclencher un ajustement technique selon le type de changement et le système.

Avant l’extension :

- vérifier la catégorie d’amélioration ;
- analyser la liste d’utilisation ;
- contrôler les structures de communication et interfaces ;
- anticiper l’alimentation du nouveau champ ;
- tester les programmes qui utilisent des affectations implicites ou des structures complètes.

## 🌺 POINTS À RETENIR

- Un append étend un objet sans modifier sa définition d’origine.
- Il est lié à une seule table ou structure cible.
- L’activation ajoute ses composants à l’objet actif.
- La catégorie d’amélioration doit être respectée.
- Une extension de table peut nécessiter un ajustement physique et des tests de régression.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Append Structures — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/ec1c9c8191b74de98feb94001a95dd76/cf21eb61446011d189700000e8322d00.html)
- [Adding an Append Structure — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_740/ec1c9c8191b74de98feb94001a95dd76/cf21ebc9446011d189700000e8322d00.html)

---

➡️ [Chapitre suivant — ACTIVATION AJUSTEMENT BASE ET ANALYSE DES DEPENDANCES](<./16 - 🍧 ACTIVATION AJUSTEMENT BASE ET ANALYSE DES DEPENDANCES.md>)
