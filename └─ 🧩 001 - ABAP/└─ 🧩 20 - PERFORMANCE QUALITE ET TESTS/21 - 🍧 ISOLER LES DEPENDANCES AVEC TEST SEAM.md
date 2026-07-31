# 🍧 ISOLER LES DEPENDANCES AVEC TEST SEAM

## 🎯 Objectif

Remplacer ponctuellement une dépendance difficile à contrôler dans un test unitaire lorsque la conception existante ne permet pas encore une injection propre.

## 🧩 Principe

Le code productif déclare une couture :

```abap
TEST-SEAM read_configuration.
  SELECT SINGLE value
    FROM zdev_config
    WHERE config_key = @iv_key
    INTO @rv_value.
END-TEST-SEAM.
```

Dans une méthode de la classe de test, une injection associée remplace temporairement cette zone :

```abap
METHOD returns_injected_configuration.
  TEST-INJECTION read_configuration.
    rv_value = 'TEST_VALUE'.
  END-TEST-INJECTION.

  cl_abap_unit_assert=>assert_equals(
    exp = 'TEST_VALUE'
    act = mo_cut->get_configuration( 'MODE' ) ).
ENDMETHOD.
```

Pendant l’exécution de cette méthode de test, l’injection remplace le contenu de la couture. Les instructions `TEST-SEAM` et `TEST-INJECTION` sont disponibles à partir d’ABAP 7.50 ; vérifier la release du système avant de retenir cette technique.

## ✅ Cas d’usage

- accès direct à une dépendance ancienne ;
- lecture de date ou contexte système encapsulée difficilement ;
- étape transitoire avant refactorisation ;
- code procédural existant sans interface injectable.

## ⚠️ Limites

- disponibilité dépendante de la release ABAP ;
- couture visible dans le code productif ;
- risque de multiplier des points artificiels ;
- ne remplace pas une architecture fondée sur des interfaces et l’injection de dépendances.

## 🧭 Priorité de conception

Pour un nouveau code objet, préférer une dépendance passée au constructeur ou à une méthode. Utiliser `TEST-SEAM` principalement pour rendre testable un code existant sans refonte immédiate.

## 🔗 Références SAP officielles

- [ABAP Keyword Documentation — TEST-INJECTION](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTEST-INJECTION_SHORTREF.html)
- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)

---

➡️ [Chapitre suivant : MESURER LA COUVERTURE AVEC SCOV](<22 - 🍧 MESURER LA COUVERTURE AVEC SCOV.md>)
