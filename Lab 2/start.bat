
@echo off
set /p id="Enter Port Number: "
cd %cd%

ruby MultiClientServer.rb %id%
pause