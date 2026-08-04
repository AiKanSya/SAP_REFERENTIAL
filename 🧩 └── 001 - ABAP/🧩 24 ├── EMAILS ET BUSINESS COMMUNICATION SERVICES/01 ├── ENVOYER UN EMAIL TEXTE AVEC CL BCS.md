# ENVOYER UN EMAIL TEXTE AVEC `CL_BCS`

## RÉSULTAT ATTENDU

Créer une demande d’envoi contenant un sujet, un corps texte et un destinataire Internet.

## CODE PRÊT À ADAPTER

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
    COMMIT WORK. "BCS persiste la demande d’envoi ; le routage reste asynchrone.

    IF lv_sent_to_all = abap_false.
      MESSAGE e001(zdemo) WITH 'Destinataire non accepté'.
    ENDIF.
  CATCH cx_bcs INTO DATA(lx_bcs).
    MESSAGE lx_bcs TYPE 'E'.
ENDTRY.
```

## POINTS À REMPLACER

- Adresse Internet, sujet, contenu et classe de messages.
- Politique de `COMMIT WORK` : dans une transaction métier, le commit appartient à l’unité de travail appelante.

## CONTRÔLE

- Vérifier la demande dans `SOST`.
- Distinguer la création de la demande, son transfert par SAPconnect et sa livraison externe.
