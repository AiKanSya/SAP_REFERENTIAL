# COMPRESSION ZIP AVEC `CL_ABAP_ZIP`

## OBJECTIFS

- Regrouper plusieurs contenus dans une archive ZIP
- Manipuler l’archive en mémoire
- Séparer compression et transport du fichier

## CRÉATION

```abap
DATA lo_zip     TYPE REF TO cl_abap_zip.
DATA lv_content TYPE xstring.
DATA lv_archive TYPE xstring.

CREATE OBJECT lo_zip.

lo_zip->add(
  name    = 'products.csv'
  content = lv_content ).

lv_archive = lo_zip->save( ).
```

Le contenu ajouté doit être binaire (`xstring`). Un texte doit donc être converti dans l’encodage prévu avant compression.

## LECTURE

```abap
CREATE OBJECT lo_zip.
lo_zip->load( zip = lv_archive ).

DATA(lv_file_content) = lo_zip->get( name = 'products.csv' ).
```

Les signatures doivent être vérifiées dans `SE24` selon la version.

## TRANSPORT

`CL_ABAP_ZIP` crée ou lit l’archive en mémoire. Il faut ensuite :

- écrire le `xstring` sur le serveur en mode binaire ;
- ou le télécharger avec `GUI_DOWNLOAD` en mode binaire ;
- ou le transmettre à une API adaptée.

## SÉCURITÉ

Lors de l’extraction :

- contrôler les noms internes ;
- refuser les chemins absolus et `../` ;
- limiter la taille et le nombre d’entrées ;
- ne pas extraire automatiquement vers un chemin construit depuis l’archive.

## PROCÉDURE PAS À PAS

1. Saisir `/nSE24`.
2. Entrer le nom d’une classe globale Z puis choisir **Créer**, ou afficher une classe existante.
3. Maintenir définition, visibilité, types, attributs et méthodes dans les onglets appropriés.
4. Implémenter les méthodes dans l’éditeur.
5. Contrôler et activer la classe complète.
6. Utiliser la fonction de test ou un report Z appelant pour vérifier le comportement.

## VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CREATE OBJECT lo_zip.
lo_zip->load( zip = lv_archive ).

DATA(lv_file_content) = lo_zip->get( name = 'products.csv' ).
```

## TERMES DU LEXIQUE

- [ABAP](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Interface](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)

## RÉFÉRENCES OFFICIELLES SAP

- [CL_ABAP_ZIP Example — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524363.html)
- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [GUI_DOWNLOAD — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/5a005e044eef436f8b27bbd3f73a3cfc/c75ab8ec178c44a8aacd1dcac3460db8.html)


---

[Chapitre suivant — CONCEVOIR UNE INTERFACE D’IMPORT](<./22 ├── CONCEVOIR UNE INTERFACE D IMPORT.md>)
