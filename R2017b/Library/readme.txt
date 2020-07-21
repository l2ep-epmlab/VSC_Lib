Date : 21/07/2020
Auteur : Antoine Bruyère
Objet : Demande de modification sur les modèles génériques 

Fichiers impactés :
- Control_Lib.slx (Matlab version R2020a)
- GFo_Lib.slx (Matlab version R2020a)

Autres fichiers remis dans l'archive zip :
- {GFo_Dev.slx ; init.m ; LoadFlow_VSC.m} : permet de tester les modèles modifiés
- {Control_Lib_R2017b.slx ; GFo_Lib_R2017b.slx} : fichiers impactés sous la version Matlab R2017b
 

Description des changements :

1. Control_Lib.slx :

a. Ajout modèles de transformation de Park génériques, permettant de choisir l'axe de référence et le gain de normalisation en per-unit

b. Ajout modèle modifié de PLL, qui reprend les transformations de Park génériques

c. Calcul du cosinus et sinus de l'angle à l'endroit où l'angle est produit.



2. GFo_Lib.slx : 

a. L-Filter modèle : intégration des modifications de la librairie Control_Lib.slx au modèle de convertisseur VSC avec filtre L
   Tests de non régression : OK

b. LCL-Filter : intégration des modifications de la librairie Control_Lib.slx au modèle de convertisseur VSC avec filtre L
   ATTENTION : le modèle n'a pas pu être etsté car les modifications ont été faites sur un modèle qui ne fonctionnait pas (problème de masque sur filtre LC)
   

