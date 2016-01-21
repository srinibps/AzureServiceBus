Function Get-ServiceBusMessagePeekLock
{
	<#
    .SYNOPSIS
        Get a message from ServiceBus and lock for processing.
    .DESCRIPTION
        Get a message from ServiceBus and lock for processing.
    #>
	
	UpdateAzureServiceBusToken

	$GetMessageheaders =  "https://{0}.servicebus.windows.net/{1}/messages/head" -f $script:Namespace, $script:Queue
	$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$headers.Add("Authorization",$script:SasToken)
	$headers.Add("Host",("{0}.servicebus.windows.net" -f $script:Namespace))
	$response = Invoke-WebRequest $GetMessageheaders -Method POST -headers $headers
	
	$message = ParseMessage($response)
	
	$message
}