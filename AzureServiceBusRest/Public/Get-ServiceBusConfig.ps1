Function Get-ServiceBusConfig
{
	<#
    .SYNOPSIS
        Gets the configuration for further ServiceBus calls
    .DESCRIPTION
        Gets the configuration for further ServiceBus calls
    #>
	
	
	@{
		Namespace = $script:Namespace
		Queue = $script:Queue
		PolicyName = $script:PolicyName
		Key = "****"
		SasExpiration = $script:SasExpiration
		SasToken = "****"
	}
}