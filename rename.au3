#include <File.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Array.au3>
$sFileRenamed = ".exe"
$sPath = @ScriptDir
;$aFiles = 0
$aFiles = _FileListToArray($sPath,"*",1)


For $i = 1 To UBound($aFiles)-1

;MsgBox(0,"","C:\Users\huber\Desktop\test\" & $aFiles[$i])

$soucre = $sPath & _ArrayToString($aFiles[$i])



$dest = $sPath &"\" &$aFiles[$i] & $sFileRenamed

;MsgBox(0,"", $dest)

$test=FileMove("C:\Users\WIN10LAB\Desktop\NeuerOrdner\" & $aFiles[$i], $dest,1)
;MsgBox(0,"", $test)
Next
