# 4. LANGAGE ET DÉVELOPPEMENT ABAP

Définitions fondamentales du langage ABAP et de la programmation orientée objet sur la plateforme ABAP.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="abap"></a>
## 4.A ABAP

**Définition.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP.

**Exemple.** Un report ABAP peut lire des données, appliquer des règles et produire une liste.

**Repère pratique.** Dans SAP GUI, le code classique est notamment maintenu avec `SE38`, `SE80`, `SE24` ou `SE37` selon l’objet.

**À distinguer de.** ABAP est le langage ; SAP GUI est un client utilisateur.


---

<a id="abap-objects"></a>
## 4.B ABAP OBJECTS

**Définition.** Extension orientée objet du langage ABAP fournissant classes, interfaces, héritage, événements et exceptions de classe.

**Exemple.** Une classe globale `ZCL_ORDER_SERVICE` implémente une interface `ZIF_ORDER_SERVICE` et collabore avec d’autres objets.

**Repère pratique.** Concevoir les composants réutilisables sous forme de classes globales et limiter les classes locales aux détails internes ou aux tests.

**À distinguer de.** ABAP Objects désigne les mécanismes orientés objet du langage ; `SE24` est l’outil SAP GUI utilisé pour gérer les objets globaux associés.


---

<a id="adapter"></a>
## 4.C ADAPTER

**Définition.** Pattern structurel qui adapte l’interface d’un composant existant à l’interface attendue par le code appelant.

**Exemple.** `ZCL_LEGACY_ADAPTER` implémente `ZIF_CUSTOMER_READER` et traduit les appels vers une API historique.

**Repère pratique.** Créer l’adapter lorsque le composant existant ne peut pas être modifié ou lorsque son interface ne doit pas se propager dans le reste de l’application.

**À distinguer de.** Un adapter rend deux interfaces compatibles ; une façade simplifie l’accès à un ensemble de services.


---

<a id="api-publique"></a>
## 4.D API PUBLIQUE

**Définition.** Ensemble des composants publics qu’une classe expose à ses consommateurs : méthodes, événements, types, constantes et attributs publics.

**Exemple.** La méthode publique `CREATE_ORDER` constitue une opération de l’API d’une classe de service.

**Repère pratique.** Limiter l’API publique au strict nécessaire et conserver l’implémentation interne dans les sections `PRIVATE` ou `PROTECTED`.

**À distinguer de.** La visibilité publique ne signifie pas que le composant est stable ou officiellement publié comme API SAP.


---

<a id="attribut"></a>
## 4.E ATTRIBUT

**Définition.** Composant de données déclaré dans une classe et appartenant soit à chaque instance, soit à la classe elle-même.

**Exemple.** `mv_status` stocke l’état d’une instance ; `CLASS-DATA gv_count` stocke une valeur commune à la classe dans la session interne.

**Repère pratique.** Préférer les attributs privés et fournir des méthodes métier plutôt que d’exposer directement l’état modifiable.

**À distinguer de.** Un attribut contient un état ; une méthode exécute un comportement.


---

<a id="classe"></a>
## 4.F CLASSE

**Définition.** Modèle orienté objet définissant état et comportements.

**Exemple.** `ZCL_ORDER_SERVICE` peut encapsuler la validation d’une commande.

**Repère pratique.** Créer une classe globale avec `SE24` ou une classe locale dans un programme.

**À distinguer de.** Une classe est une définition ; une instance est un objet créé à l’exécution.


---

<a id="classe-abstraite"></a>
## 4.G CLASSE ABSTRAITE

**Définition.** Classe déclarée `ABSTRACT` qui ne peut pas être instanciée directement et qui sert de base à des sous-classes.

**Exemple.** Une classe abstraite de traitement définit un algorithme commun et laisse une étape spécifique à ses sous-classes.

**Repère pratique.** Utiliser une classe abstraite lorsqu’un comportement commun et un état partagé doivent être factorisés.

**À distinguer de.** Une interface définit principalement un contrat ; une classe abstraite peut aussi fournir un état et une implémentation partielle.


