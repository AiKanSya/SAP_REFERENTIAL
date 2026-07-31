# 🌸 MODULES FONCTION DISTANTS ET CONTRAINTES

## 🌺 OBJECTIFS

- Marquer un module comme RFC
- Concevoir une interface transportable
- Comprendre les restrictions d’exécution
- Séparer erreurs métier et erreurs techniques

## 🌺 ACTIVATION RFC

Dans les attributs du module fonction, sélectionner le type de traitement **Module distant** ou **Remote-Enabled Module** selon la langue du système.

Cette option génère les éléments nécessaires à l’appel via l’interface RFC.

## 🌺 INTERFACE

Pour un module RFC :

- utiliser le passage par valeur pour `IMPORTING`, `EXPORTING` et `CHANGING` ;
- choisir des types compatibles RFC ;
- éviter les références d’objet et données non sérialisables ;
- limiter la taille du payload ;
- documenter les formats et longueurs ;
- fournir un résultat d’erreur structuré.

```mermaid
flowchart TD
    A["Donnée ABAP"] --> B{"Compatible RFC"}
    B -->|"Oui"| C["Sérialisation et transport"]
    B -->|"Non"| D["Reconcevoir l interface"]
```

## 🌺 CONTEXTE D EXÉCUTION

Le module s’exécute dans le système cible avec :

- l’utilisateur de la connexion ;
- son mandant ;
- ses autorisations ;
- les paramètres régionaux applicables ;
- une unité de travail propre au scénario RFC.

Ne pas supposer que `sy-uname`, `sy-mandt` ou la langue correspondent au système appelant.

## 🌺 INTERDICTIONS ET RESTRICTIONS

La documentation RFC impose des restrictions supplémentaires, notamment sur les instructions qui ferment ou modifient le contexte de traitement. Vérifier la version cible avant d’utiliser :

- traitements de dialogue ;
- changements de mode interne ;
- opérations transactionnelles internes ;
- appels récursifs ou callbacks ;
- types non pris en charge.

## 🌺 ERREURS

Séparer :

- erreur métier : donnée invalide, objet absent, règle non respectée ;
- erreur système : dump distant, indisponibilité ;
- erreur de communication : réseau, connexion, timeout ;
- erreur d’autorisation : utilisateur RFC insuffisamment autorisé.

## 🌺 STABILITÉ

Une interface RFC peut avoir des consommateurs invisibles depuis le système fournisseur. Toute modification doit être gouvernée comme une modification d’API distribuée.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [RFC Restrictions — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_816_index_htm/8.16/en-US/ABENRFC_LIMITATIONS.html)
- [RFC Call Restrictions — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/753088fc00704d0a80e7fbd6803c8adb/4889340284b84e6fe10000000a421937.html)
- [RFC Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/753088fc00704d0a80e7fbd6803c8adb/4889653184b84e6fe10000000a421937.html)

---

➡️ [Chapitre suivant — DESTINATIONS RFC AVEC SM59](<./14 - 🍧 DESTINATIONS RFC AVEC SM59.md>)
