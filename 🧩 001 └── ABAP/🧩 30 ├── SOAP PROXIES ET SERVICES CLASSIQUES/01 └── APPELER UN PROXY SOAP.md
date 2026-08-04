# 1. APPELER UN PROXY SOAP

## 1.A RÉSULTAT ATTENDU

Instancier une classe[^terme-classe] proxy générée et appeler son opération en traitant la faute système.

## 1.B PROCESS

### 1.B.1 ÉTAPE 1 — IDENTIFIER LE PROXY GÉNÉRÉ

Dans `SPROXY`[^outil-sproxy], ouvrir le consumer proxy et relever la classe générée, l’opération, les types de requête et réponse ainsi que les exceptions déclarées. Ces noms constituent l’interface réelle du code appelant.

### 1.B.2 ÉTAPE 2 — CONFIGURER LE PORT LOGIQUE

Créer ou vérifier le port logique avec l’outil de configuration prévu par le système, généralement `SOAMANAGER`[^outil-soamanager]. Contrôler l’endpoint, l’authentification, le transport TLS et les timeouts avec l’équipe d’administration.

### 1.B.3 ÉTAPE 3 — CONSTRUIRE LA REQUÊTE

Remplir la structure générée avec les données obligatoires et valider les longueurs, domaines et cardinalités. Ne pas journaliser un payload complet contenant des secrets ou des données personnelles.

### 1.B.4 ÉTAPE 4 — INSTANCIER LE PROXY

Créer la classe proxy avec le nom exact du port logique. Traiter immédiatement une erreur de configuration ou d’instanciation avant d’appeler l’opération.

### 1.B.5 ÉTAPE 5 — APPELER L’OPÉRATION

Utiliser la signature générée dans `SPROXY`. Intercepter `CX_AI_SYSTEM_FAULT` et toute faute applicative déclarée par le proxy ; ne pas inventer un type d’exception[^terme-exception] absent de cette signature.

### 1.B.6 ÉTAPE 6 — CONTRÔLER LA RÉPONSE OU LE MESSAGE

Pour un appel synchrone, valider la réponse avant la suite du traitement. Pour un appel asynchrone, relever l’identifiant de message et utiliser le moniteur prévu par la configuration pour vérifier la persistance et la transmission.

### 1.B.7 ÉTAPE 7 — TESTER LES ÉCHECS

Tester un port inconnu, une indisponibilité distante, un refus d’authentification, une faute applicative et une réponse invalide. Vérifier que chaque cas produit un diagnostic exploitable sans exposer le contenu sensible.

## 1.C CODE PRÊT À ADAPTER

Le type de requête et la méthode[^terme-methode] dépendent obligatoirement de la génération `SPROXY` :

```abap
DATA ls_request TYPE zservice_request.

TRY.
    DATA(lo_proxy) = NEW zco_service_proxy( logical_port_name = 'ZLP_SERVICE' ).
    lo_proxy->execute( EXPORTING output = ls_request ).
  CATCH cx_ai_system_fault INTO DATA(lx_system).
    MESSAGE lx_system TYPE 'E'.
ENDTRY.
```

## 1.D CONTRÔLE

- Remplacer la classe, l’opération, la signature et le port logique par ceux du proxy généré.
- Pour une opération asynchrone, contrôler aussi la persistance et le moniteur de messages prévu par la configuration.

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).

[^outil-sproxy]: **SPROXY.** Enterprise Services Browser utilisé pour afficher et générer les objets proxy ABAP. Voir [le chapitre associé](<01 └── APPELER UN PROXY SOAP.md>).
[^outil-soamanager]: **SOAMANAGER.** Application d’administration utilisée pour configurer les services Web et leurs liaisons. Voir [le chapitre associé](<01 └── APPELER UN PROXY SOAP.md>).