---

<a id="classe-finale"></a>
## 4.H CLASSE FINALE

**Définition.** Classe déclarée `FINAL` qui ne peut pas être utilisée comme super-classe.

**Exemple.** Une classe utilitaire ou une implémentation dont le comportement ne doit pas être redéfini peut être finale.

**Repère pratique.** Déclarer une classe finale lorsque l’héritage n’est pas prévu ou compromettrait ses invariants.

**À distinguer de.** `FINAL` sur une classe interdit l’héritage ; `FINAL` sur une méthode interdit uniquement sa redéfinition.


---

<a id="composition"></a>
## 4.I COMPOSITION

**Définition.** Relation dans laquelle une classe réalise son comportement en contenant ou en utilisant d’autres objets spécialisés.

**Exemple.** `ZCL_ORDER_SERVICE` utilise une référence `ZIF_ORDER_REPOSITORY` pour accéder aux commandes.

**Repère pratique.** Préférer la composition à l’héritage lorsque la relation métier n’est pas réellement de type « est un ».

**À distinguer de.** La composition assemble des collaborateurs ; l’héritage spécialise une classe existante.


---

<a id="constructeur-classe"></a>
## 4.J CONSTRUCTEUR DE CLASSE

**Définition.** Méthode statique spéciale `CLASS_CONSTRUCTOR`, appelée automatiquement une seule fois avant le premier accès actif à la classe dans une session interne.

**Exemple.** Le constructeur de classe initialise une table de constantes calculées utilisée par toutes les instances.

**Repère pratique.** Réserver ce constructeur aux initialisations statiques courtes, déterministes et sans interaction utilisateur.

**À distinguer de.** Le constructeur de classe initialise la classe ; `CONSTRUCTOR` initialise chaque nouvelle instance.


---

<a id="constructeur-instance"></a>
## 4.K CONSTRUCTEUR D’INSTANCE

**Définition.** Méthode spéciale `CONSTRUCTOR`, exécutée automatiquement lors de la création d’un objet avec `NEW` ou `CREATE OBJECT`.

**Exemple.** Le constructeur reçoit une dépendance obligatoire et vérifie qu’elle est liée.

**Repère pratique.** Établir les invariants nécessaires pour que l’objet soit utilisable immédiatement après sa création.

**À distinguer de.** Le constructeur ne doit pas être confondu avec une méthode de fabrique, qui décide quelle instance créer.


---

<a id="delegation"></a>
## 4.L DÉLÉGATION

**Définition.** Technique par laquelle une méthode transmet tout ou partie d’un traitement à un objet collaborateur.

**Exemple.** Une façade délègue la validation, l’enregistrement et la journalisation à trois services distincts.

**Repère pratique.** Utiliser la délégation pour répartir les responsabilités sans créer une hiérarchie d’héritage artificielle.

**À distinguer de.** La délégation est un mécanisme d’appel ; la composition décrit la relation structurelle entre les objets.


---

<a id="dependance-objet"></a>
## 4.M DÉPENDANCE OBJET

**Définition.** Objet ou service dont une classe a besoin pour exécuter sa responsabilité.

**Exemple.** Un service de commande dépend d’un repository et d’un journal applicatif.

**Repère pratique.** Exprimer les dépendances par des interfaces et les rendre visibles dans le constructeur lorsque leur présence est obligatoire.

**À distinguer de.** Une dépendance n’est pas nécessairement une sous-classe ni un composant statique.


---

<a id="down-cast"></a>
## 4.N DOWN CAST

**Définition.** Conversion contrôlée d’une référence de type général vers un type plus spécifique compatible avec l’objet réel.

**Exemple.** `CAST zcl_child( lo_parent )` récupère une référence spécialisée lorsque l’objet référencé est bien une instance de `ZCL_CHILD`.

**Repère pratique.** Éviter les down casts fréquents ; ils indiquent souvent que le contrat abstrait ne fournit pas l’opération nécessaire.

**À distinguer de.** L’up cast vers un type plus général est implicite et sûr ; le down cast peut échouer à l’exécution.


