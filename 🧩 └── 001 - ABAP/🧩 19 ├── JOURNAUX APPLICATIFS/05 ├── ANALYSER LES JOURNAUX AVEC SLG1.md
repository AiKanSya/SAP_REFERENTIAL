# ANALYSER LES JOURNAUX AVEC SLG1

## RÉSULTAT ATTENDU

- Rechercher efficacement un journal
- Lire les niveaux d’information disponibles
- Constituer une méthode de diagnostic reproductible

## CRITÈRES PRINCIPAUX

La transaction `SLG1` permet de filtrer notamment par :

- objet et sous-objet ;
- identifiant externe ;
- période et heure de création ;
- utilisateur ;
- transaction ou programme ;
- classe du journal ;
- mode de création, par exemple dialogue ou batch.

## MÉTHODE DE RECHERCHE

```mermaid
flowchart TD
    A["Objet et sous-objet connus"] --> B["Limiter la période"]
    B --> C["Ajouter l identifiant externe"]
    C --> D["Exécuter la sélection"]
    D --> E["Ouvrir le journal"]
    E --> F["Lire message long et données techniques"]
```

Toujours commencer par une période courte. Une sélection sans objet ni restriction temporelle peut charger un volume important.

## LECTURE DU RÉSULTAT

L’affichage standard présente :

- l’en-tête du journal ;
- une arborescence ou une liste de messages ;
- le texte court ;
- le texte long T100 lorsqu’il existe ;
- les informations techniques du message ;
- le contexte ou les paramètres complémentaires si l’application les fournit.

## DIAGNOSTIC

Pour chaque anomalie, relever :

1. objet et sous-objet ;
2. identifiant externe ;
3. date, heure et utilisateur ;
4. programme ou transaction ;
5. premier message d’erreur ;
6. messages précédents expliquant le contexte ;
7. données techniques du message.

## PROCÉDURE PAS À PAS

1. Saisir `/nSLG1`.
2. Renseigner objet, sous-objet, identifiant externe, utilisateur et période selon les informations du traitement.
3. Exécuter la recherche.
4. Ouvrir le journal correspondant au bon horodatage.
5. Analyser l’en-tête, les niveaux de gravité et le contexte des messages.
6. Exporter ou transmettre uniquement les informations nécessaires, sans données sensibles inutiles.

## VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## ERREURS FRÉQUENTES

- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

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

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## RÉFÉRENCES OFFICIELLES SAP

- [Analyze Logs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21048535d44180e10000000a15822b.html)
- [Displaying Logs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/addb96cd90c945dfb3182865363bbc47/4e21041a35d44180e10000000a15822b.html)
- [Application Log – User Guidelines — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/f63dd39a28bb4b90adbf9e608aff58ea/4e23ac220771417fe10000000a15822b.html)


---

[Chapitre suivant — EN-TÊTE DU JOURNAL AVEC BAL_S_LOG](<./06 ├── EN TETE DU JOURNAL AVEC BAL_S_LOG.md>)
