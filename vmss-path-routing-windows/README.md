### Application Gateway Integration fronting 3 VM Scale Sets and using URL Path based routing ###

Note:  Learn more about this template by reading this <a href="http://vincentlauzon.com/2017/05/08/url-routing-with…lication-gateway">blog article</a>.

This template deploys an Azure Application Gateway fronting 3 Windows VM Scale Sets using URL path routing.

Optionnally it can use <i>cookie-based affinity</i>.

The Application Gateway is configured to listen to port 80 and route requests to VMs in scale sets.

<img src="https://raw.githubusercontent.com/vplauzon/azure-quickstart-templates/master/201-app-gateway-vmss-url-path-routing-windows/images/Diagram.png" />
 
Note that this template installs simple HTML in VM Scale Set VMs using Desired State Configuration (DSC). 

This template supports VM scale sets of up to 1,000 VMs (non single placement) and uses Azure Managed Disks.

In order to test the routing, you need to find the URL to the AppGateway-IP public IP.  Let's say this is http://0dd86922-82a7-4a4a-bc22-720d8e5a2dc7.cloudapp.net/, then:

<ul>
<li>
http://0dd86922-82a7-4a4a-bc22-720d8e5a2dc7.cloudapp.net/ routes to the root of App-A
</li>
<li>
http://0dd86922-82a7-4a4a-bc22-720d8e5a2dc7.cloudapp.net/a/ routes to the sub folder 'a' of App-A
</li>
<li>
http://0dd86922-82a7-4a4a-bc22-720d8e5a2dc7.cloudapp.net/b/ routes to the sub folder 'b' of App-B
</li>
<li>
http://0dd86922-82a7-4a4a-bc22-720d8e5a2dc7.cloudapp.net/c/ routes to the sub folder 'c' of App-C
</li>
</ul>

Also note that there are three additional public IPs & load balancers, one associated to each VM Scale Set performing NAT to the RDP protocol.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fvplauzon%2Fapp-gateway%2Fmaster%2Fvmss-path-routing-windows%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fvplauzon%2Fapp-gateway%2Fmaster%2Fvmss-path-routing-windows%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>
