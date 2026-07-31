# 🌸 ANALYSER UN ENHANCEMENT AVEC `SMOD`

## 🌺 OBJECTIFS

- Afficher la définition d’un enhancement classique
- Examiner ses composants et sa documentation
- Retrouver les objets techniques appelés

## 🌺 PROCÉDURE

1. Ouvrir `SMOD`.
2. Saisir le nom de l’enhancement ou utiliser la recherche.
3. Afficher la documentation.
4. Ouvrir la liste des composants.
5. Pour chaque composant, analyser le programme, le groupe de fonctions, l’écran ou le code fonction.
6. Vérifier le point d’appel dans le code standard.
7. Rechercher le projet `CMOD` éventuellement associé.

## 🌺 INFORMATIONS À RELEVER

| Information          | Utilité                              |
| -------------------- | ------------------------------------ |
| Nom de l’enhancement | Référence fonctionnelle et transport |
| Package              | Recherche d’objets liés              |
| Composants           | Périmètre technique réel             |
| Documentation        | Contrat prévu par SAP                |
| Paramètres           | Données disponibles et modifiables   |
| Programme appelant   | Moment exact de l’appel              |
| Projet actif         | Implémentation réellement exécutée   |

## 🌺 RECHERCHE PAR PACKAGE

Lorsque le nom est inconnu, utiliser `SE84` ou la recherche étendue de `SMOD`. Une recherche par transaction doit être complétée par l’analyse du programme réellement exécuté.

## 🌺 CONTRÔLE PAR DEBUG

Placer un breakpoint dans le module `EXIT_*` ou dans l’include client. Vérifier :

- l’ordre des appels ;
- les valeurs importées ;
- les données modifiables ;
- les validations exécutées après l’exit ;
- le contexte de mise à jour.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Customer Exits (CMOD) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525722.html)
- [Ways to Find a User Exit — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525969.html)
- [Activating User Exits — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/83f4631d77654e14800e31b17fe9bd45/4c3a1afc9995677ae10000000a42189b.html)

---

➡️ [Chapitre suivant — CREER ET ACTIVER UN PROJET CMOD](<./07 - 🍧 CREER ET ACTIVER UN PROJET CMOD.md>)
