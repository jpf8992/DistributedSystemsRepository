set portnum=%arg1%
@echo off
cd %cd%
ruby MultiClientServer.rb %portnum%
