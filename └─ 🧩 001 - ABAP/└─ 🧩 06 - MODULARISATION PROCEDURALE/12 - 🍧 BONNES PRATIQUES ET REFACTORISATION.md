# 🌸 BONNES PRATIQUES ET REFACTORISATION

## 🌺 OBJECTIFS

- Évaluer la qualité d’un découpage procédural
- Réduire les dépendances globales
- Transformer un bloc monolithique en procédures cohérentes
- Identifier les syntaxes historiques à ne plus introduire
- Préparer une évolution vers ABAP Objects

## 🌺 CARACTÉRISTIQUES D’UN BON SOUS-PROGRAMME

Un sous-programme maintenable possède généralement :

- une responsabilité unique ;
- un nom orienté action ;
- peu de paramètres ;
- des types explicites ;
- peu ou pas de dépendances globales ;
- une taille permettant de comprendre le traitement sans navigation excessive ;
- un contrat clair sur les sorties et les erreurs.

## 🌺 SIGNAUX DE MAUVAIS DÉCOUPAGE

- noms comme `process`, `do_all` ou `treatment` ;
- dizaine de paramètres `CHANGING` ;
- lecture et modification de nombreuses globales ;
- sous-programme de plusieurs centaines de lignes ;
- indicateurs booléens qui activent plusieurs comportements différents ;
- appel externe vers un autre programme ;
- macro complexe ;
- duplication d’un même bloc dans plusieurs `FORM`.

## 🌺 EXEMPLE MONOLITHIQUE

```abap
START-OF-SELECTION.
  IF p_qty <= 0.
    MESSAGE 'Quantité incorrecte' TYPE 'E'.
  ENDIF.

  IF p_price < 0.
    MESSAGE 'Prix incorrect' TYPE 'E'.
  ENDIF.

  gv_net = p_qty * p_price.
  gv_tax = gv_net * '0.20'.
  gv_gross = gv_net + gv_tax.

  WRITE: / 'Net', gv_net,
         / 'Taxe', gv_tax,
         / 'TTC', gv_gross.
```

## 🌺 EXTRACTION PAR RESPONSABILITÉ

```abap
START-OF-SELECTION.
  PERFORM validate_selection
    USING p_qty p_price.

  PERFORM calculate_amounts
    USING    p_qty p_price
    CHANGING gv_net gv_tax gv_gross.

  PERFORM display_amounts
    USING gv_net gv_tax gv_gross.
```

```mermaid
flowchart LR
    A["Valider"] --> B["Calculer"]
    B --> C["Afficher"]
```

Le programme principal décrit maintenant le scénario. Chaque bloc peut être analysé séparément.

## 🌺 RÉDUIRE LES PARAMÈTRES

Lorsque plusieurs paramètres appartiennent au même concept, utiliser une structure locale clairement typée.

```abap
TYPES: BEGIN OF ty_amounts,
         net   TYPE ty_amount,
         tax   TYPE ty_amount,
         gross TYPE ty_amount,
       END OF ty_amounts.

DATA ls_amounts TYPE ty_amounts.

PERFORM calculate_amounts
  USING    p_qty p_price
  CHANGING ls_amounts.
```

La structure ne doit pas devenir un conteneur générique contenant toutes les données du programme.

## 🌺 ÉLÉMENTS À NE PLUS INTRODUIRE

Dans du nouveau code :

- ne pas utiliser les paramètres `TABLES` des sous-programmes ;
- ne pas créer d’appels externes `PERFORM ... IN PROGRAM` ;
- éviter les appels dynamiques lorsque la cible est connue ;
- éviter les macros métier ;
- ne pas masquer les sorties dans des globales ;
- ne pas multiplier les includes comme substitut à une architecture.

## 🌺 SOUS-PROGRAMMES OU MÉTHODES

Les sous-programmes restent nécessaires pour comprendre et maintenir de nombreux développements classiques SAP GUI.

Pour un nouveau développement, une méthode offre généralement :

- une visibilité contrôlée ;
- une interface nommée ;
- des exceptions de classe ;
- une meilleure encapsulation ;
- des possibilités de test et de réutilisation supérieures.

Le passage aux méthodes sera traité dans le dossier `ABAP OBJECTS`. Il n’implique pas obligatoirement Eclipse : les classes peuvent également être maintenues avec les outils SAP GUI selon le système.

## 🌺 CHECKLIST DE REVUE

- [ ] Chaque sous-programme possède-t-il une seule responsabilité ?
- [ ] Son nom décrit-il une action métier ou technique précise ?
- [ ] Les paramètres sont-ils typés et dans un ordre logique ?
- [ ] Les entrées utilisent-elles `USING` sans modification cachée ?
- [ ] Les sorties utilisent-elles `CHANGING` explicitement ?
- [ ] Les globales modifiées sont-elles réellement nécessaires ?
- [ ] Les includes organisent-ils le code sans masquer les dépendances ?
- [ ] Aucune syntaxe obsolète n’est-elle ajoutée ?
- [ ] Une méthode serait-elle plus adaptée pour un nouveau composant ?

## 🌺 POINTS À RETENIR

- La modularisation n’est utile que si les responsabilités et dépendances deviennent plus claires.
- Les sous-programmes procéduraux sont importants pour la maintenance du code classique.
- Les syntaxes obsolètes doivent être reconnues, mais pas reproduites.
- Les interfaces explicites réduisent les effets de bord.
- Pour les nouveaux composants, les méthodes constituent généralement la cible de conception.

## 🌺 CAS D’USAGE

Dans un contexte où un report devenu long doit être découpé en unités compréhensibles et testables sans modifier son résultat, le besoin consiste à **mesurer le temps d’exécution d’un scénario reproductible**. Cette notion est pertinente lorsque plusieurs solutions sont possibles et il faut retenir celle qui limite les risques de maintenance.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSAT`.
2. Créer ou sélectionner une variante de mesure adaptée.
3. Définir le programme, la transaction ou l’utilisateur à mesurer.
4. Démarrer la mesure puis reproduire une seule fois le scénario.
5. Arrêter et analyser le hit list, la hiérarchie d’appels et les temps nets.
6. Répéter la mesure après correction avec les mêmes données et le même contexte.

## 🌺 VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Créer des sous-programmes avec trop de paramètres globaux.
- Utiliser des appels externes ou dynamiques sans contrôle du nom et de l’existence.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
START-OF-SELECTION.
  IF p_qty <= 0.
    MESSAGE 'Quantité incorrecte' TYPE 'E'.
  ENDIF.

  IF p_price < 0.
    MESSAGE 'Prix incorrect' TYPE 'E'.
  ENDIF.

  gv_net = p_qty * p_price.
  gv_tax = gv_net * '0.20'.
  gv_gross = gv_net + gv_tax.

  WRITE: / 'Net', gv_net,
         / 'Taxe', gv_tax,
         / 'TTC', gv_gross.
```

## 🌺 TERMES DU LEXIQUE

- [Programme exécutable](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Module fonction](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)
- [Source Code Organization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_ORGA_GDL.html)
- [ABAP Objects as a Programming Model — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJ_PROGR_MODEL_GUIDL.html)
- [Naming — ABAP Programming Guidelines](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENNAMING_GDL.html)
