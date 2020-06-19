#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
HotKeySet("{F1}", "Terminate")
; Download a file in the background.
; Wait for the download to complete.

$apikey = "c1a74e419f48ac8f0015f3ace914d890c8587621cdbd486649449bfd6b4703dc"
Global $count = 0

$header = "Date: "& @MDAY & "." & @MON & "." & @YEAR & "    Time: " & @HOUR & ":" & @MIN &","& @SEC &"   START  " & @CRLF
ConsoleWrite($header)
$fhandler = FileOpen("Logdl.txt",1)
FileWrite($fhandler,$header)
FileClose($fhandler)

$datei = FileRead("hash.txt")
Global $hash = StringSplit($datei, @CRLF)
For $i = 1 To $hash[0] Step 2
    ;MsgBox(0, "", $hash[$i] & "  Count: " & $count)
	Example()
	$count = $count + 1
 Next
Terminate()

Func Example()
    ; Save the downloaded file to the temporary folder.
    Local $sFilePath = @ScriptDir & "\" & $count & ".zip"

    ; Download the file in the background with the selected option of 'force a reload from the remote site.'
    ;Local $hDownload = InetGet("https://malshare.com/api.php?api_key="& $apikey &"&action=getfile&hash=" & $hash[$i], $sFilePath)
	Local $hDownload = InetGet("https://s3.eu-central-1.amazonaws.com/dasmalwerk/downloads/" & $hash[$i], $sFilePath)
    ; Retrieve the number of total bytes received and the filesize.
    Local $iFileSize = FileGetSize($sFilePath)

    ; Close the handle returned by InetGet.
    InetClose($hDownload)

    ; Display details about the total number of bytes read and the filesize.
   ; MsgBox($MB_SYSTEMMODAL, "", "The total download size: "  & @CRLF & _"The total filesize: " & $iFileSize)
 $fhandler = FileOpen("Logdl.txt",1)
FileWrite($fhandler,$count & ": "&$iFileSize &"  Hash:  " &  $hash[$i] &@CRLF)
FileClose($fhandler)
    ; Delete the file.

EndFunc   ;==>Example

Func Terminate()
   $footer = "Durchläufe:  "& $count &"   Date: "& @MDAY & "." & @MON & "." & @YEAR & "    Time: " & @HOUR & ":" & @MIN &","& @SEC &"   ENDE"  & @CRLF
ConsoleWrite($footer)
$fhandler = FileOpen("Logdl.txt",1)
FileWrite($fhandler,$footer)
FileClose($fhandler)
    Exit
EndFunc   ;==>Terminate
