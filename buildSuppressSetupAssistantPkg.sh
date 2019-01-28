#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

pkgname="SupressSetupAssistant"
version="1"
identifier="com.scriptingosx.${pkgname}"
install_location="/private/var/db/"

scriptfolder=$(dirname "$0")
projectfolder="${scriptfolder}/${pkgname}"
payloadfolder="${projectfolder}/payload"

# create a projectfolder with a payload folder
if [[ ! -d "${payloadfolder}" ]]; then
    mkdir -p "${payloadfolder}"
fi

# touch the file
touch "${payloadfolder}/.AppleSetupDone"

# build the component package
pkgpath="${projectfolder}/${pkgname}.pkg"


pkgbuild --root "${projectfolder}/payload" \
         --identifier "${identifier}" \
         --version "${version}" \
         --install-location "${install_location}" \
         "${pkgpath}"

# build the product archive

productpath="${scriptfolder}/${pkgname}-${version}.pkg"

productbuild --package "${pkgpath}" \
             --version "${version}" \
             --identifier "${identifier}" \
             "${productpath}"

# clean up project folder
rm -Rf "${projectfolder}"

exit 0

