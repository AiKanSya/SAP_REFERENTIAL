# CRÉER UN OBJET D’AUTORISATION

## RÉSULTAT ATTENDU

Créer un objet client dont les champs correspondent exactement à la décision d’autorisation du programme.

## PROCESS

### Étape 1 — Formaliser la décision d’autorisation

Décrire l’action protégée et les dimensions métier nécessaires. Exemple : modifier un document uniquement pour une société donnée.

Un objet ne doit contenir que les champs réellement utilisés par le programme et administrables dans les rôles.

### Étape 2 — Réutiliser les champs standard lorsque leur sens convient

Rechercher d’abord les champs d’autorisation existants dans `SU20`. Réutiliser un champ standard uniquement si sa définition correspond exactement à la dimension métier contrôlée.

Si aucun champ adapté n’existe, créer un champ client dans `SU20` à partir d’un élément de données stable et documenté.

### Étape 3 — Créer l’objet dans `SU21`

Créer l’objet `Z...` dans une classe d’objets pertinente. Ajouter `ACTVT` lorsque la décision varie selon l’activité, puis ajouter uniquement les champs métier définis à l’étape 1.

Documenter pour chaque champ :

- sa signification ;
- les valeurs attendues ;
- les activités utilisables ;
- l’action protégée par le programme.

### Étape 4 — Implémenter le contrôle dans le code

Placer `AUTHORITY-CHECK` avant l’opération protégée et tester immédiatement `SY-SUBRC`.

```abap
CONSTANTS gc_activity_change TYPE activ_auth VALUE '02'.

AUTHORITY-CHECK OBJECT 'Z_DEV_OBJ'
  ID 'ACTVT' FIELD gc_activity_change
  ID 'ZBUKRS' FIELD p_bukrs.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_security) WITH p_bukrs.
ENDIF.
```

Remplacer l’objet, le champ, l’activité et le message par les éléments validés dans `SU21`.

### Étape 5 — Intégrer l’objet au concept de rôles

Transmettre à l’équipe sécurité le nom de l’objet, les activités, les dimensions organisationnelles et les scénarios fonctionnels. L’équipe habilitations maintient ensuite les rôles dans `PFCG` selon le processus du projet.

Les valeurs génériques ne doivent être attribuées que lorsqu’elles correspondent au besoin validé.

### Étape 6 — Tester chaque dimension séparément

Exécuter au minimum :

1. un cas entièrement autorisé ;
2. un refus sur l’activité ;
3. un refus sur chaque champ organisationnel ;
4. un utilisateur possédant une valeur différente ;
5. un contrôle avec valeur initiale si ce cas est possible dans l’application.

Utiliser `STAUTHTRACE` pour confirmer que le programme transmet les valeurs prévues et que le rôle les couvre exactement.

## CONTRÔLE

- Le code et le rôle utilisent les mêmes champs et activités.
- Aucun champ n’est neutralisé avec `DUMMY` sans décision documentée.
- Le programme interrompt l’action protégée lorsque `SY-SUBRC <> 0`.

## RÉFÉRENCES OFFICIELLES SAP

- [Creating Authorization Objects — SAP SE, SAP S/4HANA 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ad77b44570314f6d8c3a8a807273084c/85fe532b277d451f9537b93f09a485d4.html)
- [Creating an Authorization Field and Object — SAP SE, SAP S/4HANA](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/3679ef3995374110ab63971827411cc9.html)
- [Authorization Checks in Your Own Developments — SAP SE, SAP S/4HANA](https://help.sap.com/docs/ABAP_PLATFORM_NEW/88c6b8647c8d40b39eb554e2d7b6bda1/5267167f439b11d1896f0000e8322d00.html)
