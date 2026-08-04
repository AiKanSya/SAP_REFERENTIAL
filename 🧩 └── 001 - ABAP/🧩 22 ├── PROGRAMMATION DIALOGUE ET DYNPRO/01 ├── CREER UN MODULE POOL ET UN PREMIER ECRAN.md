# 1. CRÉER UN MODULE POOL ET UN PREMIER ÉCRAN

## 1.A RÉSULTAT ATTENDU

Afficher le dynpro `0100` depuis une transaction SAP GUI et permettre sa fermeture sans bloquer l’utilisateur.

## 1.B PROCESS

### 1.B.1 ÉTAPE 1 — CRÉER LE MODULE POOL

Dans `SE80`, créer le programme `ZDEMO_DYNPRO` de type module pool. Affecter le package et la demande de transport prévus, puis déclarer le champ global `GV_OK_CODE` avec le type `SYUCOMM`.

### 1.B.2 ÉTAPE 2 — CRÉER LE DYNPRO 0100

Créer l’écran `0100`. Définir ses attributs, son écran suivant et son type selon le scénario. Dans la liste des éléments, affecter `GV_OK_CODE` au champ OK_CODE afin que le PAI reçoive les commandes du statut GUI.

### 1.B.3 ÉTAPE 3 — CONSTRUIRE L’ÉCRAN

Dans Screen Painter, ajouter les champs et libellés nécessaires. Chaque champ lié au programme doit posséder le même nom et un type compatible avec la donnée ABAP correspondante.

### 1.B.4 ÉTAPE 4 — DÉFINIR LA LOGIQUE DE FLUX

Déclarer dans le flux du dynpro un module PBO pour préparer l’écran et un module PAI pour traiter les commandes. Créer ensuite les implémentations proposées dans le bloc ABAP ci-dessous.

### 1.B.5 ÉTAPE 5 — CRÉER LE STATUT ET LE TITRE GUI

Créer le statut `MAIN` avec les fonctions `BACK`, `EXIT` et `CANCEL`, puis créer le titre `T100`. Les codes de fonction du statut doivent correspondre exactement aux valeurs traitées dans le `CASE` du PAI.

### 1.B.6 ÉTAPE 6 — CRÉER LA TRANSACTION

Dans `SE93`, créer une transaction de dialogue qui référence le module pool et le dynpro `0100`. Enregistrer les attributs puis activer le programme, l’écran, le statut, le titre et la transaction.

### 1.B.7 ÉTAPE 7 — TESTER LE CYCLE PBO/PAI

Lancer la transaction avec un breakpoint dans les deux modules. Vérifier le passage PBO, l’affichage, le passage PAI après une commande et la sortie correcte pour `BACK`, `CANCEL` et `EXIT`.

## 1.C CODE PRÊT À ADAPTER

```abap
PROGRAM zdemo_dynpro.

DATA gv_ok_code TYPE syucomm.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'MAIN'.
  SET TITLEBAR 'T100'.
ENDMODULE.

MODULE user_command_0100 INPUT.
  DATA(lv_ok_code) = gv_ok_code.
  CLEAR gv_ok_code. " Évite de retraiter la commande au prochain cycle PBO/PAI.

  CASE lv_ok_code.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
```

Logique du dynpro `0100` :

```text
PROCESS BEFORE OUTPUT.
  MODULE status_0100.

PROCESS AFTER INPUT.
  MODULE user_command_0100.
```

## 1.D CONTRÔLE

- La transaction affiche l’écran `0100`.
- Les trois commandes permettent de quitter normalement.
- Le débogueur passe par PBO avant l’affichage puis par PAI après une action utilisateur.

## 1.E COMPATIBILITÉ S/4HANA

Statut : compatible, réservé au développement SAP GUI classique.
