# 🌸 TABLE DE SORTIE ET CATALOGUE DE CHAMPS

## 🌺 OBJECTIFS

- Construire une table de sortie stable
- Définir un catalogue `LVC_T_FCAT`
- Gérer textes, références et propriétés de colonnes

## 🌺 TABLE DE SORTIE

La table affichée doit représenter le contrat entre le programme et l’ALV. Éviter d’afficher directement une table de base lorsqu’une structure dédiée permet de :

- renommer les champs ;
- ajouter des indicateurs ;
- calculer des valeurs ;
- stocker styles et couleurs ;
- isoler le modèle d’affichage du modèle persistant.

## 🌺 CATALOGUE MANUEL

```abap
DATA:
  gt_fieldcat TYPE lvc_t_fcat,
  gs_fieldcat TYPE lvc_s_fcat.

CLEAR gs_fieldcat.
gs_fieldcat-fieldname = 'CARRID'.
gs_fieldcat-coltext   = 'Compagnie'.
gs_fieldcat-key       = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.

CLEAR gs_fieldcat.
gs_fieldcat-fieldname  = 'PRICE'.
gs_fieldcat-coltext    = 'Prix'.
gs_fieldcat-ref_table  = 'SFLIGHT'.
gs_fieldcat-ref_field  = 'PRICE'.
gs_fieldcat-cfieldname = 'CURRENCY'.
gs_fieldcat-do_sum     = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.
```

## 🌺 PROPRIÉTÉS IMPORTANTES

| Champ                      | Fonction                     |
| -------------------------- | ---------------------------- |
| `FIELDNAME`                | Champ de la table de sortie  |
| `REF_TABLE`, `REF_FIELD`   | Référence DDIC               |
| `COLTEXT`                  | Texte de colonne             |
| `KEY`                      | Colonne clé                  |
| `EDIT`                     | Colonne modifiable           |
| `HOTSPOT`                  | Zone cliquable               |
| `CHECKBOX`                 | Affichage case à cocher      |
| `ICON`                     | Interprétation comme icône   |
| `NO_OUT`                   | Colonne masquée initialement |
| `TECH`                     | Colonne technique            |
| `DO_SUM`                   | Totalisation                 |
| `CFIELDNAME`, `QFIELDNAME` | Devise ou unité associée     |

## 🌺 GÉNÉRATION AUTOMATIQUE

Lorsque la table de sortie correspond à une structure DDIC, `I_STRUCTURE_NAME` peut éviter un catalogue manuel. Ne fournir un catalogue explicite que lorsque des propriétés doivent être adaptées.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [The Field Catalog — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebaa38d251e56a4e10000000a421937.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)

---

➡️ [Chapitre suivant — LAYOUT ET VARIANTES DU GRID](<./13 - 🍧 LAYOUT ET VARIANTES DU GRID.md>)
