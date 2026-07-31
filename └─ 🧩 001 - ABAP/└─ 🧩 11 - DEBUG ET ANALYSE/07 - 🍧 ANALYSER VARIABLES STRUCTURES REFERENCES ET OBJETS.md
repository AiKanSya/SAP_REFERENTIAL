# 🌸 ANALYSER VARIABLES, STRUCTURES, RÉFÉRENCES ET OBJETS

## 🌺 OBJECTIFS

- Afficher la valeur et les attributs d’un objet de données
- Déplier une structure
- Suivre une référence de données ou d’objet
- Distinguer valeur initiale, référence initiale et objet absent
- Vérifier le type dynamique

## 🌺 INFORMATIONS À CONTRÔLER

Pour une variable, analyser séparément :

- nom ;
- type statique ;
- type dynamique éventuel ;
- longueur et décimales ;
- valeur ;
- portée ;
- état initial ;
- adresse ou référence lorsque pertinente.

## 🌺 STRUCTURES

Une structure doit être analysée au niveau du composant qui porte la règle métier.

```abap
TYPES: BEGIN OF ty_product,
         matnr TYPE matnr,
         werks TYPE werks_d,
         menge TYPE menge_d,
       END OF ty_product.

DATA ls_product TYPE ty_product.
```

Dans le débogueur, développer `ls_product`, puis contrôler chaque composant. Une structure entièrement initiale indique souvent qu’elle n’a pas été alimentée, mais ce n’est pas toujours une erreur.

## 🌺 RÉFÉRENCES

```abap
DATA lr_product TYPE REF TO ty_product.
CREATE DATA lr_product.
lr_product->matnr = '000000000000006200'.
```

Points à vérifier :

- la référence est-elle initiale ?
- l’objet référencé existe-t-il encore ?
- le type dynamique correspond-il au type attendu ?
- plusieurs références pointent-elles sur le même objet ?

## 🌺 OBJETS

Pour une référence d’objet, afficher :

- la classe dynamique ;
- les attributs d’instance ;
- les références contenues ;
- les interfaces ;
- l’état des attributs avant et après l’appel.

Ne pas conclure qu’une méthode est incorrecte uniquement parce qu’un attribut change. Vérifier le contrat attendu de l’objet.

## 🌺 FIELD-SYMBOLS

Pour un field-symbol :

```abap
FIELD-SYMBOLS <ls_product> TYPE ty_product.
```

Contrôler :

- s’il est affecté ;
- l’objet de données auquel il est lié ;
- le type concret ;
- les modifications indirectes produites par l’écriture via le field-symbol.

## 🌺 VALEURS FORMATÉES

Certaines données possèdent une représentation interne différente de l’affichage utilisateur :

- dates ;
- heures ;
- numéros avec zéros initiaux ;
- montants et devises ;
- quantités et unités.

Le débogueur affiche souvent la valeur interne. Comparer avec la conversion appliquée par l’écran ou l’interface.

## 🌺 PRÉCAUTION SUR LES DONNÉES SENSIBLES

Les outils de débogage peuvent exposer des données métier ou personnelles. Ne pas exporter, capturer ou partager des valeurs sans nécessité et sans respecter les règles du client.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Standard ABAP Debugger — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/ba879a6e2ea04d9bb94c7ccd7cdac446/49250c884d7216b5e10000000a42189d.html)
- [ABAP Test and Analysis Tools — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491aa66f87041903e10000000a42189c.html)

---

➡️ [Chapitre suivant — ANALYSER LES TABLES INTERNES](<./08 - 🍧 ANALYSER LES TABLES INTERNES.md>)
