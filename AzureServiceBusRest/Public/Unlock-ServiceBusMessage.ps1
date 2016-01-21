Function Unlock-ServiceBusMessage
{
    param(
    	$Message
    )
    
    UpdateAzureServiceBusToken

    $url =  "https://{0}.servicebus.windows.net/{1}/messages/{2}/{3}" -f $script:Namespace, $script:Queue, $Message.MessageId, $Message.LockToken
    $Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $Headers.Add("Authorization",$SasToken)
    $Headers.Add("Host",("{0}.servicebus.windows.net" -f $Namespace))
    Invoke-WebRequest $url -Method PUT -Headers $Headers
}