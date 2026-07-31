# 🌸 EXÉCUTION ARRIÈRE-PLAN, REPRISE ET DIAGNOSTIC

## 🌺 OBJECTIFS

- Exploiter une interface sans présence utilisateur
- Diagnostiquer les échecs
- Appliquer une checklist de livraison

## 🌺 ARRIÈRE-PLAN

Un job de fond ne dispose pas du poste utilisateur. Toute dépendance à `CL_GUI_FRONTEND_SERVICES` doit être supprimée du chemin automatique.

Vérifier :

- l’utilisateur du job ;
- ses autorisations `S_DATASET` et `S_PATH` ;
- l’instance d’exécution ;
- la visibilité du répertoire ;
- les variantes ;
- les horaires de dépôt ;
- la concurrence entre jobs.

## 🌺 DIAGNOSTIC

| Symptôme              | Vérification                                                 |
| --------------------- | ------------------------------------------------------------ |
| Fichier introuvable   | Nom logique, instance, chemin, date de dépôt                 |
| Ouverture refusée     | Autorisations SAP et OS                                      |
| Caractères incorrects | Encodage, BOM, double conversion                             |
| Fichier partiel       | Dump, arrêt de job, espace disque, fermeture                 |
| Doublons              | Identifiant de lot, reprise, commit                          |
| Fichier bloqué        | Producteur encore en écriture, verrou externe                |
| Job vert sans données | Critères, fichier vide, erreurs uniquement en log applicatif |

## 🌺 JOURNALISATION

Le journal doit contenir :

- nom logique et nom physique ;
- identifiant du lot ;
- heure de début et de fin ;
- nombre de lignes lues, acceptées et rejetées ;
- objets métier créés ou modifiés ;
- messages techniques et métier ;
- statut final et action de reprise.

Utiliser le journal applicatif lorsque l’interface doit être exploitée par les équipes support, plutôt que de dépendre uniquement de la liste du job.

## 🌺 CHECKLIST

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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Authorization for File Access — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/dc545b5a743047b6b468bbadd0085ce2.html)
- [Physical and Logical File Names — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/9e49819d5b2a440fb508772494b9a473.html)
- [Files on the Presentation Server — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFRONTEND_FILES.html)
