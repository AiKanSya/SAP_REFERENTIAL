# 🌸 PARAMÈTRES TECHNIQUES ET BUFFERISATION

## 🌺 OBJECTIFS

- Comprendre le rôle des paramètres techniques
- Choisir une classe de données et une catégorie de taille
- Identifier les types de bufferisation
- Évaluer les risques de la journalisation
- Éviter les réglages systématiques sans analyse

## 🌺 ACCÈS AUX PARAMÈTRES TECHNIQUES

Dans `SE11`, ouvrir la table puis accéder aux **Paramètres techniques**.

Ces paramètres influencent la création physique de la table et certains comportements d’accès depuis les serveurs d’application ABAP.

## 🌺 PARAMÈTRES PRINCIPAUX

| Paramètre                     | Fonction                                                            |
| ----------------------------- | ------------------------------------------------------------------- |
| Classe de données             | Catégoriser la nature générale des données                          |
| Catégorie de taille           | Estimer le volume attendu pour l’allocation en base                 |
| Autorisation de bufferisation | Autoriser ou interdire le buffer de table ABAP                      |
| Type de buffer                | Définir la granularité de mise en cache                             |
| Journalisation                | Enregistrer certaines modifications dans `DBTABLOG` sous conditions |

La portée exacte de certains paramètres dépend du système de base de données. Ils doivent néanmoins être renseignés conformément aux règles du système.

## 🌺 BUFFER DE TABLE ABAP

La bufferisation stocke des données de table dans la mémoire du serveur d’application afin d’éviter certains accès répétés à la base.

```mermaid
flowchart LR
    A["Programme ABAP"] --> B["Buffer de table"]
    B -->|"Donnée disponible"| C["Retour sans lecture base"]
    B -->|"Donnée absente"| D["Base de données"]
    D --> B
```

## 🌺 TYPES DE BUFFERISATION CLASSIQUES

| Type                  | Principe                                                               |
| --------------------- | ---------------------------------------------------------------------- |
| Enregistrement unique | Mise en cache de lignes accédées par leur clé complète                 |
| Générique             | Mise en cache de groupes de lignes selon une partie initiale de la clé |
| Intégrale             | Mise en cache de l’ensemble de la table                                |

Le type disponible et son libellé peuvent varier selon la version.

## 🌺 TABLES ADAPTÉES OU NON

La bufferisation est généralement envisagée pour des tables :

- lues fréquemment ;
- modifiées rarement ;
- de volume maîtrisé ;
- dont les données doivent être disponibles avec une cohérence compatible avec le mécanisme de buffer.

Elle est généralement inadaptée aux tables transactionnelles fortement modifiées ou aux très grandes tables.

## 🌺 INVALIDATION ET COHÉRENCE

Une modification invalide les entrées concernées et doit être propagée aux serveurs d’application.

Une mauvaise stratégie peut provoquer :

- des invalidations fréquentes ;
- une consommation mémoire inutile ;
- une baisse de performance ;
- des lectures qui ne bénéficient pas réellement du buffer.

## 🌺 JOURNALISATION

L’option de journalisation peut enregistrer les modifications de tables dans `DBTABLOG`, à condition que les prérequis système soient remplis.

Elle doit être réservée aux données importantes et peu modifiées. Elle génère un volume supplémentaire et peut créer de la contention.

La journalisation technique ne remplace pas une traçabilité applicative complète lorsque celle-ci est exigée par le métier.

## 🌺 POINTS À RETENIR

- Les paramètres techniques participent à la conception de la table.
- La bufferisation concerne le buffer ABAP des serveurs d’application.
- Une table fréquemment modifiée est rarement une bonne candidate.
- La catégorie de taille est une estimation, pas une limite fonctionnelle.
- La journalisation doit être activée de manière ciblée.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSAT`.
2. Créer ou sélectionner une variante de mesure adaptée.
3. Définir le programme, la transaction ou l’utilisateur à mesurer.
4. Démarrer la mesure puis reproduire une seule fois le scénario.
5. Arrêter et analyser le hit list, la hiérarchie d’appels et les temps nets.
6. Répéter la mesure après correction avec les mêmes données et le même contexte.

## 🌺 VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## 🌺 ERREURS FRÉQUENTES

- Modifier un objet standard au lieu d’utiliser une extension.
- Activer une table sans vérifier clé, paramètres techniques et impact base.

## 🌺 FICHE DE CONTRÔLE À COPIER

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

## 🌺 TERMES DU LEXIQUE

- [ABAP Dictionary](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#abap-dictionary>)
- [Domaine](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#domaine>)
- [Élément de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#element-donnees>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Technical Settings — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_740/ec1c9c8191b74de98feb94001a95dd76/cf21eba2446011d189700000e8322d00.html)
- [Creating Database Tables — Technical Table Settings — SAP Learning](https://learning.sap.com/courses/building-data-models-with-the-abap-dictionary-and-abap-core-data-services/creating-database-tables_ebc1477d-96ed-414b-82d4-4171da43f4a6)


---

➡️ [Chapitre suivant — CLÉS ÉTRANGÈRES, TABLES DE CONTRÔLE ET TABLES DE TEXTE](<./10 - 🍧 CLES ETRANGERES TABLES DE CONTROLE ET TABLES DE TEXTE.md>)
