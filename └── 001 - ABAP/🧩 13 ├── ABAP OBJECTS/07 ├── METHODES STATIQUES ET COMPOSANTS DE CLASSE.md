# MÉTHODES STATIQUES ET COMPOSANTS DE CLASSE

## RÉSULTAT ATTENDU

- Comprendre la différence entre composant d’instance et composant statique.
- Créer une méthode statique dans `SE24`.
- Éviter les classes utilitaires statiques devenues difficiles à tester.

## DIFFÉRENCE

Une méthode d’instance s’exécute sur un objet et peut accéder à son état. Une méthode statique appartient à la classe et s’appelle avec `=>` sans créer d’instance.

```abap
DATA(lv_normalized) = zcl_dev_string_tools=>normalize( iv_text ).
```

## QUAND UNE MÉTHODE STATIQUE EST PERTINENTE

- création contrôlée d’instances par une fabrique ;
- fonction pure sans état ni dépendance externe ;
- conversion déterministe et stable ;
- point d’entrée technique imposé par un framework.

Elle est moins adaptée si la méthode dépend de la base, de l’heure, de l’utilisateur, d’un customizing ou d’un autre service : ces dépendances deviennent cachées et difficiles à remplacer en test.

## PROCÉDURE DANS SE24

1. Créer une méthode.
2. Activer l’indicateur **Méthode de classe** ou équivalent.
3. Définir les paramètres.
4. Implémenter sans dépendre d’attributs d’instance.
5. Appeler la méthode avec `nom_classe=>nom_methode`.
6. Ajouter un test des cas limites.

## CODE DE FONCTION PURE À ADAPTER

```abap
CLASS-METHODS normalize_key
  IMPORTING iv_key TYPE string
  RETURNING VALUE(rv_key) TYPE string.

METHOD normalize_key.
  rv_key = to_upper( iv_key ).
  CONDENSE rv_key NO-GAPS.
ENDMETHOD.
```

## ATTRIBUTS STATIQUES

Un attribut statique est partagé par tous les objets de la classe dans une session interne. Il est utile pour :

- une instance Singleton ;
- un cache local à la session, correctement invalidé ;
- une constante calculée une seule fois.

Il est dangereux pour stocker un état métier implicite ou dépendant d’un utilisateur.

## CONTRÔLE

Créer deux instances de la classe et vérifier qu’un attribut d’instance reste propre à chacune. Vérifier qu’un attribut statique est partagé, uniquement lorsque ce comportement est voulu.

## ERREURS FRÉQUENTES

- Transformer toute la classe en catalogue de méthodes statiques.
- Masquer un accès base ou un `COMMIT WORK` dans une méthode utilitaire.
- Utiliser un cache statique sans mécanisme d’invalidation.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Static Classes and Singletons — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSTATIC_CLASS_SINGLETON_GUIDL.html)
- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)

---

[Chapitre suivant — CONSTRUCTEURS ET INITIALISATION](<./08 ├── CONSTRUCTEURS ET INITIALISATION.md>)
