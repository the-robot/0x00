$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()

$PDC = ($domainObj.PdcRoleOwner).Name
$searchString = "LDAP://{0}/DC={1}" -f $PDC,$domainObj.Name.Replace('.', ',DC=')

$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
$objDomain = New-Object System.DirectoryServices.DirectoryEntry
$Searcher.SearchRoot = $objDomain

function EnumService ($Search, $Service)
{
	Write-Host "Enumerating Service: $Service"

	$Search.filter="serviceprincipalname=$Service"
	$Result = $Search.FindAll()
	Foreach($obj in $Result)
	{
		Foreach($prop in $obj.Properties) { $prop }

		# get IP using ns-lookup from serviceprincipalname property
		$propName = "serviceprincipalname"
		$url = $obj.Properties[$propName].Split("/")[1]
		Write-Host ""
		Write-Host "nslookup $url"
		nslookup $url
	}
	Write-Host "---------------------"
	Write-Host ""
}

$Services = @('*http*', '*smtp*', '*smb*', '*ftp*', '*sql*', "*termsrv*", "*krbtgt*")

Foreach($Service in $Services)
{
	EnumService $Searcher $Service
}
