# 🌸 ISOLER LES DEPENDANCES AVEC TEST SEAM

## 🌺 Objectif

Remplacer ponctuellement une dépendance difficile à contrôler dans un test unitaire lorsque la conception existante ne permet pas encore une injection propre.

## 🌺 Principe

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

## 🌺 Cas d’usage

- accès direct à une dépendance ancienne ;
- lecture de date ou contexte système encapsulée difficilement ;
- étape transitoire avant refactorisation ;
- code procédural existant sans interface injectable.

## 🌺 Limites

- disponibilité dépendante de la release ABAP ;
- couture visible dans le code productif ;
- risque de multiplier des points artificiels ;
- ne remplace pas une architecture fondée sur des interfaces et l’injection de dépendances.

## 🌺 Priorité de conception

Pour un nouveau code objet, préférer une dépendance passée au constructeur ou à une méthode. Utiliser `TEST-SEAM` principalement pour rendre testable un code existant sans refonte immédiate.

## 🌺 Références SAP officielles

- [ABAP Keyword Documentation — TEST-INJECTION](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTEST-INJECTION_SHORTREF.html)
- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
TEST-SEAM read_configuration.
  SELECT SINGLE value
    FROM zdev_config
    WHERE config_key = @iv_key
    INTO @rv_value.
END-TEST-SEAM.
```

## 🌺 TERMES DU LEXIQUE

- [ATC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)
- [Trace](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **appliquer isoler les dependances avec test seam pour mesurer, contrôler et sécuriser la qualité d’une livraison ABAP**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.


---

➡️ [Chapitre suivant — MESURER LA COUVERTURE AVEC SCOV](<./22 - 🍧 MESURER LA COUVERTURE AVEC SCOV.md>)
