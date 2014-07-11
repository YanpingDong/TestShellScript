@echo off

rem ----------------------------------------------------
rem Start script for the rshop tool
rem startup.bat 2014-01-03 
rem ----------------------------------------------------

if "%OS%" == "Windows_NT" setlocal

rem Guess RSHOP_HOME if not defined
set "CURRENT_DIR=%cd%"
echo current dir is %CURRENT_DIR%
if not "%RSHOP_HOME%" == "" goto gotHome
set "RSHOP_HOME=%CURRENT_DIR%"

:gotHome
if exist "%RSHOP_HOME%\startup.bat" goto okHome
echo The RSHOP_HOME environment variable is not defined correctly
echo or in %RSHOP_HOME% cann't find startup.bat
echo This environment variable must be set as root directory of startup.bat
goto end

:okHome
rem Set standard Java environment variables
if exist "%RSHOP_HOME%\setEnv.bat" goto gotOpencvDir
echo Cannot find "%RSHOP_HOME%\setEnv.bat" 
echo This file is needed to run this program
goto end

:gotOpencvDir
if exist "%RSHOP_HOME%\opencv" goto okSetEnv
echo Cann't find opencv directory in %RSHOP_HOME%
echo Please download the file following the Rshop installation manual
goto end

:okSetEnv
echo "call" %RSHOP_HOME%\setEnv.bat
call "%RSHOP_HOME%\setEnv.bat"
if errorlevel 1 goto end 

rem set OPENCV_DIR for print
set "OPENCV_DIR=%RSHOP_HOME%\opencv"
set path=%OPENCV_DIR%;%path%

rem -----------Execute The Requested Command------------------------
echo Using JRE_HOME: "%JRE_HOME%"
echo Using RSHOP_HOME: "%RSHOP_HOME%"
echo Using OPENCV_DIR: "%OPENCV_DIR%"

rem execute command

echo start Rshop Tool, please waiting... ...

"%JRE_HOME%"\bin\java -Xmx512M -Dfile.encoding=UTF-8 -cp "%JRE_HOME%"\lib\jfxrt.jar;rshop-standalone-jar-with-dependencies.jar taggingtool.TaggingTool


:end