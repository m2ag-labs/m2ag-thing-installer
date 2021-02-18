#!/usr/bin/env bash
# https://raw.githubusercontent.com/m2ag-labs/m2ag-thing-installer/main/extras/certificates/getCertFiles.sh
if [ ! -d "$HOME/.m2ag-labs/certs" ]; then
    mkdir "$HOME/.m2ag-labs"
    mkdir "$HOME/.m2ag-labs/certs"
fi
echo "$HOME/.m2ag-labs/certs"
mkdir "templates"
mkdir "devices"
wget "https://raw.githubusercontent.com/m2ag-labs/m2ag-thing-installer/main/extras/certificates/createServerCert.sh"
wget "https://raw.githubusercontent.com/m2ag-labs/m2ag-thing-installer/main/extras/certificates/createRootCa.sh"
wget "https://raw.githubusercontent.com/m2ag-labs/m2ag-thing-installer/main/extras/certificates/templates/server.csr.cnf"
wget "https://raw.githubusercontent.com/m2ag-labs/m2ag-thing-installer/main/extras/certificates/templates/v3.ext"
mv server.csr.cnf templates/server.csr.cnf
mv v3.ext templages/v3.ext
