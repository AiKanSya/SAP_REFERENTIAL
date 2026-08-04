# 3. PUBLIER, TESTER ET ACTIVER UN SERVICE V4

## 3.A RÉSULTAT ATTENDU

Distinguer publication locale de développement et activation du service dans les systèmes cibles.

## 3.B PUBLICATION LOCALE

Dans l’éditeur du service binding actif, **Publish** crée un endpoint local permettant de tester le service. Le preview valide rapidement le metadata et les annotations UI ; il ne remplace ni les tests d’API ni les tests d’autorisation.

## 3.C PROCESS

1. Activer la service definition et le binding.
2. Publier localement dans le système de développement.
3. Tester `$metadata` et les entity sets.
4. Tester les actions, validations, déterminations et verrouillages du business object.
5. Tester avec un utilisateur sans droits de développement.
6. Exécuter ABAP Unit et ATC sur les artefacts RAP.
7. Transporter les objets de conception.
8. Dans chaque système cible, appliquer la procédure d’activation Gateway correspondant au type de binding et à la version de la plateforme.

## 3.D CONTRÔLE NÉGATIF

- Binding inactif : publication impossible ou endpoint invalide.
- Service non activé dans la cible : l’existence du binding transporté ne suffit pas.
- DCL ou autorisation refusée : aucune donnée ne doit être exposée par contournement.
- Modification concurrente : le comportement RAP doit retourner l’erreur prévue.

## 3.E COMPATIBILITÉ

La granularité de publication diffère entre bindings V2 et V4. Pour V4, la publication locale porte sur le service binding. Toujours vérifier la documentation de la version ABAP Platform cible.

## 3.F RÉFÉRENCES OFFICIELLES SAP

- [Service Binding — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-rap/service-binding)
- [Working with OData V4 Service — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-development-tools-for-visual-studio-code/working-with-odata-v4-service-a449458b1816492eb972ae5728ca2a28)
