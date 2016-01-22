Function Get-ServiceBusMessagePeekLock
{
	<#
    .SYNOPSIS
        Retrieves and locks a message for processing as an atomic operation.
    .DESCRIPTION
        This operation atomically retrieves and locks a message from a queue or subscription for processing. The message is guaranteed not to be delivered to other receivers (on the same queue or subscription only) during the lock duration specified in the queue/subscription description. When the lock expires, the message becomes available to other receivers. In order to complete processing of the message, the receiver should issue a delete command with the lock ID received from this operation. To abandon processing of the message and unlock it for other receivers, an Unlock Message command should be issued, otherwise the lock duration period can expire.
        This operation should be used in applications that require At-Least-Once delivery assurances. If the receiver does not delete the message before processing succeeds, this ensures that another receiver is able to attempt processing after the lock duration period expires.
    .LINK
        https://msdn.microsoft.com/en-us/library/azure/hh780722.aspx
    #>

    $Url =  "https://{0}.servicebus.windows.net/{1}/messages/head" -f $script:Namespace, $script:Queue
    $response = SendWebRequest -Url $Url -Method POST
	$message = ParseMessage($response)
	$message
}