---

<a id="encapsulation"></a>
## 4.O ENCAPSULATION

**Définition.** Principe consistant à protéger l’état interne d’un objet et à imposer son utilisation par une API contrôlée.

**Exemple.** Le solde reste privé et ne peut être modifié que par les méthodes `DEBIT` et `CREDIT`.

**Repère pratique.** Déclarer les attributs modifiables dans la section privée et valider les règles métier dans les méthodes.

**À distinguer de.** L’encapsulation ne signifie pas simplement regrouper du code dans une classe.


---

<a id="evenement-objet"></a>
## 4.P ÉVÉNEMENT OBJET

**Définition.** Notification déclarée par une classe ou une interface et déclenchée avec `RAISE EVENT` afin d’informer des gestionnaires enregistrés.

**Exemple.** Une classe d’import déclenche l’événement `COMPLETED` après le traitement du fichier.

**Repère pratique.** Utiliser un événement lorsque l’émetteur ne doit pas connaître directement les traitements réalisés par les abonnés.

**À distinguer de.** Un événement ne retourne pas de valeur comme une méthode fonctionnelle.


---

<a id="exception"></a>
## 4.Q EXCEPTION

**Définition.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter.

**Exemple.** Une conversion exacte peut lever une exception si la valeur ne peut pas être représentée.

**Repère pratique.** Utiliser `TRY ... CATCH` et documenter les exceptions propagées.

**À distinguer de.** `sy-subrc` est un code retour, pas une exception de classe.


---

<a id="expression"></a>
## 4.R EXPRESSION

**Définition.** Construction qui produit une valeur à partir d’opérandes et d’opérateurs.

**Exemple.** `lv_net + lv_tax` est une expression arithmétique.

**Repère pratique.** Vérifier les types et les conversions implicites ou explicites.

**À distinguer de.** Une expression n’est pas nécessairement une instruction complète.


---

<a id="facade"></a>
## 4.S FAÇADE

**Définition.** Pattern fournissant une interface simplifiée devant plusieurs composants ou sous-systèmes.

**Exemple.** `ZCL_ORDER_FACADE` expose une méthode `PROCESS` qui coordonne validation, sauvegarde et journalisation.

**Repère pratique.** Créer une façade pour stabiliser le point d’entrée et masquer une orchestration technique complexe.

**À distinguer de.** Une façade simplifie un sous-système ; un adapter convertit une interface en une autre.


---

<a id="factory-method"></a>
## 4.T FACTORY METHOD

**Définition.** Méthode, souvent statique, qui centralise et contrôle la création d’objets.

**Exemple.** `ZCL_EXPORTER_FACTORY=>CREATE( iv_format )` retourne une implémentation de `ZIF_EXPORTER` adaptée au format demandé.

**Repère pratique.** Utiliser une factory method lorsque le consommateur ne doit pas connaître la classe concrète ou les détails d’instanciation.

**À distinguer de.** Une factory method est une opération de création ; un Singleton impose en plus l’existence d’une seule instance par session interne.


---

<a id="field-symbol"></a>
## 4.U FIELD-SYMBOL

**Définition.** Alias dynamique vers une zone de mémoire existante.

**Exemple.** `ASSIGNING FIELD-SYMBOL(<ls_row>)` permet de modifier directement une ligne de table interne.

**Repère pratique.** Toujours vérifier qu’un field-symbol est affecté avant de l’utiliser.

**À distinguer de.** Il ne possède pas nécessairement sa propre zone mémoire.


---

<a id="gestionnaire-evenement"></a>
## 4.V GESTIONNAIRE D’ÉVÉNEMENT

**Définition.** Méthode déclarée `FOR EVENT` qui est appelée lorsqu’un événement auquel elle est enregistrée est déclenché.

**Exemple.** `ON_COMPLETED FOR EVENT completed OF zcl_importer` traite la fin d’un import.

**Repère pratique.** Enregistrer le gestionnaire avec `SET HANDLER` avant le déclenchement de l’événement.

