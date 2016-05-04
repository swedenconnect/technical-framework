@echo off
echo Invoking Ibex "%~1"(.xml) with "%~2"(us/a4) to "%~3"(.pdf)

if exist "%~dp0saxon.jar" goto :gotsaxon
echo Cannot find "%~dp0saxon.jar" version 6.5.5 from: 
echo http://saxon.sourceforge.net/saxon6.5.5/
goto :eof
:gotsaxon

if exist "%~dp0ibex-crane-ss.jar" goto :gotibex
echo Cannot find "%~dp0ibex-crane-ss.jar" (renamed from the posted JAR name for Crane's edition) from:
echo http://www.xmlpdf.com/ibex-downloads-signed.html
:gotibex

if "a%~3" == "a" goto :eof
if "a%~2" == "aa4" goto :ready
if not "a%~2" == "aus" goto :eof
:ready
rem Get rid of any pre-existing  target in case there is a production problem
if exist "%~3" del "%~3"
if not exist "%~3" goto :start
echo Unable to delete "%~3"
goto :eof

:start
set xml-pdf-in=%~f1
set xml-pdf-out=%~f3
pushd %~dp0
echo java -cp ".;saxon.jar;ibex-crane-ss.jar" "-Dibexconfig=ibexconfig.xml" ibex.Signed -xml "%xml-pdf-in%" -xsl "oasis-specification-fo-%~2.xsl" -manifest "oasis-specification-fo-manifest.xml" -pdf "%xml-pdf-out%"
java -cp ".;saxon.jar;ibex-crane-ss.jar" "-Dibexconfig=ibexconfig.xml" ibex.Signed -xml "%xml-pdf-in%" -xsl "oasis-specification-fo-%~2.xsl" -manifest "oasis-specification-fo-manifest.xml" -pdf "%xml-pdf-out%"
popd
set xml-pdf-in=
set xml-pdf-out=
if not exist "%~3" goto :eof
echo Done!
