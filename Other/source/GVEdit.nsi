SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user
OutFile "..\..\GVEditPortable.exe"
Icon "..\..\App\AppInfo\appicon.ico"

Section "Main" sec_main ; Checked
  ; Description:
  ; Main Section for GvEdit Launch
  IfFileExists "$EXEDIR/App/bin/Gvedit.exe" launch not_found
  launch:
    Exec $EXEDIR/App/bin/Gvedit.exe
    Goto end
  not_found:
    MessageBox MB_OK "Could not find Gvedit.exe.  Installation corrupt."
  end:
SectionEnd ; sec_main
