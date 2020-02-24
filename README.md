# AACAP
A*ndroid A*PK* CA P*atcher*

Batch automatisation program that patch any apk to allow unknowns CA to be used.

USE: 
     
     CaPatcher.bat FILE.APK
  
     CaPatcher.bat [DRAG/DROP]
    
![Example](https://raw.githubusercontent.com/TheDoka/AACAP/master/example.png)

Known issues: 

Will not work with every apk, apktool won't always be able to recompile the apk, even if the apk did not changed...

*The AndroidManifest file wich is being patched may already contains a NetworkSecurityConfig configuration file tho the batch won't be able to patch it then, it's really easy to do by hand.*

USING: 

Apktool: https://ibotpeaches.github.io/Apktool/

SignApk: https://github.com/techexpertize/SignApk
