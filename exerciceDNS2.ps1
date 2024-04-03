#========================================#
#                           	         #
# NOM : créerEnregistrementDNSTypeA      #
# AUTEUR : TERPREAU Maximilien           #
# DATE : 03 avril 2024 à 11h15           #
#                           	         #
#========================================#

<# Création d'un enregistrement DNS de Type A (adresse IP et CM) ou CNAME#>
[string]$typeEnregistrement = Read-Host "Quel type d'enregistrement voulez-vous ? (A ou CNAME) ?"
if ($typeEnregistrement -eq "A") {
    $nombreHotes = Read-Host "Combien d'hôtes de type A souhaitez-vous enregistrer ?"
    $informationsA = @()
    for ($i = 1; $i -le $nombreHotes; $i++) {
        Write-Host "Hôte numéro $i"
        $nomHote = Read-Host "Quel est le nom de l'hôte ?"
        $zoneHote = Read-Host "Quelle est la zone (local.edimbourg.cub.sioplc.fr) ?"
        $adresseReseau = Read-Host "Quelle est l'adresse réseau associée à l'hôte $nomHote ?"
        $informationsA += [PSCustomObject]@{
            Type = $typeEnregistrement
            NomHote = $nomHote
            AdresseReseau = $adresseReseau
            Zone = $zoneHote
        }
        try {
            $enregistrement = Add-DnsServerResourceRecordA -Name $nomHote -ZoneName $zoneHote -IPv4Address $adresseReseau
            Write-Host "Informations sur les hôtes enregistrés :"
            $informationsHotes
        }
        catch {
            Write-Host "Il y a eu une erreur dans le code, les informations rentrées ne sont pas correctes"
        }
        $informationsA = $null
    }
}elseif ($typeEnregistrement -eq "CNAME") {
    $nombreHotes = Read-Host "Combien d'hôtes de type CNAME souhaitez-vous enregistrer ?"
    $informationsCNAME = @()
    for ($i = 1; $i -le $nombreHotes; $i++) {
        Write-Host "Hôte numéro $i"
        $nomHote = Read-Host "Quel est le nom de l'hôte ?"
        $zoneHote = Read-Host "Quelle est la zone (local.edimbourg.cub.sioplc.fr) ?"
        $nomAlias = Read-Host "Quelle est le nom alias associé à $nomHote ?"
        $informationsCNAME += [PSCustomObject]@{
            Type = $typeEnregistrement
            NomHote = $nomHote
            Alias = $nomAlias
            Zone = $zoneHote
        }
        try {
            Add-DnsServerResourceRecordCName -Name $nomHote -HostNameAlias $nomAlias -ZoneName $zoneHote
            Write-Host "Informations sur les hôtes enregistrés :"
            $informationsCNAME
        }
        catch {
            Write-Host "Il y a eu une erreur dans le code, les informations rentrées ne sont pas correctes"
        }
        $informationsCNAME = $null
    }
}else{
    Write-Host "Ce n'est pas un type d'enregistrement DNS!"
}