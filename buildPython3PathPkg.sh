#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

pkgname="Python3Path"
version="3.7"
identifier="com.scriptingosx.${pkgname}"
install_location="/private/etc/paths.d/"

scriptfolder=$(dirname "$0")
projectfolder=$(mktemp -d)
payloadfolder="${projectfolder}/payload"

# create a projectfolder with a payload folder
if [[ ! -d "${payloadfolder}" ]]; then
    mkdir -p "${payloadfolder}"
fi

# create the file
pythonpath="/Library/Frameworks/Python.framework/Versions/${version}/bin"
echo  "${pythonpath}" > "${payloadfolder}/Python-${version}"

# build the component package
pkgpath="${scriptfolder}/${pkgname}-${version}.pkg"

pkgbuild --root "${projectfolder}/payload" \
         --identifier "${identifier}" \
         --version "${version}" \
         --install-location "${install_location}" \
         "${pkgpath}"

# clean up project folder
rm -Rf "${projectfolder}"

exit 0
