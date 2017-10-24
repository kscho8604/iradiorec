::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::  FILE	iradiorec.bat  
::  BRIEF	DOS Script for Recording RTSP Audio Stream to MP3 file  
::  DATE	24. OCT 2017
::  VERSION	V1.0
::
::  CALL 	gst-launch-1.0.exe  ( Download from GStreamer - https://gstreamer.freedesktop.org/ )
::
::  %1 		RTSP URL
::  %2 		Recording Time (SEC.)
::
::
::  Copyright (c) 2017, Chao (https://iradiorec.blogspot.com/)
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off

setlocal
:: remove '-' from %date%
set date2=%date:-=%
:: remove space from %time%
set time2=%time: =0%
:: trim %time2% 
set time3=%time2:~0,2%%time2:~3,2%
:: set file name
set FILE_NAME=%date2%_%time3%.mp3

set RTSP_URL=%1
set REC_TIME_SEC=%2

start /min c:\gstreamer\1.0\x86_64\bin\gst-launch-1.0 -q %RTSP_URL% ! decodebin ! audioconvert ! lamemp3enc ! filesink location=%FILE_NAME%

echo Recording %2 SEC.
echo From 	%RTSP_URL% 
echo To 	%FILE_NAME%

:: wait REC_TIME_SEC 
timeout /t %REC_TIME_SEC% /nobreak

:: stop recording
taskkill /im gst-launch-1.0.exe /f 

exit
