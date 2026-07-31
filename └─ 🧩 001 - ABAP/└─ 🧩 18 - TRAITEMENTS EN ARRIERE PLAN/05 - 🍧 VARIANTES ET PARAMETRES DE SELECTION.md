# 🌸 VARIANTES ET PARAMÈTRES DE SÉLECTION

## 🌺 OBJECTIFS

- Fournir des valeurs reproductibles à un rapport
- Séparer la configuration d’exécution du code
- Éviter les variantes ambiguës ou dangereuses

## 🌺 RÔLE

Une variante mémorise les valeurs d’un écran de sélection. Pour un rapport doté d’un écran de sélection, elle constitue le mécanisme standard permettant de transmettre les paramètres à une étape ABAP planifiée depuis les transactions de jobs.

## 🌺 CRÉATION

Depuis `SE38` ou `SA38` :

1. saisir le programme ;
2. ouvrir la maintenance des variantes ;
3. renseigner les paramètres ;
4. enregistrer sous un nom explicite ;
5. tester la variante en dialogue ;
6. l’affecter à l’étape du job.

## 🌺 BON NOMMAGE

```text
Z_<DOMAINE>_<TRAITEMENT>_<FREQUENCE>_<ENVIRONNEMENT>
```

Exemple :

```text
Z_FI_EXPORT_FACTURES_DAILY_PROD
```

## 🌺 VALEURS DYNAMIQUES

Les variables de sélection permettent de calculer certaines dates à l’exécution. Leur comportement doit être testé sur le système cible, notamment pour :

- date du jour ;
- début ou fin de période ;
- jours ouvrés ;
- variables issues de tables de variantes.

## 🌺 RISQUES

- intervalle trop large provoquant une charge excessive ;
- variante modifiée sans validation ;
- variante de test réutilisée en production ;
- dates fixes devenues obsolètes ;
- absence de contrôle des paramètres dans le programme.

La variante ne remplace pas les validations métier du rapport.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Variant Maintenance — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/c0980374e58611d194cc00a0c94260a5.html)
- [Background Work Processes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b3c3e8eb51780e10000000a42189c.html)

---

➡️ [Chapitre suivant — PLANIFIER UN JOB AVEC SM36](<./06 - 🍧 PLANIFIER UN JOB AVEC SM36.md>)
