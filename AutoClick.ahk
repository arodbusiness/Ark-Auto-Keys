#SingleInstance, Force
#Persistent
#InstallKeybdHook
#InstallMouseHook
#Include TransSplashText.ahk


SpamDelay := 1000
KeyDownDelay := 50


SelectedKey := "LButton"
LastKey := SelectedKey
F10Text := "Choose Key"

X := 0
Y := 30



Enabled := False
GuiN := 88
GoSub, ToggleFn

Loop{
	if (WinActive("ahk_class UnrealWindow") && Enabled){

		if (SelectedKey="t"){
			if (CheckInv()){
				Send {%SelectedKey% down}
				Sleep KeyDownDelay
				Send {%SelectedKey% up}
			}
		}
		else
		{
			Send {%SelectedKey% down}
			Sleep KeyDownDelay
			Send {%SelectedKey% up}
		}
	}
	Sleep SpamDelay
}


F10::
	LastKey := A_PriorKey
	SelectedKey := "_"
	F10Text := "Waiting..."
	GoSub, UpdateGUI
	While (LastKey = SelectedKey || SelectedKey="F10" || SelectedKey="_"){
		SelectedKey := A_PriorKey
		Sleep 100
		;Tooltip, %A_PriorKey%`n%SelectedKey%`n%LastKey%
	}
	LastKey := SelectedKey
	F10Text := "Choose Key"
	GoSub, UpdateGUI

return




F12::
	Enabled := Enabled ? False : True
	GoSub, ToggleFn
return

ToggleFn:
	Gui, %GuiN%:Destroy
	EnabledText := Enabled ? "ON" : "OFF"
	TransSplashText_On(GuiN,"F12:", EnabledText, "Spam Current: " SelectedKey "  (F10: " F10Text ") (Spam Delay: " SpamDelay " ms) (Key Down Delay: " KeyDownDelay " ms)", hwndText, hwndTextS,,"White","Black",,X,Y, 800)
return

UpdateGUI:
	TransSplashText_Update("Spam Current: " SelectedKey "  (F10: " F10Text ") (Spam Delay: " SpamDelay " ms) (Key Down Delay: " KeyDownDelay " ms)", hwndText, hwndTextS)
return





~+Right::
	SpamDelay := SpamDelay + 50
	GoSub, UpdateGUI
return
		
~!Right::	
	KeyDownDelay := KeyDownDelay + 50
	GoSub, UpdateGUI
return



~+Left::
	SpamDelay := SpamDelay>50 ? SpamDelay - 50 : SpamDelay
	GoSub, UpdateGUI
return

~!Left::
	KeyDownDelay := KeyDownDelay>50 ? KeyDownDelay - 50 : KeyDownDelay
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

	if (R<165 && G>220 && B>240 && WinActive("ahk_class UnrealWindow"))
		RetVal := true
	else
		RetVal := false
		
	return RetVal
}
