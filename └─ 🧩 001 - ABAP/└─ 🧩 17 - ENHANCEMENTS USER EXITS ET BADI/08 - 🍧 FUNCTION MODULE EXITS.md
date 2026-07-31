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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Types of Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975e643b111d1896f0000e8322d00.html)
- [Customer Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975cc43b111d1896f0000e8322d00.html)
- [Customer Exits (CMOD) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525722.html)

---

➡️ [Chapitre suivant — SCREEN EXITS](<./09 - 🍧 SCREEN EXITS.md>)
