# 10. APPELS DYNAMIQUES ET EXTERNES

## 10.A RÉSULTAT ATTENDU

- Identifier un appel dynamique de sous-programme
- Reconnaître un appel externe
- Comprendre les risques de résolution à l’exécution
- Connaître le statut obsolète des appels externes
- Privilégier des interfaces explicites

## 10.B APPEL STATIQUE INTERNE

Forme recommandée dans un programme procédural existant :

```abap
PERFORM validate_input.
```

Le nom est connu lors du contrôle de syntaxe et le sous-programme appartient au même programme principal.

## 10.C APPEL DYNAMIQUE

Le nom du sous-programme peut être fourni dans une donnée :

```abap
DATA lv_form_name TYPE c LENGTH 30 VALUE 'DISPLAY_RESULT'.

PERFORM (lv_form_name).
```

La cible n’est déterminée qu’à l’exécution.

```mermaid
flowchart TD
    A["Nom contenu dans une variable"] --> B["Résolution à l’exécution"]
    B --> C["Sous-programme valide ?"]
    C -->|"Oui"| D["Exécution"]
    C -->|"Non"| E["Erreur d’exécution ou traitement IF FOUND"]
```

## 10.D APPEL EXTERNE

ABAP[^terme-abap] possède également des variantes permettant d’appeler un sous-programme d’un autre programme.

Exemple de syntaxe historique :

```abap
PERFORM external_form IN PROGRAM z_external_program.
```

Des variantes dynamiques existent également.

## 10.E STATUT ET RECOMMANDATION

La documentation ABAP classe[^terme-classe] les appels externes de sous-programmes parmi les éléments obsolètes. Ils créent une dépendance forte envers l’implémentation interne d’un autre programme.

À la place, utiliser une interface conçue pour être appelée :

- méthode[^terme-methode] publique ;
- module fonction[^terme-module-fonction] ;
- API[^terme-api] ou service adapté au scénario.

## 10.F IF FOUND

Certaines variantes externes ou dynamiques proposent `IF FOUND` afin d’éviter l’arrêt immédiat lorsque la cible n’existe pas.

Cette addition ne transforme pas l’appel en interface sûre :

- la signature peut rester incompatible ;
- le nom n’est pas contrôlé statiquement ;
- la dépendance n’est pas visible dans les usages classiques ;
- le comportement peut changer après transport.

## 10.G POURQUOI CES APPELS SONT FRAGILES

| Risque                             | Conséquence                                    |
| ---------------------------------- | ---------------------------------------------- |
| Nom construit dynamiquement        | Recherche d’usages incomplète                  |
| Programme cible modifié            | Rupture à l’exécution                          |
| Interface positionnelle            | Incompatibilité silencieuse ou erreur runtime  |
| Accès à une implémentation interne | Couplage non contractuel                       |
| Contrôle tardif                    | Défaut détecté uniquement sur certains chemins |

## 10.H MAINTENANCE D’UN CODE EXISTANT

Lorsqu’un appel externe existe déjà :

1. identifier toutes les valeurs possibles du programme et du sous-programme ;
2. vérifier l’interface réelle de chaque cible ;
3. analyser les transports et dépendances ;
4. ajouter des tests sur les branches dynamiques ;
5. préparer une migration vers une interface explicite.

## 10.I POINTS À RETENIR

- Un appel dynamique résout sa cible à l’exécution.
- Un appel externe vise un sous-programme d’un autre programme.
- Les appels externes de sous-programmes sont obsolètes.
- `IF FOUND` réduit un risque d’absence, mais ne sécurise pas l’interface.
- Pour du nouveau code, utiliser des méthodes ou modules fonction selon le besoin.

## 10.J VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 10.K ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Créer des sous-programmes avec trop de paramètres globaux.
- Utiliser des appels externes ou dynamiques sans contrôle du nom et de l’existence.

## 10.L SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lv_form_name TYPE c LENGTH 30 VALUE 'DISPLAY_RESULT'.

PERFORM (lv_form_name).
```

## 10.M TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)

## 10.N RÉFÉRENCES OFFICIELLES SAP

- [PERFORM, External Calls — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPPERFORM_OBSOLETE.html)
- [External Procedure Call — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCALL_PROCEDURES_EXTERN.html)
- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)


---

[Chapitre suivant — DEBUG ET ANALYSE DES APPELS](<./11 ├── DEBUG ET ANALYSE DES APPELS.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-module-fonction]: **MODULE FONCTION.** Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
