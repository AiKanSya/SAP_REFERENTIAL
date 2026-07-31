# 🌸 API BAL CLASSIQUE, API OBJET ET CODE HISTORIQUE

## 🌺 OBJECTIFS

- Distinguer les familles d’API
- Choisir selon la version et le contexte du système
- Reconnaître le code historique

## 🌺 API CLASSIQUE BAL

Les modules fonction `BAL_*` sont largement disponibles dans les systèmes ABAP classiques :

- `BAL_LOG_CREATE` ;
- `BAL_LOG_MSG_ADD` ;
- `BAL_LOG_EXCEPTION_ADD` ;
- `BAL_DSP_LOG_DISPLAY` ;
- `BAL_DB_SAVE` ;
- `BAL_DB_SEARCH` ;
- `BAL_DB_LOAD`.

Ils constituent la base de ce dossier car ils sont accessibles et vérifiables dans `SE37` depuis SAP GUI.

## 🌺 API ORIENTÉE OBJET

Les versions récentes de l’ABAP Platform proposent des classes et interfaces `CL_BALI_*` / `IF_BALI_*`. Elles encapsulent la création, les éléments du journal et la persistance.

Leur disponibilité dépend de la version du système et du modèle de développement. Vérifier dans `SE24` et dans la documentation correspondant exactement à la release.

## 🌺 CODE HISTORIQUE

Les fonctions `APPL_LOG_*` appartiennent à une API plus ancienne. SAP indique que les fonctions `BAL_*`, introduites ultérieurement, sont plus flexibles.

Pour un nouveau développement classique :

1. privilégier l’API recommandée et disponible dans la version cible ;
2. encapsuler l’API pour réduire le couplage ;
3. conserver `APPL_LOG_*` uniquement lors de la maintenance d’un programme existant ;
4. ne pas mélanger plusieurs familles d’API dans le même composant sans raison.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Create Application Log — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/1090027b6c5310149844b23fcc030a11/2afa0216493111d182b70000e829fbfe.html)
- [Create a New Application Log — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/f7c20f7b2fce4fbaba79ae0c5182d869.html)
- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)

---

➡️ [Chapitre suivant — PROGRAMMES DE DEMONSTRATION TESTS ET DIAGNOSTIC](<./23 - 🍧 PROGRAMMES DE DEMONSTRATION TESTS ET DIAGNOSTIC.md>)
