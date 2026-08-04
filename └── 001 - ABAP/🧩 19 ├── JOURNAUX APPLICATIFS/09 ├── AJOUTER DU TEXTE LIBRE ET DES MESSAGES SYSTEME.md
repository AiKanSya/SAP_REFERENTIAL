# AJOUTER DU TEXTE LIBRE ET DES MESSAGES SYSTÈME

## OBJECTIFS

- Ajouter un texte qui ne provient pas d’une classe de messages
- Connaître les limites du texte libre
- Choisir entre T100 et texte libre

## TEXTE LIBRE

```abap
DATA lv_text TYPE c LENGTH 200.

lv_text = |Fichier { lv_filename } ouvert avec succès|.

CALL FUNCTION 'BAL_LOG_MSG_ADD_FREE_TEXT'
  EXPORTING
    i_log_handle     = lv_log_handle
    i_msgty          = 'I'
    i_probclass      = '4'
    i_text           = lv_text
  EXCEPTIONS
    log_not_found    = 1
    msg_inconsistent = 2
    log_is_full      = 3
    OTHERS           = 4.
```

## CHOIX

| Critère            | Message T100                             | Texte libre                                  |
| ------------------ | ---------------------------------------- | -------------------------------------------- |
| Traduction         | Native                                   | À gérer dans le code ou les symboles texte   |
| Texte long         | Possible                                 | Non standard                                 |
| Réutilisation      | Forte                                    | Faible                                       |
| Données techniques | Classe et numéro                         | Principalement le texte                      |
| Usage recommandé   | Messages fonctionnels et erreurs stables | Diagnostic ponctuel ou information dynamique |

## RECOMMANDATION

Utiliser T100 pour les messages susceptibles d’être montrés aux utilisateurs, documentés ou recherchés régulièrement. Réserver le texte libre aux informations techniques dont le contenu est fortement dynamique.

Ne jamais enregistrer directement :

- mots de passe ;
- jetons ;
- secrets techniques ;
- données bancaires complètes ;
- contenu métier sensible non nécessaire au diagnostic.

## VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lv_text TYPE c LENGTH 200.

lv_text = |Fichier { lv_filename } ouvert avec succès|.

CALL FUNCTION 'BAL_LOG_MSG_ADD_FREE_TEXT'
  EXPORTING
    i_log_handle     = lv_log_handle
    i_msgty          = 'I'
    i_probclass      = '4'
    i_text           = lv_text
  EXCEPTIONS
    log_not_found    = 1
    msg_inconsistent = 2
    log_is_full      = 3
    OTHERS           = 4.
```

## TERMES DU LEXIQUE

- [Application Log](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## RÉFÉRENCES OFFICIELLES SAP

- [Basics — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21029235d44180e10000000a15822b.html)
- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)


---

[Chapitre suivant — AJOUTER DES EXCEPTIONS](<./10 ├── AJOUTER DES EXCEPTIONS.md>)
