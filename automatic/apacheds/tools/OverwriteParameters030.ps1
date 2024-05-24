function OverwriteParameters030 {
	$arguments = @{};
	$packageParameters = $env:chocolateyPackageParameters;

	if($packageParameters) {
		$MATCH_PATTERN = "/([a-zA-Z]+)=([`"'])?(.*)([`"'])?"
		$PARAMATER_NAME_INDEX = 1
		$VALUE_INDEX = 3
		
		if($packageParameters -match $MATCH_PATTERN){
			$results = $packageParameters | Select-String $MATCH_PATTERN -AllMatches 
			$results.matches | % { 
			$arguments.Add(
				$_.Groups[$PARAMATER_NAME_INDEX].Value.Trim(),
				$_.Groups[$VALUE_INDEX].Value.Trim()) 
			}
		}     
		
		if($arguments.ContainsKey("InstallLocation")) {
			$global:installLocation = $arguments["InstallLocation"];
			Write-Host "Value variable installLocation changed to $global:installLocation"
		}
	}	
}