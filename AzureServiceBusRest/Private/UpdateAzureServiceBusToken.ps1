Function UpdateAzureServiceBusToken
{
	param
	(
		[Alias("Config")]
		[ref]$ServiceBusConfig
	)

	if (!$ServiceBusConfig -and !$ServiceBusConfig.Value)
	{
		throw "ServiceBusConfig parameter not specified."
	}
	
	if (!$ServiceBusConfig.Value.Namespace -or !$ServiceBusConfig.Value.Queue -or !$ServiceBusConfig.Value.PolicyName -or !$ServiceBusConfig.Value.Key)
	{
		throw "ServiceBus configuration not valid.  Call Set-ServiceBusConfig."
	}

	elseif ($ServiceBusConfig.Value.SasToken -eq "" -or $ServiceBusConfig.Value.SasExpiration -lt (Get-Date).ToUniversalTime())
	{
		$ServiceBusConfig.Value.SasExpiration = (Get-Date).ToUniversalTime().AddHours(1)

		$TimeSpan = (New-TimeSpan -Start (Get-Date -Year 1970 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0) -End $ServiceBusConfig.Value.SasExpiration)

		$ServiceBusUrl = "https://{0}.servicebus.windows.net/{1}" -f $ServiceBusConfig.Value.Namespace,$ServiceBusConfig.Value.Queue

		$hmacsha = New-Object System.Security.Cryptography.HMACSHA256
		$hmacsha.key = [Text.Encoding]::UTF8.GetBytes($ServiceBusConfig.Value.Key)

		$signature = [uri]::EscapeDataString($ServiceBusUrl) + "`n" + $TimeSpan.TotalSeconds
		$signature = $hmacsha.ComputeHash([Text.Encoding]::UTF8.GetBytes($signature))
		$signature = [Convert]::ToBase64String($signature)
		$signature = [uri]::EscapeDataString($signature)
		
		$ServiceBusConfig.Value.SasToken = "SharedAccessSignature sr={0}&sig={1}&se={2}&skn={3}" -f ([uri]::EscapeDataString($ServiceBusUrl)), $signature, $TimeSpan.TotalSeconds, $ServiceBusConfig.Value.PolicyName
	}
}