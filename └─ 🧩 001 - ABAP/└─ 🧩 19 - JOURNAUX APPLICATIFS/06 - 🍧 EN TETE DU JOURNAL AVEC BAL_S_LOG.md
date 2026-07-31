# 🌸 EN-TÊTE DU JOURNAL AVEC BAL_S_LOG

## 🌺 OBJECTIFS

- Renseigner les données utiles de l’en-tête
- Définir l’identifiant externe et la rétention
- Éviter les champs redondants ou sensibles

## 🌺 STRUCTURE PRINCIPALE

L’en-tête transmis à `BAL_LOG_CREATE` utilise la structure `BAL_S_LOG`.

```abap
DATA ls_log TYPE bal_s_log.

ls_log-object    = 'ZDEV_LOG'.
ls_log-subobject = 'IMPORT'.
ls_log-extnumber = |PRODUCTS_{ sy-datum }_{ sy-uzeit }|.
ls_log-alprog     = sy-repid.
ls_log-date_del   = sy-datum + 90.
ls_log-del_before = abap_true.
```

Les noms exacts des champs disponibles doivent être contrôlés dans `SE11` sur la version du système. Les champs essentiels restent l’objet, le sous-objet et l’identifiant externe.

## 🌺 DATE D’EXPIRATION

Le journal peut posséder :

- une date après laquelle il devient supprimable ;
- un indicateur interdisant sa suppression avant cette date.

Cette information ne supprime pas automatiquement le journal. Elle alimente la stratégie de nettoyage exécutée avec `SLG2`, les programmes de suppression ou l’archivage.

## 🌺 STATUT ET CONTEXTE

L’en-tête peut aussi porter :

- un statut informatif ;
- un contexte applicatif ;
- des paramètres de détail ;
- le programme appelant.

Ne pas dupliquer dans l’en-tête toutes les informations déjà présentes dans les messages. L’en-tête doit permettre d’identifier l’exécution, pas reproduire son contenu complet.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)
- [Set Header Information — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/b962eb9ce95048eea479e6e7b38fb481.html)

---

➡️ [Chapitre suivant — CREER UN JOURNAL AVEC BAL_LOG_CREATE](<./07 - 🍧 CREER UN JOURNAL AVEC BAL_LOG_CREATE.md>)
