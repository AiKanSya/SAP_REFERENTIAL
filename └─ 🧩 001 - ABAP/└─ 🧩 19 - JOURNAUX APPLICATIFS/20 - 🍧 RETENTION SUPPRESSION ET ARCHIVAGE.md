# 🌸 RÉTENTION, SUPPRESSION ET ARCHIVAGE

## 🌺 OBJECTIFS

- Définir une durée de conservation
- Supprimer les journaux de façon contrôlée
- Éviter la croissance illimitée des tables BAL

## 🌺 PRINCIPES

Un journal applicatif est une donnée technique persistante. Sa durée de conservation doit être définie selon :

- besoin opérationnel ;
- fréquence du traitement ;
- obligations d’audit ;
- présence de données personnelles ;
- volumétrie ;
- capacité de reprise.

## 🌺 SUPPRESSION AVEC SLG2

La transaction `SLG2` utilise le programme de suppression standard du BAL. La sélection doit cibler l’objet, le sous-objet, la période ou la date d’expiration.

```mermaid
flowchart LR
    A["Date d expiration atteinte"] --> B["Sélection SLG2"]
    B --> C["Exécution de contrôle"]
    C --> D["Suppression en job"]
    D --> E["Contrôle de volumétrie"]
```

Planifier la suppression en arrière-plan pour les volumes importants.

## 🌺 ARCHIVAGE

L’objet d’archivage `BC_SBAL` permet d’archiver les journaux applicatifs. SAP fournit notamment des programmes pour écrire les données BAL dans les archives puis supprimer les données archivées des tables d’origine.

## 🌺 PRÉCAUTIONS

- ne pas supprimer tous les objets sans filtre ;
- tester la sélection en environnement non productif ;
- aligner `DATE_DEL` et la politique d’exploitation ;
- documenter la responsabilité du nettoyage ;
- surveiller les tables techniques et les temps de sélection `SLG1`.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Archiving Object BC_SBAL — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e4a2209872c3b0fe10000000a42189e.html)
- [Deletion of Business Application Logs — SAP Help Portal](https://help.sap.com/docs/btc/security-guide/deletion-of-business-application-logs)
- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)

---

➡️ [Chapitre suivant — AUTORISATIONS ET DONNEES SENSIBLES](<./21 - 🍧 AUTORISATIONS ET DONNEES SENSIBLES.md>)
