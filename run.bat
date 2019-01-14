@echo off
setlocal enabledelayedexpansion
cd %~dp0
::env\Scripts\activate.bat
echo Killing 8000 port....
for /f "tokens=1-5" %%a in ('netstat -ano ^| find "8000"') do (
    if "%%e%" == "" (
        set pid=%%d
    ) else (
        set pid=%%e
    )
    echo !pid!
    taskkill /f /pid !pid!
)
ping 123.45.67.89 -n 1 -w 3000 > nul
echo Starting....

start /b %~dp0env\Scripts\python.exe -m SimpleHTTPServer
::start /b python -m http.server
echo Waiting and opening browser....
ping 123.45.67.89 -n 1 -w 3000 > nul
start "C:\Users\%username%\AppData\Local\Google\Chrome\Application\chrome.exe" http://127.0.0.1:8000 
echo DO NOT CLOSE THE WINDOW!
pause