# EXÉCUTION ARRIÈRE-PLAN, REPRISE ET DIAGNOSTIC

## OBJECTIFS

- Exploiter une interface sans présence utilisateur
- Diagnostiquer les échecs
- Appliquer une checklist de livraison

## ARRIÈRE-PLAN

Un job de fond ne dispose pas du poste utilisateur. Toute dépendance à `CL_GUI_FRONTEND_SERVICES` doit être supprimée du chemin automatique.

Vérifier :

- l’utilisateur du job ;
- ses autorisations `S_DATASET` et `S_PATH` ;
- l’instance d’exécution ;
- la visibilité du répertoire ;
- les variantes ;
- les horaires de dépôt ;
- la concurrence entre jobs.

## DIAGNOSTIC

| Symptôme              | Vérification                                                 |
| --------------------- | ------------------------------------------------------------ |
| Fichier introuvable   | Nom logique, instance, chemin, date de dépôt                 |
| Ouverture refusée     | Autorisations SAP et OS                                      |
| Caractères incorrects | Encodage, BOM, double conversion                             |
| Fichier partiel       | Dump, arrêt de job, espace disque, fermeture                 |
| Doublons              | Identifiant de lot, reprise, commit                          |
| Fichier bloqué        | Producteur encore en écriture, verrou externe                |
| Job vert sans données | Critères, fichier vide, erreurs uniquement en log applicatif |

## JOURNALISATION

Le journal doit contenir :

- nom logique et nom physique ;
- identifiant du lot ;
- heure de début et de fin ;
- nombre de lignes lues, acceptées et rejetées ;
- objets métier créés ou modifiés ;
- messages techniques et métier ;
- statut final et action de reprise.

Utiliser le journal applicatif lorsque l’interface doit être exploitée par les équipes support, plutôt que de dépendre uniquement de la liste du job.

## CHECKLIST

- [ ] Emplacement serveur ou frontend justifié
- [ ] Aucun chemin physique codé en dur
- [ ] Encodage et format documentés
- [ ] Autorisations testées avec l’utilisateur réel
- [ ] Fichier fermé dans tous les chemins
- [ ] Volume et mémoire maîtrisés
- [ ] Numéros de ligne conservés
- [ ] Doublons et reprise définis
- [ ] Succès partiel défini
- [ ] Publication d’un fichier complet uniquement
- [ ] Archive et purge définies
- [ ] Logs exploitables sans débogage
- [ ] Test DEV, QAS et exécution en job

## PROCÉDURE PAS À PAS

1. Lire la définition et identifier les prérequis du chapitre.
2. Choisir un objet Z ou un scénario de démonstration sans impact métier.
3. Reproduire l’exemple dans un système de développement et relever les données d’entrée.
4. Contrôler la syntaxe ou la configuration avant activation/exécution.
5. Comparer le résultat observé avec la section **Vérification**.
6. Documenter toute différence liée à la release, aux autorisations ou au paramétrage du système.

## VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## ERREURS FRÉQUENTES

- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## TERMES DU LEXIQUE

- [Interface](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Authorization for File Access — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/dc545b5a743047b6b468bbadd0085ce2.html)
- [Physical and Logical File Names — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/9e49819d5b2a440fb508772494b9a473.html)
- [Files on the Presentation Server — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFRONTEND_FILES.html)
