Func _Au3RecordSetupAccHisRep()
Opt('WinWaitDelay',100)
Opt('WinDetectHiddenText',1)
Opt('MouseCoordMode',0)
Local $aResult = DllCall('User32.dll', 'int', 'GetKeyboardLayoutNameW', 'wstr', '')
If $aResult[1] <> '00000409' Then
  MsgBox(64, 'Warning', 'Recording has been done under a different Keyboard layout' & @CRLF & '(00000409->' & $aResult[1] & ')')
EndIf

EndFunc

Func _WinWaitActivateAccHisRep($title,$text,$timeout=0)
	WinWait($title,$text,$timeout)
	If Not WinActive($title,$text) Then WinActivate($title,$text)
	WinWaitActive($title,$text,$timeout)
EndFunc


#endregion --- Internal functions Au3Recorder End ---

Func _AccountHistoryReport()
_WinWaitActivateAccHisRep("WO Traffic 8.1.0","")
ControlClick("WO Traffic 8.1.0", "", "[CLASS:Edit; INSTANCE:1]")
Send("account{SPACE}history{SPACE}report{ENTER}")
_WinWaitActivateAccHisRep("Saved Reports - Account History Report","")
WinSetState("Saved Reports - Account History Report","", @SW_MAXIMIZE)

MouseClick("left",450,125,1)
Send("custom1{ENTER}")

MouseClick("left",690,211,1)
MouseClick("left",690,211,2)

_WinWaitActivateAccHisRep("Account History [Custom1]","")
WinSetState("Account History [Custom1]","", @SW_MAXIMIZE)
sleep(3000)

Local $hwnd = WinWait("[CLASS:TfrmAdvertiserHistory]", "", 10)

;MouseClick("left",261,61,1)

Send("{ALTDOWN}r{ALTUP}")


;Local $PgxBarExists = ControlCommand($hWnd, "", "[CLASS:TcxProgressBar]", "IsVisible", "")
;$PgxBarExists
Sleep(3000)
While ControlCommand($hWnd, "", "[CLASS:TcxProgressBar]", "IsVisible", "") = 1
	;MsgBox($MB_SYSTEMMODAL, "", "Progress Bar is Visible")
	;Local $PgxBarExists = ControlCommand($hWnd, "", "[CLASS:TcxProgressBar]", "IsVisible", "")
    Sleep(3000)
WEnd
;Do
;	MsgBox($MB_SYSTEMMODAL, "", "Progress Bar is Visible")
;	Sleep(3000)
;Until $PgxBarExists = 1
Sleep(2000)
;MsgBox($MB_SYSTEMMODAL, "", "Progress Bar is Not Visible1")

;----------- Save to File ---------------
MouseClick("right",348,458,1)
MouseClick("left",483,744,1)
MouseClick("left",582,742,1)

;--------------wait for save as Dialog ----------------
_WinWaitActivateAccHisRep("WideOrbit: Save to file","")

;------------- click on File name Textbox ----------------
MouseClick("left",441,514,1)
;Send("{SHIFTDOWN}c{SHIFTUP}{SHIFTDOWN};{SHIFTUP}\{SHIFTDOWN}r{SHIFTUP}eports{SHIFTDOWN}-{SHIFTUP}{SHIFTDOWN}i{SHIFTUP}{BACKSPACE}{BACKSPACE}\{SHIFTDOWN}i{SHIFTUP}nve{BACKSPACE}{BACKSPACE}{BACKSPACE}{BACKSPACE}{SHIFTDOWN}r{SHIFTUP}ev{SHIFTDOWN}r{SHIFTUP}ep{SHIFTDOWN}-{SHIFTUP}{SHIFTDOWN}c{SHIFTUP}ustom")
Send("C:\Reports\Custom_AccountHistoryReport")

;---------------- Select XLS option -------------------
MouseClick("left",382,538,1)
MouseClick("left",371,559,1)

;--------------- Click on Ok Button -------------------
MouseClick("left",793,587,1)

;--------------- Wait for 'Do you want to open Exported File?' message Dialog -----------------
_WinWaitActivateAccHisRep("WideOrbit Message","")

;-------------- Click on No Button in message Dialog -------------------
MouseClick("left",350,181,1)
_WinWaitActivateAccHisRep("frmFormManager","")
MouseClick("right",502,407,1)
_WinWaitActivateAccHisRep("Account History [Custom1]","")
MouseClick("right",560,465,1)
MouseClick("left",641,749,1)
MouseClick("left",791,755,1)
_WinWaitActivateAccHisRep("WideOrbit: Save to file","")
MouseClick("left",442,520,1)
Send("C:\Reports\Custom_AccountHistoryReport")
;Send("{SHIFTDOWN}re{SHIFTUP}v{SHIFTDOWN}re{SHIFTUP}{BACKSPACE}ep{SHIFTDOWN}-{SHIFTUP}{SHIFTDOWN}c{SHIFTUP}ustom")
MouseClick("left",322,585,1)
MouseClick("left",324,541,1)
MouseClick("left",315,569,1)
MouseClick("left",768,587,1)
_WinWaitActivateAccHisRep("WideOrbit Message","")

MouseClick("left",350,181,1)

Sleep(3000)

WinClose("Account History [Custom1]","")
WinClose("Saved Reports - Account History Report","")

EndFunc

_AU3RecordSetupAccHisRep()
_AccountHistoryReport()

Exit