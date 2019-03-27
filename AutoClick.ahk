#SingleInstance, Force
#Persistent


Gui, +AlwaysOnTop +HwndMyGuiWindow
Gui, Add, Text, x5 y5 vInfoText1, Enter a Single Key to Press
Gui, Add, Text, x5 y25 vInfoText2, (LButton, t, e, etc.)
Gui, Add, Edit, w85 vInputKey, t
Gui, Add, Button, x95 y43 gChangeKey vEnterButton, Enter

Delay := 1000
SelectedKey := "LButton"

Pause


Loop{
	if (WinActive("ahk_class UnrealWindow")){
		Send {%SelectedKey% down}
		Sleep 50
		Send {%SelectedKey% up}
	}
	Sleep Delay
	Tooltip
}

F9::
	Gui, Show
return


#If, A_IsPaused
F12::
	Tooltip
	Pause
return
#If
F12::
	Tooltip
	Pause
return

~Right::
	Delay := Delay + 100
	Tooltip, %Delay% ms
	Sleep 200
	Tooltip
return

~Left::
	Delay := Delay>100 ? Delay - 100 : Delay
	Tooltip, %Delay% ms
	Sleep 200
	Tooltip
return

ChangeKey:
	Gui, Submit
	GuiControlGet, SelectedKey, , InputKey
	SoundBeep
return
