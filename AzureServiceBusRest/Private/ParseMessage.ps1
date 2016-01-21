function ParseMessage
{

	param(
		$response
	)

    $message = new-object Message;
    $message.Content = $response.Content
    $message.DequeuedTimeUtc = (Get-Date).ToUniversalTime()

    $properties = ($response.Headers["BrokerProperties"] | ConvertFrom-Json);
    if ($properties) {
        $message.DeliveryCount = $properties.DeliveryCount;
        $message.EnqueuedSequenceNumber = $properties.EnqueuedSequenceNumber;
        $message.EnqueuedTimeUtc = ([DateTime]$properties.EnqueuedTimeUtc).ToUniversalTime();
        $message.LockToken = $properties.LockToken;
        $message.LockedUntilUtc = ([DateTime]$properties.LockedUntilUtc).ToUniversalTime();
        $message.MessageId = $properties.MessageId;
        $message.PartitionKey = $properties.PartitionKey;
        $message.SequenceNumber = $properties.SequenceNumber;
        $message.State = $properties.State;
        $message.TimeToLive = $properties.TimeToLive;
    }
    
    $message

}