$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()

$PDC = ($domainObj.PdcRoleOwner).Name
$searchString = "LDAP://{0}/DC={1}" -f $PDC,$domainObj.Name.Replace('.', ',DC=')

$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
$objDomain = New-Object System.DirectoryServices.DirectoryEntry
$Searcher.SearchRoot = $objDomain

function SearchNested ($Search, $Name)
{
	$Search.filter="(name=$Name)"
	$Result = $Search.FindAll()
	Foreach($obj in $Result)
	{
		# Print member and search inside the nested group if member is not null (exists)
		if (-Not [string]::IsNullOrEmpty($obj.Properties.member)) {
			$Member = $obj.Properties.member.Split(",").Split("=")[1]
			Write-Host $Member

			SearchNested $Searcher $Member
		}
	}
}

SearchNested $Searcher "Super_Secret_Group"
