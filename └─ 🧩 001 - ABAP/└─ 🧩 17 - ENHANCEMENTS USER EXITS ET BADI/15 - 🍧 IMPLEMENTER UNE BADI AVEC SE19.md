# 🌸 IMPLÉMENTER UNE BAdI AVEC `SE19`

## 🌺 OBJECTIFS

- Créer une implémentation BAdI client
- Générer ou affecter la classe d’implémentation
- Activer et tester l’ensemble des objets

## 🌺 PROCÉDURE

1. Ouvrir `SE19`.
2. Choisir le mode correspondant au type de BAdI.
3. Saisir la définition BAdI ou l’enhancement spot.
4. Créer l’implémentation dans un package client.
5. Renseigner une description fonctionnelle.
6. Maintenir les valeurs de filtre si nécessaire.
7. Implémenter les méthodes de la classe générée ou affectée.
8. Activer la classe et l’implémentation.
9. Tester le scénario standard.

## 🌺 DÉLÉGATION

Conserver une classe d’implémentation légère :

```abap
METHOD if_ex_zbadi_demo~change_data.
  zcl_dev_badi_service=>change_data(
    EXPORTING
      is_context = is_context
    CHANGING
      cs_data    = cs_data ).
ENDMETHOD.
```

Cette délégation facilite les tests, la réutilisation et la séparation entre contrat SAP et logique client.

## 🌺 ACTIVATION

```mermaid
flowchart TD
    A["Méthodes de classe actives"] --> B["Implémentation BAdI active"]
    B --> C{"Filtres compatibles ?"}
    C -->|"Oui"| D["Implémentation appelée"]
    C -->|"Non"| E["Implémentation ignorée"]
```

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementation of BAdIs in the Enhancement Builder — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12a713d06c531014903e876ccc9a0b0d27/b2873842134bad04e10000000a1550b0.html)
- [How to Implement a BAdI — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/44f518d884056c30e10000000a114a6b.html)
- [Business Add-Ins — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/46a2cfc13d25463b8b9a3d2a3c3ba0d9/8ff2e540f8648431e10000000a1550b0.html)

---

➡️ [Chapitre suivant — BADI CLASSIQUES FILTRES ET USAGE MULTIPLE](<./16 - 🍧 BADI CLASSIQUES FILTRES ET USAGE MULTIPLE.md>)
