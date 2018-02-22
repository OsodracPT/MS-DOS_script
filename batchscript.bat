@echo off

REM creating the user_records directory
mkdir C:\user_records
cls

REM remove any quotation marks
set tempName=%~1

REM check if the first parameter is empty and run interative mode if it is
if "%tempName%"=="" (

goto imode
)

REM check the existence of a second parameter
REM inform the user that we are missing 1 parameter and then run interactive mode
if "%2"=="" (
@echo Error: There is no second parameter.
@echo Starting the interactive mode.

goto imode
)

REM check the existence of more than 2 parameters
REM inform the user that they entered more than 2 parameters and then run interactive mode
if not "%3"=="" (
@echo Error: No more than two parameters are accepted.
@echo Starting the interactive mode.

goto imode
)

REM set variables used as data for the file creation 
set nameInput=%tempName%
set textfileName=%2

REM check if the file already exists with the same name
REM if exists print an error message to the user and go to imode
if exist c:\user_records\%textfileName%.txt (
@echo Error: Invalid UserName. File already exists.
@echo Starting the interactive mode. 

goto imode
)

REM getting the date and time for the file creation
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%DD%/%MM%/%YYYY%:%HH%:%Min%:%Sec%"

REM print the user data in the file
(
echo(%nameInput%
echo(%textfileName%
echo(%fullstamp%

) >> C:\user_records\%textfileName%.txt

REM display success message to the user
goto displayMessage

REM this is the interactive mode asking the user for input
:imode
set /p tempName=What is your name? 
set /p textfileName=What is your chosen username? 

REM Check if the user didn't input anything
REM if so print an error message and ask for the input again by restarting interactive mode
if "%tempName%"=="" (
@echo Error: Name input was empty/blank.
@echo Please insert your data again.

goto imode
)

REM Check if the user didn't input anything
REM if so print an error message and ask for the input again by restarting interactive mode
if "%textfileName%%"=="" (
@echo Error: User Name input was empty/blank.
@echo Please insert your data again.

goto imode
)

REM remove any quotation marks
set tempName=%tempName:"=%

set nameInput=%tempName%

if exist c:\user_records\%textfilename%.txt (
@echo Error: Invalid UserName. File already exists.
@echo Restarting the interactive mode. 

REM delete variable content.
set tempName=
set textfileName=

goto imode
)

REM getting the date and time for the file creation
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%DD%/%MM%/%YYYY%:%HH%:%Min%:%Sec%"

REM print the user data in the file
(
echo(%nameInput%
echo(%textfileName%
echo(%fullstamp%

) >> C:\user_records\%textfileName%.txt

REM display success message to the user
:displayMessage
@echo Your file has been created and is in C:\user_records directory.
@echo It is named %textfileName%.txt

REM deleting the variables stored
set nameInput=
set textfileName=
set fullstamp=
set tempName=
set YY=
set YYYY=
set MM=
set DD=
set HH=
set Min=
set Sec=

pause