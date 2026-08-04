# 7. MÉTHODES STATIQUES ET COMPOSANTS DE CLASSE

## 7.A RÉSULTAT ATTENDU

- Comprendre la différence entre composant d’instance et composant statique.
- Créer une méthode statique dans `SE24`.
- Éviter les classes utilitaires statiques devenues difficiles à tester.

## 7.B DIFFÉRENCE

Une méthode d’instance s’exécute sur un objet et peut accéder à son état. Une méthode statique appartient à la classe et s’appelle avec `=>` sans créer d’instance.

```abap
" Exemple à éviter : identifier le défaut avant de choisir la correction.
DATA(lv_normalized) = zcl_dev_string_tools=>normalize( iv_text ).
```

## 7.C QUAND UNE MÉTHODE STATIQUE EST PERTINENTE

- création contrôlée d’instances par une fabrique ;
- fonction pure sans état ni dépendance externe ;
- conversion déterministe et stable ;
- point d’entrée technique imposé par un framework.

Elle est moins adaptée si la méthode dépend de la base, de l’heure, de l’utilisateur, d’un customizing ou d’un autre service : ces dépendances deviennent cachées et difficiles à remplacer en test.

## 7.D PROCESS

### 7.D.1 Étape 1 — Vérifier que l’instance est inutile

Confirmer que le traitement ne dépend d’aucun état propre à un objet et qu’il représente une opération de classe, une conversion ou une factory. Sinon créer une méthode d’instance.

### 7.D.2 Étape 2 — Créer la méthode de classe

Dans `SE24`, créer la méthode puis activer **Méthode de classe**. Définir visibilité et signature complète comme pour une méthode d’instance.

### 7.D.3 Étape 3 — Contrôler les dépendances

Implémenter en utilisant paramètres, constantes et attributs de classe autorisés. Toute tentative d’accès direct à un attribut d’instance doit être supprimée ou remplacée par une instance explicitement fournie.

### 7.D.4 Étape 4 — Appeler sans instance

Utiliser `zcl_nom=>methode( ... )` dans un report. Vérifier qu’aucun `NEW` n’est nécessaire et que le résultat ne dépend pas de l’ordre d’appels précédents.

### 7.D.5 Étape 5 — Tester les limites

Tester cas nominal, valeur initiale et valeur maximale pertinente. La méthode est validée lorsque deux appels identiques produisent le même résultat en l’absence d’état de classe volontaire.

## 7.E CODE DE FONCTION PURE À ADAPTER

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
CLASS-METHODS normalize_key
  IMPORTING iv_key TYPE string
  RETURNING VALUE(rv_key) TYPE string.

METHOD normalize_key.
  rv_key = to_upper( iv_key ).
  CONDENSE rv_key NO-GAPS.
ENDMETHOD.
```

## 7.F ATTRIBUTS STATIQUES

Un attribut statique est partagé par tous les objets de la classe dans une session interne. Il est utile pour :

- une instance Singleton ;
- un cache local à la session, correctement invalidé ;
- une constante calculée une seule fois.

Il est dangereux pour stocker un état métier implicite ou dépendant d’un utilisateur.

## 7.G CONTRÔLE

Créer deux instances de la classe et vérifier qu’un attribut d’instance reste propre à chacune. Vérifier qu’un attribut statique est partagé, uniquement lorsque ce comportement est voulu.

## 7.H ERREURS FRÉQUENTES

- Transformer toute la classe en catalogue de méthodes statiques.
- Masquer un accès base ou un `COMMIT WORK` dans une méthode utilitaire.
- Utiliser un cache statique sans mécanisme d’invalidation.

## 7.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 7.J RÉFÉRENCES OFFICIELLES SAP

- [Static Classes and Singletons — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSTATIC_CLASS_SINGLETON_GUIDL.html)
- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)

---

[Chapitre suivant — CONSTRUCTEURS ET INITIALISATION](<./08 ├── CONSTRUCTEURS ET INITIALISATION.md>)
