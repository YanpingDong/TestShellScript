rem -----------------------------------------------------
rem Set JAVA_HOME or JRE_HOME if not already set, provide
rem setting error infomation for prompt message
rem setEnv.bat 2014-01-03
rem -----------------------------------------------------

@echo off

rem Make sure either JRE or JDK are fine
if not "%JRE_HOME%" == "" goto gotJreHome
if not "%JAVA_HOME%" == "" goto gotJavaHome
echo Neither the JAVA_HOME nor the JRE_HOME environment 
echo variable is not defined
echo At least one of these environment variable is needed 
echo to run this program
goto exit

:gotJavaHome
rem No JRE given, use JAVA_HOME\jre as JRE_HOME
set "JRE_HOME=%JAVA_HOME%\jre"

:gotJreHome
rem Check if have a usable jfxrt.jar
if not exist "%JRE_HOME%\lib\jfxrt.jar" goto noJfxrt
if not exist "%JRE_HOME%\bin\java.exe" goto noJavaExe
goto end

:noJfxrt
rem need jfxrt.jar
echo The jfxrt.jar file is not exist
echo This file is needed to run this program
goto exit

:noJavaExe
rem need java.exe
echo The java.exe is not exist
echo This is needed to run this program
goto exit

:exit
exit /b 1

:end
exit /b 0