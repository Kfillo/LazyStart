@ECHO OFF
CLS

REM Pay no attention to the man behind the curtain!
TITLE LazyStart

REM Who in the world am I? Ah, that’s the great puzzle.
SET HOME_DIR=%~dp0
SET SCRIPT=%~nx0
SET TOMCAT_HOME=%HOME_DIR%\hybris\bin\platform\tomcat
SET HYBRIS_HOME=%HOME_DIR%
SET HYBRIS_PLATFORM=%HOME_DIR%\hybris\bin\platform
SET ANT_HOME=%HOME_DIR%\hybris\bin\platform\apache-ant
SET PATH=%PATH%;%ANT_HOME%\bin\

REM I’m not crazy. My reality is just different than yours.
SET SLEEP=5
SET ANT_OPTS=-Xmx512m -Dfile.encoding=UTF-8
REM deleting CLASSPATH as a workaround for PLA-8702
SET CLASSPATH=

REM Imagination is the only weapon in the war against reality.
SET iDoDo=%1

REM I can’t go back to yesterday because I was a different person then.
IF "%iDoDo%" == "HybrisStart" (
	TITLE LazyStart - Hybris With Debug
	GOTO CommandHybrisStart
)
IF "%iDoDo%" == "AntBuild" (
	TITLE LazyStart - Ant Build
	GOTO CommandAntBuild
)
IF "%iDoDo%" == "AntCleanBuild" (
	TITLE LazyStart - Ant Clean Build
	GOTO CommandAntCleanBuild
)
IF "%iDoDo%" == "AntCleanBuildInitialize" (
	TITLE LazyStart - Ant Clean Build Initialize
	GOTO CommandAntCleanBuildInitialize
)
IF "%iDoDo%" == "AntInitialize" (
	TITLE LazyStart - Ant Initialize
	GOTO CommandAntInitialize
)
IF "%iDoDo%" == "AntYunitinit" (
	TITLE LazyStart - Ant Yunitinit
	GOTO CommandAntYunitinit
)
IF "%iDoDo%" == "Console" (
	TITLE LazyStart - Console
	GOTO CommandConsole
)
REM All king's horses and all the king's men.
REM Couldn't put me back together again.

:MainMenu
CLS
ECHO.
ECHO ----------------------------------------------------
ECHO  PRESS 1 to 6 select your Hybris task, or 0 to EXIT
ECHO ----------------------------------------------------
ECHO.
ECHO  1 - Start Hybris with debug
ECHO  2 - Open Console in platform folder
ECHO  3 - Ant Initialize
ECHO  4 - Ant Build
ECHO  5 - Ant Clean Build
ECHO  6 - Ant Clean Build Initialize
ECHO  7 - Ant Yunitinit
ECHO  0 - EXIT
ECHO.

SET /P M= Type 0 to 6 then press ENTER: 
IF %M%==0 GOTO TheEnd
IF %M%==1 GOTO HybrisStart
IF %M%==2 GOTO NewConsole
IF %M%==3 GOTO AntInitialize
IF %M%==4 GOTO AntBuild
IF %M%==5 GOTO AntCleanBuild
IF %M%==6 GOTO AntCleanBuildInitialize
IF %M%==7 GOTO AntYunitinit

REM Some where over the rainbow way up high... 
REM there's a land that I've heard of once in a lullaby.
GOTO MainMenu

REM A baby has brains, but it doesn’t know much. Experience
REM is the only thing that brings knowledge, and the longer 
REM you are on earth the more experience you are sure to get.

:HybrisStart
START %HOME_DIR%\%SCRIPT% HybrisStart
GOTO MainMenu

:AntBuild
START %SCRIPT% AntBuild
GOTO MainMenu

:AntCleanBuild
START %SCRIPT% AntCleanBuild
GOTO MainMenu

:AntCleanBuildInitialize
START %SCRIPT% AntCleanBuildInitialize
GOTO MainMenu

:AntInitialize
START %SCRIPT% AntInitialize
GOTO MainMenu

:AntYunitinit
START %SCRIPT% AntYunitinit
GOTO MainMenu

:NewConsole
START %SCRIPT% Console
GOTO MainMenu

REM If everybody minded their own business, the world would 
REM go around a great deal faster than it does.

:CommandHybrisStart
SETLOCAL
CD %HYBRIS_PLATFORM%\
SET _YWRAPPER_CONF=%TOMCAT_HOME%/conf/wrapper-debug.conf
CALL %TOMCAT_HOME%\bin\wrapper.bat console
ENDLOCAL
GOTO TheEnd

:CommandAntBuild
SET ANT_COMMAND=build
SET NEXT_COMMAND=ExitCommand
GOTO AntRunCommand

:CommandAntCleanBuild
SET ANT_COMMAND=clean build
SET NEXT_COMMAND=ExitCommand
GOTO AntRunCommand

:CommandAntCleanBuildInitialize
SET ANT_COMMAND= clean build initialize
SET NEXT_COMMAND=ExitCommand
GOTO AntRunCommand

:CommandAntInitialize
CD %HYBRIS_PLATFORM%
SET ANT_COMMAND=initialize
SET NEXT_COMMAND=ExitCommand
GOTO AntRunCommand

:CommandAntYunitinit
SET ANT_COMMAND=yunitinit
SET NEXT_COMMAND=TheEnd
GOTO AntRunCommand

:CommandConsole
CD %HYBRIS_PLATFORM%
GOTO TheEnd

REM The Duchess! The Duchess! Oh my dear paws! Oh my fur and whiskers!
REM She’ll get me executed, as sure as ferrets are ferrets!

:AntRunCommand
CD %HYBRIS_PLATFORM%
CALL ant %ANT_COMMAND%
IF %ERRORLEVEL% GTR 0 GOTO FailCommand
GOTO %NEXT_COMMAND%

:FailCommand
ECHO.
ECHO ---------------------------------------------
ECHO               What Went Wrong?
ECHO ---------------------------------------------
GOTO TheEnd

:ExitCommand
ECHO.
ECHO ---------------------------------------------
ECHO         Closing within %SLEEP% sec!
ECHO ---------------------------------------------
TIMEOUT %SLEEP% > NUL
EXIT

REM Roses are red... Violets are blue... 
REM To run this .bat is so nice of you!

:TheEnd
