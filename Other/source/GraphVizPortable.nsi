!define VER 2.26.3.1
SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On
RequestExecutionLevel user
OutFile "..\..\GVEditPortable-Install-${VER}.exe"
Icon "..\..\App\AppInfo\appicon.ico"
Name "GraphVizPortable"
BrandingText "GraphVizPortable"
!include "MUI2.nsh"
!include "FileFunc.nsh"
!define MUI_ICON "..\..\App\AppInfo\appicon.ico"
!define MUI_HEADERIMAGE

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING
!define MUI_PAGE_HEADER_TEXT "GraphViz Portable"
!define MUI_PAGE_HEADER_SUBTEXT "GraphViz on the Go"

!define MUI_COMPONENTSPAGE_SMALLDESC

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\..\App\share\license.rtf"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"


SectionGroup /e "Graph Viz Portable" sec_graph_viz_portable ; Collapsed
  ; Description:
  ; Graph Viz Portable
  Section "Graph Viz Binaries" sec_graph_viz_binaries ; Checked
    ; Description:
    ; Graph Viz Binaries
    RmDir /r "$INSTDIR"
    SetOutPath "$INSTDIR"
    File "..\..\GVEditPortable.exe"
    SetOutPath "$INSTDIR\App\AppInfo"
    File /r "..\..\App\AppInfo\*.*"
    SetOutPath "$INSTDIR\App\bin"
    File /r "..\..\App\bin\*.*"
    SetOutPath "$INSTDIR\App\etc"
    File /r "..\..\App\etc\*.*"
    SetOutPath "$INSTDIR\App\lib"
    File /r "..\..\App\lib\*.*"
    SetOutPath "$INSTDIR\App"
    File "..\..\App\fontconfig_fix.dll"
    SetOutPath "$INSTDIR\App\share\"
    File "..\..\App\share\license.rtf"
    File "..\..\App\share\Thumbs.db"
    SetOutPath "$INSTDIR\App\share\fonts"
    File /r "..\..\App\share\fonts\*.*"
    SetOutPath "$INSTDIR\App\share\graphviz"
    File /r "..\..\App\share\graphviz\*.*"
  SectionEnd ; sec_graph_viz_binaries
  Section /o "Include Headers" sec_include_headers ; Unchecked (/o)
    ; Description:
    ; These are the c headers to include
    SetOutPath "$INSTDIR\include"
    File /r "..\..\App\include\*.*"
  SectionEnd ; sec_include_headers
  Section /o "Unix Man Pages" sec_unix_man_pages ; Unchecked (/o)
    ; Description:
    ; Unix Man Pages
    SetOutPath "$INSTDIR\share\man"
    File /r "..\..\App\share\man\*.*"
  SectionEnd ; sec_unix_man_pages
  Section /o "Portable App Build Sources" sec_portable_app_build_sources ; Unchecked (/o)
    ; Description:
    ; Portable App Build Sources
    SetOutPath "$INSTDIR\Other"
    File /r "..\..\Other\*.*"
  SectionEnd ; sec_portable_app_build_sources
SectionGroupEnd ; sec_graph_viz_portable
;--------------------------------
;Description(s)
LangString DESC_sec_graph_viz_portable ${LANG_ENGLISH} "Graph Viz Portable"
LangString DESC_sec_portable_app_build_sources ${LANG_ENGLISH} "Portable App Build Sources"
LangString DESC_sec_unix_man_pages ${LANG_ENGLISH} "Unix Man Pages"
LangString DESC_sec_include_headers ${LANG_ENGLISH} "These are the c headers to include"
LangString DESC_sec_graph_viz_binaries ${LANG_ENGLISH} "Graph Viz Binaries"
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${sec_portable_app_build_sources} $(DESC_sec_portable_app_build_sources)
  !insertmacro MUI_DESCRIPTION_TEXT ${sec_unix_man_pages} $(DESC_sec_unix_man_pages)
  !insertmacro MUI_DESCRIPTION_TEXT ${sec_include_headers} $(DESC_sec_include_headers)
  !insertmacro MUI_DESCRIPTION_TEXT ${sec_graph_viz_binaries} $(DESC_sec_graph_viz_binaries)
  !insertmacro MUI_DESCRIPTION_TEXT ${sec_graph_viz_portable} $(DESC_sec_graph_viz_portable)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Var PA
Function GetDriveVars
  StrCmp $9 "c:\" spa
  StrCmp $8 "HDD" gpa
  StrCmp $9 "a:\" spa
  StrCmp $9 "b:\" spa
  
  gpa:
    IfFileExists "$9PortableApps" 0 spa
    StrCpy $PA "$9PortableApps"
  spa:
    Push $0
FunctionEnd

Function .onInit
  StrCpy $PA ""
  ${GetDrives} "FDD+HDD" "GetDriveVars"
  StrCpy $INSTDIR "$PA\GraphVizPortable"
  IntOp $0 ${SF_RO} | ${SF_SELECTED}
  SectionSetFlags ${sec_graph_viz_binaries} $0
FunctionEnd
