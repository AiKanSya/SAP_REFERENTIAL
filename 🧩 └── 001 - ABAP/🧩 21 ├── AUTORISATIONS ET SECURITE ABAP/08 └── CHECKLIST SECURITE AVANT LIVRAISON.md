# CHECKLIST SÉCURITÉ AVANT LIVRAISON

## RÉSULTAT ATTENDU

Bloquer la livraison d’un développement ABAP qui expose une action ou une donnée sans contrôle suffisant.

## CHECKLIST

- Toutes les actions métier sensibles exécutent un `AUTHORITY-CHECK` et traitent immédiatement son résultat.
- Les contrôles couvrent les dimensions métier, pas seulement `S_TCODE`.
- Les entrées externes sont validées en type, longueur, domaine et volume.
- Les noms dynamiques proviennent d’une liste blanche.
- Aucun secret, mot de passe ou jeton n’est codé en dur ou écrit dans les journaux.
- Aucun chemin de fichier externe n’est utilisé directement.
- Les appels RFC, HTTP et SOAP appliquent des contrôles dans le système cible.
- Les messages utilisateur ne révèlent pas de détails internes inutiles.
- Les données personnelles et financières ne sont pas dupliquées dans les traces.
- Les contrôles `ATC`, `SCI` et les variantes de sécurité du projet sont exécutés.
- Un test négatif prouve le refus pour chaque action protégée.
- `STAUTHTRACE` confirme que les valeurs contrôlées correspondent au concept de rôles.

## CRITÈRE DE SORTIE

Aucune anomalie de sécurité ouverte ne peut être compensée par la seule restriction d’accès à la transaction.
