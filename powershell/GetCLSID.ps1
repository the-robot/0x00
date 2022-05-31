# Sauce: https://medium.com/r3d-buck3t/impersonating-privileges-with-juicy-potato-e5896b20d505

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
$CLSID = Get-ItemProperty HKCR:\clsid\* | select-object AppID,@{N='CLSID'; E={$_.pschildname}} | where-object {$_.appid -ne $null}

foreach($a in $CLSID)
{
  Write-Host $a.CLSID
}
