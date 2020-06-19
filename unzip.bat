for %%i in (C:\Users\huber\Desktop\NeuerOrdner\*.zip) do call :entpacken "%%i" 
pause
goto :eof
pause
:entpacken 
"C:\Program Files\7-Zip\7z.exe" e  "%~1"  -oC:\Users\huber\Desktop\NeuerOrdner -pinfected
goto :eof 
pause