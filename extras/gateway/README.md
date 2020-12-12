# Installs services for webthings.io gateway

Use install.sh to install base framework

The gateway is not required for any device. A central gateway will work as long as it supports ssl to the
thing. This may require updating node on an existing system.

Nginx is used as a proxy to the gateway locally --  pagekite can still be set up for external access.

Node 12.x needs to be installed so that extra-certs will work with the gateway (for ssl use in the things). If ssl is not
to be used node does not have to be upgraded. The installer in m2ag-thing-builder can be used. Remove the system installed
node before installing.

bash m2ag-labs/installer/extras/install_node.sh 12.18.3

Generally, these guides assume ssl is the preferred option and will be geared to that. Access the gateway directly at
8080 if not using ssl.

Install the gateway minimally on an exiting pi system. Gives a little more flexibility, but will not have
the auto update or other services that Mozilla image offers.

To install on a Raspbian image (assumes m2ag-builder is installed)

Use 'sudo m2ag-labs/installer/extras/gateway/install_gateway.sh' to install systemd and nginx configs
Ensure the file  ~/.m2ag-labs/ssl/rootca.crt exists.
The service will be mozilla-gateway.service. The ssl port for the gateway will be 8443.

Test the gateway by running 'node build/gateway.js'
The gateway should start with no errors. There will be no addons installed.
The gateway will be available on port 8080.
If you add the webthings adapter it will complain: "unable to verify the first certificate" when ssl
enabled things are found.
Go ahead and do the initial setup and get the gateway working with no ssl (on the gateway server -- not the addon -- that is handled with node_extra_certs)






