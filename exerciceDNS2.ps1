#============================================#
#                           	             #
# NOM : créerEnregistrementDNSTypeAOuCNAME   #
# AUTEUR : TERPREAU Maximilien               #
# DATE : 03 avril 2024 à 11h15               #
#                           	             #
#============================================#

<# Création d'un enregistrement DNS de Type A (adresse IP et CM) ou CNAME#>
Add-Type -AssemblyName Microsoft.VisualBasic
[string]$typeEnregistrement = [Microsoft.VisualBasic.Interaction]::InputBox("Quel type d'enregistrement voulez-vous ? (A ou CNAME) ?")
if ($typeEnregistrement -eq "A") {
    $nombreHotes = [Microsoft.VisualBasic.Interaction]::InputBox("Combien d'hôtes de type A souhaitez-vous enregistrer ?")
    $informationsA = @()
    for ($i = 1; $i -le $nombreHotes; $i++) {
        $nomHote = [Microsoft.VisualBasic.Interaction]::InputBox("Quel est le nom de l'hôte ?", "Hôte numéro $i")
        $zoneHote = [Microsoft.VisualBasic.Interaction]::InputBox("Quelle est la zone (local.edimbourg.cub.sioplc.fr) ?", "Hôte numéro $i")
        $adresseReseau = [Microsoft.VisualBasic.Interaction]::InputBox("Quelle est l'adresse réseau associée à l'hôte $nomHote ?", "Hôte numéro $i")
        $informationsA += [PSCustomObject]@{
            Type = $typeEnregistrement
            NomHote = $nomHote
            AdresseReseau = $adresseReseau
            Zone = $zoneHote
        }
        try {
            $enregistrement = Add-DnsServerResourceRecordA -Name $nomHote -ZoneName $zoneHote -IPv4Address $adresseReseau
            [Microsoft.VisualBasic.Interaction]::MsgBox("Informations sur les hôtes enregistrés :" , "Information" , "Enregistrements")
            $resultat = Get-DnsServerResourceRecord -ZoneName $zoneHote
            $message = ""
                foreach ($prop in $resultat | Get-Member -MemberType Properties) 
                {
                    $message += "$($prop.Name): $($resultat.$($prop.Name))`n"
                }
            [Microsoft.VisualBasic.Interaction]::MsgBox($message, "Information", "Informations des enregistrements")
        }
        catch {
            [Microsoft.VisualBasic.Interaction]::MsgBox("Il y a eu une erreur dans le code, les informations rentrées ne sont pas correctes")
        }
        $informationsA = $null
    }
}elseif ($typeEnregistrement -eq "CNAME") {
    $nombreHotes = [Microsoft.VisualBasic.Interaction]::InputBox("Combien d'hôtes de type CNAME souhaitez-vous enregistrer ?")
    $informationsCNAME = @()
    for ($i = 1; $i -le $nombreHotes; $i++) {
        $nomHote = [Microsoft.VisualBasic.Interaction]::InputBox("Quel est le nom de l'hôte ?", "Hôte numéro $i")
        $zoneHote = [Microsoft.VisualBasic.Interaction]::InputBox("Quelle est la zone (local.edimbourg.cub.sioplc.fr) ?", "Hôte numéro $i")
        $nomAlias = [Microsoft.VisualBasic.Interaction]::InputBox("Quelle est le nom alias associé à $nomHote ?", "Hôte numéro $i")
        $informationsCNAME += [PSCustomObject]@{
            Type = $typeEnregistrement
            NomHote = $nomHote
            Alias = $nomAlias
            Zone = $zoneHote
        }
        try {
            Add-DnsServerResourceRecordCName -Name $nomHote -HostNameAlias $nomAlias -ZoneName $zoneHote
            [Microsoft.VisualBasic.Interaction]::MsgBox("Informations sur les hôtes enregistrés :" , "Information" , "Enregistrements")
            $message = ""
            $resultat = Get-DnsServerResourceRecord -ZoneName $zoneHote
            foreach ($prop in $resultat | Get-Member -MemberType Properties) 
                {
                    $message += "$($prop.Name): $($resultat.$($prop.Name))`n"
                }
            [Microsoft.VisualBasic.Interaction]::MsgBox($message, "Information", "Informations des enregistrements")
            }
        catch {
            [Microsoft.VisualBasic.Interaction]::MsgBox("Il y a eu une erreur dans le code, les informations rentrées ne sont pas correctes")
            }
        $informationsCNAME = $null
    }
}else{
    [Microsoft.VisualBasic.Interaction]::MsgBox("Ce n'est pas un type d'enregistrement DNS!" , "Informations" , "Erreur de type !")
}