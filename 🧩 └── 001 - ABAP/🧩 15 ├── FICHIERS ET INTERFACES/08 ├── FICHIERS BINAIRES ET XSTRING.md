# 8. FICHIERS BINAIRES ET `XSTRING`

## 8.A RÉSULTAT ATTENDU

- Distinguer texte et binaire
- Lire ou écrire des octets sans conversion de caractères
- Utiliser des buffers adaptés

## 8.B MODE BINAIRE

```abap
" Ouvrir le fichier avec le mode et l’encodage attendus.
OPEN DATASET lv_file
  FOR INPUT
  IN BINARY MODE.
```

En mode binaire, les octets sont transférés sans conversion de code page. Ce mode convient notamment aux fichiers ZIP, PDF, images ou formats propriétaires.

## 8.C LECTURE PAR BLOCS

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

## 8.D `X` ET `XSTRING`

| Type         | Usage                      |
| ------------ | -------------------------- |
| `x LENGTH n` | Buffer de taille fixe      |
| `xstring`    | Séquence binaire dynamique |

Pour les gros fichiers, éviter de charger tout le contenu dans un seul `xstring` sans nécessité. Une lecture par blocs limite la consommation mémoire.

## 8.E INTERDICTIONS

- Ne pas ouvrir un CSV en mode binaire pour contourner un problème d’encodage.
- Ne pas convertir arbitrairement un PDF en `string`.
- Ne pas supposer que la taille en caractères égale la taille en octets.

## 8.F PROCESS

### 8.F.1 Étape 1 — Confirmer que le contenu est binaire

Utiliser le mode binaire pour des données dont les octets doivent rester inchangés : archive, image, PDF ou format propriétaire. Ne pas appliquer de conversion de code page.

### 8.F.2 Étape 2 — Fixer une taille maximale

Déterminer la taille maximale acceptée avant de charger le fichier en mémoire. Pour un contenu volumineux, privilégier un traitement par blocs plutôt qu’un `XSTRING` unique.

### 8.F.3 Étape 3 — Ouvrir le dataset en mode binaire

Utiliser `OPEN DATASET ... IN BINARY MODE`, puis traiter l’autorisation et le code retour d’ouverture avant toute lecture ou écriture.

### 8.F.4 Étape 4 — Lire avec la longueur réellement reçue

Appeler `READ DATASET` avec une zone binaire et exploiter `ACTUAL LENGTH` pour distinguer les octets valides du dernier bloc. Arrêter la boucle uniquement sur le code retour de fin.

### 8.F.5 Étape 5 — Écrire les octets sans conversion

Transmettre les blocs dans leur ordre exact. Ne pas convertir le contenu en `STRING` pour le transporter ou le journaliser.

### 8.F.6 Étape 6 — Fermer et contrôler l’intégrité

Fermer le dataset, comparer la taille et, si le contrat le prévoit, une empreinte calculée par le producteur et le consommateur. Tester un fichier vide, un dernier bloc partiel et la taille maximale.

## 8.G VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 8.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 8.I SNIPPET À RÉUTILISER

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

## 8.J TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 8.K RÉFÉRENCES OFFICIELLES SAP

- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [READ DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREAD_DATASET.html)
- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)


---

[Chapitre suivant — LIRE AVEC `READ DATASET`](<./09 ├── LIRE AVEC READ DATASET.md>)
