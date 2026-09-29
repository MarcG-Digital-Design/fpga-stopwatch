# Configuration du dépôt

Les cinq sources VHDL actives ont été copiées sans modification depuis le dossier Chronometre présent dans le même répertoire parent.

## Modifications de configuration

- Sources regroupées dans rtl/ et référencées par des chemins relatifs depuis quartus/.
- diviseur_seconde.vhd déclaré explicitement dans le projet Quartus.
- Affectations de broches et standards électriques conservés pour les 35 ports utilisés : horloge, deux interrupteurs et quatre afficheurs de huit bits.
- Référence FPGA d'origine conservée : 10M50DAF484C6GES. À confirmer sur la carte physique.
- Contrainte d'horloge ajoutée : 50 MHz, soit une période de 20 ns.
- Références aux modules non instanciés counter_seconde.vhd et DE10_LITE_Golden_Top.v retirées du nouveau projet. Leurs fichiers restent dans le dossier original.
- Anciennes configurations d'export Stamp, ViewDraw et IBIS non reprises.
- Fichiers de compilation, sauvegardes et réglages personnels exclus par .gitignore.
- Script sim/compile.do créé pour compiler les sources avec des chemins portables. Ce n'est pas un testbench.

## Documentation

architecture.png est l'image extraite du document Word fourni. Le Word reste dans le dossier original : son texte est inachevé et ne sert pas de rapport final pour ce dépôt. Le README décrit le code actuel ; le schéma illustre les blocs fonctionnels avec une nomenclature différente.

## Vérifications et limites

Les chemins des sources et de la contrainte ont été contrôlés. Les sources copiées sont identiques aux originales et les affectations des broches utilisées ont été préservées.

Aucune nouvelle compilation Quartus, simulation fonctionnelle ou validation sur carte n'a été effectuée. La présence de la contrainte de 20 ns ne constitue pas une preuve de respect du timing. Les contraintes d'entrées/sorties et la synchronisation des interrupteurs restent à étudier.

## Dépôt Git parent

fpga-stopwatch est actuellement un sous-dossier du dépôt Git MarcG-Digital-Design. Aucun dépôt Git imbriqué, commit ou envoi vers GitHub n'a été créé. Pour le publier comme dépôt indépendant, il faudra utiliser fpga-stopwatch comme racine du dépôt souhaité.
