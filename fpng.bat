@echo off
setlocal
cd /d %~dp0


set location=%CD%
set project_name=%1
set direct=%2
set direc=%direct:~0,-1%
set drive=%direc:~1, 2%
set undrive="%direc:~4%
echo.(%drive% drive %undrive%" )
echo.(Extracting node Modules)
Call :UnZipFile %direc%\%1" "C:\Program Files\FastProjectAngular\node_modules.zip"
%drive%
cd %undrive%\%1\node_modules"%
echo.(now calling zpack_extract)
Call zpack_extract.bat
cd ..
echo.(Procress Finished)
exit /b

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%