set portnum=%1%
@echo off
cd %cd%
ruby MultiClientServer.rb %portnum%
