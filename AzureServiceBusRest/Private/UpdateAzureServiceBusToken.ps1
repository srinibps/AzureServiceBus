Function UpdateAzureServiceBusToken
{
	if (!$script:Namespace -or !$script:Queue -or !$script:PolicyName -or !$script:Key)
	{
		throw "ServiceBus configuration not set.  Call Set-ServiceBusConfig."
	}

	elseif ($script:SasToken -eq "" -or $script:ExpirationDate -lt (Get-Date).ToUniversalTime())
	{
		$script:ExpirationDate = (Get-Date).ToUniversalTime().AddHours(1)

		$TimeSpan = (New-TimeSpan -Start (Get-Date -Year 1970 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0) -End $ExpirationDate)

		$ServiceBusUrl = "https://{0}.servicebus.windows.net/{1}" -f $script:Namespace,$script:Queue

		$hmacsha = New-Object System.Security.Cryptography.HMACSHA256
		$hmacsha.key = [Text.Encoding]::UTF8.GetBytes($script:Key)

		$signature = [uri]::EscapeDataString($ServiceBusUrl) + "`n" + $TimeSpan.TotalSeconds
		$signature = $hmacsha.ComputeHash([Text.Encoding]::UTF8.GetBytes($signature))
		$signature = [Convert]::ToBase64String($signature)
		$signature = [uri]::EscapeDataString($signature)
		
		$script:SasToken = "SharedAccessSignature sr={0}&sig={1}&se={2}&skn={3}" -f ([uri]::EscapeDataString($ServiceBusUrl)), $signature, $TimeSpan.TotalSeconds, $script:PolicyName
	}
}