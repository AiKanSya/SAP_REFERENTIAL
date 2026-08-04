# USER EXITS DANS LES PROGRAMMES STANDARD

## OBJECTIFS

- Reconnaître un user exit historique codé dans un programme SAP
- Comprendre son mode d’implémentation
- Éviter la modification directe du programme principal

## PRINCIPE

Dans certaines applications classiques, SAP fournit des routines ou includes dédiés au code client. Elles peuvent porter un nom tel que `USEREXIT_*` et être appelées depuis le flux standard.

Exemple de forme historique :

```abap
FORM userexit_prepare_data.
  " Déléguer la logique à une classe client
  zcl_dev_extension=>prepare_data(
    CHANGING
      cs_data = gs_data ).
ENDFORM.
```

Le nom, l’emplacement et les paramètres dépendent de l’application. Ne pas créer arbitrairement une routine `USEREXIT_*` : elle doit déjà être appelée par le standard.

## CARACTÉRISTIQUES

- technologie liée à une application précise ;
- interface souvent constituée de données globales du programme ;
- forte dépendance au contexte d’exécution ;
- faible isolation par rapport au standard ;
- transport du code client comme objet Repository.

## PRÉCAUTIONS

- vérifier l’appel par breakpoint ;
- ne modifier que l’include client prévu ;
- ne pas dépendre de variables globales non documentées sans contrôle ;
- ne pas interrompre le flux standard par `MESSAGE A`, `LEAVE` ou commit sans nécessité ;
- encapsuler le traitement dans une classe client ;
- documenter la transaction et l’événement métier concernés.

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
FORM userexit_prepare_data.
  " Déléguer la logique à une classe client
  zcl_dev_extension=>prepare_data(
    CHANGING
      cs_data = gs_data ).
ENDFORM.
```

## TERMES DU LEXIQUE

- [BAdI](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## RÉFÉRENCES OFFICIELLES SAP

- [Enhancements, User Exits and Customer Exits — SAP Help Portal](https://help.sap.com/docs/btp/ABAP/3353526313.html)
- [Enhancements and Modifications — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353523593.html)


---

[Chapitre suivant — CUSTOMER EXITS ET ENHANCEMENTS CLASSIQUES](<./05 ├── CUSTOMER EXITS ET ENHANCEMENTS CLASSIQUES.md>)
