# 21. ISOLER LES DEPENDANCES AVEC TEST SEAM

## 21.A RÉSULTAT ATTENDU

Remplacer ponctuellement une dépendance difficile à contrôler dans un test unitaire lorsque la conception existante ne permet pas encore une injection propre.

## 21.B Principe

Le code productif déclare une couture :

```abap
" Isoler cet accès direct uniquement pour tester le code existant.
TEST-SEAM read_configuration.
  SELECT SINGLE value
    FROM zdev_config
    WHERE config_key = @iv_key
    INTO @rv_value.
END-TEST-SEAM.
```

Dans une méthode de la classe de test, une injection associée remplace temporairement cette zone :

```abap
" Vérifier un seul comportement observable avec une attente explicite.
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

## 21.C Cas d’usage

- accès direct à une dépendance ancienne ;
- lecture de date ou contexte système encapsulée difficilement ;
- étape transitoire avant refactorisation ;
- code procédural existant sans interface injectable.

## 21.D Limites

- disponibilité dépendante de la release ABAP ;
- couture visible dans le code productif ;
- risque de multiplier des points artificiels ;
- ne remplace pas une architecture fondée sur des interfaces et l’injection de dépendances.

## 21.E Priorité de conception

Pour un nouveau code objet, préférer une dépendance passée au constructeur ou à une méthode. Utiliser `TEST-SEAM` principalement pour rendre testable un code existant sans refonte immédiate.

## 21.F PROCESS

### 21.F.1 ÉTAPE 1 — VÉRIFIER LA RELEASE

Contrôler la disponibilité de `TEST-SEAM` et `TEST-INJECTION` sur le système cible. Si la syntaxe n’est pas supportée, utiliser une interface injectable ou une autre technique compatible. Ne copier pas l’exemple sans contrôle syntaxique.

### 21.F.2 ÉTAPE 2 — ISOLER UNE DÉPENDANCE PRÉCISE

Choisir un accès direct difficile à contrôler : lecture de configuration, date ou appel legacy. Encadrer uniquement cette zone avec un nom de seam stable. Ne pas englober la logique métier que le test doit réellement exécuter.

### 21.F.3 ÉTAPE 3 — CONSERVER UN COMPORTEMENT PRODUCTIF INCHANGÉ

Placer le code existant entre `TEST-SEAM` et `END-TEST-SEAM` sans modifier sa sémantique. Contrôler et activer. Exécuter les tests fonctionnels avant d’ajouter l’injection.

### 21.F.4 ÉTAPE 4 — CRÉER L’INJECTION DANS LE TEST

Dans la méthode `FOR TESTING`, déclarer `TEST-INJECTION` avec le même nom et affecter un résultat déterministe. Fournir uniquement les données que le seam productif aurait produites.

### 21.F.5 ÉTAPE 5 — APPELER LE CODE ET ASSERTIR

Exécuter la méthode publique du composant ; l’injection remplace le seam pendant ce test. Vérifier le résultat observable. Ajouter un autre test avec une injection différente pour les erreurs ou valeurs limites.

### 21.F.6 ÉTAPE 6 — PLANIFIER LA REFACTORISATION

Documenter la dépendance masquée par le seam. Lorsqu’une évolution le permet, extraire une interface et injecter l’implémentation au constructeur. Retirer alors seam et injections après équivalence des tests.

## 21.G Références SAP officielles

- [ABAP Keyword Documentation — TEST-INJECTION](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTEST-INJECTION_SHORTREF.html)
- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)

## 21.H VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 21.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 21.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Isoler cet accès direct uniquement pour tester le code existant.
TEST-SEAM read_configuration.
  SELECT SINGLE value
    FROM zdev_config
    WHERE config_key = @iv_key
    INTO @rv_value.
END-TEST-SEAM.
```

## 21.K TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
