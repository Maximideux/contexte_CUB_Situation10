#========================================#
#                           	         #
# NOM : créerEnregistrementDNSTypeA      #
# AUTEUR : TERPREAU Maximilien           #
# DATE : 03 avril 2024 à 11h15           #
#                           	         #
#========================================#

<# Création d'un enregistrement DNS de Type A (adresse IP et CM) #>
$nombreHotes = Read-Host "Combien d'hôtes de type A souhaitez-vous enregistrer ?"
$informations = @()
for ($i = 1; $i -le $nombreHotes; $i++) {
    Write-Host "Hôte numéro $i"
    $nomHote = Read-Host "Quel est le nom de l'hôte ?"
    $zoneHote = Read-Host "Quelle est la zone (local.edimbourg.cub.sioplc.fr ou edimbourg.cub.sioplc.fr) ?"
    $adresseReseau = Read-Host "Quelle est l'adresse réseau associée à l'hôte $nomHote ?"
    $informationsHotes += [PSCustomObject]@{
        Type = "Type A"
        NomHote = $nomHote
        AdresseReseau = $adresseReseau
        Zone = $zoneHote
    }
    $enregistrement = Add-DnsServerResourceRecordA -Name $nomHote -ZoneName $zoneHote -IPv4Address $adresseReseau
}
Write-Host "Informations sur les hôtes enregistrés :"
$informationsHotes
