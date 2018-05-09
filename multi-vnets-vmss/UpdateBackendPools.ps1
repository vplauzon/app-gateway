$resourceGroupName = "appgw"
$appGatewayName = "AppGateway"
#  Map between the backend pool names of the Application gateway and the scale set names
$backendPoolToScaleSetNameMap = @{
    "backendPool" = "app-a-Pool";
    "scaleSet" = "App-A"
},
@{
    "backendPool" = "app-b-Pool";
    "scaleSet" = "App-B"
},
@{
    "backendPool" = "app-c-Pool";
    "scaleSet" = "App-C"
}


#  Fetch Application Gateway object
$ag = Get-AzureRmApplicationGateway -ResourceGroupName $resourceGroupName -Name $appGatewayName

$backendPoolToScaleSetNameMap | foreach{
    $backendPoolName = $_.backendPool
    $setName = $_.scaleSet

    #  Fetch IPs from the NICs attached to specified VMSS
    $ips = Get-AzureRmNetworkInterface -ResourceGroupName $resourceGroupName -VirtualMachineScaleSetName $setName |
        foreach {$_.IpConfigurations[0].PrivateIpAddress}
    #  Update Application Gateway object with ips
    $ag = Set-AzureRmApplicationGatewayBackendAddressPool -ApplicationGateway $ag -Name $backendPoolName `
        -BackendIPAddresses $ips
}

#  Update Application Gateway resource with the object
Set-AzureRmApplicationGateway -ApplicationGateway $ag
