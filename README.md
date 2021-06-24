# Installs the m2ag.labs webthings based iot framework

Some assembly required!

Use install.sh to install base framework

Ensure i2c is enabled on your pi.

Use ssl is encouraged but not mandatory. Place self-signed certificates in .m2ag-labs/ssl. File names are server.crt and server.key.

This [document](https://docs.google.com/document/d/14vuQJgqhT3Ylm6VSoCiv0JzX6T2fNVaKkcaUYLtU_xM/edit?usp=sharing) discusses how to create self-signed certificates

beta 1 6/10/21

To assist with prerequisites try this [doc](https://docs.google.com/document/d/1MfYIxnEYlHoLYPp0aK_jBCefJHbil6GVLdsT3CCK7yQ/edit?usp=sharing)

install with:

Raspberry PI:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/m2ag-labs/m2ag-thing-installer/master/install.sh)"
```


