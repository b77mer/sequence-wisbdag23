@echo off
color 0a
cd %appdata%\sequence
del colCount.txt
del run.txt
del run2.txt
del run3.txt
set max=100
set bin=0000
set pA=0
set pB=0
set pC=0
set pD=0
set w=0
set bin=0000
set sLength=4
goto sLength4

:sLength4
cls
set nA=0
set nB=0
set nC=0
set nD=0
set rowCount=0
set colCount=0
set x=0
set itSum=1
goto 0000

:sL3
set nA=%nA2%
set nB=%nB2%
set nC=%nC2%
set nD=%nD2%
goto sL5

:sL4
echo _____________
set colCount=0
set rowCount=0
set nA=%pA%
set nB=%pB%
set nC=%pC%
set nD=%pD%
goto sL5

:sL5
echo %nA%  %nB%  %nC%  %nD% >>run2.txt
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
		goto sL5
	)
) else (
	set p=1
)
echo Error occured. Please check code. Error at nxtN
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
if %nSum%==0 goto finish4
goto sL3

:finish4
if %colCount% GEQ %w% (
	echo %pA%  %pB%  %pC%  %pD% >run3.txt
	set w=%colCount%
)
echo %colCount% >>colCount.txt
goto checkr

:checkr
if %bin%==0000 goto 0000
if %bin%==0001 goto 0001
if %bin%==0010 goto 0010
if %bin%==0011 goto 0011
if %bin%==0100 goto 0100
if %bin%==0101 goto 0101
if %bin%==0110 goto 0110
if %bin%==0111 goto 0111
if %bin%==1000 goto 1000
if %bin%==1001 goto 1001
if %bin%==1010 goto 1010
if %bin%==1011 goto 1011
if %bin%==1100 goto 1100
if %bin%==1101 goto 1101
if %bin%==1111 goto 1111
echo Error occured. Please check code. Error at :checkr.
pause >nul
exit

:reset
set pA=0
set pB=0
set pC=0
set pD=0
goto checkr

:0000
::A B C D+1
set /A pD=%pD%+1
if %pD% GTR %max% (
	set bin=0001
	goto reset
)
goto sL4

:0001
::A B C+1 D
set /A pC=%pC%+1
if %pC% GTR %max% (
	set bin=0010 
	set crry=1
	goto reset
)
goto sL4

:0010
::A B C+1 D+1
if %crry%==1 (
	set crry=0
	set pC=1
)
set /A pD=%pD%+1
if %pD% GTR %max% (
	set pD=0
	set /A pC=%pC%+1
	if %pC% GEQ %max% (
		set bin=0011 
		goto reset
	
	)
)
goto sL4

:0011
::A B+1 C D
set /A pB=%pB%+1
if %pB% GTR %max% (
	set bin=0100 
	set crry=1
	goto reset
)
goto sL4


:0100
::A B+1 C D+1
if %crry%==1 (
	set crry=0
	set pB=1
)
set /A pD=%pD%+1
if %pD% GTR %max% (
	set pD=0
	set /A pB=%pB%+1
	if %pB% GEQ %max% (
		set bin=0101
		set crry=1
		goto reset
	)
)
goto sL4

:0101
::A B+1 C+1 D+1
if %crry%==1 (
	set crry=0
	set pB=1
)
set /A pD=%pD%+1
if %pD% GTR %max% (
	set pD=0
	set /A pC=%pC%+1
	if %pC% GEQ %max% (
		set pC=0
		set pD=0
		set /A pB=%pB%+1
		if %pB% GEQ %max% (
			set bin=0111
			goto reset
		)
	)
)
goto sL4

:0111
::A+1 B C D
set /A pA=%pA%+1
if %pA% GTR %max% (
	set bin=1000 
	goto reset
)
goto sL4

:1000
::A+1 B C D+1
set /A pD=%pD%+1
if %pD% GTR %max% (
	set pD=0
	set /A pA=%pA%+1
	if %pA% GTR %max% (
		set bin=1001 
		goto reset
	)
)
goto sL4

:1001
::A+1 B C+1 D
set /A pC=%pC%+1
if %pC% GTR %max% (
	set pC=0
	set /A pA=%pA%+1
	if %pA% GTR %max% (
		set bin=1010 
		set crry=1
		goto reset
	)
)
goto sL4

:1010
::A+1 B C+1 D+1
if %crry%=1 (
	set crry=0
	set pA=1
)
set /A pD=%pD%+1
if %pD% GTR %max% (
	set pD=0
	set /A pC=%pC%+1
	if %pC% GTR (
		set pD=0
		set pC=0
		set /A pA=%pA%+1
		if %pA% GTR %max% (
			set bin=1011 
			goto reset
		)
	)
)
goto sL4

:1011
::A+1 B+1 C D
set /A pB=%pB%+1
if %pB% GTR %max% (
	set pB=0
	set /A pA=%pA%+1
	if %pA% GTR %max% (
		set bin=1100
		set crry=1
		goto reset
	)
)
goto sL4

:1100
::A+1 B+1 C D+1
if %crry%==1 (
	set crry=0
	set pA=1
)
set /A pD=%pD%+1
if %pD% GTR %max% (
	set pD=0
	set /A pB=%pB%+1
	if %pB% GTR %max% (
		set pD=0
		set pB=0
		set /A pA=%pA%+1
		if %pA% GTR %max% (
			set bin=1101
			set crry=1
			goto reset
		)
	)
)

:1101
::A+1 B+1 C+1 D+1
if crry=1 (
	set crry=0
	set pA=1
)
set /A pD=%pD%+1
if %pD% GTR %max% (
	set pD=0
	set /A pC=%pC%+1
	if %pD% GTR %max% & if %pC% GTR %max% (
		set pD=0
		set pC=0
		set /A pB=%pB%+1
		if %pD% GTR %max% & if %pC% GTR %max% & if %pB% GTR %max% (
			set pD=0
			set pC=0
			set pB=0
			set /A pA=%pA%+1
		)
	)
)
if %pD% GTR %max% & if %pC% GTR %max% & if %pB% GTR %max% & if %pA% GTR %max% goto finished.

:finished
echo Finished. Longest streak was %w%.
pause >nul