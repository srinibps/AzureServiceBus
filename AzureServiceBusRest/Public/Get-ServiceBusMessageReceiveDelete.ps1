Function Get-ServiceBusMessageReceiveDelete
{
    UpdateAzureServiceBusToken

    $GetMessageUrl =  "https://{0}.servicebus.windows.net/{1}/messages/head" -f $script:Namespace, $script:Queue
    $Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $Headers.Add("Authorization",$SasToken)
    $Headers.Add("Host",("{0}.servicebus.windows.net" -f $Namespace))
    $response = Invoke-WebRequest $GetMessageUrl -Method DELETE -Headers $Headers
    
    $message = ParseMessage($response)
    
    return $message
}