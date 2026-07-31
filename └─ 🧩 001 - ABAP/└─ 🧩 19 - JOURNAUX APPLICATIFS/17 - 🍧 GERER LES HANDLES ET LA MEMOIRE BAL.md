# 🌸 GÉRER LES HANDLES ET LA MÉMOIRE BAL

## 🌺 OBJECTIFS

- Comprendre la mémoire globale utilisée par le framework
- Éviter les mélanges de journaux
- Libérer les données devenues inutiles

## 🌺 MÉMOIRE GLOBALE

Le framework BAL maintient des journaux et messages en mémoire. Cette mémoire peut contenir plusieurs journaux créés ou chargés par différents composants exécutés dans la même session interne.

## 🌺 FONCTIONS UTILES

| Fonction                 | Usage                                              |
| ------------------------ | -------------------------------------------------- |
| `BAL_LOG_EXIST`          | Vérifier qu’un journal existe en mémoire           |
| `BAL_LOG_REFRESH`        | Retirer un journal de la mémoire                   |
| `BAL_GLB_MEMORY_REFRESH` | Réinitialiser tout ou partie de la mémoire globale |
| `BAL_GLB_SEARCH_LOG`     | Rechercher les journaux en mémoire                 |
| `BAL_GLB_SEARCH_MSG`     | Rechercher les messages en mémoire                 |
| `BAL_LOG_HDR_READ`       | Lire l’en-tête                                     |
| `BAL_LOG_MSG_READ`       | Lire un message                                    |

## 🌺 RÈGLE D’ISOLATION

Toujours transmettre explicitement le handle. Plusieurs fonctions acceptent un handle facultatif et utilisent alors un journal par défaut. Cette simplification devient dangereuse dès que plusieurs journaux coexistent.

```abap
CALL FUNCTION 'BAL_LOG_MSG_ADD'
  EXPORTING
    i_log_handle = mv_log_handle
    i_s_msg      = ls_msg
  EXCEPTIONS
    OTHERS       = 1.
```

## 🌺 NETTOYAGE

Après sauvegarde et affichage, retirer le journal de la mémoire lorsqu’il n’est plus utile. Ne pas appeler `BAL_GLB_MEMORY_REFRESH` depuis une bibliothèque générique sans connaître les autres journaux chargés par l’application.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)
- [Basics — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21029235d44180e10000000a15822b.html)

---

➡️ [Chapitre suivant — INTEGRER LE JOURNAL AUX JOBS ET PROGRAMMES BATCH](<./18 - 🍧 INTEGRER LE JOURNAL AUX JOBS ET PROGRAMMES BATCH.md>)
