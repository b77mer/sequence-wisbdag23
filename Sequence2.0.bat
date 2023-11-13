@echo off
color 0a
cd %appdata%
if not exist %appdata%\sequence2\ mkdir sequence2
cd %appdata%\sequence2
if exist run.txt del run.txt
cls
set nA=0
set nB=0
set nC=0
set nD=0
set pA=0
set pB=0
set pC=0
set pD=0
set nMAX=100
set rowCount=0
set colCount=0
set nSUM=0
set nABS=0
set longestStreak=0
goto setVariables

:setVariables
::	Sets newest variables. Skips 0  0  0  0. Resets colCount and rowCount.
set /A nD=%nD%+1
if %nD% GTR %nMAX% (
	set nD=0
	set /A nC=%nC%+1
	if %nC% GEQ %nMAX% (
		set nC=0
		set /A nB=%nB%+1
		if %nB% GEQ %nMAX% (
			set nB=0
			set /A nA=%nA%+1
			if %nA% GEQ %nMAX% (
				goto finishAll
			)
		)
	)
)
echo ------------------
echo %nA%  %nB%  %nC%  %nD%
set colCount=0
set rowCount=0
set mA=%nA%
set mB=%nB%
set mC=%nC%
set mD=%nD%
goto setSum

:setNumber
::	Sets the variables of nA, nB, nC and nD to the output of the sum before setSum.
set mA=%pA%
set mB=%pB%
set mC=%pC%
set mD=%pD%
goto setSum

:setSum
::	Checks which row we're on and sets which numbers need to be in the sum.
if %rowCount%==0 (
	set sA=%mA%
	set sB=%mB%
)
if %rowCount%==1 (
	set sA=%mB%
	set sB=%mC%
)
if %rowCount%==2 (
	set sA=%mC%
	set sB=%mD%
) 
if %rowCount%==3 (
	set sA=%mD%
	set sB=%mA%
)
goto createSum

:createSum
::	Does sum and reserves variable position.
set /A nNEXT=%sA%-%sB%
if %nNEXT% GEQ 0 (set nABS=%nNEXT%) else set /A nABS=0-%nNEXT%
if %rowCount%==0 set pA=%nABS%
if %rowCount%==1 set pB=%nABS%
if %rowCount%==2 set pC=%nABS%
if %rowCount%==3 set pD=%nABS%
set /A rowCount=%rowCount%+1
if "%rowCount%" GTR "3" (
	set rowCount=0
	echo %pA%  %pB%  %pC%  %pD%
	set /A colCount=%colCount%+1
	goto checkSum
) else (
	goto setSum
)

:checkSum
::	Since all of these sequences end at a 0  0  0  0, the sum of all numbers in the
::	lowest column is obivously 0. So this is a check wether it ended or not.
set /A nSUM=%pA%+%pB%+%pC%+%pD%
if %nSUM%==0 goto finishRun
goto setNumber

:finishRun
::	Finishes off the run and updates longest stream information.
if %colCount% GEQ %longestStreak% (
	set longestStreak=%colCount%
	echo Longest streak of %longestStreak% was reached at %nA%  %nB%  %nC%  %nD%. >>run.txt
)
echo ------------------
echo Streak: %colCount%   Longest Streak: %longestStreak%
goto setVariables

:finishAll
::	End of the program.
echo Finished. Longest streak was: %longestStreak%.
pause >nul
exit
