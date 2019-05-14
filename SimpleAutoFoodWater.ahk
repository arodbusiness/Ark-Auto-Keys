#SingleInstance, Force
#Persistent
#Include TransSplashText.ahk


TooltipDelay := 1000

WaterDelay := 3600
FoodDelay := 10800


WaterButton := "8"
FoodButton := "9"


Enabled := true


LastDrink := A_Now
LastEat := A_Now



Loop{
	if (Enabled && WinActive("ahk_class UnrealWindow")){
		
		DrinkTime := LastDrink
		EnvSub, DrinkTime, %A_Now%, seconds 
		DrinkTime := WaterDelay + DrinkTime
		
		DrinkTimeM := DrinkTime/60
		DrinkTimeS := round("0" substr(DrinkTimeM, InStr(DrinkTimeM, "."))*60,0)
		DrinkTimeM := substr(DrinkTimeM, 1, InStr(DrinkTimeM, ".")-1)
		
		DrinkTimeDisp := DrinkTimeM "m " DrinkTimeS "s"
		if (DrinkTime<=0)
			GoSub, Drink
			
			
		EatTime := LastEat
		EnvSub, EatTime, %A_Now%, seconds
		EatTime := FoodDelay + EatTime
		
		EatTimeM := EatTime/60
		EatTimeS := round("0" substr(EatTimeM, InStr(EatTimeM, "."))*60,0)
		EatTimeM := substr(EatTimeM, 1, InStr(EatTimeM, ".")-1)
		
		EatTimeDisp := EatTimeM "m " EatTimeS "s"
		if (EatTime<=0)
			GoSub, Eat
		
		
		
		GoSub, UpdateGUI
	}
	Sleep TooltipDelay
}

return

Eat:
	Send {%FoodButton%}
	LastEat := A_Now
return

Drink:
	Send {%WaterButton%}
	LastDrink := A_Now
return


F9::
	LastEat := A_Now
	LastDrink := A_Now
return


F11::
	if (Enabled)
		Enabled := False
	else
		Enabled := True
	GoSub, UpdateGUI
return


UpdateGUI:
	Gui, 99:Destroy
	if (Enabled)
		EnabledText := "ON"
	else
		EnabledText := "OFF"
	TransSplashText_On(99,"F11:", EnabledText, "Auto (Food: " EatTimeDisp ") (Water: " DrinkTimeDisp ") (F9: Reset)",,"White","Black",,0,0)
return