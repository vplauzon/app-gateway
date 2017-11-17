$resourceGroupName = "appgw"
$appGatewayName = "AppGateway"

#  Fetch Application Gateway object
$ag = Get-AzureRmApplicationGateway -ResourceGroupName $resourceGroupName -Name $appGatewayName

#  Grab backend address pools (A, B, C)
$backendAddressPoolA = $ag.BackendAddressPools | where {$_.Name -eq "app-a-Pool"}
$backendAddressPoolB = $ag.BackendAddressPools | where {$_.Name -eq "app-b-Pool"}
$backendAddressPoolC = $ag.BackendAddressPools | where {$_.Name -eq "app-c-Pool"}

#  Grab http settings (in our case, there is only one)
$backendHttpSetting = $ag.BackendHttpSettingsCollection[0]

#  Grab existing rules
$rules = $ag.UrlPathMaps[0].PathRules

#  Create a new rule, "rule-D"
$newRule = New-AzureRmApplicationGatewayPathRuleConfig -Name "rule-D" -Paths "/d/*" `
    -BackendAddressPoolId $backendAddressPoolA.Id `
    -BackendHttpSettingsId $backendHttpSetting.Id

#  Add the rule to existing rules (inplace)
$rules.Add($newRule)

#  Update Application Gateway resource with the object
Set-AzureRmApplicationGateway -ApplicationGateway $ag
