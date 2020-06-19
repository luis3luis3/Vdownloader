;~ https://www.autoitscript.com/forum/topic/183043-autoit-console-data-to-file

#pragma compile(Console, true)

#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <FileConstants.au3>

If $CmdLine[0] = 0 Then Exit

Example()

Func Example()
    Local $sCommand = $CmdLine[1]
    If $CmdLine[0] > 1 Then
        For $iCMD_idx = 2 To $CmdLine[0]
            $sCommand &= ' ' & $CmdLine[$iCMD_idx]
        Next
    EndIf
    Local $iPID = Run(@ComSpec & " /c " & $sCommand, @SystemDir, Default, $RUN_CREATE_NEW_CONSOLE + $STDERR_CHILD + $STDOUT_CHILD)
    Local $sOutput = _
            @CRLF & @CRLF & _
            'THIS IS LOG FILE FOR:' & @CRLF & _
            $sCommand & @CRLF & _
            'LOG START TIME: ' & _LogGetDate() & @CRLF & _
            'RESULT:' & @CRLF & _
            '=====================================' & @CRLF & _
            ''

    Local $hFile = FileOpen('ConsoleWrite_' & StringRegExpReplace(_LogGetDate(),'\D','_') & '.log', $FO_OVERWRITE + $FO_UTF8_NOBOM)

    ConsoleWrite($sOutput)
    FileWrite($hFile, $sOutput)

    While 1
        $sOutput = StdoutRead($iPID)
        If @error Then ; Exit the loop if the process closes or StdoutRead returns an error.
            ExitLoop
        EndIf
        ConsoleWrite($sOutput)
        FileWrite($hFile, $sOutput)
    WEnd

    $sOutput = _
            '=====================================' & @CRLF & _
            'LOG END TIME: ' & _LogGetDate() & @CRLF & _
            ''

    ConsoleWrite($sOutput)
    FileWrite($hFile, $sOutput)
    FileClose($hFile)

EndFunc   ;==>Example

Func _LogGetDate()
    Return @YEAR & '/' & @MON & '/' & @MDAY & '  ' & @HOUR & ':' & @MIN & ':' & @SEC
EndFunc   ;==>_LogGetDate