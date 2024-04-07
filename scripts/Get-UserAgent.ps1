function Get-UserAgent {
  # Uses PowerShell's prebuilt UA strings. See
  # http://goo.gl/9IGloI
  param (
        [ValidateSet('Firefox','Chrome','InternetExplorer','Opera','Safari')]
        [string]$browsertype
  )
  
  if (!$browsertype) {
    $browsers    = @('Firefox','Chrome','InternetExplorer','Opera','Safari')
    $browsertype = Get-Random -InputObject $browsers
  }

  [Microsoft.PowerShell.Commands.PSUserAgent]::$browsertype
	
}