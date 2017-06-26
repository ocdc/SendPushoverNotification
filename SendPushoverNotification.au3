#include "WinHttp.au3"

; Check command line parameters
If $CmdLine[0] < 4 Or $CmdLine[0] > 5 Then
    MsgBox(64, "Help", "Must be called with arguments:" _
		& @CRLF & "1. API token - string no quotes (mandatory)" _
		& @CRLF & "2. User key - string no quotes (mandatory)" _
		& @CRLF & "3. Message Title - plain text string with quotes (mandatory but can be blank string)" _
		& @CRLF & "4. Message - plain text or HTML encoded string with quotes (mandatory)" _
		& @CRLF & "5. -debug - if used will show message popup (optional will assume not required)" _
		& @CRLF & @CRLF & "Example usage:" _
		& @CRLF & "SendPushoverNotification.exe apitoken userkey ""Title"" ""Message text"" -debug")
    Exit
Else
	; Pushover api url
	$sAddress = "https://api.pushover.net/1/messages.json"

	; Assign command line parameters to variables
	$sApiToken = $CmdLine[1]
	$sUserKey = $CmdLine[2]
	$sTitle = $CmdLine[3]
	$sMessage = $CmdLine[4]

	; Construct the form
	Const $sForm = '<form action="' & $sAddress & '" method="post">' & _
	'<input name="token" value="' & $sApiToken & '"/>' & _
	'<input name="user" value="' & $sUserKey & '"/>' & _
	'<input name="title" value="' & $sTitle & '"/>' & _
	'<input name="message" value="' & $sMessage & '"/>' & _
	'</form>'

	; Open session
	$hOpen = _WinHttpOpen()
	; To collect connection handle (because the form is in-line)
	$hConnect = $sForm
	; Fill the form
	$sRead = _WinHttpSimpleFormFill($hConnect, $hOpen)

	; Close handles
	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)

	; Message sent
	If $CmdLine[0] = 5 And $CmdLine[5] = "-debug" Then
		MsgBox(4096, "Debug Information", $sRead, 10)
	EndIf
EndIf