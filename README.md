# Installs the m2ag.labs webthings based iot framework

Some assembly required!

Use install.sh to install base framework

Ensure i2c is enabled on your pi.

This installer assumes self-signed certificates are installed in .m2ag-labs/ssl. File names are server.crt and server.key.

This [blog post](https://m2aglabs.com/2020/03/13/securing-local-iot-devices/) discusses how to create self-signed certificates

This is alpha 6, 1-22-21.

To assist with prerequisites try this [doc](https://docs.google.com/document/d/1IOkm031a4Nz10pL8d6RLf2KLE6ad4fCZOHY0flHtfXE/edit?usp=sharing)

install with:

Raspberry PI:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/m2ag-labs/m2ag-thing-installer/master/install.sh)"
```


