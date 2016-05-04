#
#  Shell script for publishing an OASIS specification DocBook XML instance
#
#  Assumes three script files exist in the system:
#
#      xmldtd.sh  input-XML-file
#
#      xslt.sh  input-XML-file  stylesheet-XSL-file  output-file
#
#      xslfo-pdf.sh  input-FO-file  output-PDF-file
#

# only the latter of the following assignments is in play
oasis_ss_dir=http://docs.oasis-open.org/templates/DocBook/spec-0.5/stylesheets/
oasis_ss_dir=/home/gkholman/oasis/spec-0.5/stylesheets/

echo Validating instance...
sh ../../xmldtd.sh wd-spectools-docbook-template-$1.xml
echo Making HTML...
sh ../../xslt.sh wd-spectools-docbook-template-$1.xml $oasis_ss_dir\oasis-specification-html.xsl spectools-docbook-template-$1-offline.html
echo Making HTML...
sh ../../xslt.sh wd-spectools-docbook-template-$1.xml $oasis_ss_dir\oasis-specification-html.xsl /dev/null automatic-output-filename=yes
echo Making XSL-FO US...
sh ../../xslt.sh wd-spectools-docbook-template-$1.xml $oasis_ss_dir\oasis-specification-fo-us.xsl /dev/null automatic-output-filename=yes
echo Making PDF US...
sh ../../xslfo-pdf.sh wd-spectools-docbook-template-$1.fo wd-spectools-docbook-template-$1-us.pdf
echo Making XSL-FO A4...
sh ../../xslt.sh wd-spectools-docbook-template-$1.xml $oasis_ss_dir\oasis-specification-fo-a4.xsl /dev/null automatic-output-filename=yes
echo Making PDF A4...
sh ../../xslfo-pdf.sh wd-spectools-docbook-template-$1.fo wd-spectools-docbook-template-$1.pdf

