## Powershell Module for interacting with Azure ServiceBus via the REST API

This is my first attempt and writing a Powershell module, so I'm hoping this goes well.

This module is to facilitate accessing the Azure ServiceBus Queus via the REST API.  I wrote this specifically for use with Azure Automation so that I could get messages from ServiceBus and process them.  The goal is to use this instead of having to stand up a VM to help process messages coming into the Queue.

### Installing

If you want to run this locally, you should be able to install it as any other Powershell Module:
```
	Import-Module .\AzureServiceBusRest.psd1 -Verbose
```

### Instructions

The first time you run it, you will need to provide it with credentials for ServiceBus.  This can be done with the command:
```
	Set-ServiceBusConfig -Namespace "{namespace}" -Queue "{queue}" -PolicyName "{policyname}" -Key "{key}"
```
	
After that is called, it will cache those settings and use them for authentication continuing to renew an expiring token as necessary.  Most of the functions of the REST API are supported in this module.  The REST API can be found at https://msdn.microsoft.com/en-us/library/azure/hh780762.aspx

### Commands

* Set-ServiceBusConfig: Used to set the configuration for future calls.  See Instructions section.
* Get-ServiceBusConfig: Returns the current ServiceBus configuration.
* Add-ServiceBusMessage: Adds a message to the ServiceBus queue.  Takes a single paramenter "message" that should be a string.  https://msdn.microsoft.com/en-us/library/azure/hh780786.aspx
```
		Add-ServiceBusMessage -Message "some sting that could be whatever including serialize json or xml"
```
* Get-ServiceBusMessagePeekLock: Gets and locks a message from the queue.  Returns a message object containing the BrokerProperties and Body of the message.  https://msdn.microsoft.com/en-us/library/azure/hh780722.aspx

* Get-ServiceBusMessageReceiveDelete: Gets and deletes a message from the queue.  https://msdn.microsoft.com/en-us/library/azure/hh780770.aspx

* Unlock-ServiceBusMessage: Unlocks a message that was locked by Get-ServiceBusMessagePeekLock.  https://msdn.microsoft.com/en-us/library/azure/hh780737.aspx
```
		Unlock-ServiceBusMessage -Message {messageOjectFromGet-ServiceBusMessagePeekLock}
```
* Remove-ServiceBusMessage: Deletes a message that was previously locked by Get-ServiceBusMessagePeekLock.  https://msdn.microsoft.com/en-us/library/azure/hh780768.aspx
```
		Remove-ServiceBusMessage -Message {messageOjectFromGet-ServiceBusMessagePeekLock}
```
