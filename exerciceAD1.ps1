#========================================#
#                           	         #
# NOM : créerUO                          #
# AUTEUR : TERPREAU Maximilien           #
# DATE : 03 avril 2024 à 11h15           #
#                           	         #
#========================================#

<# Création d'une Unité d'Organisation #>
$réponse = Read-Host "Voulez vous créer une Unité d'Organisation (Y/n) ?"

Do{
$nomUO = Read-Host "Quel sera son nom ?"
New-ADOrganizationalUnit -Name $nomUO -Path "DC=local,DC=edimbourg,DC=cub,DC=sioplc,DC=fr"
$réponse = Read-Host "Voulez- vous créer une autre UO (Y/n) ?"
} While ($réponse -eq 'Y' )