TransSplashText_On(Number=99,Text1="",Text2="",Text3="",Font="",TC="",SC="",TS="",xPos="",yPos=""){
	If Text = 
		Text = TransSplashText
	If Font = 
		Font = Impact
	If TC = 
		TC = White
	If SC = 
		SC = 828284
	If TS = 
		TS = 16
	If xPos = 
		xPos = Center
	If yPos = 
		yPos = Center
		
	Q = 4
	If SC != 0
	{
		Gui, %Number%:Font, S%TS% C%SC% Q%Q%, %Font%
		Gui, %Number%:Add, Text, x12 y8, %Text1%

		Gui, %Number%:Font, S%TS% C%SC% Q%Q%, %Font%
		Gui, %Number%:Add, Text, x45 y8, %Text2%

		Gui, %Number%:Font, S%TS% C%SC% Q%Q%, %Font%
		Gui, %Number%:Add, Text, x85 y8, %Text3%
		
		
		
	}
	
	Gui, %Number%:Font, S%TS% C%TC% Q%Q%, %Font%
	Gui, %Number%:Add, Text, x10 y6 BackgroundTrans, %Text1%


	ToggleColor := Text2="ON" ? "Green" : "Red"
	Gui, %Number%:Font, S%TS% C%ToggleColor% Q%Q%, %Font%
	Gui, %Number%:Add, Text, x43 y6 BackgroundTrans, %Text2%

	Gui, %Number%:Font, S%TS% C%TC% Q%Q%, %Font%
	Gui, %Number%:Add, Text, x83 y6 BackgroundTrans, %Text3%

	
	
	
	Gui, %Number%:Color, EEAA99
	Gui, %Number%:+LastFound -Caption +AlwaysOnTop +ToolWindow
	WinSet, TransColor, EEAA99
	Gui, %Number%:Show, x%xPos% y%yPos% AutoSize NA, TransSplashTextWindow
}