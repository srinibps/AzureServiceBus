Function Add-ServiceBusMessage
{
    <#
    .SYNOPSIS
        Enqueues a message into the specified queue or topic.
    .DESCRIPTION
        Sends a message to a Service Bus queue or topic.
    .PARAMETER Message
        A string containing the message to be sent.  You can send JSON or XML but this should already be serialized to a string.
    .EXAMPLE
        Add-ServiceBusMessage -Message "some sting that could be whatever including serialize json or xml"
    .LINK
        https://msdn.microsoft.com/en-us/library/azure/hh780786.aspx
    #>

	param (
		[alias('Message')]
		[string]$messageString
	)

    $Url =  "https://{0}.servicebus.windows.net/{1}/messages" -f $script:Namespace, $script:Queue
    $response = SendWebRequest -Url $Url -Method POST -Content $messageString

}