**À distinguer de.** La déclaration du gestionnaire ne suffit pas ; l’enregistrement détermine les événements effectivement reçus.


---

<a id="heritage"></a>
## 4.W HÉRITAGE

**Définition.** Relation permettant à une sous-classe de reprendre les composants accessibles d’une super-classe et de spécialiser son comportement.

**Exemple.** `ZCL_EXPRESS_ORDER` hérite de `ZCL_ORDER` et redéfinit le calcul du délai.

**Repère pratique.** Utiliser l’héritage uniquement pour une relation stable « est un » et lorsque la substituabilité est respectée.

**À distinguer de.** L’héritage ne remplace pas la composition pour assembler des responsabilités indépendantes.


---

<a id="injection-dependances"></a>
## 4.X INJECTION DE DÉPENDANCES

**Définition.** Fourniture des collaborateurs d’un objet depuis l’extérieur au lieu de les créer directement dans son implémentation.

**Exemple.** Le constructeur reçoit une référence `ZIF_ORDER_REPOSITORY` utilisée par le service.

**Repère pratique.** Injecter les dépendances obligatoires par le constructeur et utiliser des interfaces pour permettre leur remplacement en test.

**À distinguer de.** L’injection ne signifie pas nécessairement utiliser un framework ou un conteneur dédié.


---

<a id="instance-objet"></a>
## 4.Y INSTANCE D’OBJET

**Définition.** Objet concret créé à l’exécution à partir de la définition d’une classe.

**Exemple.** `DATA(lo_service) = NEW zcl_order_service( ).` crée une instance de la classe.

**Repère pratique.** Une référence peut être initiale même si son type désigne une classe ; vérifier `IS BOUND` lorsque l’existence de l’instance est incertaine.

**À distinguer de.** La classe est la définition ; l’instance possède son propre état d’instance.


---

<a id="instruction-abap"></a>
## 4.Z INSTRUCTION ABAP

**Définition.** Unité syntaxique terminée par un point.

**Exemple.** `DATA lv_total TYPE i.` est une instruction.

**Repère pratique.** Utiliser le contrôle syntaxique avant l’activation.

**À distinguer de.** Une instruction peut s’étendre sur plusieurs lignes.


---

<a id="interface-abap-objects"></a>
## 4.AA INTERFACE ABAP OBJECTS

**Définition.** Contrat de méthodes, événements et types qu’une classe peut implémenter.

**Exemple.** Plusieurs classes peuvent implémenter la même interface de validation.

**Repère pratique.** Déclarer `INTERFACES` dans la classe, puis implémenter les méthodes requises.

**À distinguer de.** Une interface ne fournit généralement pas d’état d’instance.


---

<a id="invariant"></a>
## 4.AB INVARIANT

**Définition.** Condition qui doit rester vraie pendant toute la durée de vie valide d’un objet.

**Exemple.** Une commande confirmée doit toujours posséder au moins un poste et un client.

**Repère pratique.** Établir les invariants dans le constructeur et les préserver dans chaque méthode qui modifie l’état.

**À distinguer de.** Une précondition concerne l’entrée d’une opération ; un invariant concerne la cohérence permanente de l’objet.


---

<a id="methode"></a>
## 4.AC MÉTHODE

**Définition.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie.

**Exemple.** `lo_service->validate( )` appelle une méthode d’instance.

**Repère pratique.** Donner à chaque méthode une responsabilité claire et limiter les effets de bord non visibles dans son interface.

**À distinguer de.** Une méthode appartient à une classe ; un module fonction appartient à un groupe de fonctions.


---

<a id="methode-abstraite"></a>
## 4.AD MÉTHODE ABSTRAITE

**Définition.** Méthode déclarée `ABSTRACT` sans implémentation dans la classe qui la déclare.

**Exemple.** Une classe abstraite déclare `CALCULATE` et chaque sous-classe fournit son algorithme.

**Repère pratique.** Utiliser une méthode abstraite lorsqu’une étape est obligatoire mais dépend du type concret.

**À distinguer de.** Une méthode abstraite exige une implémentation dans une sous-classe concrète ; une méthode redéfinissable possède déjà une implémentation.


