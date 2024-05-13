:: BAT script to release the application for Windows.
:: WARNING: This script must be executed from its own folder.
@echo OFF

:: Example usage: .\create_release_windows.bat C:\Users\Ricardo\Qt\5.14.2\mingw73_32\bin C:\Users\Ricardo\Libraries\build-app-Desktop_Qt_5_14_2_MinGW_32_bit-Release\release

set USAGE_MSG=".\create_release_windows.bat <PATH_TO_QT_BIN> <PATH_TO_APP_EXE_FILE>

:: App executable binary file
set APP_EXE_FILENAME=app.exe
:: App QML files
set QML_DIR=../qml

::Check argument 1
set QT_BIN_PATH=%1
if "%1"=="" (
    echo Invalid arguments number. Usage: %USAGE_MSG%
    exit
) else (
    echo -- Using QtEnv setup script: %QT_BIN_PATH%\qtenv2.bat
)

::Check argument 2
set APP_EXE_PATH=%2
if "%2"=="" (
    echo Invalid arguments number. Usage: %USAGE_MSG%
    exit
) else (
    echo -- Using current executable: %APP_EXE_PATH%\%APP_EXE_FILENAME%
)

:: Creates a release folder
set /p RELEASE_VERSION=Enter version for release: 
set RELEASE_FOLDER=release_%RELEASE_VERSION%
md %RELEASE_FOLDER%\
md %RELEASE_FOLDER%\app
set RELEASE_FOLDER=%RELEASE_FOLDER%\app

echo -- Release folder %RELEASE_FOLDER%

copy %APP_EXE_PATH%\%APP_EXE_FILENAME% %RELEASE_FOLDER%

:: Source qtenv2 script to set up the Qt Enviroment
echo -- Setting up Qt Enviroment
cmd /C %QT_BIN_PATH%\qtenv2.bat

:: Release the application using the tool windeployqt
echo -- Deploying App
cmd /C %QT_BIN_PATH%/windeployqt --qmldir %QML_DIR% --no-translations %RELEASE_FOLDER%\%APP_EXE_FILENAME% --compiler-runtime

:: Copying some missed libs
echo -- Copying some missed libs of the Qt MinGW 32 bits compiler
copy "%QT_BIN_PATH%\libgcc_s_seh-1.dll" %RELEASE_FOLDER%
copy "%QT_BIN_PATH%\libstdc++-6.dll" %RELEASE_FOLDER%
copy "%QT_BIN_PATH%\libwinpthread-1.dll" %RELEASE_FOLDER%
copy "%QT_BIN_PATH%\libgcc_s_dw2-1.dll" %RELEASE_FOLDER%

:: echo -- zip folder
:: tar.exe -a -cf %RELEASE_FOLDER%.zip %RELEASE_FOLDER%
endlocal
