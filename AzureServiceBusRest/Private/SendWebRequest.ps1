Function SendWebRequest
{
    param
    (
        $Url,
        $Method,
        $Content
    )

    UpdateAzureServiceBusToken

    $headers = @{ "Authorization" = $script:SasToken
                  "Host" = "{0}.servicebus.windows.net" -f $script:Namespace}

    if ($Content)
    {
        return (Invoke-WebRequest $Url -Headers $headers -Method $Method -UseBasicParsing -Body $Content -ContentType "application/atom+xml;type=entry;charset=utf-8")
    }
    else
    {
        return (Invoke-WebRequest $Url -Headers $headers -Method $Method -UseBasicParsing)    
    }
}