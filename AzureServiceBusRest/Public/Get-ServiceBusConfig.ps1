Function Get-ServiceBusConfig
{
	<#
    .SYNOPSIS
        Gets the configuration for further ServiceBus calls
    .DESCRIPTION
        Gets the configuration for further ServiceBus calls
    #>
	
	[cmdletbinding()]
	param(

	)
	
	@{
		Namespace = $script:Namespace
		Queue = $script:Queue
		PolicyName = $script:PolicyName
		Key = "****"
		SasExpiration = $script:SasExpiration
		SasToken = "****"
	}
}