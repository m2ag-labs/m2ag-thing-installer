# Installs the m2ag.labs webthings based iot framework

Use install.sh to install base framework

Ensure i2c is enabled on your pi.

This installer assumes self-signed certificates are installed in .m2ag-labs/ssl. File names are server.crt and server.key.
This [blog post](https://m2aglabs.com/2020/03/13/securing-local-iot-devices/) discusses how to create self-signed certificates

This is alpha 6, 1-22-21.

install with:

Raspberry PI:

bash -c "$(curl -fsSL https://raw.githubusercontent.com/m2ag-labs/m2ag-thing-installer/master/install.sh)"

Mac:  
Experimental installer -- won't work but coming soon.

