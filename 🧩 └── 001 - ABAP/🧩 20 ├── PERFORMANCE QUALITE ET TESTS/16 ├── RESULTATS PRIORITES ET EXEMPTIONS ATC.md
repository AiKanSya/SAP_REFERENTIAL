# RESULTATS PRIORITES ET EXEMPTIONS ATC

## RÉSULTAT ATTENDU

Traiter les findings ATC selon leur priorité et encadrer strictement les exemptions.

## Priorités

Les findings ATC utilisent des niveaux de priorité. Dans une configuration courante, les priorités 1 et 2 peuvent bloquer la libération des transports, tandis que la priorité 3 est informative ou moins critique. Le comportement exact dépend des réglages du système.

## Ordre de traitement

1. Findings de sécurité et erreurs potentielles.
2. Incompatibilités de release ou d’API.
3. Défauts de performance avérés.
4. Maintenabilité et conventions.
5. Findings faibles ou contextuels.

## Exemption

Une exemption n’est pas une suppression arbitraire. Elle doit contenir :

- justification technique précise ;
- périmètre minimal ;
- durée de validité limitée lorsque possible ;
- approbation par le rôle qualité autorisé ;
- référence au risque accepté.

```mermaid
flowchart TD
    A["Finding ATC"] --> B["Correction possible ?"]
    B -->|"Oui"| C["Corriger et recontrôler"]
    B -->|"Non"| D["Demande d exemption justifiée"]
    D --> E["Évaluation qualité"]
```

## Mauvaises pratiques

- pseudo-commentaire sans analyse ;
- exemption sur tout un package alors qu’un sous-objet suffit ;
- validité illimitée par défaut ;
- justification « faux positif » sans démonstration ;
- demandeur et approbateur confondus lorsque la gouvernance l’interdit.

## Références SAP officielles

- [SAP Help Portal — ATC Quality Checking](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec1a1126e391014adc9fffe4e204223.html)
- [SAP Help Portal — ATC Exemptions](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/3a759579e173410caa551e0d428bd7d6.html)

## PROCESS

### ÉTAPE 1 — OUVRIR LE RUN EXACT

Relever variante, périmètre, date et version analysée. Ouvrir le résultat ATC correspondant à la dernière exécution, pas un run antérieur. Regrouper les findings par priorité, contrôle et objet.

### ÉTAPE 2 — COMPRENDRE LA RÈGLE

Lire la documentation, la ligne source et le contexte. Reproduire si le finding dépend d’un type, d’un appel ou d’une donnée. Distinguer une erreur réelle d’un code standard ou généré hors du périmètre de correction.

### ÉTAPE 3 — CORRIGER LA CAUSE

Modifier le code avec la solution la plus simple respectant la règle. Ajouter ou adapter les tests. Relancer le contrôle sur l’objet pour obtenir un retour rapide, puis sur le périmètre complet.

### ÉTAPE 4 — PRÉPARER UNE EXEMPTION JUSTIFIÉE

Si la correction est impossible ou non applicable, documenter la raison précise, le risque résiduel, la preuve et l’échéance. Définir le propriétaire qui devra réévaluer la décision. Limiter l’exemption à l’objet et au finding nécessaires.

### ÉTAPE 5 — SOUMETTRE ET SUIVRE LA DÉCISION

Utiliser le workflow d’exemption configuré. Ne pas considérer la demande comme acceptée avant décision. Vérifier le statut et les conditions posées par l’approbateur.

### ÉTAPE 6 — RELANCER ET AUDITER

Exécuter ATC sur la version finale et vérifier que les findings corrigés ont disparu et que les exemptions valides sont reconnues. Suivre les échéances ; une exemption expirée redevient un finding à traiter.

## VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## ERREURS FRÉQUENTES

- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

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

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
