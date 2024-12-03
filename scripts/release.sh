#!/bin/bash
#
# release.sh
#
# Author: Martin Lindström
#

INSTALL_DIR=$(dirname $0)

#
# usage
#
usage() {
    echo 1>&2 "usage: $0 <input directory> <output directory>"
    echo 1>&2 "  Where <input directory> is the directory containing the specifications"
}

#
# Check parameters.
#
if [ $# -lt 2 ]; then
    usage
    exit 127
fi

INPUT_DIR=${1%/}
OUTPUT_DIR=${2%/}

declare -a SPECIFICATIONS=("00 - Tekniskt ramverk - Introduktion"
    "00 - Swedish eID Framework - Introduction"
    "02 - Deployment Profile for the Swedish eID Framework"
    "03 - Registry for Identifiers"
    "04 - Attribute Specification for the Swedish eID Framework"
    "06 - Entity Categories for the Swedish eID Framework"
    "07 - Implementation Profile for using DSS in Central Signing Services"
    "08 - Certificate Profile for Central Signing Services"
    "09 - DSS Extension for Federated Signing Services"
    "11 - eIDAS Constructed Attributes Specification for the Swedish eID Framework"
    "12 - BankID Profile for the Swedish eID Framework"
    "13 - Signature Activation Protocol"
    "14 - Principal Selection in SAML Authentication Requests"
    "18 - User Message Extension in SAML Authentication Requests"
    "OpenID Connect Claims and Scopes Specification"
    "OpenID Connect Profile for Sweden Connect")

#
# Produce HTML
#
for spec in "${SPECIFICATIONS[@]}"
do
    echo "Processing ${spec}.md ..."
    ORIENTATION="p"
    if [ "${spec}" == "03 - Registry for Identifiers" ] || [ "${spec}" == "04 - Attribute Specification for the Swedish eID Framework" ];
    then
	ORIENTATION="l"
    fi
    ${INSTALL_DIR}/tohtml.sh ${INPUT_DIR}/"${spec}.md" ${OUTPUT_DIR} -o $ORIENTATION
done

#
# Create the template for the index.html file
#
${INSTALL_DIR}/tohtml.sh ${INSTALL_DIR}/templates/index.md ${OUTPUT_DIR} -o p

exit 0
