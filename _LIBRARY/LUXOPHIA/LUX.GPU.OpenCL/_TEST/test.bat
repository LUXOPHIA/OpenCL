@echo off
setlocal

rem This file is Shift-JIS. Run it under code page 932, then restore the console's code page.
for /f "tokens=2 delims=:." %%A in ('chcp') do set CP=%%A
chcp 932 >nul
call :main %*
set RESULT=%ERRORLEVEL%
chcp %CP% >nul
exit /b %RESULT%

rem 試験（LUX.OpenCL.Tests）を作って走らせる。
rem
rem   test.bat     試験を作り（Win64）、走らせ、出力を消す
rem
rem ・出力は、すべて一時フォルダーの下の専用のフォルダーに出し、終わったら消す（ここに dcu・exe を残さない）。
rem ・失敗は、終了コード 1 で返す。
rem ・このライブラリは、基盤のライブラリ LUX を使う。LUX は、このフォルダーの 2 つ上にある LUX（アプリに
rem   組み込まれたときの並び）か、・LUX（ライブラリの実体を並べた場所での並び）から読む。
rem ・このファイルは、Shift-JIS・CRLF で保存する。cmd は、バッチを、コンソールのコード ページで読むので、
rem   上で、コード ページを 932 に替えてから、ここから下を読ませている。

:main
rem 開発環境の場所は、その登録から取る
set STUDIO=
for /f "tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\WOW6432Node\Embarcadero\BDS\37.0" /v RootDir 2^>nul ^| find "RootDir"') do set STUDIO=%%B
if not defined STUDIO echo RAD Studio 37.0 が見つかりません。& exit /b 1
if "%STUDIO:~-1%"=="\" set STUDIO=%STUDIO:~0,-1%

cd /d "%~dp0" || goto :fail

set LUX=..\..\LUX
if not exist "%LUX%\LUX.pas" set LUX=..\..\・LUX
if not exist "%LUX%\LUX.pas" echo 基盤のライブラリ LUX が見つかりません（..\..\LUX にも ..\..\・LUX にも無い）。& exit /b 1

set OUT=%TEMP%\lux-opencl-tests
set UNITS=..;..\CL;..\Core;..\Argume;..\Stream;%LUX%;%LUX%\Code;%LUX%\Color;%LUX%\Data\List
set DCC="%STUDIO%\bin\dcc64.exe" -B -Q "-NSSystem;Winapi;System.Win;FMX" "-U%STUDIO%\lib\win64\release;%UNITS%" "-E%OUT%" "-NU%OUT%"

if exist "%OUT%" rmdir /s /q "%OUT%"
mkdir "%OUT%" || goto :fail

rem 試験を作って走らせる
%DCC% LUX.OpenCL.Tests.dpr || goto :fail
"%OUT%\LUX.OpenCL.Tests.exe" || goto :fail

rmdir /s /q "%OUT%"
echo 試験は、すべて通りました。
exit /b 0

:fail
if exist "%OUT%" rmdir /s /q "%OUT%"
echo 失敗しました（理由は、上の出力）。
exit /b 1
