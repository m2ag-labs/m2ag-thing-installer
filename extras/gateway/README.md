# Install services for webthings.io gateway

Ensure the m2ag.labs thing builder has been installed before proceeding.

The gateway is not required for any device. A central gateway will work as long as it supports ssl to the
thing. This may require updating node on an existing system.

Nginx is used as a proxy to the gateway locally --  pagekite can still be set up for external access.

Node 12.x needs to be installed so that extra-certs will work with the gateway (for ssl use in the things).  
If ssl is not to be used, node does not have to be upgraded.
```
bash m2ag-labs/installer/extras/gateway/install_node.sh 12.18.3
```
Generally, these guides assume ssl is the preferred option and will be geared to that. Access the gateway directly at
8080 if not using ssl.

To install the gateway minimally on an exiting pi system use the install_gateway.sh. This install gives a little more flexibility, but will not have
the auto update or other services that Mozilla image offers.

To install on a Raspbian image (assumes m2ag-builder is installed)
Ensure the file  ~/.m2ag-labs/ssl/rootca.crt exists.
```
bash m2ag-labs/installer/extras/gateway/install_gateway.sh
```
The service will be m2ag-gateway.service. The ssl port for the gateway will be 8443. Browse to {your device}.local:8443
to complete the setup process for the gateway.

There will be no addons installed.




