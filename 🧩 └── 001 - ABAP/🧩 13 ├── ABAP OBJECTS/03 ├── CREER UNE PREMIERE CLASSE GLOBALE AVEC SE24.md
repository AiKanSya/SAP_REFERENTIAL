# 3. CRÉER UNE PREMIÈRE CLASSE GLOBALE AVEC SE24

## 3.A RÉSULTAT ATTENDU

- Créer une classe globale transportable.
- Définir une méthode publique simple.
- Implémenter, activer et tester la classe.
- Comprendre la différence entre la définition et l’implémentation.

## 3.B CAS D’USAGE

Créer une classe `ZCL_DEV_TEXT_FORMATTER` réutilisable qui normalise un texte saisi par plusieurs programmes.

## 3.C PRÉREQUIS

- Autorisation de développement.
- Package client existant, ou `$TMP` uniquement pour un essai local non transportable.
- Convention de nommage du projet.

## 3.D PROCESS

### 3.D.1 Étape 1 — Créer l’objet global

Ouvrir `SE24`, saisir `ZCL_DEV_TEXT_FORMATTER` et choisir **Créer**. Si le nom existe, l’afficher et ne pas l’écraser. Renseigner description et instanciation publique, puis affecter package et tâche de transport.

### 3.D.2 Étape 2 — Définir la méthode publique

Dans **Méthodes**, créer `NORMALIZE`, conserver le niveau instance et choisir la visibilité publique. Ouvrir la signature avant d’écrire l’implémentation.

### 3.D.3 Étape 3 — Définir la signature exacte

Ajouter `IV_TEXT` dans `IMPORTING` avec le type `STRING`. Ajouter `RV_TEXT` dans `RETURNING`, type `STRING`, passage par valeur. Vérifier qu’un seul paramètre returning existe et qu’aucun paramètre inutile n’a été généré.

### 3.D.4 Étape 4 — Implémenter

Ouvrir le source de `NORMALIZE`, coller le code du chapitre et vérifier qu’il utilise uniquement `IV_TEXT` pour calculer `RV_TEXT`. Enregistrer puis exécuter le contrôle syntaxique.

### 3.D.5 Étape 5 — Activer la classe complète

Activer et examiner la liste d’objets. Si la signature ou l’implémentation reste inactive, corriger le premier message avant de relancer.

### 3.D.6 Étape 6 — Tester deux cas

Instancier avec `NEW zcl_dev_text_formatter( )`, appeler la méthode avec un texte contenant espaces irréguliers puis avec une chaîne vide. La classe est validée lorsque chaque résultat correspond au contrat et que l’appel utilise la signature publiée.

## 3.E IMPLÉMENTATION

Signature publique à créer dans `SE24` :

```abap
METHODS normalize
  IMPORTING
    iv_text TYPE string
  RETURNING
    VALUE(rv_text) TYPE string.
```

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
METHOD normalize.
  rv_text = to_upper( condense( val = iv_text ) ).
ENDMETHOD.
```

## 3.F REPORT DE TEST À COPIER

```abap
" Construire les dépendances avant d’exécuter le traitement.
REPORT zdev_test_text_formatter.

PARAMETERS p_text TYPE string LOWER CASE DEFAULT '  exemple   sap  '.

START-OF-SELECTION.
  DATA(lo_formatter) = NEW zcl_dev_text_formatter( ).
  DATA(lv_result) = lo_formatter->normalize( p_text ).

  WRITE: / |Résultat : { lv_result }|.
```

## 3.G RÉSULTAT ATTENDU

Pour l’entrée `  exemple   sap  `, le programme doit afficher un texte condensé et converti en majuscules. Le comportement exact de `CONDENSE` et des fonctions de chaîne dépend des caractères fournis.

## 3.H COMMENT VÉRIFIER

- La classe est active dans `SE24`.
- La méthode apparaît en visibilité publique.
- Le report se compile.
- Un breakpoint placé dans `NORMALIZE` est atteint.
- La liste des utilisations de la méthode contient le report de test.

## 3.I ERREURS FRÉQUENTES

- Oublier d’activer la classe après avoir activé uniquement une méthode.
- Créer l’objet dans `$TMP` alors qu’il doit être transporté.
- Utiliser un paramètre `CHANGING` alors qu’une valeur de retour suffit.
- Placer le formatage directement dans plusieurs reports au lieu de centraliser la règle.

## 3.J COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 3.K RÉFÉRENCES OFFICIELLES SAP

- [Defining the Basic Attributes of a Global Class — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_703/b9c78754117d480793fadb452da906d8/2d66934264a5c56ae10000000a155106.html)
- [Class Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/a602ff71a47c441bb3000504ec938fea/cac035baa6c611d1b4790000e8a52bed.html)

---

[Chapitre suivant — CLASS POOL ET ORGANISATION TECHNIQUE](<./04 ├── CLASS POOL ET ORGANISATION TECHNIQUE.md>)
