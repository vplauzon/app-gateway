# Application Gateway Integration with 2 VNETs peered together

This POC highlights the current (as of end-of-October 2017) limitation of Application Gateway of
not being able to route to VMSS outside its VNET.

You can find a detailed discussion of this POC in this
[blog post](http://vincentlauzon.com/2017/11/20/using-application-gateway-with-vnet-peering).

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fvplauzon%2Fapp-gateway%2Fmaster%2Fmulti-vnets-vmss%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fvplauzon%2Fapp-gateway%2Fmaster%2Fmulti-vnets-vmss%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

The limitation is based on a test done when a VMSS tries to register itself to the Application
Gateway ; if we input the VMSS private IPs directly in the App Gateway backend pools, this
works flawlessly.

For this reason the PowerShell script [UpdateBackendPools.ps1](UpdateBackendPools.ps1) automates
the process of matching the VMSS private IPs to the backend pool.

## Update limitations

Until the limitation is lifted we could run the PowerShell script every few minutes via
Azure Automation.

For a fixed VMSS, i.e. VMSS with fixed amount of instances, it would be a viable solution since
VMs inside the VMSS do not change private IPs.

For a VMSS using autoscale, this solution could be slightly sub optimal.  In the case of the
number of instances increasing, the new instances wouldn't be seen by the App Gateway until
the script is executed.  In the case of reduced number of instances, the App Gateway probes
would fail on the removed VMs until the script is executed.

## Update routes

Since we now update the Application Gateway outside of the ARM template, it forces
us to do other updates via PowerShell.  This is because if we would re-run the ARM template
we would lose the VM registered via PowerShell.

For instance, if we want to ajust a route, we need to use PowerShell.  This is given as an
example in [ChangeRule.ps1](ChangeRule.ps1) where we add a rule, *rule-D*, to the main url map.