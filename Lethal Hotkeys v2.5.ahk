/*
	Script: Lethal Hotkeys
	Author: persondatlovesgames
	Version: 2.5
	Description: A script providing macros for lethal company
*/

#SingleInstance Force
#MaxThreads 255
#HotIf WinActive("ahk_exe Lethal Company.exe")

; Set up the Specific Shutdown GUI
SpecificShutdownGui := Gui.Call()
SpecificShutdownGui.Opt("+Resize +MinSize200x100 +MaxSize200x100 -MaximizeBox -MinimizeBox")
SpecificShutdownGui.SetFont("s10", "Segoe UI")
SpecificShutdownGui.Title := "Specific Shutdown"
SpecificShutdownGui.AddText("x5", "Please enter codes")
SpecificShutdown := SpecificShutdownGui.AddEdit("w190 h25 y40 x5")
SpecificShutdownClearButton := SpecificShutdownGui.AddButton("w90 h25 y70 x105", "Clear")
SpecificShutdownClearButton.OnEvent("Click", (*) => SpecificShutdown.value := "")
SpecificShutdownConfirmButton := SpecificShutdownGui.AddButton("Default w90 h25 y70 x5", "Confirm")
SpecificShutdownConfirmButton.OnEvent("Click", (*) => WinClose(SpecificShutdownGui))
SpecificShutdownGui.OnEvent("Escape", WinClose)

; Set up the Radar Booster GUI
RadarBoosterGui := Gui.Call()
RadarBoosterGui.Opt("+Resize +MinSize200x100 +MaxSize200x100 -MaximizeBox -MinimizeBox")
RadarBoosterGui.SetFont("s10", "Segoe UI")
RadarBoosterGui.Title := "Radar Booster"
RadarBoosterGui.AddText("x5", "Please enter radar name")
RadarBooster := RadarBoosterGui.AddEdit("w190 h25 y40 x5")
RadarBoosterClearButton := RadarBoosterGui.AddButton("w90 h25 y70 x105", "Clear")
RadarBoosterClearButton.OnEvent("Click", (*) => RadarBooster.value := "")
RadarBoosterConfirmButton := RadarBoosterGui.AddButton("Default w90 h25 y70 x5", "Confirm")
RadarBoosterConfirmButton.OnEvent("Click", (*) => WinClose(RadarBoosterGui))
RadarBoosterGui.OnEvent("Escape", WinClose)

; Open GUI Keybinds
F6::RadarBoosterGui.Show()
F7::SpecificShutdownGui.Show()

; F# Keybinds
F1::Send "view monitor{Enter}"
F2::Send "switch{Enter}"
F3::Send "transmit "
F4::{
	Global RadarBooster
	For each, RadarBooster in StrSplit(RadarBooster.value,","){
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
	break
	}
	Send "flash " RadarBooster "{Enter}"
	Sleep 50
	}
}
F5::{
	Global RadarBooster
	For each, RadarBooster in StrSplit(RadarBooster.value,","){
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
	break
	}
	Send "ping " RadarBooster "{Enter}"
	Sleep 50
	}
}

; Utility Keybinds
*^x::Send "scan{Enter}"

*^Backspace::Send "{BS 10}"

*^c::{
Send("buy walk 1{Enter}")
Sleep 250
Send("con{Enter}")
}

; Drop All Loot
DroppingLoot := false
*XButton2::{
	If !ChrouchSprintToggle and !SellingLoot{
		Global DroppingLoot := true
	Loop 4 {
		If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
			break
		}
		Send "g"
		Sleep 100
		Send "{WheelDown}"
		Sleep 200
	}
	Send "g"
	DroppingLoot := false
}
}

; Sell All Loot
SellingLoot := false
*XButton1::{
	If !ChrouchSprintToggle and !DroppingLoot{
		Global SellingLoot := true
	Loop 4 {
		If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
			break
		}
		Send "e"
		Sleep 100
		Send "{WheelDown}"
		Sleep 1000
	}
	Send "e"
	SellingLoot := false
}
}

; Hold to Scan
*RButton::{
If !ChrouchSprintToggle and !DroppingLoot and !SellingLoot{
While (GetKeyState("RButton", "P")){
	Send "{RButton}"
	Sleep 500
	}
} else {
	Send "{RButton}"
}
}


; Code Toggle Keybinds
*^k::{
CurrentCode := 1
While(CurrentCode < StrLen(SpecificShutdown.value)){
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
		break
	}
	Send(SubStr(SpecificShutdown.value, CurrentCode, 2))
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
		break
	}
	Send "{Enter}"
	Sleep 30
	CurrentCode := CurrentCode + 2
	}
}

*^m::{
GlobalCodes := "b3c1c2c7d6f2h5i1j6k9l0m6m9o5p1r2r4t2u2u9v0x8y9z3"
CurrentCode := 1
While(CurrentCode < StrLen(GlobalCodes)){
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
		break
	}
	Send(SubStr(GlobalCodes, CurrentCode, 2))
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
		break
	}
	Send "{Enter}"
	Sleep 30
	CurrentCode := CurrentCode + 2
	}
}

; Loop Code Toggle Keybinds
#MaxThreadsPerHotkey 2
GlobalCodesToggle := false
^n::{
Global GlobalCodesToggle := !GlobalCodesToggle
GlobalCodes := "b3c1c2c7d6f2h5i1j6k9l0m6m9o5p1r2r4t2u2u9v0x8y9z3"
Loop{
	If not GlobalCodesToggle
		break
CurrentCode := 1
While(CurrentCode < StrLen(GlobalCodes)){
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
		GlobalCodesToggle := false
		break 2
	}
	Send(SubStr(GlobalCodes, CurrentCode, 2))
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
		GlobalCodesToggle := false
		break 2
	}
	Send "{Enter}"
	Sleep 30
	CurrentCode := CurrentCode + 2
	}
	Sleep 1700
}
}

SpecificCodesToggle := false
^j::{
Global SpecificCodesToggle := !SpecificCodesToggle
Loop{
	If not SpecificCodesToggle
		break
CurrentCode := 1
While(CurrentCode < StrLen(SpecificShutdown.value)){
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
		SpecificCodesToggle := false
		break 2
	}
	Send(SubStr(SpecificShutdown.value, CurrentCode, 2))
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
		SpecificCodesToggle := false
		break 2
	}
	Send "{Enter}"
	Sleep 30
	CurrentCode := CurrentCode + 2
	}
	Sleep 1700
}
}

; Movement Keybinds
ChrouchSprintToggle := false
*MButton::{
Global ChrouchSprintToggle := !ChrouchSprintToggle
If ChrouchSprintToggle{
	Send "{LControl}"
	Send "{LShift Down}"
}
else
	Send "{LShift Up}"
Loop{
	If !WinActive("ahk_exe Lethal Company.exe") or GetKeyState("LWin", "P"){
		Send "{LShift Up}"
		Send "{LControl Up}"
		ChrouchSprintToggle := false
		break
	}
	If !ChrouchSprintToggle{
		break
	}
	Send "{LControl}"
	Sleep 100
	}
}