---

<a id="methode-instance"></a>
## 4.AE MÉTHODE D’INSTANCE

**Définition.** Méthode appelée sur une instance avec l’opérateur `->` et pouvant accéder à son état.

**Exemple.** `lo_order->confirm( )` modifie l’état d’une commande particulière.

**Repère pratique.** Utiliser une méthode d’instance lorsque le traitement dépend de l’état propre à un objet.

**À distinguer de.** Une méthode statique est appelée sur la classe avec `=>` et ne dépend pas d’une instance.


---

<a id="methode-statique"></a>
## 4.AF MÉTHODE STATIQUE

**Définition.** Méthode déclarée `CLASS-METHODS`, appelée sur la classe avec `=>` sans créer d’instance.

**Exemple.** `ZCL_DATE_UTIL=>IS_WORKING_DAY( )` exécute un calcul sans état d’instance.

**Repère pratique.** Réserver les méthodes statiques aux opérations réellement indépendantes d’un état d’objet ou aux points de création contrôlés.

**À distinguer de.** Une méthode statique n’est pas automatiquement sans effet de bord ; elle peut modifier des données de classe ou appeler d’autres services.


---

<a id="objet-donnees"></a>
## 4.AG OBJET DE DONNÉES

**Définition.** Zone de mémoire typée contenant une valeur pendant l’exécution.

**Exemple.** Une variable déclarée avec `DATA` est un objet de données.

**Repère pratique.** Observer sa valeur dans le débogueur.

**À distinguer de.** Une table interne est aussi un objet de données, mais structuré et dynamique.


---

<a id="polymorphisme"></a>
## 4.AH POLYMORPHISME

**Définition.** Capacité à utiliser plusieurs classes concrètes au travers d’un même type de référence abstrait.

**Exemple.** Une variable `REF TO zif_exporter` peut référencer un exporteur CSV ou XML et appeler la même méthode `EXPORT`.

**Repère pratique.** Programmer contre une interface ou une super-classe stable plutôt que contre chaque implémentation concrète.

**À distinguer de.** Le polymorphisme décrit l’utilisation interchangeable ; l’héritage et les interfaces sont des mécanismes qui le permettent.


---

<a id="redefinition"></a>
## 4.AI REDÉFINITION

**Définition.** Nouvelle implémentation, dans une sous-classe, d’une méthode héritée déclarée redéfinissable.

**Exemple.** La sous-classe redéfinit `CALCULATE_PRICE` et peut appeler l’implémentation parente avec `SUPER->CALCULATE_PRICE( )`.

**Repère pratique.** Préserver le contrat de la méthode parente et documenter les différences de comportement.

**À distinguer de.** La redéfinition concerne une méthode héritée ; l’implémentation d’interface satisfait un contrat d’interface.


---

<a id="reference"></a>
## 4.AJ RÉFÉRENCE

**Définition.** Valeur qui pointe vers un objet de données ou une instance de classe.

**Exemple.** `REF TO` déclare un type de référence.

**Repère pratique.** Tester la référence avec `IS BOUND` avant la déréférenciation lorsque son état est incertain.

**À distinguer de.** Une référence initiale ne pointe vers aucun objet utilisable.


---

<a id="simple-factory"></a>
## 4.AK SIMPLE FACTORY

**Définition.** Objet ou méthode qui choisit une classe concrète parmi plusieurs implémentations selon un critère fourni.

**Exemple.** Une factory retourne un exporteur CSV, JSON ou XML selon `iv_format`.

**Repère pratique.** Retourner un type d’interface pour éviter de rendre les consommateurs dépendants des classes concrètes.

**À distinguer de.** Simple Factory est un nom d’usage ; Factory Method désigne plus précisément une méthode de création contrôlée.


---

<a id="singleton"></a>
## 4.AL SINGLETON

**Définition.** Pattern limitant la création à une seule instance accessible dans une session interne ABAP.

**Exemple.** Une classe `CREATE PRIVATE` conserve une référence dans `CLASS-DATA` et la retourne avec `GET_INSTANCE`.

