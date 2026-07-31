# 🌸 FICHIERS BINAIRES ET `XSTRING`

## 🌺 OBJECTIFS

- Distinguer texte et binaire
- Lire ou écrire des octets sans conversion de caractères
- Utiliser des buffers adaptés

## 🌺 MODE BINAIRE

```abap
OPEN DATASET lv_file
  FOR INPUT
  IN BINARY MODE.
```

En mode binaire, les octets sont transférés sans conversion de code page. Ce mode convient notamment aux fichiers ZIP, PDF, images ou formats propriétaires.

## 🌺 LECTURE PAR BLOCS

```abap
DATA lv_buffer TYPE x LENGTH 4096.
DATA lv_length TYPE i.

OPEN DATASET lv_file FOR INPUT IN BINARY MODE.

DO.
  READ DATASET lv_file
    INTO lv_buffer
    ACTUAL LENGTH lv_length.

  IF sy-subrc <> 0 AND lv_length = 0.
    EXIT.
  ENDIF.

  " Traiter uniquement les lv_length octets utiles
ENDDO.

CLOSE DATASET lv_file.
```

Le dernier bloc peut être partiellement rempli. La longueur réellement lue doit être prise en compte.

## 🌺 `X` ET `XSTRING`

| Type         | Usage                      |
| ------------ | -------------------------- |
| `x LENGTH n` | Buffer de taille fixe      |
| `xstring`    | Séquence binaire dynamique |

Pour les gros fichiers, éviter de charger tout le contenu dans un seul `xstring` sans nécessité. Une lecture par blocs limite la consommation mémoire.

## 🌺 INTERDICTIONS

- Ne pas ouvrir un CSV en mode binaire pour contourner un problème d’encodage.
- Ne pas convertir arbitrairement un PDF en `string`.
- Ne pas supposer que la taille en caractères égale la taille en octets.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [READ DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREAD_DATASET.html)
- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)

---

➡️ [Chapitre suivant — LIRE AVEC READ DATASET](<./09 - 🍧 LIRE AVEC READ DATASET.md>)
