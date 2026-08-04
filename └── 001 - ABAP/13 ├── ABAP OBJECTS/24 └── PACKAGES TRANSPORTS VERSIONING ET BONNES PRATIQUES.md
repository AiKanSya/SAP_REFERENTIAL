# PACKAGES, TRANSPORTS, VERSIONING ET BONNES PRATIQUES

## RÉSULTAT ATTENDU

- Intégrer les classes globales dans un package cohérent.
- Transporter toutes les dépendances nécessaires.
- Comparer les versions et limiter les ruptures d’API.
- Appliquer une checklist avant livraison.

## PACKAGE

Une classe globale doit appartenir au package du domaine qu’elle sert. Les interfaces, exceptions et classes concrètes associées doivent suivre une organisation cohérente. Les dépendances entre packages doivent être intentionnelles.

## TRANSPORT

Lors d’une modification :

1. vérifier le package de la classe ;
2. affecter la modification à l’ordre de transport correct ;
3. inclure les interfaces, exceptions et objets DDIC créés ;
4. contrôler la liste d’objets de l’ordre ;
5. activer tous les objets dépendants ;
6. exécuter les tests avant libération ;
7. vérifier l’import sur le système cible.

## COMPATIBILITÉ DE L’API

Modifications à risque :

- suppression ou renommage d’une méthode publique ;
- ajout d’un paramètre obligatoire ;
- modification incompatible d’un type public ;
- nouvelle exception déclarée imposant une gestion aux appelants ;
- changement d’instanciation publique vers privée ;
- passage d’une classe extensible à `FINAL`.

Préférer une évolution compatible lorsque cela est possible : nouveau paramètre optionnel, nouvelle méthode, nouvelle interface versionnée ou adaptateur.

## PROCÉDURE DE CONTRÔLE AVANT LIVRAISON

1. Contrôler la syntaxe et activer la classe complète.
2. Exécuter ABAP Unit.
3. Exécuter ATC ou SCI avec la variante projet.
4. Consulter la liste des utilisations des composants modifiés.
5. Tester les cas nominaux et erreurs.
6. Vérifier les autorisations et données utilisées.
7. Contrôler l’ordre de transport.
8. Documenter le changement fonctionnel et technique.
9. Préparer un scénario de non-régression.

## CHECKLIST À COPIER

```text
Classe / interface        :
Package                    :
Ordre de transport        :
API publique modifiée     : Oui / Non
Liste des utilisations    : Contrôlée / Non contrôlée
ABAP Unit                 : OK / KO / Non applicable
ATC ou SCI                : OK / KO
Test nominal              : OK / KO
Tests d'erreur            : OK / KO
Dépendances transportées  : Oui / Non
Documentation mise à jour : Oui / Non
```

## BONNES PRATIQUES SYNTHÉTIQUES

- Concevoir d’abord le contrat, puis l’implémentation.
- Préférer les classes globales pour les services réutilisables.
- Dépendre d’interfaces lorsque plusieurs implémentations ou tests sont attendus.
- Garder les attributs privés.
- Utiliser l’héritage seulement pour une vraie relation de spécialisation.
- Préférer la composition et l’injection de dépendances.
- Utiliser Factory ou Singleton uniquement pour un problème réel de création ou d’unicité.
- Ne jamais masquer un `COMMIT WORK` dans une méthode métier sans contrat explicite.
- Documenter les effets, exceptions et contraintes de version.

## CRITÈRE DE FIN DE DOSSIER

Le lecteur doit être capable de créer dans `SE24` une classe globale transportable, définir son API, injecter ses dépendances, implémenter une interface, gérer ses exceptions, choisir un pattern adapté et fournir un test reproductible.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Class Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/a602ff71a47c441bb3000504ec938fea/cac035baa6c611d1b4790000e8a52bed.html)
- [ABAP Code Documentation — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/documenting-abap-code_ad565c7e-6ac5-4a49-95e2-e4c33268dac6)
- [Improving Code Quality using ABAP Test Cockpit — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/improving-code-quality-using-abap-test-cockpit_dd1d868f-a539-49ee-8e49-e57563131058)
