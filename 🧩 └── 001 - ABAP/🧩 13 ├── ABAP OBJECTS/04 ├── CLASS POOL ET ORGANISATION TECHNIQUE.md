# 4. CLASS POOL ET ORGANISATION TECHNIQUE

## 4.A RÉSULTAT ATTENDU

- Comprendre où le système stocke une classe globale.
- Identifier les includes gérés par le Class Builder.
- Savoir où placer les classes locales et les déclarations privées au Class Pool.
- Éviter les modifications techniques qui rendent l’objet incohérent.

## 4.B FONCTIONNEMENT

Une classe globale est stockée dans un programme spécial appelé **Class Pool**. Le Class Builder organise la définition, l’implémentation et les parties locales dans des includes techniques.

```mermaid
flowchart TD
    A["Classe globale"] --> B["Class Pool"]
    B --> C["Définition publique et protégée"]
    B --> D["Définition privée"]
    B --> E["Implémentation des méthodes"]
    B --> F["Classes locales du Class Pool"]
```

Le nom technique des includes est généré. Il ne faut pas renommer, déplacer ou supprimer manuellement ces includes.

## 4.C PARTIES LOCALES UTILES

Le Class Builder fournit généralement des emplacements pour :

- définitions locales visibles de la classe globale ;
- implémentations locales ;
- macros historiques ;
- classes de test ABAP Unit.

Les classes locales sont utiles pour des collaborateurs strictement internes ou des doubles de test. Elles ne remplacent pas les classes globales devant être appelées depuis d’autres objets.

## 4.D PROCESS

### 4.D.1 Étape 1 — Ouvrir le class pool

Afficher la classe dans `SE24` ou `SE80`, puis naviguer vers son programme de classe et ses includes. Relever le nom technique généré et le package.

### 4.D.2 Étape 2 — Identifier les parties générées

Distinguer définition publique/protected/private, implémentations de méthodes, includes locaux et zones contrôlées par le Class Builder. Ne modifier pas manuellement une section dont la prochaine génération écraserait le contenu.

### 4.D.3 Étape 3 — Localiser le bon point de maintenance

Pour une signature, revenir aux onglets du Class Builder. Pour le corps d’une méthode, ouvrir son implémentation. Pour une classe locale prévue, utiliser l’include local dédié.

### 4.D.4 Étape 4 — Contrôler la cohérence globale

Après modification, exécuter le contrôle de la classe complète. Une erreur signalée dans un include généré doit être corrigée depuis le composant source correspondant.

### 4.D.5 Étape 5 — Activer et vérifier

Activer la classe et tous ses composants. La procédure est validée lorsque les zones générées restent intactes et que chaque changement se trouve dans son point de maintenance durable.

## 4.E CAS D’USAGE

Une classe globale doit utiliser un petit parseur qui n’a aucun sens en dehors de son implémentation. Une classe locale du Class Pool peut encapsuler ce détail sans ajouter un objet global supplémentaire dans le package.

## 4.F CODE DE CLASSE LOCALE À ADAPTER

```abap
" Modifier uniquement les données de la table cible maîtrisée.
CLASS lcl_tokenizer DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS split
      IMPORTING iv_text TYPE string
      RETURNING VALUE(rt_tokens) TYPE string_table.
ENDCLASS.

CLASS lcl_tokenizer IMPLEMENTATION.
  METHOD split.
    SPLIT iv_text AT space INTO TABLE rt_tokens.
    DELETE rt_tokens WHERE table_line IS INITIAL.
  ENDMETHOD.
ENDCLASS.
```

## 4.G CONTRÔLE

- La classe globale reste activable.
- La classe locale n’est pas visible depuis un report externe.
- Aucun include généré n’a été créé manuellement.
- La responsabilité de la classe locale est strictement interne.

## 4.H ERREURS FRÉQUENTES

- Développer toute la logique dans les includes au lieu des méthodes de la classe globale.
- Déclarer globalement une classe qui ne sert qu’à une seule implémentation privée.
- Dépendre d’une classe locale depuis un autre objet Repository.

## 4.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 4.J RÉFÉRENCES OFFICIELLES SAP

- [Creating Local Definitions and Implementations — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/b5693ecb185011d5969b00a0c94260a5.html)
- [Class Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/a602ff71a47c441bb3000504ec938fea/cac035baa6c611d1b4790000e8a52bed.html)

---

[Chapitre suivant — VISIBILITÉ, TYPES, CONSTANTES ET ATTRIBUTS](<./05 ├── VISIBILITE TYPES CONSTANTES ET ATTRIBUTS.md>)
