@echo off
cd %appdata%
if not exist sequence mkdir sequence
cd sequence
del run.txt
set sLength=4
goto sLength4

:sLength4
cls
set /P nA=First number: 
set /P nB=Second number: 
set /P nC=Third number: 
set /P nD=Fourth number:
echo.
set /P itCount=Iteration max. count:
echo This is your sequence. Continue?
echo.
echo %nA%  %nB%  %nC%  %nD%
echo.
echo.
pause >nul
set rowCount=0
set colCount=0
set x=0
goto sL4

:sL3
set nA=%nA2%
set nB=%nB2%
set nC=%nC2%
set nD=%nD2%
goto sL4

:sL4
if %rowCount%==0 (
	set sA=%nA%
	set sB=%nB%
) else (
	set p=1
)
if %rowCount%==1 (
	set sA=%nB%
	set sB=%nC%
) else (
	set p=1
)
if %rowCount%==2 (
	set sA=%nC%
	set sB=%nD%
) else (
	set p=1
)
if %rowCount%==3 (
	set sA=%nD%
	set sB=%nA%
) else (
	set p=1
)
goto nxtN

:nxtN
set /A nxtN=%sA%-%sB%
If %nxtN% GEQ 0 (set nxtABS=%nxtN%) else set /a nxtABS=0-%nxtN%
set /A x=%x%+1
if %rowCount%==0 set nA1=%nxtABS%
if %rowCount%==1 set nB1=%nxtABS%
if %rowCount%==2 set nC1=%nxtABS%
if %rowCount%==3 set nD1=%nxtABS%
if %sLength%==4 (
	if "%x%" GTR "3" (
		set x=0
		goto sLength4cont
	) else (
		set /A rowCount=%rowCount%+1
		goto sL4
	)
) else (
	set p=1
)
echo Error occured. Please check code.
pause >nul
exit

:sLength4cont
set nA2=%nA1%
set nB2=%nB1%
set nC2=%nC1%
set nD2=%nD1%
if "%rowCount%" GEQ "3" set rowCount=0
set /A colCount=%colCount%+1
goto check4

:check4
set /A nSum=%nA2%+%nB2%+%nC2%+%nD2%
echo %nA2%  %nB2%  %nC2%  %nD2%
echo %nA2%  %nB2%  %nC2%  %nD2% >>run.txt
if %nSum%==0 goto finish4
goto checkit

:checkit
if %colCount% LEQ %itCount% goto sL3
pause
goto finish4

:check4R
echo just to see
pause >nul
exit

:finish4
echo The sequence was created to "%appdata%\sequence\run.txt". The lenght was %colCount%.
echo Press any button to exit.
pause >nul
exit
