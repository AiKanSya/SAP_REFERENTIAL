# POINTS D’ENHANCEMENT EXPLICITES

## RÉSULTAT ATTENDU

- Distinguer `ENHANCEMENT-POINT` et `ENHANCEMENT-SECTION`
- Créer un source code plug-in sur une option publiée
- Évaluer le risque d’un remplacement de section

## ENHANCEMENT POINT

Un point explicite désigne une position où le code d’une implémentation est ajouté.

Définition côté fournisseur :

```abap
ENHANCEMENT-POINT ep_validate SPOTS es_demo.
```

Implémentation client affichée dans l’éditeur :

```abap
ENHANCEMENT 1 zdev_validate.
  zcl_dev_extension=>validate( ).
ENDENHANCEMENT.
```

## ENHANCEMENT SECTION

Une section explicite encadre un bloc standard qui peut être remplacé par l’implémentation. Le code client ne complète pas le bloc : il le substitue.

```mermaid
flowchart LR
    A["Enhancement point"] --> B["Ajout de code"]
    C["Enhancement section"] --> D["Remplacement du bloc standard"]
```

Le remplacement augmente le risque de perdre des corrections ou évolutions apportées ultérieurement au bloc standard. Il doit être justifié et revu lors des upgrades.

## STATIC ET DYNAMIC

Certaines options sont statiques et interviennent dans les parties déclaratives ; d’autres sont dynamiques et interviennent dans le flux d’exécution. Respecter le contexte syntaxique de l’option.

## PROCÉDURE PAS À PAS

1. Saisir `/nSE80`.
2. Sélectionner le type d’objet ou le package dans la liste de gauche.
3. Entrer le nom technique puis valider.
4. Commencer en mode **Afficher** pour analyser l’objet et ses sous-objets.
5. Passer en modification uniquement dans un système et un objet autorisés.
6. Contrôler la syntaxe, activer les objets modifiés puis vérifier leur statut actif.

## VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
ENHANCEMENT 1 zdev_validate.
  zcl_dev_extension=>validate( ).
ENDENHANCEMENT.
```

## TERMES DU LEXIQUE

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## RÉFÉRENCES OFFICIELLES SAP

- [Explicit Enhancement Options — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/56ee9441026aae5fe10000000a1550b0.html)
- [ABAP Source Code Enhancements — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/46a2cfc13d25463b8b9a3d2a3c3ba0d9/a047e94086087e7fe10000000a1550b0.html)
- [Source Code Plug-Ins — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/e5dca35db39546569b2a35a359f816b4.html)


---

[Chapitre suivant — OPTIONS D’ENHANCEMENT IMPLICITES](<./19 ├── OPTIONS D ENHANCEMENT IMPLICITES.md>)
