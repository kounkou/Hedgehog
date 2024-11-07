@echo off

REM Function to replace destination binary path in Makefile (Windows equivalent)
setlocal
set "file=Makefile.Release"
set "string_to_replace=\\Hedgehog"
set "replacement_string=/Hedgehog"

REM Run qmake and make
qmake
REM Use PowerShell to replace the string
powershell -Command "(Get-Content %file%) -replace '%string_to_replace%', '%replacement_string%' | Set-Content %file%"
echo Replaced "%string_to_replace%" with "%replacement_string%" in "%file%".

set "file=Makefile.Release"
set "string_to_replace=Hedgehog\\"
set "replacement_string=Hedgehog/"

REM Use PowerShell to replace the string
powershell -Command "(Get-Content %file%) -replace '%string_to_replace%', '%replacement_string%' | Set-Content %file%"
echo Replaced "%string_to_replace%" with "%replacement_string%" in "%file%".

REM Clean previous builds
if exist build rmdir /S /Q build
mkdir build

make

REM Copy the final binary
if "%~1"=="" (
    copy "build\Hedgehog.exe" "Hedgehog.exe"
) else (
    copy "build\Hedgehog.exe" "Hedgehog-%~1.exe"
)

endlocal
