#!/bin/bash
#
# release.sh
#
# Author: Martin Lindström, Litsec AB
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

declare -a SPECIFICATIONS=("ELN-0600 - Tekniskt ramverk - Svensk e-legitimation"
    "ELN-0602 - Deployment Profile for the Swedish eID Framework"
    "ELN-0603 - Registry for Identifiers"
    "ELN-0604 - Attribute Specification for the Swedish eID Framework"
    "ELN-0606 - Entity Categories for the Swedish eID Framework"
    "ELN-0607 - Implementation Profile for using DSS in Central Signing Services"
    "ELN-0608 - Certificate Profile for Central Signing Services"
    "ELN-0609 - DSS Extension for Federated Signing Services"
    "ELN-0611 - eIDAS Constructed Attributes Specification for the Swedish eID Framework"
    "ELN-0612 - BankID Profile for the Swedish eID Framework"
    "ELN-0613 - Signature Activation Protocol")

#
# Produce HTML
#
for spec in "${SPECIFICATIONS[@]}"
do
    echo "Processing ${spec}.md ..."
    ORIENTATION="p"
    if [ "${spec}" == "ELN-0603 - Registry for Identifiers" ] || [ "${spec}" == "ELN-0604 - Attribute Specification for the Swedish eID Framework" ];
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





