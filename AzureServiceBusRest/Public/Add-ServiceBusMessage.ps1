Function Add-ServiceBusMessage
{

	param (
		[alias('Message')]
		[string]$messageString
	)

    UpdateAzureServiceBusToken

    $GetMessageUrl =  "https://{0}.servicebus.windows.net/{1}/messages" -f $script:Namespace, $script:Queue
    $Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $Headers.Add("Authorization",$SasToken)
    $Headers.Add("Host",("{0}.servicebus.windows.net" -f $Namespace))
    Invoke-WebRequest $GetMessageUrl -Method POST -Headers $Headers -Body $messageString -ContentType "application/atom+xml;type=entry;charset=utf-8"
}