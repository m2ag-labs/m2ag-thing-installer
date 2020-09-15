# Installs services for mozilla-iot

Use install.sh to install base framework

The gateway is not required for any device. A central gateway will work as long as it supports ssl to the
thing. This may require updating node on an existing system.

Nginx is used as a proxy to the gateway -- I have not been able to get browser notifications to work in this
context. Pagekite is not addressed by the installer. If is working before the install it should work after.

There are two options for integrating with the Mozilla IoT gateway on a device. Both options will require Node 12.x
to be installed so that extra-certs will work with the gateway (for ssl use in the things). If ssl is not
to be used node does not have to be upgraded.

Generally, these guides assume ssl is the preferred option and will be geared to that. Modifications to
nginx configs will need to be made if not using ssl.


Install on existing setup -- most likely installing on the Mozilla raspberry pi image. Using the
Mozilla image has the benefit of easier wifi setup -- the device will act as a hot spot so that a
network can be configured. Plus all the update services are enabled and running.

Node needs to be upgraded and npm install rerun to get node extra certs to work
The nginx config for the client needs to be modified.
    edit /etc/nginx/sites-available/m2ag-client   -- change the port to 9443 (or other unused port)

Or

Install the gateway minimally on an exiting pi system. Gives a little more flexibility, but will not have
the auto update or other services that Mozilla image offers.

To install on a Raspbian image.

1. Ensure node 12.x is installed. Desktop currently comes with 10.x, but I have not been able to get
node extra certs to work on 10.x
    remove node 10 with -- sudo apt remove nodejs -y
    add new node        -- sudo bash m2ag-labs/installer/extras/gateway/install_node.sh 12.18.3
    reboot the device

2. Clone the gateway repo and build with node 12 -- this can be done on the Pi but is pretty slow on a 3b+
3. Copy the following dirs:
    build
    src
    static
    config
and the files:
    package.json
    pagekite.py
4. (optional) Edit package.json -- remove dev dependencies
5. npm install -- this will take a while.
6. Test the gateway by running 'node build/gateway.js'
    The gateway should start with no errors. There will be no addons installed.
    The gateway will be available on port 8080.
    If you add the webthings adapter it will complain: "unable to verify the first certificate" when ssl
    enabled things are found.
    Go ahead and do the initial setup and get the gateway working with no ssl (on the gateway server -- not the addon -- that is handled with node_extra_certs)
7. use 'sudo m2ag-labs/installer/extras/gateway/install_gateway.sh' to install systemd and nginx configs
     Ensure the file  ~/.m2ag-labs/ssl/rootca.crt exists.
     The service will be mozilla-gateway.service. The ssl port for the gateway will be 8443.





