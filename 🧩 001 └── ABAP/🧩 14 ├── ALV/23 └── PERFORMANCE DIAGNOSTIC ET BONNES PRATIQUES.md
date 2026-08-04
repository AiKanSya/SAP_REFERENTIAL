# 23. PERFORMANCE, DIAGNOSTIC ET BONNES PRATIQUES

## 23.A RÉSULTAT ATTENDU

- Éviter les principaux problèmes de performance
- Diagnostiquer un comportement incorrect
- Appliquer une checklist de livraison

## 23.B PERFORMANCE DES DONNÉES

L’ALV[^terme-alv] ne corrige pas une sélection inefficace. Avant l’affichage :

- sélectionner uniquement les champs requis ;
- appliquer les filtres dans ABAP[^terme-abap] SQL[^terme-acro-sql] ;
- éviter les accès base dans une boucle ;
- limiter les volumes incompatibles avec une utilisation interactive ;
- construire les textes et indicateurs en une phase maîtrisée.

## 23.C PERFORMANCE DU CONTRÔLE

- Créer la grille une seule fois.
- Utiliser `REFRESH_TABLE_DISPLAY` pour les actualisations.
- Éviter un catalogue excessivement dynamique.
- Ne pas recalculer toutes les lignes dans un handler de cellule si seule une ligne est concernée.
- Conserver les références du conteneur, de la grille et des handlers.

## 23.D DIAGNOSTIC

| Symptôme                    | Vérification                                         |
| --------------------------- | ---------------------------------------------------- |
| Grille vide                 | Table interne[^terme-table-interne], PBO, appel initial                    |
| Colonne absente             | `FIELDNAME`, structure, `TECH`, `NO_OUT`             |
| Événement non déclenché     | `SET HANDLER`, durée de vie du receiver              |
| Valeur saisie non récupérée | `REGISTER_EDIT_EVENT`, `CHECK_CHANGED_DATA`          |
| Mise en page perdue         | clé `DISVARIANT`, `I_SAVE`, reconstruction de grille |
| Position perdue             | `LVC_S_STBL`, mode de rafraîchissement               |
| Erreur frontend[^terme-frontend]             | Control Framework, `FLUSH`, dump ou message système  |

## 23.E PROGRAMMES DE DÉMONSTRATION

Selon la version du système, SAP[^terme-acro-sap] livre des programmes de démonstration ALV, notamment dans les familles `BCALV_*`. Les analyser dans `SE38`[^outil-se38] ou `SE80`[^outil-se80] permet d’observer les événements, l’édition et les styles disponibles sur le système réel.

## 23.F CHECKLIST

- [ ] Technologie choisie selon le besoin
- [ ] Structure de sortie dédiée et lisible
- [ ] Devise et unité correctement référencées
- [ ] Autorisations contrôlées dans le backend[^terme-backend]
- [ ] Gestionnaires d’événements enregistrés une seule fois
- [ ] Modifications transférées avant sauvegarde
- [ ] Sauvegarde transactionnelle explicite
- [ ] Rafraîchissement stable
- [ ] Variantes testées
- [ ] Volume de données maîtrisé
- [ ] Messages issus d’une classe[^terme-classe] de messages
- [ ] Aucun accès base inutile dans les événements

## 23.G VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 23.H ERREURS FRÉQUENTES

- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 23.I TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 23.J RÉFÉRENCES OFFICIELLES SAP

- [ABAP List Viewer (ALV) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694342.html)
- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)
- [Demo Program Information in NetWeaver — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694205.html)
- [refresh_table_display — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/0ab5531ed30911d2b467006094192fe3.html)

[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-table-interne]: **TABLE INTERNE.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-backend]: **BACKEND.** Système serveur qui exécute la logique ABAP et accède aux données. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#backend>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).

[^outil-se38]: **SE38.** Éditeur ABAP classique utilisé pour créer, modifier, vérifier et exécuter des programmes. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
[^outil-se80]: **SE80.** Object Navigator utilisé pour parcourir et maintenir les objets du Repository ABAP. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
