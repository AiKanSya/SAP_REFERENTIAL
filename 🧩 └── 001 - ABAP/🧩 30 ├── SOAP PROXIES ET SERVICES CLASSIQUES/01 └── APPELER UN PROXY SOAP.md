# APPELER UN PROXY SOAP

## RÉSULTAT ATTENDU

Instancier une classe proxy générée et appeler son opération en traitant la faute système.

## CODE PRÊT À ADAPTER

Le type de requête et la méthode dépendent obligatoirement de la génération `SPROXY` :

```abap
DATA ls_request TYPE zservice_request.

TRY.
    DATA(lo_proxy) = NEW zco_service_proxy( logical_port_name = 'ZLP_SERVICE' ).
    lo_proxy->execute( EXPORTING output = ls_request ).
  CATCH cx_ai_system_fault INTO DATA(lx_system).
    MESSAGE lx_system TYPE 'E'.
ENDTRY.
```

## CONTRÔLE

- Remplacer la classe, l’opération, la signature et le port logique par ceux du proxy généré.
- Pour une opération asynchrone, contrôler aussi la persistance et le moniteur de messages prévu par la configuration.
