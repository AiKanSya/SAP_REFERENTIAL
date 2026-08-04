# NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES

Définitions fonctionnelles et organisationnelles fréquemment rencontrées dans les projets SAP.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="business-object"></a>
## BUSINESS OBJECT

**Définition.** Représentation métier d’une entité avec données, opérations et cycle de vie.

**Exemple.** Commande client, fournisseur ou demande d’achat.

**Repère pratique.** Identifier clés, statuts, API disponibles et règles transactionnelles.

**À distinguer de.** Un Business Object n’est pas seulement une table de base de données.


---

<a id="customizing"></a>
## CUSTOMIZING

**Définition.** Paramétrage permettant d’adapter le comportement standard SAP à l’organisation.

**Exemple.** Définir des types de documents ou des règles de détermination.

**Repère pratique.** Identifier le chemin IMG, les dépendances et le type de transport.

**À distinguer de.** Le Customizing n’est pas du code ABAP, même s’il influence son comportement.


---

<a id="division"></a>
## DIVISION

**Définition.** Unité organisationnelle logistique couramment appelée plant dans les modèles SAP.

**Exemple.** Un article peut être géré en stock dans plusieurs divisions.

**Repère pratique.** Vérifier le champ technique et le module concerné, car le terme métier peut être ambigu.

**À distinguer de.** En français SAP, « division » peut prêter à confusion avec d’autres notions organisationnelles.


---

<a id="document-sap"></a>
## DOCUMENT SAP

**Définition.** Objet transactionnel enregistré avec en-tête, postes, statuts et références.

**Exemple.** Une commande d’achat comprend un en-tête et plusieurs postes.

**Repère pratique.** Toujours distinguer numéro externe, numéro interne, année et poste lorsque nécessaire.

**À distinguer de.** Le terme document peut désigner des objets différents selon le module.


---

<a id="donnee-base"></a>
## DONNÉE DE BASE

**Définition.** Donnée relativement stable réutilisée par plusieurs processus métier.

**Exemple.** Article, client ou fournisseur sont des données de base courantes.

**Repère pratique.** Identifier l’objet métier, son cycle de vie et l’organisation responsable.

**À distinguer de.** Une donnée de base peut tout de même évoluer et être historisée.


---

<a id="donnee-transactionnelle"></a>
## DONNÉE TRANSACTIONNELLE

**Définition.** Donnée créée par l’exécution d’un processus métier.

**Exemple.** Commande, livraison, facture ou mouvement de stock.

**Repère pratique.** Analyser le document, ses postes, statuts et références.

**À distinguer de.** Elle dépend souvent de données de base et de paramétrage.


---

<a id="objet-autorisation"></a>
## OBJET D’AUTORISATION

**Définition.** Structure de contrôle contenant des champs vérifiés lors d’une action.

**Exemple.** `S_DATASET` contrôle certains accès fichiers serveur.

**Repère pratique.** Identifier l’objet, l’activité et les valeurs contrôlées ; ne pas contourner le contrôle dans le code.

**À distinguer de.** Un contrôle d’autorisation doit être conçu avec l’équipe sécurité.


---

<a id="organisation-commerciale"></a>
## ORGANISATION COMMERCIALE

**Définition.** Unité responsable de la vente et de la distribution dans le modèle SD.

**Exemple.** Une commande client est créée pour une organisation commerciale donnée.

**Repère pratique.** Identifier aussi canal de distribution et secteur d’activité lorsque le processus les utilise.

**À distinguer de.** Ce concept ne correspond pas directement à une société juridique.


---

<a id="organisation-achats"></a>
## ORGANISATION D’ACHATS

**Définition.** Unité responsable des activités d’approvisionnement.

**Exemple.** Un contrat fournisseur peut être géré par une organisation d’achats.

**Repère pratique.** Vérifier ses affectations aux sociétés et divisions.

**À distinguer de.** Elle peut être centralisée ou spécifique selon le modèle de l’entreprise.


---

<a id="regle-metier"></a>
## RÈGLE MÉTIER

**Définition.** Condition ou calcul imposé par le processus fonctionnel.

**Exemple.** Refuser une quantité qui ne respecte pas le conditionnement.

**Repère pratique.** Formaliser entrées, résultat attendu, exceptions et message utilisateur.

**À distinguer de.** Une règle technique ne doit pas être présentée comme une règle métier sans validation fonctionnelle.


---

<a id="role-utilisateur"></a>
## RÔLE UTILISATEUR

**Définition.** Regroupement d’autorisations et de menus attribué à un utilisateur.

**Exemple.** Un rôle développeur donne accès à certaines transactions techniques en DEV.

**Repère pratique.** Analyser l’échec d’autorisation avec les outils prévus par l’organisation.

**À distinguer de.** Disposer d’une transaction dans le menu ne garantit pas toutes les autorisations internes.


---

<a id="societe"></a>
## SOCIÉTÉ

**Définition.** Unité comptable légale souvent représentée par le company code.

**Exemple.** Une écriture FI est comptabilisée dans une société.

**Repère pratique.** Identifier le code société et les périodes comptables concernées.

**À distinguer de.** La société n’est pas nécessairement identique à une entité commerciale ou à un site.


---

<a id="unite-organisationnelle"></a>
## UNITÉ ORGANISATIONNELLE

**Définition.** Élément structurant l’entreprise dans SAP.

**Exemple.** Société, division, organisation commerciale ou organisation d’achats.

**Repère pratique.** Demander la définition fonctionnelle exacte et les règles d’affectation.

**À distinguer de.** Les noms et niveaux pertinents varient selon le module SAP.

---

## Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)

---

Chapitre suivant : [ACRONYMES SAP](<./10 └── ACRONYMES SAP.md>)
