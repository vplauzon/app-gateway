### Application Gateway Integration with 2 VNETs peered together ###

This POC highlights the current (as of end-of-October 2017) limitation of Application Gateway of
not being able to route to VMSS outside its VNET.

The limitation is based on a test done when a VMSS tries to register itself to the Application Gateway ;
if we input the VMSS private IPs directly in the App Gateway backend pools, this works flawlessly.

For this reason the PowerShell script [UpdateBackendPools.ps1](UpdateBackendPools.ps1) automates
the process of matching the VMSS private IPs to the backend pool.


Until the limitation is lifted we could run the PowerShell script every few minutes via
Azure Automation.

For a fixed VMSS, i.e. VMSS with fixed amount of instances, it would be a viable solution since
VMs inside the VMSS do not change private IPs.

For a VMSS using autoscale, this solution could be slightly sub optimal.  In the case of the number
of instances increasing, the new instances wouldn't be seen by the App Gateway until the script is
executed.  In the case of reduced number of instances, the App Gateway probes would fail on the removed
VMs until the script is executed.