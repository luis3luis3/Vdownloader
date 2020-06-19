#RequireAdmin
#include <File.au3>
#include <Timers.au3>
HotKeySet("{F1}", "Terminate")
$header = "Date: "& @MDAY & "." & @MON & "." & @YEAR & "    Time: " & @HOUR & ":" & @MIN &","& @SEC &"   START  " & @CRLF
Global $prozent = 0
Global $bprozent = 0
Global $blockprozent = 0
Global $rblockprozent = 0
Global $blocked = 0
Global $missed = 0
Global $misspath[100]
ConsoleWrite($header)
$fhandler = FileOpen("Logex.txt",1)
FileWrite($fhandler,$header)
FileClose($fhandler)

Local $sPath, $aFiles, $sText
$sPath = FileSelectFolder("Please select a folder.","",Default,@ScriptDir)
If @error Then Exit


$hStarttime = _Timer_Init()
$aFiles = _FileListToArray($sPath,"*.exe",1) ; Txt Dateien in ein Array lesen
If @error Then Exit MsgBox(16,"Error","No files found")
For $i = 1 To UBound($aFiles)-1
Local $iPID = run($sPath & "\" &$aFiles[$i])
$anzahl = UBound($aFiles)-1
$onep = 100 / $anzahl
$bonep = 100 / $i
if $iPID = 0 Then
$blocked = $blocked + 1
$status = "blocked!"
Else

$status = "missed!"
$misspath[$missed] = ($sPath & "\" &$aFiles[$i])
;_ArrayDisplay($misspath,"tisplay")
$missed = $missed + 1
EndIf

$blockprozent  = $blocked * $bonep
$rblockprozent = Round($blockprozent, 2)
 $prozent  = $prozent + $onep
 $rprozent = Round($prozent, 2)


$load1 = "'" & $sPath & "\" &$aFiles[$i] & "' " & $status & @CRLF
$load2 = "Progress:  "& $rprozent & " % done" & @CRLF
$load3 = "Pro-activ Detection: " & $rblockprozent & "%" &@CRLF
ConsoleWrite($load1)
ConsoleWrite($load2)
ConsoleWrite($load3)
$fhandler = FileOpen("Logex.txt",1)
FileWrite($fhandler,$load1)
FileWrite($fhandler,$load2)
FileWrite($fhandler,$load3)
FileClose($fhandler)

Next
Terminate()

Func Terminate()
    $dif = _Timer_Diff($hStarttime)
    $Count = $dif/1000
    $60Count = Round($Count / 60,2)
$fhandler = FileOpen("Logex.txt",1)
   $footer1 =  @CRLF & "--- Test is done.  "& $i-1 &" files executed!" & @CRLF & @CRLF
   $footer2 = "Final pro-activ detection: " & $rblockprozent & " %  " & @CRLF & "Total missed: " & $missed & @CRLF & @CRLF
   $footer3 = "Time Taken (min): " & $60Count & @CRLF
   $footer4 = "Date: "& @MDAY & "." & @MON & "." & @YEAR & "    Time: " & @HOUR & ":" & @MIN &","& @SEC &"   ENDE"  & @CRLF
   $footer5 = "Test conducted by LH - Cyber Security." & @CRLF & @CRLF & @CRLF & @CRLF & "Files missed:" & @CRLF
   FileWrite($fhandler,$footer1)
   FileWrite($fhandler,$footer2)
   FileWrite($fhandler,$footer3)
   FileWrite($fhandler,$footer4)
   FileWrite($fhandler,$footer5)
   _FileWriteFromArray($fhandler, $misspath, 1)
ConsoleWrite($footer1)
ConsoleWrite($footer2)
ConsoleWrite($footer3)
ConsoleWrite($footer4)
ConsoleWrite($footer5)

FileClose($fhandler)
    Exit
EndFunc   ;==>Terminate



