# 1. ENVOYER UN EMAIL TEXTE AVEC `CL_BCS`

## 1.A RÉSULTAT ATTENDU

Créer une demande d’envoi contenant un sujet, un corps texte et un destinataire Internet.

## 1.B PROCESS

### 1.B.1 ÉTAPE 1 — VÉRIFIER LE CANAL D’ENVOI

Confirmer avec l’administration que SAPconnect est configuré pour le système et que l’adresse de test est autorisée. Utiliser un destinataire contrôlé en développement afin d’éviter un envoi externe involontaire.

### 1.B.2 ÉTAPE 2 — CONSTRUIRE LE CORPS ET LE SUJET

Préparer le corps dans `BCSY_TEXT` et fixer un sujet compréhensible. Ne pas insérer de secret ni de donnée personnelle non nécessaire dans le message.

### 1.B.3 ÉTAPE 3 — CRÉER LA DEMANDE ET LE DOCUMENT

Appeler `CL_BCS=>CREATE_PERSISTENT`, créer le document avec `CL_DOCUMENT_BCS=>CREATE_DOCUMENT`, puis l’affecter à la demande avec `SET_DOCUMENT`.

### 1.B.4 ÉTAPE 4 — AJOUTER UN DESTINATAIRE VALIDÉ

Créer l’adresse avec `CL_CAM_ADDRESS_BCS=>CREATE_INTERNET_ADDRESS` puis l’ajouter à la demande. Valider l’adresse fonctionnellement avant l’appel ; sa forme syntaxique ne prouve pas que le destinataire est autorisé.

### 1.B.5 ÉTAPE 5 — ENVOYER ET TRAITER LE RÉSULTAT

Appeler `SEND` sans écran d’erreur interactif pour un traitement automatisé. Contrôler la valeur retournée et intercepter `CX_BCS` afin de journaliser le défaut technique sans exposer des informations internes à l’utilisateur.

### 1.B.6 ÉTAPE 6 — RESPECTER LA FRONTIÈRE DE COMMIT

Dans un rapport autonome, exécuter le commit après la création de la demande. Dans une transaction métier, laisser l’unité appelante décider du commit afin de ne pas valider prématurément d’autres écritures.

### 1.B.7 ÉTAPE 7 — CONTRÔLER LA DEMANDE DANS SOST

Rechercher la demande par heure, expéditeur, destinataire et sujet. Distinguer sa création, son transfert par SAPconnect et la livraison finale par l’infrastructure externe.

## 1.C CODE PRÊT À ADAPTER

```abap
TRY.
    DATA(lo_send_request) = cl_bcs=>create_persistent( ).
    DATA(lt_body) = VALUE bcsy_text(
      ( line = 'Traitement terminé.' )
      ( line = 'Consultez le journal applicatif pour le détail.' ) ).

    DATA(lo_document) = cl_document_bcs=>create_document(
      i_type    = 'RAW'
      i_text    = lt_body
      i_subject = 'Résultat du traitement' ).

    lo_send_request->set_document( lo_document ).
    lo_send_request->add_recipient(
      cl_cam_address_bcs=>create_internet_address( 'destinataire@example.com' ) ).

    DATA(lv_sent_to_all) = lo_send_request->send( i_with_error_screen = abap_false ).
    COMMIT WORK. " BCS persiste la demande d’envoi ; le routage reste asynchrone.

    IF lv_sent_to_all = abap_false.
      MESSAGE e001(zdemo) WITH 'Destinataire non accepté'.
    ENDIF.
  CATCH cx_bcs INTO DATA(lx_bcs).
    MESSAGE lx_bcs TYPE 'E'.
ENDTRY.
```

## 1.D POINTS À REMPLACER

- Adresse Internet, sujet, contenu et classe[^terme-classe] de messages.
- Politique de `COMMIT WORK`[^terme-commit-work] : dans une transaction métier, le commit appartient à l’unité de travail appelante.

## 1.E CONTRÔLE

- Vérifier la demande dans `SOST`[^outil-sost].
- Distinguer la création de la demande, son transfert par SAPconnect et sa livraison externe.

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).

[^outil-sost]: **SOST.** Transaction de surveillance des demandes d’envoi gérées par SAPconnect. Voir [le chapitre associé](<01 ├── ENVOYER UN EMAIL TEXTE AVEC CL BCS.md>).
