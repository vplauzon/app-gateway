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
Gateway.

Until this template can deploy without errors, we can tell the limitation exist.