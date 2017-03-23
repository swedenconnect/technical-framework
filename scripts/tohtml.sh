#!/bin/bash
#
# tohtml.sh - A script that converts specifications written in Markdown to HTML.
#
# Author: Martin Lindström, Litsec AB
#

INSTALL_DIR=$(dirname $0)

#
# usage
#
usage() {
echo 1>&2 "usage: $0 <markdown file> <output directory> [-o <orientation>]"
    echo 1>&2 "  Where orientation is p (for portrait) or l (for landscape)."
    echo 1>&2 "  The 'orientation' is for printing."
}

#
# Check parameters.
#
if [ $# -lt 2 ]; then
    usage
    exit 127
fi

ORIENTATION="portrait"
MD_FILE=$1
OUTPUT_DIR=${2%/}

if [ $# -gt 3 ]; then
  if [ "$3" != "-o" ]; then
      echo 1>&2 "Unknown parameter $3"
      usage
      exit 127
  fi
  if [ "$4" == "p" ]; then
      ORIENTATION="portrait"
  elif [ "$4" == "l" ]; then
      ORIENTATION="landscape"
  else
      echo 1>&2 "Unexpected value for orientation"
      usage
      exit 127
  fi
fi

#
# Check if the Markdown file exists.
#
if [ ! -f "$MD_FILE" ]; then
    echo -n "${MD_FILE} does not exist"
    exit 0
fi

#
# generate-md doesn't seem to handle spaces in file names, so we'll create a temporary file
# for it to parse.
#
_MD_FILE=`echo $MD_FILE | tr ' ' '_'`
echo $_MD_FILE

#
# Make a copy if needed
#
COPY_FLAG=false
if [ "$MD_FILE" != "$_MD_FILE" ]
then
    cp "$MD_FILE" $_MD_FILE
    COPY_FLAG=true
fi

#
# Use the correct page layout
#
echo $ORIENTATION
cp ${INSTALL_DIR}/github-layout/page-${ORIENTATION}.html ${INSTALL_DIR}/github-layout/page.html
 

## Se https://github.com/mixu/markdown-styles
generate-md --layout ${INSTALL_DIR}/github-layout/ --no-header-links --input ${_MD_FILE} --output ${OUTPUT_DIR}

# Remove copy
if [ "$COPY_FLAG" == "true" ]
then
    rm $_MD_FILE
fi

# Reset layout
rm ${INSTALL_DIR}/github-layout/page.html

# Copy images to output directory
if [ ! -d "${OUTPUT_DIR}/img" ]; then
    cp -r ${INSTALL_DIR}/../img "${OUTPUT_DIR}/img"
fi

exit 0





