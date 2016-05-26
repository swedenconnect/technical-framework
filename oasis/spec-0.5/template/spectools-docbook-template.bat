@echo off
goto :start

  Windows batch file for publishing an OASIS specification DocBook XML instance

  Assumes three batch files exist in the system:

      xmldtd  input-XML-file

      xslt  input-XML-file  stylesheet-XSL-file  output-file

      xslfo-pdf  input-FO-file  output-PDF-file

:start
if a%1 == a goto :error

rem The last of the following set commands is the one engaged
set oasis-ss-dir=http://docs.oasis-open.org/templates/DocBook/spec-0.5/stylesheets/
set oasis-ss-dir=c:/oasis/spec-0.5/stylesheets/

echo Validating instance...
call xmldtd spectools-docbook-template-%1.xml
if %errorlevel% neq 0 goto :done
echo Making offline HTML...
call xslt spectools-docbook-template-%1.xml %oasis-ss-dir%oasis-specification-html-offline.xsl spectools-docbook-template-%1-offline.html
echo Making HTML...
call xslt spectools-docbook-template-%1.xml %oasis-ss-dir%oasis-specification-html.xsl nul automatic-output-filename=yes
if %errorlevel% neq 0 goto :done
echo Making XSL-FO US...
call xslt spectools-docbook-template-%1.xml %oasis-ss-dir%oasis-specification-fo-us.xsl nul automatic-output-filename=yes
if %errorlevel% neq 0 goto :done
echo Making PDF US...
call xslfo-pdf spectools-docbook-template-%1.fo spectools-docbook-template-%1-us.pdf
if %errorlevel% neq 0 goto :done
echo Making XSL-FO A4...
call xslt spectools-docbook-template-%1.xml %oasis-ss-dir%oasis-specification-fo-a4.xsl nul automatic-output-filename=yes
if %errorlevel% neq 0 goto :done
echo Making PDF A4...
call xslfo-pdf spectools-docbook-template-%1.fo spectools-docbook-template-%1.pdf
if %errorlevel% neq 0 goto :done

goto :done

:error
echo Missing version of document as first argument

:done