# 14. VARIANTES DE SÉLECTION

## 14.A RÉSULTAT ATTENDU

- Comprendre le rôle d’une variante
- Enregistrer un jeu de valeurs réutilisable
- Distinguer variante et variante d’affichage ALV
- Préparer une exécution récurrente ou en arrière-plan
- Gérer l’évolution du programme sans casser les variantes

## 14.B DÉFINITION

Une variante de sélection enregistre des valeurs et propriétés de l’écran de sélection d’un programme exécutable.

```mermaid
flowchart LR
    A["Programme"] --> B["Écran de sélection"]
    C["Variante"] --> B
    B --> D["Exécution reproductible"]
```

Une variante de sélection ne doit pas être confondue avec une variante de mise en page ALV.

## 14.C PROCESS

Depuis l’écran de sélection :

### 14.C.1 Étape 1 — Préparer une sélection représentative

Ouvrir le programme dans le système et le mandant cibles. Saisir toutes les valeurs à mémoriser, y compris intervalles et exclusions, puis vérifier le récapitulatif de sélection avant l’enregistrement.

### 14.C.2 Étape 2 — Enregistrer la variante

Ouvrir la fonction **Variantes → Sauvegarder comme variante** depuis l’écran. Saisir un nom conforme à la convention, une description fonctionnelle et, si requis, le propriétaire ou le périmètre de protection.

### 14.C.3 Étape 3 — Définir les attributs des champs

Pour chaque champ, décider s’il doit être protégé, masqué, obligatoire ou alimenté dynamiquement. Ne protéger une valeur que si l’utilisateur ne doit réellement pas l’adapter.

### 14.C.4 Étape 4 — Sauvegarder et recharger

Enregistrer, quitter le programme puis le relancer en choisissant la variante. Comparer chaque paramètre et chaque ligne de `SELECT-OPTIONS` avec les valeurs préparées.

### 14.C.5 Étape 5 — Tester l’exécution réelle

Exécuter avec la variante et contrôler le périmètre traité. Pour une utilisation en job, tester la variante avec l’utilisateur d’exécution prévu et vérifier qu’aucune variable de sélection n’est résolue différemment.

La variante est validée lorsque son rechargement restitue exactement le périmètre autorisé et que son exécution produit le même résultat qu’une saisie manuelle équivalente.

La maintenance est également accessible depuis les fonctions de variantes de `SE38` ou `SA38`.

## 14.D USAGES

- exécutions manuelles répétitives ;
- jobs d’arrière-plan ;
- transactions associées à une variante ;
- appels `SUBMIT USING SELECTION-SET` ;
- jeux de test reproductibles.

## 14.E VALEURS DYNAMIQUES

Selon les possibilités du système et les attributs de variante, certaines valeurs peuvent être calculées dynamiquement, notamment des dates.

Ne pas remplacer une règle métier complexe par une configuration de variante incompréhensible. Documenter les variables utilisées.

## 14.F ÉVOLUTION DU PROGRAMME

Une modification de l’écran peut affecter les variantes existantes :

- renommage d’un paramètre ;
- changement de type ;
- suppression d’un champ ;
- ajout d’un champ obligatoire ;
- modification des règles de validation.

Prévoir la compatibilité lors des évolutions productives.

## 14.G SÉCURITÉ

Ne jamais enregistrer dans une variante :

- mot de passe ;
- jeton ;
- secret technique ;
- donnée sensible sans justification et protection appropriée.

Une variante facilite l’entrée de valeurs ; elle ne crée aucune autorisation.

## 14.H TRANSPORT

Les possibilités de transport des variantes dépendent du type de variante, de son propriétaire et des procédures du système. Utiliser les fonctions standard de maintenance et l’ordre de transport prévu par le projet.

## 14.I VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 14.J ERREURS FRÉQUENTES

- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 14.K FICHE DE CONTRÔLE À COPIER

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

## 14.L TERMES DU LEXIQUE

- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 14.M RÉFÉRENCES OFFICIELLES SAP

- [Variant Maintenance — SAP Help Portal](https://help.sap.com/saphelp_ewm900/helpdata/en/c0/980374e58611d194cc00a0c94260a5/content.htm)
- [Understanding the Concept of Background Processing — SAP Learning](https://learning.sap.com/courses/technical-implementation-and-operation-ii-of-sap-s-4hana-and-sap-business-suite/understanding-the-concept-of-background-processing-1)
- [SUBMIT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSUBMIT_SHORTREF.html)

---

[Chapitre suivant — APPEL D’UN RAPPORT AVEC SUBMIT](<./15 ├── APPEL D UN RAPPORT AVEC SUBMIT.md>)
