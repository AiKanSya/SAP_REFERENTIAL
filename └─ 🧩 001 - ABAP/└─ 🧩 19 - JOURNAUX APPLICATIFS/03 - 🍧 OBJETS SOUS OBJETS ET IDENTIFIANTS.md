# 🌸 OBJETS, SOUS-OBJETS ET IDENTIFIANTS

## 🌺 OBJECTIFS

- Définir une nomenclature stable
- Utiliser correctement l’objet, le sous-objet et le numéro externe
- Éviter la multiplication incontrôlée des objets de journal

## 🌺 OBJET

L’objet représente un domaine fonctionnel ou une application durable, par exemple :

- `ZMM_MOBILE` pour une application logistique mobile ;
- `ZFI_IMPORT` pour des imports financiers ;
- `ZINT_CPI` pour des traitements d’intégration.

L’objet ne doit pas correspondre à un numéro de ticket, une version ou un programme temporaire.

## 🌺 SOUS-OBJET

Le sous-objet distingue des processus cohérents au sein du domaine :

| Objet        | Sous-objet  | Usage                       |
| ------------ | ----------- | --------------------------- |
| `ZMM_MOBILE` | `CREATE_PR` | Création de demande d’achat |
| `ZMM_MOBILE` | `REASSORT`  | Lecture du réassort         |
| `ZINT_CPI`   | `PRODUCTS`  | Extraction produits         |
| `ZINT_CPI`   | `ORDERS`    | Extraction commandes        |

## 🌺 NUMÉRO EXTERNE

Le champ `EXTNUMBER` doit permettre de retrouver un traitement sans connaître son numéro technique. Il peut contenir :

- un numéro de document ;
- un identifiant d’exécution ;
- un nom de fichier ;
- un identifiant de message d’interface ;
- une combinaison courte et stable.

```abap
ls_log-extnumber = |IMPORT_PRODUCTS_{ sy-datum }_{ sy-uzeit }|.
```

## 🌺 RÈGLES

- garder la même sémantique pour un objet dans tous les programmes ;
- ne pas mettre de données sensibles dans l’identifiant externe ;
- éviter les identifiants trop longs ou impossibles à rechercher ;
- documenter la convention de nommage dans le dépôt technique ;
- réutiliser un objet existant si le domaine et les autorisations sont identiques.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)
- [Analyze Logs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21048535d44180e10000000a15822b.html)

---

➡️ [Chapitre suivant — CREER UN OBJET AVEC SLG0](<./04 - 🍧 CREER UN OBJET AVEC SLG0.md>)
