function Get-InstallComponents( [HashTable]$pp )
{
    if($pp.Components){
        $res += $pp.Components
    }

    if ($res.Length -eq 0) { return }
    return '/COMPONENTS="{0}"' -f ($res -join ",")
}

function Get-InstallOptions( [HashTable]$pp )
{
    
    if ($pp.Full -And $pp.Components) {
        throw "Invalid argument /Components used with /Full, please use only one"
    }
    
    if ($pp.NoIcons) { 
        $res += '/NOICONS', '/TASKS=""'
    } 
    
    if ($pp.Full) {
        $res += "/TYPE=full"
    }

#    $tasks += "desktopicon", "quicklaunchicon"
#    return '/TASKS="{0}"' -f ($res -join ",")
    return $res
}