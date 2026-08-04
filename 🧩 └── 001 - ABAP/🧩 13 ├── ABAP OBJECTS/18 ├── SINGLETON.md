# ENCADRER L’USAGE D’UN SINGLETON

## RÉSULTAT ATTENDU

- Implémenter un Singleton uniquement lorsqu’une instance unique par session interne est requise.
- Garantir une instance unique par session interne.
- Savoir quand ne pas utiliser ce pattern.

## DÉFINITION

Un Singleton contrôle sa propre instanciation et retourne toujours la même instance pendant une session interne ABAP. Il utilise généralement :

- une instanciation privée ;
- un attribut statique contenant la référence ;
- une méthode statique `GET_INSTANCE`.

```mermaid
flowchart TD
    A["GET_INSTANCE"] --> B{"Instance déjà créée ?"}
    B -->|"Non"| C["Créer et mémoriser"]
    B -->|"Oui"| D["Réutiliser"]
    C --> E["Retourner la référence"]
    D --> E
```

## PROCESS

### Étape 1 — Justifier l’unicité

Vérifier que le processus exige réellement une seule instance par session interne. Si le besoin est seulement de partager une dépendance, préférer l’injection explicite.

### Étape 2 — Fermer l’instanciation

Créer `ZCL_DEV_APP_CONTEXT` et définir l’instanciation privée. Vérifier depuis un report que `NEW zcl_dev_app_context( )` est interdit.

### Étape 3 — Stocker l’instance

Créer l’attribut de classe privé `GO_INSTANCE TYPE REF TO zcl_dev_app_context`. Créer la méthode de classe publique `GET_INSTANCE` avec une référence de même type en `RETURNING`.

### Étape 4 — Implémenter la création paresseuse

Si `GO_INSTANCE` n’est pas liée, créer l’objet ; retourner ensuite la référence existante. Ne placer pas dans le singleton un état utilisateur qui devrait être isolé par opération.

### Étape 5 — Tester portée et identité

Appeler deux fois et comparer les références. Relancer dans une nouvelle session interne pour vérifier la portée réelle. Le singleton est validé uniquement si cette portée correspond au besoin documenté.

## CODE PRÊT À ADAPTER

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
CLASS zcl_dev_app_context DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS get_instance
      RETURNING VALUE(ro_instance) TYPE REF TO zcl_dev_app_context.

    METHODS get_run_id
      RETURNING VALUE(rv_run_id) TYPE sysuuid_c32.

  PRIVATE SECTION.
    CLASS-DATA go_instance TYPE REF TO zcl_dev_app_context.
    DATA mv_run_id TYPE sysuuid_c32.

    METHODS constructor.
ENDCLASS.

CLASS zcl_dev_app_context IMPLEMENTATION.
  METHOD constructor.
    TRY.
        mv_run_id = cl_system_uuid=>create_uuid_c32_static( ).
      CATCH cx_uuid_error.
        CLEAR mv_run_id.
    ENDTRY.
  ENDMETHOD.

  METHOD get_instance.
    IF go_instance IS NOT BOUND.
      go_instance = NEW zcl_dev_app_context( ).
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.

  METHOD get_run_id.
    rv_run_id = mv_run_id.
  ENDMETHOD.
ENDCLASS.
```

Test :

```abap
DATA(lo_first)  = zcl_dev_app_context=>get_instance( ).
DATA(lo_second) = zcl_dev_app_context=>get_instance( ).
ASSERT lo_first = lo_second.
```

## LIMITES

Un Singleton est un état global masqué. Il complique les tests, le parallélisme et la réinitialisation. Il est pertinent pour une ressource réellement unique dans la session, pas pour éviter de transmettre une dépendance.

## CONTRÔLE

- `NEW zcl_dev_app_context( )` est interdit hors de la classe.
- Deux appels retournent la même référence.
- Une nouvelle session interne peut créer une autre instance.
- Le Singleton ne contient pas d’état utilisateur persistant supposé partagé entre systèmes ou processus.

## ERREURS FRÉQUENTES

- Considérer le Singleton comme unique dans tout le système SAP.
- Stocker des données métier sensibles dans un attribut statique.
- Utiliser le pattern à la place d’une injection de dépendances.

## COMPATIBILITÉ S/4HANA

- Statut : compatible, mais à usage limité.
- L’instance est unique dans une session interne ABAP, pas dans le système, le mandant, un cluster ou plusieurs processus de travail.
- Préférer l’injection de dépendances lorsque l’objectif est seulement de partager ou remplacer un service.
- Ne pas utiliser un Singleton comme cache distribué ni comme stockage persistant.

## RÉFÉRENCES OFFICIELLES SAP

- [Static Classes and Singletons — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSTATIC_CLASS_SINGLETON_GUIDL.html)
- [ABAP Objects Design Patterns - Singleton — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapobjects/3353525629.html)
- [Singleton Classes — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524225.html)

---

[Chapitre suivant — COMPOSITION ET DÉLÉGATION](<./19 ├── COMPOSITION ET DELEGATION.md>)
