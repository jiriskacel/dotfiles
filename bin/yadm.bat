@echo off

if "%GitFolder%" == "" for %%I in ("git.exe") do for %%J in ("%%~$PATH:I") do set GitFolder=%%~dpJ..\
set ShellExe=%GitFolder%bin\sh.exe
set GIT_WORK_TREE=%USERPROFILE%

"%ShellExe%" %~dp0yadm %*
