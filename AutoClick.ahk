Delay := 1000

Loop{
	if (WinActive("ahk_class UnrealWindow")){
		Send {LButton}
		;;Send {t}
		;;Send {e}
	}
	Sleep Delay
	Tooltip
	
	
	
}

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

Right::
	Delay := Delay + 100
	Tooltip, %Delay% ms
return

Left::
	Delay := Delay>100 ? Delay - 100 : Delay
	Tooltip, %Delay% ms
return
