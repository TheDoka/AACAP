@echo off
set file=%~nx1

echo [PHASE 1] Decompiling %file%...
"bin/apktool.jar" d %file%
echo [PHASE 1] Done.



echo [PHASE 2] Patching %file%...
echo [PHASE 2] Editing AndroidManifest.xml...
rem Edit the AndroidManifest file to specifiy to use our custom network-security-config file.
powershell -Command "(gc %~n1\AndroidManifest.xml) -replace '<application', '<application android:networkSecurityConfig=""@xml/network_security_config""""' | Out-File -encoding ASCII %~n1\AndroidManifest.xml"



echo [PHASE 2] Creating network-security-config file...
rem Create the XML file that allows the application to use unknown certificates.
(
echo ^<network-security-config^>  
echo       ^<base-config^>  
echo             ^<trust-anchors^>  
echo                 ^<!-- Trust preinstalled CAs --^>  
echo                 ^<certificates src="system" /^>  
echo                 ^<!-- Additionally trust user added CAs --^>  
echo                 ^<certificates src="user" /^>  
echo            ^</trust-anchors^>  
echo       ^</base-config^>  
echo  ^</network-security-config^>
 )>%~n1/res/xml/network_security_config.xml
echo [PHASE 2] Done.



echo [PHASE 3] Recompiling %~n1...
rem Recompile by directory as a temp apk
"bin/apktool.jar" b %~n1 -o %~n1-tmp.apk
echo [PHASE 3] Done.



echo [PHASE 4] Signing...
rem Sign the tmp apk as final patched apk.
"bin/signapk.jar" "bin/certificate.pem" "bin/key.pk8" %~n1-tmp.apk %~n1-patched.apk
echo [PHASE 4] Done.


echo Cleaning...
del %~n1-tmp.apk
rmdir /S /Q %~n1
echo Done.


pause
