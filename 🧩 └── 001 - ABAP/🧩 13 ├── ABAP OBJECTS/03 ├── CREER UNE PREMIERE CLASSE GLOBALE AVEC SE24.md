# CRÉER " Construire les dépendances avant d’exécuter le traitement.
UNE PREMIÈRE CLASSE GLOBALE AVEC SE24

## RÉSULTAT ATTENDU

- Créer une classe globale transportable.
- Définir une méthode publique simple.
- Implémenter, activer et tester la classe.
- Comprendre la différence entre la définition et l’implémentation.

## CAS D’USAGE

Créer une classe `ZCL_DEV_TEXT_FORMATTER` réutilisable qui normalise un texte saisi par plusieurs programmes.

## PRÉREQUIS

- Autorisation de développement.
- Package client existant, ou `$TMP` uniquement pour un essai local non transportable.
- Convention de nommage du projet.

## PROCÉDURE PAS À PAS

1. Saisir `/nSE24`.
2. Entrer `ZCL_DEV_TEXT_FORMATTER`.
3. Choisir **Créer**.
4. Saisir une description claire.
5. Conserver une instanciation publique pour ce premier exemple.
6. Affecter la classe au package du projet.
7. Affecter l’objet à un ordre de transport.
8. Dans l’onglet **Méthodes**, créer `NORMALIZE` en visibilité publique.
9. Définir un paramètre `IV_TEXT` de type `STRING` en `IMPORTING`.
10. Définir `RV_TEXT` de type `STRING` en `RETURNING` et activer la case **Passage par valeur** si l’outil le demande.
11. Ouvrir l’implémentation de `NORMALIZE`.
12. Saisir le code ci-dessous.
13. Contrôler la syntaxe.
14. Activer la classe complète.
15. Tester depuis `SE24` ou avec le report fourni.

## IMPLÉMENTATION

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

## REPORT DE TEST À COPIER

```abap
" Construire les dépendances avant d’exécuter le traitement.
REPORT zdev_test_text_formatter.

PARAMETERS p_text TYPE string LOWER CASE DEFAULT '  exemple   sap  '.

START-OF-SELECTION.
  DATA(lo_formatter) = NEW zcl_dev_text_formatter( ).
  DATA(lv_result) = lo_formatter->normalize( p_text ).

  WRITE: / |Résultat : { lv_result }|.
```

## RÉSULTAT ATTENDU

Pour l’entrée `  exemple   sap  `, le programme doit afficher un texte condensé et converti en majuscules. Le comportement exact de `CONDENSE` et des fonctions de chaîne dépend des caractères fournis.

## COMMENT VÉRIFIER

- La classe est active dans `SE24`.
- La méthode apparaît en visibilité publique.
- Le report se compile.
- Un breakpoint placé dans `NORMALIZE` est atteint.
- La liste des utilisations de la méthode contient le report de test.

## ERREURS FRÉQUENTES

- Oublier d’activer la classe après avoir activé uniquement une méthode.
- Créer l’objet dans `$TMP` alors qu’il doit être transporté.
- Utiliser un paramètre `CHANGING` alors qu’une valeur de retour suffit.
- Placer le formatage directement dans plusieurs reports au lieu de centraliser la règle.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Defining the Basic Attributes of a Global Class — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_703/b9c78754117d480793fadb452da906d8/2d66934264a5c56ae10000000a155106.html)
- [Class Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/a602ff71a47c441bb3000504ec938fea/cac035baa6c611d1b4790000e8a52bed.html)

---

[Chapitre suivant — CLASS POOL ET ORGANISATION TECHNIQUE](<./04 ├── CLASS POOL ET ORGANISATION TECHNIQUE.md>)
