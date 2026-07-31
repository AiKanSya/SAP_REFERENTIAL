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

## 🌺 CAS D’USAGE

Dans un contexte où SAP échange un fichier structuré avec une application externe et doit garantir format, encodage, sécurité et reprise, le besoin consiste à **concevoir ou exécuter fichiers binaires et `xstring` en contrôlant emplacement, format, encodage, sécurité et reprise**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **concevoir ou exécuter fichiers binaires et `xstring` en contrôlant emplacement, format, encodage, sécurité et reprise**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [READ DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREAD_DATASET.html)
- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)


---

➡️ [Chapitre suivant — LIRE AVEC `READ DATASET`](<./09 - 🍧 LIRE AVEC READ DATASET.md>)