**Repère pratique.** Utiliser ce pattern avec retenue, uniquement lorsqu’une instance unique possède un sens technique clair dans la session.

**À distinguer de.** Le Singleton ABAP ne garantit pas une instance unique dans tout le système ni entre plusieurs sessions internes.


---

<a id="strategy"></a>
## 4.AM STRATEGY

**Définition.** Pattern qui encapsule plusieurs algorithmes interchangeables derrière une même interface.

**Exemple.** Plusieurs classes implémentent `ZIF_PRICE_STRATEGY` pour calculer un prix standard, promotionnel ou contractuel.

**Repère pratique.** Injecter la stratégie dans le service consommateur afin de changer l’algorithme sans modifier son code principal.

**À distinguer de.** Strategy sélectionne un comportement ; Factory centralise la création d’objets.


---

<a id="structure-abap"></a>
## 4.AN STRUCTURE

**Définition.** Objet ou type composé de plusieurs composants nommés.

**Exemple.** Une structure de commande peut contenir numéro, client, date et montant.

**Repère pratique.** Accéder à un composant avec le tiret : `ls_order-id`.

**À distinguer de.** Une structure ne contient qu’une ligne, contrairement à une table interne.


---

<a id="super-reference"></a>
## 4.AO SUPER

**Définition.** Pseudo-référence permettant à une sous-classe d’accéder à l’implémentation héritée de sa super-classe.

**Exemple.** `super->constructor( ... )` appelle le constructeur de la super-classe.

**Repère pratique.** Utiliser `SUPER` lorsque la spécialisation complète le comportement parent au lieu de le remplacer entièrement.

**À distinguer de.** `ME` désigne l’instance courante ; `SUPER` désigne sa vue au niveau de la super-classe.


---

<a id="table-interne"></a>
## 4.AP TABLE INTERNE

**Définition.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP.

**Exemple.** Le résultat d’un `SELECT ... INTO TABLE` est souvent reçu dans une table interne.

**Repère pratique.** Déclarer le type de ligne et la catégorie de table, puis utiliser `LOOP AT`, `READ TABLE` ou une expression de table.

**À distinguer de.** Une table interne n’est pas une table de base de données.


---

<a id="type-donnees"></a>
## 4.AQ TYPE DE DONNÉES

**Définition.** Définition des propriétés d’une valeur : nature, longueur, précision et opérations autorisées.

**Exemple.** `i`, `string` et `d` sont des types intégrés ABAP.

**Repère pratique.** Déclarer un type local avec `TYPES` ou réutiliser un type DDIC.

**À distinguer de.** Le type n’est pas la variable qui contient la valeur.


---

<a id="up-cast"></a>
## 4.AR UP CAST

**Définition.** Affectation d’une référence d’un type plus spécifique vers un type plus général compatible.

**Exemple.** Une référence vers `ZCL_CSV_EXPORTER` est affectée à une variable `REF TO ZIF_EXPORTER`.

**Repère pratique.** Utiliser l’up cast pour masquer le type concret et travailler avec un contrat abstrait.

**À distinguer de.** L’up cast est sûr ; le down cast exige de vérifier la compatibilité du type réel.


---

<a id="visibilite"></a>
## 4.AS VISIBILITÉ

**Définition.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`.

**Exemple.** Une méthode publique est accessible aux consommateurs ; un attribut privé est limité à la classe.

**Repère pratique.** Commencer par la visibilité la plus restrictive et n’exposer que les composants nécessaires au contrat.

**À distinguer de.** La visibilité contrôle l’accès au code ; elle ne remplace pas les autorisations métier ou techniques SAP.

---

## 4.AT Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)
- [Implementing Factory Methods — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-factory-methods_ff885b1e-5e7c-4d73-b9df-b4be5112e1fa)
- [Static Classes and Singleton — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSTATIC_CLASS_SINGLETON_GUIDL.html)

---

Chapitre suivant : [DONNÉES, DICTIONNAIRE ET BASE DE DONNÉES](<./05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md>)
