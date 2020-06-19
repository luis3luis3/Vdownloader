#include <inet.au3>
#include <array.au3>
#include <File.au3>

$count= 0

$address = "https://das-malwerk.herokuapp.com/"
$source = _InetGetSource($address)



;$links = StringRegExp($source,'<a href="(.*?)"',3) malshare
$links = StringRegExp($source,'<a href="https://s3.eu-central-1.amazonaws.com/dasmalwerk/downloads/(.*?)"',3)



_ArrayDisplay($links)

; Create a file in the users %TEMP% directory.
Local $sFilePath = @ScriptDir & "\Links.txt"

; Write array to a file by passing the file name.
_FileWriteFromArray($sFilePath, $links, 1)

; Display the file.
ShellExecute($sFilePath)

