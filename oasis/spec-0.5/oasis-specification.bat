@echo off
goto :start

  Windows batch file for publishing an OASIS specification DocBook XML instance

  Assumes three batch files exist in the system:

      xmldtd  input-XML-file

      xslt  input-XML-file  stylesheet-XSL-file  output-file

      xslfo-pdf  input-FO-file  output-PDF-file

  $Id: oasis-specification.bat,v 1.11 2010/04/15 15:58:06 gkholman Exp $

:start
if a%2 == a goto :error
echo Validating instance...
call xmldtd oasis-specification-%1-%2.xml
if %errorlevel% neq 0 goto :done
echo Making offline HTML...
call xslt oasis-specification-%1-%2.xml c:/oasis/spec-0.5/stylesheets/oasis-specification-html-offline.xsl oasis-specification-%1-%2-offline.html
if %errorlevel% neq 0 goto :done
echo Making online HTML...
call xslt oasis-specification-%1-%2.xml c:/oasis/spec-0.5/stylesheets/oasis-specification-html.xsl nul automatic-output-filename=yes
if %errorlevel% neq 0 goto :done
echo Making XSL-FO US...
call xslt oasis-specification-%1-%2.xml c:/oasis/spec-0.5/stylesheets/oasis-specification-fo-us.xsl nul automatic-output-filename=yes
if %errorlevel% neq 0 goto :done
echo Making PDF US...
call xslfo-pdf oasis-specification-%1-%2.fo oasis-specification-%1-%2-us.pdf
if %errorlevel% neq 0 goto :done
echo Making XSL-FO A4...
call xslt oasis-specification-%1-%2.xml c:/oasis/spec-0.5/stylesheets/oasis-specification-fo-a4.xsl nul automatic-output-filename=yes
if %errorlevel% neq 0 goto :done
echo Making PDF A4...
call xslfo-pdf oasis-specification-%1-%2.fo oasis-specification-%1-%2.pdf
if %errorlevel% neq 0 goto :done

goto :done

:error
echo Missing version of document as first argument and stage as second argument

:done