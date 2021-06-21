# Installs the m2ag.labs webthings based iot framework

Some assembly required!

Use install.sh to install base framework

Ensure i2c is enabled on your pi.

This installer assumes self-signed certificates are installed in .m2ag-labs/ssl. File names are server.crt and server.key.

This [blog post](https://m2aglabs.com/2020/03/13/securing-local-iot-devices/) discusses how to create self-signed certificates

beta 1 6/10/21

To assist with prerequisites try this [doc](https://docs.google.com/document/d/e/2PACX-1vTlw2WPZS36lkDJTlFGO669EHH5NCbk-76RwSg9kdyZ60QY8vEj1O3FCp021VRd7EftiQzNE2SL6d3s/pub)

install with:

Raspberry PI:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/m2ag-labs/m2ag-thing-installer/master/install.sh)"
```


