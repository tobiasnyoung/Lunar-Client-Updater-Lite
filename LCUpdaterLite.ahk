#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#SingleInstance, Force
EnvGet, vHomeDrive, HOMEDRIVE
EnvGet, vHomePath, HOMEPATH
UserProfile=% vHomeDrive vHomePath
;Index URLs

Arguments := ["-Download", "-UpdateIndex", "-UpdateIndexLT"]
for n, param in A_Args  ; For each parameter:
{
	
	IfNotExist, %UserProfile%\.lunarclient
		FileCreateDir, %UserProfile%\.lunarclient
	
	If (param = "-Download"){
		IfNotExist, Index.txt
			URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Updater-Lite/main/LCIndex.txt, Index.txt
		
		FileReadLine, vpatcher, Index.txt, 1
		FileReadLine, lunarprodoptifine, Index.txt, 2
		FileReadLine, lunarlibs, Index.txt, 3
		FileReadLine, lunarassetsprod1optifine, Index.txt, 4
		FileReadLine, lunarassetsprod2optifine, Index.txt, 5
		FileReadLine, lunarassetsprod3optifine, Index.txt, 6
		FileReadLine, nativeswinx64, Index.txt, 7
		FileReadLine, OptiFine, Index.txt, 8
		FileReadLine, LCVersion, Index.txt, 9
		
		
		;MsgBox, 64, Patches, %vpatcher%`n`n%lunarlibs%`n`n%lunarprodoptifine%`n`n%lunarassetsprod1optifine%`n`n%lunarassetsprod2optifine%`n`n%lunarassetsprod3optifine%`n`n%nativeswinx64%`n`n%optifine%
		
		
		IfNotExist, %UserProfile%\.lunarclient\offline\1.8
			FileCreateDir, %UserProfile%\.lunarclient\offline\1.8
		
		IfNotExist, %UserProfile%\.lunarclient\offline\licenses
			FileCreateDir, %UserProfile%\.lunarclient\licenses
		
		URLDownloadToFile, https://launcherlicenses.lunarclientcdn.com/ReplayMod.md, %UserProfile%\.lunarclient\licenses\ReplayMod.md
		URLDownloadToFile, https://launcherlicenses.lunarclientcdn.com/Blur.md, %UserProfile%\.lunarclient\licenses\Blur.md
		
		Gui, New, -MinimizeBox -MaximizeBox
		Gui, Add, Progress, w400 h20 vProgress cGreen +Smooth
		Gui, Add, Text,w400 vStatus, 
		Gui, Show,, Lunar Client Lite Updater - %LCVersion%
		
		GuiControl,, Progress, +10
		GuiControl, Text, Status, Downloading Lunar Client 1.8 vpatcher-prod.jar...
		URLDownloadToFile, https://offline.lunarclientcdn.com/1.8/vpatcher-prod.jar/%vpatcher%, %UserProfile%\.lunarclient\offline\1.8\vpatcher-prod.jar
		
		GuiControl,, Progress, +10
		GuiControl, Text, Status, Downloading Lunar Client 1.8 lunar-libs.jar...
		URLDownloadToFile, https://offline.lunarclientcdn.com/1.8/lunar-libs.jar/%lunarlibs%, %UserProfile%\.lunarclient\offline\1.8\lunar-libs.jar
		
		GuiControl,, Progress, +10
		GuiControl, Text, Status, Downloading Lunar Client 1.8 lunar-prod-optifine.jar...
		URLDownloadToFile, https://offline.lunarclientcdn.com/1.8/lunar-prod-optifine.jar/%lunarprodoptifine%, %UserProfile%\.lunarclient\offline\1.8\lunar-prod-optifine.jar
		
		GuiControl,, Progress, +10
		GuiControl, Text, Status, Downloading Lunar Client 1.8 lunar-assets-prod-1-optifine.jar...
		URLDownloadToFile, https://offline.lunarclientcdn.com/1.8/lunar-assets-prod-1-optifine.jar/%lunarassetsprod1optifine%, %UserProfile%\.lunarclient\offline\1.8\lunar-assets-prod-1-optifine.jar
		
		GuiControl,, Progress, +10
		GuiControl, Text, Status, Downloading Lunar Client 1.8 lunar-assets-prod-2-optifine.jar...
		URLDownloadToFile, https://offline.lunarclientcdn.com/1.8/lunar-assets-prod-2-optifine.jar/%lunarassetsprod2optifine%, %UserProfile%\.lunarclient\offline\1.8\lunar-assets-prod-2-optifine.jar
		
		GuiControl,, Progress, +10
		GuiControl, Text, Status, Downloading Lunar Client 1.8 lunar-assets-prod-3-optifine.jar...
		URLDownloadToFile, https://offline.lunarclientcdn.com/1.8/lunar-assets-prod-3-optifine.jar/%lunarassetsprod3optifine%, %UserProfile%\.lunarclient\offline\1.8\lunar-assets-prod-3-optifine.jar
		
		GuiControl,, Progress, +10
		GuiControl, Text, Status, Downloading Lunar Client 1.8 OptiFine.jar...
		URLDownloadToFile, %OptiFine%, %UserProfile%\.lunarclient\offline\1.8\OptiFine.jar
		
		GuiControl,, Progress, +10
		GuiControl, Text, Status, Downloading 1.8 natives-win-x64.zip...
		URLDownloadToFile, https://offline.lunarclientcdn.com/1.8/natives-win-x64.zip/%nativeswinx64%, %UserProfile%\.lunarclient\offline\1.8\natives-win-x64.zip
		
		GuiControl,, Progress, +10
		GuiControl, Text, Status, Extracting 1.8 natives-win-x64.zip...
		Run, "C:\Windows\System32\WindowsPowerShell\v1.0\PowerShell.exe" -Command Expand-Archive -LiteralPath '%UserProfile%\.lunarclient\offline\1.8\natives-win-x64.zip' -DestinationPath '%UserProfile%\.lunarclient\offline\1.8\natives' -Force,, Hide
		Process, Wait, powershell.exe
		
		GuiControl,, Progress, +100
		GuiControl, Text, Status, Finished
		Sleep, 1000
		ExitApp
		
	}

	If (param = "-UpdateIndexLT"){
		FileDelete, Index.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Updater-Lite/main/Index.txt, Index.txt
		MsgBox, 64, Index Updated, Downloaded the latest index for Lunar Tweaks from Lunar Client Updater Lite's GitHub Repository., 2
		ExitApp
	}
	
	If (param = "-UpdateIndex") {
		FileDelete, Index.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Updater-Lite/main/LCIndex.txt, Index.txt
		MsgBox, 64, Index Updated, Downloaded the latest index from Lunar Client Updater Lite's GitHub Repository., 2
		ExitApp
	}	
}

GuiClose(){
	ExitApp
}
