# 12. BONNES PRATIQUES ET REFACTORISATION

## 12.A RÉSULTAT ATTENDU

- Évaluer la qualité d’un découpage procédural
- Réduire les dépendances globales
- Transformer un bloc monolithique en procédures cohérentes
- Identifier les syntaxes historiques à ne plus introduire
- Préparer une évolution vers ABAP Objects[^terme-abap-objects]

## 12.B CARACTÉRISTIQUES D’UN BON SOUS-PROGRAMME

Un sous-programme maintenable possède généralement :

- une responsabilité unique ;
- un nom orienté action ;
- peu de paramètres ;
- des types explicites ;
- peu ou pas de dépendances globales ;
- une taille permettant de comprendre le traitement sans navigation excessive ;
- un contrat clair sur les sorties et les erreurs.

## 12.C SIGNAUX DE MAUVAIS DÉCOUPAGE

- noms comme `process`, `do_all` ou `treatment` ;
- dizaine de paramètres `CHANGING` ;
- lecture et modification de nombreuses globales ;
- sous-programme de plusieurs centaines de lignes ;
- indicateurs booléens qui activent plusieurs comportements différents ;
- appel externe vers un autre programme ;
- macro complexe ;
- duplication d’un même bloc dans plusieurs `FORM`.

## 12.D EXEMPLE MONOLITHIQUE

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

## 12.E EXTRACTION PAR RESPONSABILITÉ

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

## 12.F RÉDUIRE LES PARAMÈTRES

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

## 12.G ÉLÉMENTS À NE PLUS INTRODUIRE

Dans du nouveau code :

- ne pas utiliser les paramètres `TABLES` des sous-programmes ;
- ne pas créer d’appels externes `PERFORM ... IN PROGRAM` ;
- éviter les appels dynamiques lorsque la cible est connue ;
- éviter les macros métier ;
- ne pas masquer les sorties dans des globales ;
- ne pas multiplier les includes comme substitut à une architecture.

## 12.H SOUS-PROGRAMMES OU MÉTHODES

Les sous-programmes restent nécessaires pour comprendre et maintenir de nombreux développements classiques SAP GUI[^terme-sap-gui].

Pour un nouveau développement, une méthode[^terme-methode] offre généralement :

- une visibilité[^terme-visibilite] contrôlée ;
- une interface nommée ;
- des exceptions de classe[^terme-classe] ;
- une meilleure encapsulation[^terme-encapsulation] ;
- des possibilités de test et de réutilisation supérieures.

Le passage aux méthodes sera traité dans le dossier `ABAP OBJECTS`. Il n’implique pas obligatoirement Eclipse : les classes peuvent également être maintenues avec les outils SAP GUI selon le système.

## 12.I CHECKLIST DE REVUE

- [ ] Chaque sous-programme possède-t-il une seule responsabilité ?
- [ ] Son nom décrit-il une action métier ou technique précise ?
- [ ] Les paramètres sont-ils typés et dans un ordre logique ?
- [ ] Les entrées utilisent-elles `USING` sans modification cachée ?
- [ ] Les sorties utilisent-elles `CHANGING` explicitement ?
- [ ] Les globales modifiées sont-elles réellement nécessaires ?
- [ ] Les includes organisent-ils le code sans masquer les dépendances ?
- [ ] Aucune syntaxe obsolète n’est-elle ajoutée ?
- [ ] Une méthode serait-elle plus adaptée pour un nouveau composant ?

## 12.J POINTS À RETENIR

- La modularisation n’est utile que si les responsabilités et dépendances deviennent plus claires.
- Les sous-programmes procéduraux sont importants pour la maintenance du code classique.
- Les syntaxes obsolètes doivent être reconnues, mais pas reproduites.
- Les interfaces explicites réduisent les effets de bord.
- Pour les nouveaux composants, les méthodes constituent généralement la cible de conception.

## 12.K PROCESS

### 12.K.1 Étape 1 — Sélectionner un bloc et figer son comportement

Choisir un bloc monolithique limité. Préparer des cas de test couvrant succès, validation en erreur et valeurs limites, puis conserver les sorties et effets de bord actuels.

### 12.K.2 Étape 2 — Repérer les frontières

Marquer séparément validation, calcul, accès aux données et affichage. Relever pour chaque partie les variables globales lues ou modifiées. Une partie qui cumule plusieurs verbes doit encore être divisée.

### 12.K.3 Étape 3 — Extraire la première responsabilité

Créer une procédure au nom explicite, déclarer ses entrées avec `USING` et ses sorties nécessaires avec `CHANGING`, puis déplacer le code sans autre changement fonctionnel. Contrôler et tester immédiatement.

### 12.K.4 Étape 4 — Réduire les dépendances implicites

Remplacer progressivement les lectures de globales par des paramètres typés. Regrouper dans une structure les valeurs appartenant au même concept, sans créer un fourre-tout destiné à contourner l’interface.

### 12.K.5 Étape 5 — Répéter sans mélanger les corrections

Extraire une responsabilité supplémentaire seulement après validation de la précédente. Ne pas combiner refactorisation, changement métier et optimisation dans le même pas : leur cause deviendrait impossible à isoler en cas d’écart.

### 12.K.6 Étape 6 — Valider et décider de la cible

Relancer tous les tests initiaux, comparer les résultats et exécuter les contrôles statiques. Si le traitement doit évoluer ou être testé isolément, planifier sa migration vers une méthode plutôt que multiplier de nouveaux `FORM`.

La refactorisation est terminée lorsque le scénario principal est lisible, les responsabilités sont séparées et aucun résultat fonctionnel n’a changé.

## 12.L VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant[^terme-mandant], transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace[^terme-trace] ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 12.M ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Créer des sous-programmes avec trop de paramètres globaux.
- Utiliser des appels externes ou dynamiques sans contrôle du nom et de l’existence.

## 12.N SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 12.O TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)

## 12.P RÉFÉRENCES OFFICIELLES SAP

- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)
- [Source Code Organization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_ORGA_GDL.html)
- [ABAP Objects as a Programming Model — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJ_PROGR_MODEL_GUIDL.html)
- [Naming — ABAP Programming Guidelines](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENNAMING_GDL.html)

[^terme-abap-objects]: **ABAP OBJECTS.** Extension orientée objet du langage ABAP fournissant classes, interfaces, héritage, événements et exceptions de classe. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap-objects>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-encapsulation]: **ENCAPSULATION.** Principe consistant à protéger l’état interne d’un objet et à imposer son utilisation par une API contrôlée. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#encapsulation>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
