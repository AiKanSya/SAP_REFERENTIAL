# CONTRÔLER UNE AUTORISATION AVEC `AUTHORITY-CHECK`

## RÉSULTAT ATTENDU

Interrompre une action lorsque l’utilisateur ne possède pas l’activité requise pour l’objet d’autorisation contrôlé.

## PRÉREQUIS

- Objet d’autorisation existant et validé avec l’équipe sécurité.
- Valeurs fonctionnelles à contrôler identifiées.
- Rôle attribué à l’utilisateur de test.

## CODE PRÊT À ADAPTER

Cet exemple contrôle l’autorisation d’affichage sur un objet client fictif.

```abap
" Vérifier l’autorisation avant l’action protégée.
CONSTANTS:
  gc_auth_object TYPE xuobject VALUE 'Z_DEV_OBJ',
  gc_activity     TYPE activ_auth VALUE '03'.

AUTHORITY-CHECK OBJECT gc_auth_object
  ID 'ACTVT' FIELD gc_activity
  ID 'ZBUKRS' FIELD p_bukrs.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_security) WITH p_bukrs.
ENDIF.
```

`ACTVT = '03'` représente habituellement l’affichage. Les activités autorisées doivent être confirmées dans la documentation de l’objet et avec l’équipe chargée des rôles.

## POINTS À REMPLACER

| Élément         | Remplacement attendu           |
| --------------- | ------------------------------ |
| `Z_DEV_OBJ`     | Objet d’autorisation réel      |
| `ZBUKRS`        | Champ défini dans cet objet    |
| `P_BUKRS`       | Valeur fonctionnelle contrôlée |
| `'03'`          | Activité requise               |
| `ZDEV_SECURITY` | Classe de messages du projet   |

## PROCESS

### Étape 1 — Définir précisément l’action protégée

Identifier l’opération à autoriser : affichage, modification, suppression, validation ou exécution. Déterminer aussi les dimensions métier qui restreignent cette opération, par exemple la société, l’organisation commerciale ou le type de document.

Le contrôle doit répondre à une décision explicite : « cet utilisateur peut-il exécuter cette activité sur cette valeur métier ? »

### Étape 2 — Examiner l’objet dans `SU21`

Ouvrir l’objet d’autorisation et relever :

- son nom exact ;
- ses champs ;
- les activités autorisées ;
- la signification fonctionnelle de chaque champ.

Ne pas inventer un identifiant de champ ou une valeur d’activité à partir d’un exemple. Le code doit correspondre à la définition réelle de l’objet.

### Étape 3 — Préparer les valeurs contrôlées

Utiliser des variables typées avec les éléments de données fonctionnels appropriés. Convertir les valeurs dans le format attendu avant le contrôle, notamment en majuscules lorsque le domaine l’exige.

Ne pas remplacer une valeur métier connue par `DUMMY` ou `*`. Ces valeurs élargissent ou neutralisent une partie de la décision d’autorisation.

### Étape 4 — Placer le contrôle avant l’opération sensible

Exécuter `AUTHORITY-CHECK` avant la lecture de données sensibles, la modification ou l’appel protégé. Tous les champs nécessaires à la décision doivent apparaître dans le contrôle.

Un contrôle placé après la lecture ou la modification ne protège pas l’opération déjà exécutée.

### Étape 5 — Traiter immédiatement `SY-SUBRC`

Tester `SY-SUBRC` juste après `AUTHORITY-CHECK`, avant toute autre instruction susceptible de le modifier.

- `SY-SUBRC = 0` : poursuivre l’opération protégée.
- `SY-SUBRC <> 0` : interrompre le traitement et retourner un message adapté.

Le message utilisateur ne doit pas divulguer inutilement le contenu du rôle. Les détails techniques nécessaires au support doivent être conservés dans un journal protégé.

### Étape 6 — Tester les cas positifs et négatifs

Exécuter au minimum les scénarios suivants avec des utilisateurs représentatifs :

1. activité et valeur métier autorisées ;
2. activité refusée ;
3. valeur organisationnelle refusée ;
4. autorisation partielle couvrant une autre valeur.

Après chaque refus, utiliser immédiatement `SU53` ou une trace ciblée `STAUTHTRACE` pour confirmer l’objet, les champs et les valeurs réellement contrôlés.

## CONTRÔLE

- `SY-SUBRC = 0` : l’autorisation demandée a été trouvée dans le contexte utilisateur.
- `SY-SUBRC <> 0` : le contrôle a échoué.
- L’opération protégée ne doit jamais continuer après un échec.
- `SU53` ou `STAUTHTRACE` permet de confirmer l’objet et les valeurs testées.

## ERREURS FRÉQUENTES

| Symptôme                                            | Cause probable                                    | Correction                                                        |
| --------------------------------------------------- | ------------------------------------------------- | ----------------------------------------------------------------- |
| Le contrôle ne protège rien                         | `SY-SUBRC` n’est pas traité                       | Tester le résultat immédiatement                                  |
| Un utilisateur trop large passe le test             | Valeur `DUMMY` ou `*` utilisée sans justification | Contrôler les champs fonctionnels nécessaires                     |
| Refus inattendu                                     | Valeur ou activité incorrecte                     | Comparer le contrôle avec le rôle et la trace                     |
| Autorisation codée en dur dans plusieurs programmes | Contrôles dupliqués                               | Centraliser la politique dans une API du projet lorsque pertinent |
| Données sensibles lues avant le contrôle            | Contrôle placé trop tard                          | Contrôler avant la lecture ou l’action protégée                   |

## COMPATIBILITÉ S/4HANA

- Statut : mécanisme standard du développement ABAP classique.
- Le contrôle technique doit correspondre au concept d’autorisation fonctionnel de l’application.
- Ne pas remplacer un contrôle fin par la seule autorisation de lancer une transaction.

## RÉFÉRENCES OFFICIELLES SAP

- [Authorization Checks in Your Own Developments — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/88c6b8647c8d40b39eb554e2d7b6bda1/5267167f439b11d1896f0000e8322d00.html)
- [Programming Authorization Checks — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c6e6d078ab99452db94ed7b3b7bbcccf/526712ac439b11d1896f0000e8322d00.html)

---

[Chapitre suivant — DIAGNOSTIQUER UN REFUS AVEC SU53 ET STAUTHTRACE](<./02 ├── DIAGNOSTIQUER UN REFUS AVEC SU53 ET STAUTHTRACE.md>)
