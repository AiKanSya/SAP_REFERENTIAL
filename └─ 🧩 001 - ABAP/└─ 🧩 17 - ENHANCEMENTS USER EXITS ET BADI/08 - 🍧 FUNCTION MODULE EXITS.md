# 🌸 FUNCTION MODULE EXITS

## 🌺 OBJECTIFS

- Comprendre l’appel `CALL CUSTOMER-FUNCTION`
- Implémenter le code dans l’include client prévu
- Respecter l’interface et le contexte transactionnel

## 🌺 PRINCIPE

Le standard appelle un module fonction d’exit, souvent nommé selon le modèle `EXIT_<programme>_<numéro>`. Ce module expose une interface et contient un include client destiné à l’implémentation.

```mermaid
flowchart LR
    A["Programme SAP"] --> B["CALL CUSTOMER-FUNCTION"]
    B --> C["Module EXIT fourni par SAP"]
    C --> D["Include client ZX..."]
    D --> E["Classe de logique client"]
```

## 🌺 IMPLÉMENTATION

Ne pas modifier le module `EXIT_*`. Depuis le composant du projet `CMOD`, ouvrir l’include client et déléguer le traitement :

```abap
zcl_dev_customer_exit=>process(
  EXPORTING
    is_header = i_header
  CHANGING
    cs_item   = c_item ).
```

Les noms de paramètres sont définis par SAP. Ne pas supposer qu’un paramètre `CHANGING` peut être modifié sans vérifier son usage après le retour.

## 🌺 GESTION DES ERREURS

- utiliser les messages autorisés par le contrat de l’exit ;
- éviter un dump pour une erreur fonctionnelle attendue ;
- ne pas déclencher de commit ;
- ne pas lancer une mise à jour indépendante qui survivrait à un rollback du standard ;
- conserver un temps d’exécution faible si l’exit est appelé dans une boucle.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nCMOD`.
2. Créer ou afficher un projet client Z.
3. Affecter l’enhancement `SMOD` validé.
4. Implémenter les composants nécessaires dans les includes client.
5. Activer les composants puis le projet.
6. Tester le scénario avec un breakpoint et vérifier qu’aucun autre projet actif ne provoque de conflit.

## 🌺 VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
zcl_dev_customer_exit=>process(
  EXPORTING
    is_header = i_header
  CHANGING
    cs_item   = c_item ).
```

## 🌺 TERMES DU LEXIQUE

- [BAdI](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-badi>)
- [BTE](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/03 - 🍧 REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Types of Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975e643b111d1896f0000e8322d00.html)
- [Customer Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975cc43b111d1896f0000e8322d00.html)
- [Customer Exits (CMOD) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525722.html)


---

➡️ [Chapitre suivant — SCREEN EXITS](<./09 - 🍧 SCREEN EXITS.md>)
