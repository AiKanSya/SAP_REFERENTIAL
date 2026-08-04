# VARIANTES ET PARAMÈTRES DE SÉLECTION

## RÉSULTAT ATTENDU

- Fournir des valeurs reproductibles à un rapport
- Séparer la configuration d’exécution du code
- Éviter les variantes ambiguës ou dangereuses

## RÔLE

Une variante mémorise les valeurs d’un écran de sélection. Pour un rapport doté d’un écran de sélection, elle constitue le mécanisme standard permettant de transmettre les paramètres à une étape ABAP planifiée depuis les transactions de jobs.

## PROCESS

### ÉTAPE 1 — OUVRIR LA MAINTENANCE DES VARIANTES

Dans `SE38` ou `SA38`, saisir le programme actif puis ouvrir la maintenance des variantes. Vérifier que l’écran de sélection correspond à la version du report planifiée. Ne pas copier une variante d’un autre programme ou environnement sans contrôler chaque champ.

### ÉTAPE 2 — RENSEIGNER LE PÉRIMÈTRE

Saisir les dates, plages, options et modes prévus par l’exploitation. Limiter les sélections vides ou génériques qui pourraient traiter un volume non borné. Utiliser un chemin logique ou un identifiant de configuration plutôt qu’un chemin physique codé dans la variante.

### ÉTAPE 3 — CONFIGURER LES VALEURS DYNAMIQUES

Pour les dates calculées, choisir la variable de sélection adaptée et vérifier son aperçu. Tester son résultat aux changements de mois, d’année et de calendrier si pertinent. Une description comme « date du jour » doit être confirmée par la valeur réellement résolue à l’exécution.

### ÉTAPE 4 — ENREGISTRER AVEC UN NOM EXPLICITE

Utiliser la convention du projet et renseigner la description. Protéger la variante ou ses champs uniquement selon la gouvernance définie. Documenter le propriétaire et l’usage afin qu’une modification ultérieure soit analysable.

### ÉTAPE 5 — TESTER LA VARIANTE EN DIALOGUE

Exécuter le report avec un mode test ou un faible périmètre. Vérifier les paramètres effectifs, le volume sélectionné et les sorties. Tester aussi une valeur dynamique à la date d’exécution prévue, pas seulement au jour de création.

### ÉTAPE 6 — AFFECTER ET CONTRÔLER DANS LE JOB

Dans `SM36`, affecter la variante à l’étape ABAP. Enregistrer puis ouvrir le job dans `SM37` pour confirmer le nom du programme et de la variante. Avant production, comparer la variante du système cible, car son contenu peut différer entre environnements.

## BON NOMMAGE

```text
Z_<DOMAINE>_<TRAITEMENT>_<FREQUENCE>_<ENVIRONNEMENT>
```

Exemple :

```text
Z_FI_EXPORT_FACTURES_DAILY_PROD
```

## VALEURS DYNAMIQUES

Les variables de sélection permettent de calculer certaines dates à l’exécution. Leur comportement doit être testé sur le système cible, notamment pour :

- date du jour ;
- début ou fin de période ;
- jours ouvrés ;
- variables issues de tables de variantes.

## RISQUES

- intervalle trop large provoquant une charge excessive ;
- variante modifiée sans validation ;
- variante de test réutilisée en production ;
- dates fixes devenues obsolètes ;
- absence de contrôle des paramètres dans le programme.

La variante ne remplace pas les validations métier du rapport.

## VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## ERREURS FRÉQUENTES

- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## FICHE DE CONTRÔLE À COPIER

```text
Système / SID       :
Mandant             :
Utilisateur         :
Transaction / outil :
Objet technique     :
Jeu de données      :
Résultat attendu    :
Résultat observé    :
Horodatage          :
Ordre de transport  :
```

## TERMES DU LEXIQUE

- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)

## RÉFÉRENCES OFFICIELLES SAP

- [Variant Maintenance — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/c0980374e58611d194cc00a0c94260a5.html)
- [Background Work Processes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b3c3e8eb51780e10000000a42189c.html)

---

[Chapitre suivant — PLANIFIER UN JOB AVEC `SM36`](<./06 ├── PLANIFIER UN JOB AVEC SM36.md>)
