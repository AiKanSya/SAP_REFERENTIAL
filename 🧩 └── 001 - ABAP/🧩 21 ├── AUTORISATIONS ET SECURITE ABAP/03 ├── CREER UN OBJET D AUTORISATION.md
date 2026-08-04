# CRÉER UN OBJET D’AUTORISATION

## RÉSULTAT ATTENDU

Créer un objet client dont les champs correspondent exactement à la décision d’autorisation du programme.

## PROCÉDURE RAPIDE

1. Définir les champs nécessaires dans `SU20` lorsqu’aucun champ standard adapté n’existe.
2. Créer l’objet `Z...` dans une classe d’objets avec `SU21`.
3. Ajouter `ACTVT` et uniquement les dimensions métier réellement contrôlées.
4. Documenter les valeurs et activités attendues.
5. Faire intégrer l’objet dans le rôle `PFCG` par l’équipe sécurité.
6. Implémenter `AUTHORITY-CHECK` avec tous les champs pertinents.
7. Tester un cas autorisé et un refus avec `STAUTHTRACE`.

## CONTRÔLE

- Le code et le rôle utilisent les mêmes champs et activités.
- Aucun champ n’est neutralisé avec `DUMMY` sans décision documentée.
- Le programme interrompt l’action protégée lorsque `SY-SUBRC <> 0`.
