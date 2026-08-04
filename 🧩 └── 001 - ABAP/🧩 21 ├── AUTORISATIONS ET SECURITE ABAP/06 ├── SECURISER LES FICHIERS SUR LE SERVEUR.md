# 6. SÉCURISER LES FICHIERS SUR LE SERVEUR

## 6.A RÉSULTAT ATTENDU

Limiter une lecture ou écriture applicative aux chemins logiques autorisés et aux contrôles d’autorisation du système.

## 6.B PROCESS

### 6.B.1 Étape 1 — Définir le périmètre du fichier

Déterminer si le programme lit, crée, remplace ou ajoute un fichier. Fixer le répertoire, le format, l’encodage, la taille maximale et la règle de nommage attendus.

Ne pas accepter un chemin physique complet provenant d’un écran, d’un fichier ou d’un appel distant.

### 6.B.2 Étape 2 — Configurer un nom logique dans `FILE`

Créer le chemin logique et le nom de fichier logique correspondant à l’usage applicatif. Associer le format physique propre au système d’exploitation dans la configuration transportable prévue par le projet.

Le programme doit connaître le nom logique autorisé. L’utilisateur ne doit pas pouvoir choisir arbitrairement n’importe quel nom logique.

### 6.B.3 Étape 3 — Résoudre le nom physique avec l’API standard

Appeler `FILE_GET_NAME` et tester immédiatement `SY-SUBRC`.

```abap
CONSTANTS gc_logical_filename TYPE filename-fileintern
  VALUE 'Z_SECURE_EXPORT'.

DATA lv_filename TYPE string.

CALL FUNCTION 'FILE_GET_NAME'
  EXPORTING
    logical_filename = gc_logical_filename
    including_dir    = abap_true
  IMPORTING
    file_name        = lv_filename
  EXCEPTIONS
    file_not_found   = 1
    OTHERS           = 2.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_file).
ENDIF.
```

Ajouter uniquement des paramètres de substitution définis dans la configuration du nom logique. Ne pas concaténer ensuite un autre répertoire au résultat.

### 6.B.4 Étape 4 — Ouvrir le dataset dans un mode explicite

Utiliser le chemin résolu avec `OPEN DATASET`. Préciser le mode, le type et l’encodage adaptés au contrat du fichier.

```abap
TRY.
    OPEN DATASET lv_filename
      FOR OUTPUT IN TEXT MODE ENCODING UTF-8.

    IF sy-subrc <> 0.
      MESSAGE e002(zdev_file).
    ENDIF.

    " Écrire les données validées ici.

    CLOSE DATASET lv_filename.

  CATCH cx_sy_file_authority.
    MESSAGE e003(zdev_file).
ENDTRY.
```

Les contrôles d’autorisation du serveur sont exécutés lors de l’accès au dataset. Ne pas les remplacer par un contrôle manuel isolé.

### 6.B.5 Étape 5 — Traiter les erreurs et garantir la fermeture

Traiter séparément :

- l’échec de résolution du nom logique ;
- le refus d’autorisation ;
- l’échec du système d’exploitation indiqué par `SY-SUBRC` ;
- l’échec de lecture ou d’écriture.

Fermer le dataset sur chaque chemin où l’ouverture a réussi. Ne pas écrire le contenu sensible du fichier dans les messages ou journaux techniques.

### 6.B.6 Étape 6 — Tester avec la configuration réelle

Tester les scénarios suivants sur le système cible :

1. fichier et répertoire autorisés ;
2. utilisateur sans autorisation de dataset ;
3. fichier absent en lecture ;
4. répertoire indisponible ;
5. nom logique mal configuré ;
6. contenu dépassant la limite applicative.

## 6.C CONTRÔLE

- Aucun chemin fourni par l’utilisateur n’est concaténé directement.
- Le fichier reste dans le répertoire autorisé après résolution.
- Le programme ne journalise ni secret ni contenu personnel inutile.

## 6.D RÉFÉRENCES OFFICIELLES SAP

- [Logical File Names — SAP SE, SAP S/4HANA 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7120868b257c4f96b79a2512474ec895/48d59192982b424be10000000a421937.html)
- [File Authorization — SAP SE, SAP S/4HANA 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/dc545b5a743047b6b468bbadd0085ce2.html)
- [File Name Validation — SAP SE, SAP S/4HANA 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/922b318d87f047deb635d505df93f024.html)
