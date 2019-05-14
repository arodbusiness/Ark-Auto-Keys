#SingleInstance, Force
#Persistent
#InstallKeybdHook
#InstallMouseHook
#Include TransSplashText.ahk


Delay := 1000
TooltipDelay := 1500

SelectedKey := "LButton"
LastKey := SelectedKey
F10Text := "Choose Key"

X := 0
Y := 30



Enabled := False
GoSub, UpdateGUI

Loop{
	if (WinActive("ahk_class UnrealWindow") && Enabled){
	
	
	
		if (SelectedKey="t"){
			if (CheckInv()){
				Send {%SelectedKey% down}
				Sleep 50
				Send {%SelectedKey% up}
			}
		}
		else
		{
			Send {%SelectedKey% down}
			Sleep 50
			Send {%SelectedKey% up}
		}
		
		
	}
	Sleep Delay
}


F10::
	LastKey := A_PriorKey
	F10Text := "Waiting..."
	GoSub, UpdateGUI
	While (LastKey = SelectedKey || LastKey="F10" || SelectedKey="" || SelectedKey="F10"){
		SelectedKey := A_PriorKey
		Sleep 100
	}
	LastKey := SelectedKey
	F10Text := "Choose Key"
	GoSub, UpdateGUI

return




F12::
	if (Enabled)
		Enabled := False
	else
		Enabled := True
	GoSub, UpdateGUI
return


UpdateGUI:
	GuiN := 88
	Gui, %GuiN%:Destroy
	if (Enabled)
		EnabledText := "ON"
	else
		EnabledText := "OFF"
	TransSplashText_On(GuiN,"F12:", EnabledText, "Spam Current: " SelectedKey "  (F10: " F10Text ") (Delay: " Delay " ms)",,"White","Black",,X,Y)

return





~Right::
	Delay := Delay + 100
	GoSub, UpdateGUI
return

~Left::
	Delay := Delay>100 ? Delay - 100 : Delay
	GoSub, UpdateGUI
return



CheckInv(){

	if (A_ScreenWidth>=1920){
		;;;;;;1920x1080
		X := 0.438*A_ScreenWidth
		Y := 0.026*A_ScreenHeight
	}
	else
	{
		;;;;;;1680x1050
		X := 0.440*A_ScreenWidth
		Y := 0.08*A_ScreenHeight
	}
	
	PixelGetColor, Color, %X%, %Y%
	B := Color >> 16 & 0xFF, G := Color >> 8 & 0xFF, R := Color & 0xFF
	;Tooltip, %R%`n%G%`n%B%`n%Color%`n%X%`n%Y%, X+2, Y+2

	if (R<165 && G>220 && B>240 && WinActive("ahk_class UnrealWindow"))
		RetVal := true
	else
		RetVal := false
		
	return RetVal
}
