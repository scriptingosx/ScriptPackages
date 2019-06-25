#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

pkgname="SupressSetupAssistantRestart"
version="1"
identifier="com.scriptingosx.${pkgname}"
install_location="/private/var/db/"

scriptfolder=$(dirname "$0")
projectfolder=$(mktemp -d)
payloadfolder="${projectfolder}/payload"

# create a projectfolder with a payload folder
if [[ ! -d "${payloadfolder}" ]]; then
    mkdir -p "${payloadfolder}"
fi

# touch the file
touch "${payloadfolder}/.AppleSetupDone"

# create a PackageInfo.xml to require a reboot
echo '<?xml version="1.0" encoding="utf-8" standalone="no"?><pkg-info postinstall-action="restart"/>' > "${projectfolder}/PackageInfo.xml"


# build the component package
pkgpath="${projectfolder}/${pkgname}.pkg"


pkgbuild --root "${projectfolder}/payload" \
         --identifier "${identifier}" \
         --info "${projectfolder}/PackageInfo.xml" \
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

