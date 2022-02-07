
;########################;;########################;;########################;;########################;;########################;;########################;;########################;
;########################;;########################;;########################;;########################;;########################;;########################;;########################;
;########################;;########################;;########################;;########################;;########################;;########################;;########################;
;  Usage:  (required AHK v1.1.31+)
;;;
;;;
;;;        Space - CHANGES THE KEY MODE !!! - Two modes, OSD or Window Management
;;;        
;;;        OSD MODE KEYS:
;;;            CAPSLOCK + 
;;;            F - Changes the Capslock + Left/Right Mouse button and C key modes
;;;                Left button creates, Right button offers options for existing interfaces, and C clears all interfaces.    
;;;            X - Creates a tick counter, offers options if active to change style, remove the counter, or change the tick count limit.
;;;            Z - Offers options for hiding, sticking cursor objects (messages/timers/etc) and nameplates
;;;            E - Changes the Global Timer Display mode between cursor, runelite, and runelite unless inactive
;;;            W - Pauses/Unpauses the global timer
;;;            R - Sets either the Account Specific countdown tzzzimer start time or the same for the Global Timer.
;;;            T - Creates or removes an account specific timer
;;;            Q - Creates or removes the Global Timer
;;;            A - Either counts the account specific counter up, or clears it - These are attached to nameplates, if nameplates are hidden these are too.
;;;            Up, Down, Left, Right move the nameplates and attached displays on the runelite windows, these locations are saved.
;;;        
;;;        
;;;        WINDOW MANAGEMENT KEYS:
;;;            CAPSLOCK + 
;;;            G - Launch a single runelite    
;;;            A - Disable/enable a window under the cursor
;;;            T - Disable/enable a single window that is focused (non runelite, very handy to use on the desktop, so accidentally right *FORBIDDEN_WORD*ing (c1ick) it is not possible)
;;;            Q - Set a window to be always ontop or not
;;;            R - Save runelite window locations or move to saved runelite window locations
;;;            D - Bring firefox/chrome into focus
;;;            W - Bring window opacity down
;;;            E - Reset window opacity to 255 (opaque)
;;;        
;;;        
;;;        GLOBAL KEYS
;;;        Capslock alone - Cycles through runelite window focus, priority on next account window if active else search for empty runelite (not logged in)
;;;            ;CAPSLOCK + 
;;;            B - Clears script settings, either all or all non-account settings    
;;;            Y - Reloads the script
;;;            N - Kills all runelite windows without warning
;;;            H - Kills the window, any window, even explorer, that is under the cursor without warning.
;;;            
;;;          
;;;

;########################;;########################;;########################;;########################;;########################;;########################;;########################;
;########################;;########################;;########################;;########################;;########################;;########################;;########################;
;########################;;########################;;########################;;########################;;########################;;########################;;########################;

;;;     ***It should go without saying, this script does not break jagex ToS.***
;;;----------------------------------------------------
;;;     A6 - File Below, current. "Moving Forward"
;;;----------------------------------------------------
;;;Nike'd the caps+H
;;;Created Temp variables in some for loops to prevent loops overlapping and causing some variables to change when they shouldn't
;;;Added searching for ontop windows to the reload function
;;;When displaying a window ontop, you will still be able to see the gui now instead of the gui being stuck underneath it.
;;;Nearly removed the please wait times on the global timer (its much faster)
;;;Changed the way text outlines are created and drawn
;;;Changed the way GUI's are removed/hidden/shown/added (Enabling the easy addition of future GUI)
;;;Changed When starting an account specific timer, with no time set now, it will prompt for a time as usual, but will start the timer afterward as well.
;;;Fixed GUI: 0 trying to exist (causing tons of error messages)
;;;Fixed when sometimes pausing the timer while attached to the cursor, the timer actually just stopping the change of location of the timer, meanwhile the timer would continue running.
;;;Fixed when setting a new global timer time, and the timer was running and attached to the cursor, the timer would freeze.
;;;Fixed timer not clearing text outlines
;;;Fixed Gui's not showing ontop of windows that are shown ontop
;;;Fixed Global timer displaying 60 when it should be 59, or 59 when it should be 60
;;;Added Capslock + B, tick counter, Left Alt + B changes its display mode, Capslock + N selects a new tick limit
;;;Added a gui specifically for debug messages, Capslock + U enables them.
;;;Various small optimizations, but didn't note them, IE. added GuiConF() which is a new function to handle GUI much better than before.
;;;     
;;;----------------------------------------------------
;;;     A503 513 - Depreciated
;;;----------------------------------------------------
;;;     
;;;     Account Specific timer functions operate on for loops, intialization of one now is a while loop.
;;;         Moved drawing of timers into a function paired with global UpdateOSD timer so
;;;         there is no delay when moving the GUI around.
;;;     Added rudimentary Outlines around GUI 3, and 2, which are the global timers and the mouse tooltip messages
;;;     Capslock F now will change the next Account Specific Timer Time that is created.
;;;     Added Capslock C which will hide Mouse Tooltip messages
;;;     Added Capslock H which will offer to kill the process of the window under the cursor, press again to confirm.
;;;     Fixed an issue where some variables may be written to the script directory not C:\Serbz_multilog
;;;     Fixed an issue where the Account specific timer belonging to the last account in the Account Array would not
;;;         Be created properly or drawn, and would also interrupt and remove the timer belongong to the first
;;;         Account in the Account Array
;;;     Added a sound that plays at the end of an Account specific timer
;;;     If the file favicon.ico exists in the directory C:\Serbz_Multilog\ as C:\Serbz_Multilog\favicon.ico
;;;         It will now be set as the script icon rather than the defaul AHK green bordered, white, capital, H.
;;;     
;;;----------------------------------------------------
;;;     A420, 421, 422 - Depreciated.
;;;----------------------------------------------------
;;;
;;;     Your usernames do not need to be entered at all anymore, your usernames are automatically added as played.
;;;     Account Setup Removed.
;;;     Fixed another problem with the global timer, where if the .log didn't exist it would get stuck in a loop
;;;     Removed msgbox left in a for statement
;;;     Changed the way GUI 1 is Hidden/Destroyed/Built to remove the blank ahk windows from the task bar
;;;     Fixed the global timer not setting as ontop
;;;     fixed not being able to reset the account specific timers
;;;
;;;----------------------------------------------------
;;;     A418 - https://pastebin.com/m5ygrkaV
;;;----------------------------------------------------
;;;
;;;     Account specific timers are funcional!
;;;     Each account can have its own timer, global timer is still a thing.
;;;     Fixed saving of the UI position, increased the amount of pixels it moves per key press as well.
;;;     Added Firefox or chrome first run question, caps d will now function with the one you select
;;;     added keys for clearing some or all of the settings
;;;     Fixed various different global timer bugs, where GUI failed destroy/build
;;;     Fixed an issue where deactivating a window did not work
;;;     Fixed unintentional issue with capslock+enter
;;;     Every dialogue box should now open at the cursor position
;;;     Added a delay to the reload for debugging reasons
;;;     Added Mouse tooltips for functions that were missing them.
;;;
;;;----------------------------------------------------
;;;     A332 - https://pastebin.com/TgypMUMx
;;;----------------------------------------------------
;;;
;;;     Every Hotkey is a capslock hotkey now
;;;     Various bugs fixed with the timer, hiding displays, and messages
;;;     Some more old hotkeys were removed
;;;     The timer's reset key was merged with capslock Q
;;;     
;;;----------------------------------------------------
;;;     A330 - https://pastebin.com/TgypMUMx
;;;----------------------------------------------------
;;;
;;;     Re-wrote how the GUI is built
;;;     Removed OBS and Twitch binds/functions/variables
;;;     Removed Login functions
;;;     Removed Window position functions
;;;     Re-wrote timer, fixing bugs and adding color
;;;     Added options to timer for window placement
;;;     Added GUI 3, status messages
;;;----------------------------------------------------
;;;     A120 & A121 - https://pastebin.com/eYrgizfQ <-121
;;;----------------------------------------------------
;;;
;;;     Added GUI Controls
;;;     Added an initial setup for account names so it will work for not just me
;;;     Changed many static variabls to dynamic
;;;     The twitch/obs timers are set to off by default
;;;     
;;;     -/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-
;;;     @Roof Scapers 
;;;     **ALSO!!
;;;     If you could react to this message with :thumbsup: I'll assign you a role to be specifically tagged with these updates in the future so I do not have to tag the @Roof Scapers role from then on.**
;;;     -/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-

;########################;;########################;;########################;;########################;;########################;;########################;;########################;
;########################;;########################;;########################;;########################;;########################;;########################;;########################;
;########################;;########################;;########################;;########################;;########################;;########################;;########################;


;;;Fixed the jitter when the tick counter was set to rotate around the cursor, its very smooth now, and it moves slower, i didn't like how fast it was going it was hard to pay attention to. Much better now.
;;;They Aren't Perfect yet but account specific timers have outlines now too
;;;Account Specific timer time will now save between reloads
;;;Finally have proper timer sounds that don't force the whole thread to pause.
    ;; The global timer will now audibly alert you.

;;;;#MaxThreadsPerHotkey 999
#MaxThreads 999
#MaxThreadsPerHotkey 99
;;;#HotkeyInterval 500 ; This is the default value (milliseconds).
#MaxHotkeysPerInterval 999
#MaxThreadsBuffer On
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
;;;#ErrorStdOut
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 2 ; Match if the text appears anywhere in the window title
SetCapsLockState, off
SetCapsLockState, alwaysoff
StringCaseSense, off
DetectHiddenWindows, on
SetBatchLines, -1
CoordMode, Mouse, Screen
;;Hotkey, Capslock & LButton, , T99
SetMouseDelay, 0
SetKeyDelay, 0
SetWinDelay, 0
IfExist, C:\Serbz_Multilog\
    FileMoveDir, C:\Serbz_Multilog\, C:\ProgramData\SerbzOSD, R
CS=C:\ProgramData\SerbzOSD\







IfExist, %CS%favicon.ico
    Menu, Tray, Icon, %CS%favicon.ico



P_WinUMID:=

;########################;;########################;;########################;
;########################;;######ACC SETUP#########;;########################;
;########################;;########################;;########################;
NoRLDir:=0
NoAHKVars:=0
RuneLiteDir:=
MsgboxMove_String:=
SetTimer, MsgboxMove, 250
SetTimer, MsgboxMove, off

ifExist, %CS%AHKDirectory.log
{ 
fileRead, AHKDirectory, %CS%AHKDirectory.log
ifExist, E:\rsahkvars
    FileMoveDir, E:\rsahkvars, %AHKDirectory%, R
SavedVarsDir=%AHKDirectory% ;; SavedVarsDir=C:\rsahkvars ;; - LAPTOP
ifNotExist, %SavedVarsDir%
    NoAHKVars:=1
} else {
NoAHKVars:=1
}
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;;-;-;-;-;-;-;-;-
;-;-;-;-;-;-; Number of accounts, and account names ;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;;-;-;-;-;-;-;-;-

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-; Check for runelite directory  ;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;;-;-;-;-;-;-;-;-

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-; Variable Initialization ;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;;-;-;-;-;-;-;-;-
MouseFollowMag:=0
keyentercaps:=0
CounterVar:=0
counterkey:=0
count_type:=0
TimerIsRunning:=0
cdvar:=0
capsTitle=
colorswap:=0
GlobalSecondDisplay:=0
lastmanual:=0
TimerIsPaused:=0
stopToggle:=0
TimerResetWarning=0
guidUnderCursorDumbDumbDumb:=
TimerArrayMGetX:=0
capsp_press:=0
capsm_press:=0
ChangeBtnNames:=0
CounterFuncArray:=Object()
AccountTimerCDownSec:=Array()
GuiActiveArray:=Array()

OnTopArray:=Array()
wheelMouseClipval = a
MarkerArrayY:=()
MarkerArrayX:=Array()
xz := Array()
yz := Array()
RLUID:=
Zy := Array()
Zx := Array()
ResX := Array()
ResY := Array()
x2 := Array()
y2 := Array()
hdd_frame := Array()
hdc_frame := Array()
Note:=Array()
ChaosArray:=Array()
IsRunelite:=0
ChaosWindowGUIDArray:=Array()
ChaosX:=Array()
ChaosY:=Array()
WinName2:=Array()
WinNameNW2:=Array()
WinNameNH2:=Array()
WinNameNoXW2:=Array()
WinNameNoXY2:=Array()
stopToggle2:=1
DotCounter:=0
chaosDirection2:=Array()y
chaosDirection:=Array()
xmcoordArray:=Array()
ordercoordArray:=Array()
ymcoordArray:=Array()
MagGUID:=0
MagCounter:=0
AccTimerTimeStr2:=
AccTimerCDownSec:=
AccTimerMinFloor:=
AccountGUIColor:=
MgetY5T:=0
MgetX5T:=0
3String=
OutlineCounter:=0
TockTockTickText:=
TickTockTickTock:=0
tickHUD=0
initTick:=0
SkipCounterT:=
SkipCounter:=
WinDisable:=Array()
NoteSkipArray:=Array()
TockTickText=
tickCounter:=0
4ThreeX:=
4ThreeY:=
T:=
Debug:=0
ThreeSinCosCounter:=0
5String:=
5ThreeX:=
5ThreeY:=
stopThreeGo:=0
GuiVarCounter:=0
PlayVariable:=0
    PlaySound:=0
    DebugPriority:=0
MarkerCounter4:=0
MarkerOutline:=
DebugCycle:=0
Global GuiOutlineID
Global MyText
WaitJustOneFuckingSecond:=2
asciichar := Chr(8226)
ActiveToggle:=0
FoundX:=
FoundY:=
;--------;--------;--------;--------
GuiNumber:=0
while (GuiNumber<5) {
GuiNumber++
OutlineBuilder(GuiNumber)
BuildGUI(GuiNumber)
Gui, %GuiNUmber%: Hide
}
;--------;--------;--------;--------
WinBackTimerCounter:=0
ClickCounterBoolean=True
WinNameNoXW:=Array()
WinNameNoXY:=Array()
WinNameNW:=Array()
WinNameNH:=Array()
CounterWinBack:=0
CounterWinBack2:=0
WinName:=Array()
    KeysSet:=2
    MarkersNotesMagnifiers:="Markers"
stringyString:=
clipBoardA:=Array()
SetTimer, UpdateOSD, 500
SetTimer, UpdateOSD, on
SetTimer, UpdateOSD2, 1000
SetTimer, UpdateOSD2, off
SetTimer, Three, 25
SetTimer, Three, off
SetTimer, 1fuckingsecondtimer, on
SetTimer, TimersCheck, 500
SetTimer, TimersCheck, on
;SetTimer, ActivateWinUM, 0
;SetTimer, ActivateWinUM, off
SetTimer, Repaint, off
SetTimer, ChaosTimer, off
output:=0
clipCounter:=1
MouseSetVar:=0
notExistVar:=False

;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-

ifExist, %CS%ClickCounter.log
{
    fileRead, ClickCounter, %CS%ClickCounter.log
} else { 
    ClickCount:=0
}


AccDisable := Object()
    for key in Acccount {
        AccDisabled[key]:=0    
    }
AccDisabledIndex := % AccDisabled.MaxIndex()-1
AccountIndex := % Account.MaxIndex()-1


ifExist %CS%GlobalTimerMInutes.log
{
 FileRead, GlobalTimerMInutes, %CS%GlobalTimerMInutes.log
 GlobalTotalSeconds:=GlobalTimerMInutes*60
 GlobalSecondsDisplayInit:=GlobalTotalSeconds-1
} else {
GlobalTotalSeconds:=
GlobalTimerMInutes:=
GlobalSecondsDisplayInit:=
}

IfExist %CS%tickDisplaySetting.log
{
    fileRead, tickDisplaySetting, %CS%tickDisplaySetting.log
} 
if (tickDisplaySetting<1 or tickDisplaySetting>6 or !tickDisplaySetting) {
tickDisplaySetting:=1
}


IfExist %CS%FFCH.log
{
    fileRead, FFCH, %CS%FFCH.log
} else {
MsgboxMove_String=Firefox or Chrome
ChangeBtnNames:=1
Btn1_Name=Firefox ; YES
Btn2_Name=Chrome ; ELSE
SetTimer, MsgboxMove, on
MsgBox, 4, %MsgboxMove_String%, Choose a button:
IfMsgBox, YES 
    FFCH=Mozilla
else 
    FFCH=Chrome
fileAppend, %FFCH%, %CS%FFCH.log
}

ifExist %CS%TimerIsPaused.log
    fileRead, TimerIsPaused, %CS%TimerIsPaused.log
ifExist %CS%GlobalTimerMInutes.log
    fileRead, GlobalTimerMInutes, %CS%GlobalTimerMInutes.log
ifExist %CS%GlobalTimerMinR.log
    fileRead, GlobalTimerMinR, %CS%GlobalTimerMinR.log
ifExist %CS%GlobalSecondDisplay.log
    fileRead, GlobalSecondDisplay, %CS%GlobalSecondDisplay.log

;    ifExist %CS%ActiveToggle.log
;    {
;    fileRead, ActiveToggle, %CS%ActiveToggle.log
;        if (ActiveToggle=1) {
;        ActiveToggle:=0
;        SetTimer, ActivateWinUM, off
;        } else {
;        ActiveToggle:=1
;        SetTimer, ActivateWinUM, on
;        }
;    }

    ifExist %CS%MouseMessages.log
    {
        FileRead, MouseMessages, %CS%MouseMessages.log
        if (MouseMessages=1) {
        }
    }
    
    while (WaitJustOneFuckingSecond > 0)
     sleep,1
	 
	 
	 clipLimit:=0
	 
	ifExist %CS%clipboard.txt 
	{
	clipBoardB := Array()
    fileRead, clipboardPreSpl, %CS%clipboard.txt
    clipBoardB := % strSplit(clipboardPreSpl, "|")
    for key, val in clipBoardB {
        valLen := StrLen(val)
		
        if (valLen > 1)
            clipBoardA.insert(val)
			clipLimit++
	}		
}	
return
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-




;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;;-;-;-;-;-;-;-;-;-;-;;-;-;-;-;--;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;--;-;-;-;-;-;-;-;-;-;-;-;-;--;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-

Capslock & del::send, {down}{del}{del}{del}{del}

Capslock & space::
if (KeysSet=2) {
KeysSet:=1
        3String=On screen display
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
} else {
KeysSet:=2
        3String=Window Management
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
}
return

~MButton & LButton::
keywait, MButton
keyWait, LButton
send, {MButton down}
send, {MButton up}
	3String = Mouse Set 1
	3Time:=40*2
	GuiConF(3,3,3String,-1)
	MouseSetVar:=1
return
RButton::Rbutton
MButton::MButton
LCTRL & CAPSLOCK::
keywait T
xmcoordArray := []
ordercoordArray := []
; ymcoordArray := []
        3String=cleared.
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
return
LCTRL & q::
keywait Q
counter := 0
mousegetpos, x, y
for each in xmcoordArray{
counter+=1
}



xmcoordArray[counter+1]:=x
ymcoordArray[counter+1]:=y
ordercoordArray[counter+1]:=1
        3String=%x%, %y%
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
return
LCTRL & E::
keywait E
counter := 0
mousegetpos, x, y
for each in xmcoordArray{
counter+=1
}



xmcoordArray[counter+1]:=x
ymcoordArray[counter+1]:=y
ordercoordArray[counter+1]:=0
        3String=%x%, %y%
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
return
LCTRL & R::
keywait R
counter := 0
mousegetpos, x, y
for each in xmcoordArray{
counter+=1
}



xmcoordArray[counter+1]:=x
ymcoordArray[counter+1]:=y
ordercoordArray[counter+1]:=2
        3String=%x%, %y%
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
return
LCTRL & w::
        3String=play
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
keywait w
send, {ctrl up}{w up}
sleep, 150
mousegetpos, xx2, yy2
blockinput, on
counter = 0
for each, key in xmcoordArray {
counter += 1
		xx := key
		yy := ymcoordArray[counter]
		oo := ordercoordArray[counter]
		;y := ymcoordArray[counter]
        3String=%xx%, %yy%
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
		if (ordercoordArray[counter] == 3) {
			mousemove, %xx%, %yy%
		}
		if (ordercoordArray[counter] == 0) {
			mousemove, %xx%, %yy%
			send, {RButton}
			sleep, 250
		} else { 
		click, %xx%, %yy%
		sleep, mdelaycount
		
		}

}
blockinput, off	
mousemove, xx2, yy2
return
ctrl & numpadadd::
mdelaycount+=50
        3String=%mdelaycount%
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
return
ctrl & numpadsub::
mdelaycount-=50
        3String=%mdelaycount%
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
return

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#If MouseSetVar=3
LButton::LButton
XButton2 & WheelUp::
wtx+=speed3Mult
goto updateWin
XButton2 & WheelDown::
wtx-=speed3Mult
goto updateWin
RButton & WheelUp::
wty-=speed3Mult
goto updateWin
RButton & WheelDown::
wty+=speed3Mult
goto updateWin
MButton & WheelUp::
wt_Height+=speed3Mult
goto updateWin
MButton & WheelDown::
wt_Height-=speed3Mult
goto updateWin
XButton1 & WheelUp::
wt_Width+=speed3Mult
goto updateWin
XButton1 & WheelDown::
wt_Width-=speed3Mult
updateWin:
if !(wt_Width)
	wt_Width:=20
if !(wt_Height)
	wt_Height:=20
if !(wtx)
	wtx:=10
if !(wty)
	wty:=10
winset, AlwaysOnTop, on, ahk_exe chrome.exe
winset, region, %wtx%-%wty% W%wt_Width% H%wt_Height%, ahk_exe chrome.exe
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
MButton & LButton::
send, {MButton up}
	3String = Mouse Set 4
	3Time:=40*2
	GuiConF(3,3,3String,-1)
	MouseSetVar:=4
return




;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

#If MouseSetVar=2
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

XButton1 & WheelDown::Volume_Down
XButton1 & WheelUp::Volume_Up
MButton & WheelUp::
blockinput, on
send, {MButton up}
Send, {Media_Next}
send, {MButton up}
3String = Media - Next
3Time:=40*2
GuiConF(3,3,3String,-1)
sleep 100
blockinput, off
return
MButton & WheelDown::
blockinput, on
send, {MButton up}
Send, {Media_Prev}
send, {MButton up}
3String = Media - Prev
3Time:=40*2
GuiConF(3,3,3String,-1)
sleep 100
blockinput, off
return
MButton & RButton::
send, {MButton up}
Send, {Media_Play_Pause}
send, {MButton up}
3String = Media - Play/Pause
3Time:=40*2
GuiConF(3,3,3String,-1)
return
MButton & LButton::
send, {MButton up}
	3String = Mouse Set 3
	3Time:=40*2
	GuiConF(3,3,3String,-1)
	MouseSetVar:=3
	speed3Mult:=10
return



;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#If MouseSetVar=100
wheelDown::
wheelMouseClipval = a
wheelUp::
gosub, wheelMouseClip
return
wheelMouseClip:
blockinput, on
fileAppend, %wheelMouseClipval%, %CS%InputWait.txt
MouseSetVar := 1
return
#If MouseSetVar=1 
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;


MButton & LButton::
send, {MButton up}
	3String = Mouse Set 0
	3Time:=40*2
	GuiConF(3,3,3String,-1)
	MouseSetVar:=0
return




RButton & MButton::
wheelMouseClipval = s
send, {MButton up}

        3String=MWheelUp: Remove&Save  --- WheelDown: Copy&Save
        3Time:=40*200 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
sleep, 100 
ifExist, %CS%InputWait.txt
	fileDelete, %CS%InputWait.txt
notExistVar:=False
MouseSetVar:=100
while (MouseSetVar==100) {
	ifExist, %CS%InputWait.txt
		break
	sleep, 1
}
sleep 150
blockinput, off
fileRead, InputVar, %CS%InputWait.txt
if (InputVar=="a")  {

send, {ctrl down}
sleep 100
send, c
sleep 100
send, {ctrl up}

clipBoardA.insert(clipboard)
strStrstrstrstsrsrstsrtsr = added %clipboard%

        3String=`[%clipCounter%`] `- %strStrstrstrstsrsrstsrtsr% to clipboard array`.
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
        sleep 20
        clipLimit:=0
		clipCounter++
for key, val in clipBoardA
    clipLimit++
		if clipCounter < 1 
			clipCounter:=clipLimit
		if clipCounter > clipLimit
			clipCounter:=1
ifExist, %CS%clipboard.txt
    fileDelete, %CS%clipboard.txt
for key, val in clipBoardA
    fileAppend, %val%|, %CS%clipboard.txt

return        
} else if (InputVar=="s") {
sleep 100
strStrtsrtsr := % clipBoardA[clipCounter]
clipBoardA.remove(clipCounter)
		if clipCounter=0
		{
			3String=There is nothing on the clipboard array.
					3Time:=40*2 ;; 40 = 1 second
			GuiConF(3,3,3String,-1)
			return
		} 
		else
		{		
		3String=`[%clipCounter%`] `- %strStrtsrtsr% removed from clipboard array`.
        }
		3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
        clipLimit:=0
clipCounter--
			
for key, val in clipBoardA
    clipLimit++
		if clipCounter < 1 
			clipCounter:=clipLimit
		if clipCounter > clipLimit
			clipCounter:=1
ifExist, %CS%clipboard.txt
    fileDelete, %CS%clipboard.txt
for key, val in clipBoardA
    fileAppend, %val%|, %CS%clipboard.txt

return
}
return

MButton & WheelDown::
clipCounter--
if (clipCounter < 1)
    clipCounter:=clipLimit
goto clipboardACont
MButton & WheelUp::
clipCounter++
if (clipCounter > clipLimit)
    clipCounter:=1 ;chk starts with 1 not 0 which is odd anyway

clipboardACont:
if clipLimit=0
{
3String=Nothing on clipboard array.
        3Time:=40*1 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
		
return		
}

clipboard := % clipBoardA[clipCounter] 
        strestwaers := % clipBoardA[clipCounter] 
        3String=`[%clipCounter%`] - %strestwaers%
        3Time:=40*1 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
		
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#if MouseSetVar = 4
MButton & LButton::
send, {MButton up}
	3String = Mouse Set DISABLED
	3Time:=40*2
	GuiConF(3,3,3String,-1)
	MouseSetVar:=0
return
XButton2::
setTimer, chungus, off
return
XButton1::
setTimer, chungus, on
setTimer, chungus, 200
keywait, XButton1
return

chungus:
	send, {left down}
	sleep 100
	send, {left up}{right down}
	sleep 100
	send, {right up}
return




;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#If KeysSet=1
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;



Capslock & F::
if (!MarkersNotesMagnifiers or MarkersNotesMagnifiers="Notes") {
MarkersNotesMagnifiers=Markers
3String=Current Caps + LB/RB/MB/C/X selections set to MARKERS.
3Time:=40*2 ;; 40 = 1 second
GuiConF(3,3,3String,-1)
} else if (MarkersNotesMagnifiers="Markers") {
MarkersNotesMagnifiers=Magnifiers
3String=Current Caps + LB/RB/MB/C/X selections set to MAGNIFIERS.
3Time:=40*2 ;; 40 = 1 second
GuiConF(3,3,3String,-1)
} else {
MarkersNotesMagnifiers=Notes
3String=Current Caps + LB/RB/MB/C/X selections set to NOTES.
3Time:=40*2 ;; 40 = 1 second
GuiConF(3,3,3String,-1)
}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#if MarkersNotesMagnifiers="Notes" and KeysSet=1
Capslock & RButton::
if (SelNote<300 or SelNote>=NoteCounter)
    SelNote:=NumAccs+300
if(SubStr(3String, 1, 12)="Current note")
    SelNote++
if (SelNote=NumAccs+300)
    SelNote:=NumAccs+300+1
NoteCounterT:=NoteCounter-NoteSafety
SelMNote:=SelNote-(NumAccs)-300
3String=Current note - %SelMNote%/%NoteCounterT%. 1 to move/show selected note. 2 to hide the note.
3Time:=40*2 ;; 40 = 1 second
GuiConF(3,3,3String,-1)
Input, Outputvar, L1 T3
if(Outputvar="1") {
MouseGetPos, NoteX, NoteY
NoteSel=Note_%SelNote%
GuiConF("Note_" SelNote,1,NoteX,NoteY) 
} else if (Outputvar="2") {
SkipCounter++
GuiConF("Note_" SelNote,2,-1,-1)
NoteSkipArray[SkipCounter]:=SelNote
GuiActiveArray[SelNote]:=5
} else {
    3String=Canceled.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
}
return

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#if MarkersNotesMagnifiers="Notes" and KeysSet=1
Capslock & LButton::
if (!TempGUI or TempGUI!="TempGUI") {
NoteString:=
!NoteString
MouseGetPos, NoteX, NoteY
NoteSafety:=NumAccs+300
if (NoteCounter<NoteSafety or !NoteCounter)
    NoteCounter=%NoteSafety%
NoteCounter++
TempGUI:="TempGUI"
OutlineBuilder(TempGUI)
BuildGUI(TempGUI)
GuiConF(TempGUI, 3, "______", -1)    
GuiRandColor(TempGUI)
GuiConF(TempGUI, 1,NoteX-40,NoteY-40)
InputBox, NoteString, Note, Enter a note`, hide or move it with Capslock + RButton., , 275, 175, NoteX+50, NoteY+50
if (!NoteString or NoteString="") {
    3String=Note Canceled.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
}

if !(3String="Note Caceled.") {
    NoteCounter2=Note_%NoteCounter%
OutlineBuilder(NoteCounter2)
BuildGUI(NoteCounter2)
GuiConF(NoteCounter2,3,NoteString,-1)
GuiRandColor(NoteCounter2)
GuiConF(NoteCounter2,1,NoteX,NoteY) 
}
sleep 500
GuiConF(TempGUI, 2, -1, -1)
TempGUI:=
} else {
    3String=Please finish what you are doing.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#if MarkersNotesMagnifiers="Notes" and KeysSet=1
Capslock & c::
Counter:=0
TempArray:=Array()
guiactivekey:=
guiactivevalue:=
for guiactivekey, guiactivevalue in GuiActiveArray {
if (guiactivevalue=3 or guiactivevalue=4) {
    GuiConF(guiactivekey, 2, -1, -1)
    GuiActiveArray[guiactivekey]:=0
    Counter++
    }
}
for guiactivekey, guiactivevalue in GuiActiveArray {
    if (guiactivevalue!=3 and guiactivevalue!=4 and guiactivevalue!=0) {
        TempArray[guiactivekey]:=guiactivevalue
    }
}
GuiActiveArray:=TempArray
TempArray:=
Counter:=floor(Counter)
    3String=%Counter% Notes Destroyed.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    Counter:=
    NoteCounter:=
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#if MarkersNotesMagnifiers="Markers" and KeysSet=1
Capslock & LButton::
MouseGetPos, MarkX, MarkY
MarkerSafety:=NumAccs+300
if (MarkerCounter<MarkerSafety or !MarkerCounter)
    MarkerCounter=%MarkerSafety%
MarkerCounter++
MarkerCounter2=_%MarkerCounter%
MarkerCounter4=%asciichar%%MarkerCounter%
MarkerCounter3:=MarkerCounter-MarkerSafety
OutlineBuilder(MarkerCounter4)
BuildGUI(MarkerCounter2)
OutlineBuilder(MarkerCounter2)
GuiConF(MarkerCounter2, 3, asciichar, -1)    
GuiConF(MarkerCounter4, 1,MarkX-80,MarkY-86)
GuiRandColor(MarkerCounter2)
GuiConF(MarkerCounter2,1,MarkX-80,MarkY-85)
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#if MarkersNotesMagnifiers="Markers" and KeysSet=1
Capslock & c::
Counter:=0
TempArray:=Array()
for guiactivekey, guiactivevalue in GuiActiveArray {
if (guiactivevalue=2) {
    GuiConF(guiactivekey, 2, -1, -1)
    GuiActiveArray[guiactivekey]:=0
    Counter++
    }
}
for guiactivekey, guiactivevalue in GuiActiveArray {
if (guiactivevalue!=2 and guiactivevalue!=0 and guiactivevalue!=4) {
        TempArray[guiactivekey]:=guiactivevalue
    } 
}
GuiActiveArray:=TempArray
TempArray:=
Counter:=floor(Counter/2)
    3String=%Counter% Markers Destroyed.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    Counter:=
    MarkerCounter:=
    MarkerCounter3:=
    MarkerCounter4:=
    MarkerSafety:=
    DotCounter:=0
return
#if MarkersNotesMagnifiers="Markers" and KeysSet=1
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & RButton::
DotCounter:=0
    3String=Counter Set to 1
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#if MarkersNotesMagnifiers="Magnifiers" and KeysSet=1
Capslock & LButton::
if(!counterPMM or counterPMM<0 or counterPMM>=2)
counterPMM=0
    counterPMM++
if(!counterMM or counterMM<=0)
    counterMM:=0
MouseGetPos x, y
if (counterPMM=1) {
    Rx1 := x
    Ry1 := y
    OutlineBuilder("X1")
    GuiConF("X1", 1,x-84,y-86)
        3String=Top Left corner set.
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
} else if (counterPMM=2) {
    Rx2 := x
    Ry2 := y
        3String=Bottom Right corner set.
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
    GuiConF("X1Outline1", 2, -1, -1)
    counterMM++
    zoom := 3              
    ResX[counterMM] := Rx2-Rx1
    Rx := ResX[counterMM]
    ResY[counterMM] := Ry2-Ry1
    Ry := ResY[counterMM]
    Gui Magnifier%counterMM%: Default
    Gui Magnifier%counterMM%: new, +AlwaysOnTop -0xC00000
    Gui Show, % "w" ((2*Rx)-10) " h" ((2*Ry)-30) " x" x " y" y "", Magnifier%counterMM%
    WinGet MagnifierID, id,  Magnifier%counterMM%
    WinGet PrintSourceID, ID
    hdd_frame[counterMM] := DllCall("GetDC", UInt, PrintSourceID)
    hdc_frame[counterMM] := DllCall("GetDC", UInt, MagnifierID)
    ;WinSet, Style, ^0xC00000
    Zx[counterMM] := ResX[counterMM]/zoom           ; frame x/y size
    Zy[counterMM] := ResY[counterMM]/zoom
    x2[counterMM] := Rx2-Zx[counterMM]-(rx/zoom)
    y2[counterMM] := Ry2-Zy[counterMM]
    SetTimer Repaint, 50
    setTimer, Repaint, on
}
return

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#if MarkersNotesMagnifiers="Magnifiers" and KeysSet=1
Capslock & c::
counterM:=0
counterM2:=0
counterMM:=0
for key, value in hdd_frame{
DllCall("gdi32.dll\DeleteDC"    , UInt,value )
hdd_frame[key]:="removeme"
}
for key, value in hdc_frame{
DllCall("gdi32.dll\DeleteDC"    , UInt,value )
winclose Magnifier%key%
keyCount++
hdc_frame[key]:="removeme"
}
    3String=Removed %keyCount% Magnifiers.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
while (keyCount>0) {
if (hdd_frame[keyCount]="removeme") {
    hdd_frame.RemoveAt(keyCount)
}
if (hdc_frame[keyCount]="removeme") {
    hdc_frame.RemoveAt(keyCount)
}
keyCount--
}
    MouseFollowMagID:=0
    MouseFollowMag:=0
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#if MarkersNotesMagnifiers="Magnifiers" and KeysSet=1
Capslock & RButton::
if(!counterM or counterM<0 or counterM>=counterMM)
    counterM:=0
destroyed_tryagain:
if(SubStr(3String, 1, 9)="Magnifier")
    counterM++
if (counterM=0)
    counterM:=1
    3String=Magnifier%counterM%, 1 location, 2 window, 3 mouse/tick counter, 4 destroy
    3Time:=40*10 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    if (hdd_frame[counterM]="destroyed")
        goto destroyed_tryagain
Input, Outputvar, L1 T10
if(Outputvar="1") {
MouseGetPos x2x, y2y
zoom := 3
Zx[counterM] := ResX[counterM]/zoom  ; zoom           ; frame x/y size
Zy[counterM] := ResY[counterM]/zoom
x2[counterM] := x2x-Zx[counterM]+(ResX[counterM]/zoom)/2
y2[counterM] := y2y-Zy[counterM]+(ResY[counterM]/zoom)
    3String=Magnified Location of Magnifier%counterM% set
    3Time:=40*3 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    return
} else if (Outputvar="2") {
MouseGetPos x2x, y2y
WinActivate, Magnifier%counterM%
WinMove A, , % x2x, % y2y
winset, AlwaysOntop, On, A
    3String=Magnifier%counterM% window position set.
    3Time:=40*3 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    return
} else if (Outputvar="4") {
DllCall("gdi32.dll\DeleteDC"    , UInt,hdd_frame[counterM] )
DllCall("gdi32.dll\DeleteDC"    , UInt,hdc_frame[counterM] )
    3String=Magnifier%counterM% destroyed.
    3Time:=40*3 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    winclose Magnifier%counterM%
    hdd_frame[counterM]:="destroyed"
    if (MouseFollowMagID=counterM) { 
        MouseFollowMagID:=0
        MouseFollowMag:=0
    }
        return
} else if (Outputvar="3") {
        MouseFollowMag++
        if (MouseFollowMag=1) {
            3String=Magnifier%counterM% is following mouse.
        } else if (MouseFollowMag=2 and tickHUD=1) {
            3String=Magnifier%counterM% is following tick counter.
        } else {
            3String=Disabled following of cursor/tickcounter
            MouseFollowMag:=0
        }
        3Time:=40*10 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
        MouseFollowMagID:=CounterM
        return
} else {
    3String=Canceled.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#If KeysSet=1
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & x::
TickTockTickTock:=0
tickLimit=NaN
initTick:=-1
if (tickHUD=1) {
        3String=Tick Counter Active. 1. to disable`, 2. to change tick count`, 3. to change style
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
    Input, Outputvar, L1 T5
    if(Outputvar="1") {
    tickHUD:=0
        3String=Tick Counter turned off
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
    } else if(Outputvar="2") {
    MouseGetPos, MgetX, MgetY
                    MgetX4:=MgetX+10
                    MgetY4:=MgetY+10                
    InputBox, tickLimit, Tick Count Limit, Enter the number of ticks to count up to`, this repeats until canceled. If you enter 0 or 1`, it will just count forever., , 275, 175, MgetX4, MgetY4
    ifExist, %CS%tickLimit.log
        fileDelete, %CS%tickLimit.log
    fileAppend, %tickLimit%, %CS%tickLimit.log
    } 
} else {
    tickHUD:=1
boredCounter:=1
setTimer, tickHUD, 600
setTimer, tickHUD, on
    3String=Creating tick counter.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    temp:=
    boredCounter:=Rand(1,2)
    if (boredCounter=2)
        boredCounter=-1
    boredCounter2:=Rand(1,2)
    if (boredCounter2=2)
        boredCounter2=-1
    boredDirection:=Rand(1,2)
    if (boredDirection=2)
        boredDirection=-1
    boredDirection2:=Rand(1,2)
    if (boredDirection2=2)
        boredDirection2=-1
    angle := Rand(0,360)

    if (tickDisplaySetting=5 or tickDisplaySetting=2) {
    tickMonArray:=monitorFunc()
    TickCurDisplayWidth:=tickMonArray[6]
    TickCurDisplayHeight:=tickMonArray[5]
    TickCurDisplayY:=tickMonArray[1]
    TickCurDisplayX:=tickMonArray[2]
    }
    tickTryAgain:
    ifNotExist, %CS%tickLimit.log
    {
    MouseGetPos, MgetX, MgetY
                    MgetX4:=MgetX+10
                    MgetY4:=MgetY+10                
    InputBox, tickLimit, Tick Count Limit, RESET THIS NUMBER WITH CAPSLOCK + N. -- Enter the number of ticks to count up to`, this repeats until canceled. If you enter 0 or 1`, it will just count forever.. LEFT ALT + B changes the display mode, , 380, 175, MgetX4-190, MgetY4-100
    if (tickLimit and (tickLimit<=0 or tickLimit>=0)){
        fileAppend, %tickLimit%, %CS%tickLimit.log
    } else {
        3String=Please enter something into the input box. Anything... Literally anything.
        3Time:=40*5 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
        goto tickTryAgain
    }    
    } else {
        fileRead, tickLimit, %CS%tickLimit.log
    }

}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & Z::
    3String=Z again to stick/unstick these messages, 1 to hide/show these messages
    3Time:=40*5 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    Input, Outputvar, L1 T5
 if (Outputvar="1") {
        if (MouseMessages=0) {
            MouseMessages:=1
                3String=These messsages are now being shown
                3Time:=40*2 ;; 40 = 1 second
                GuiConF(3,3,3String,-1)
            FileDelete, %CS%MouseMessages.log
            FileAppend, %MouseMessages%, %CS%MouseMessages.log
        } else {
        3String=These messsages are now being hidden
                3Time:=40*1 ;; 40 = 1 second
                GuiConF(3,3,3String,-1)
                sleep 2000
            MouseMessages=0
            FileDelete, %CS%MouseMessages.log
            FileAppend, %MouseMessages%, %CS%MouseMessages.log
        }    
    } else if (Outputvar="Z") {
if(!stopThreeGo or stopThreeGo=0) {
    3String=Cursor objects stuck to location.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
stopThreeGo:=1
} else {
    3String=Cursor objects stuck to cursor.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
stopThreeGo:=0
}
}    else {
        3String=Canceled.
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
    }
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
    Capslock & w::
    Keywait, w
    if (WaitJustOneFuckingSecond>=0) {
        3String=Please Wait
        3Time:=40*1 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
        return
    } else {
        WaitJustOneFuckingSecond=2
        SetTimer, 1fuckingsecondtimer, on
        if (TimerIsPaused=0) {
            fileDelete, %CS%GlobalTimerMinR.log
            fileDelete, %CS%GlobalSecondDisplay.log
            fileDelete, %CS%TimerIsPaused.log
            TimerIsPaused:=1
            TimerIsRunning:=0
            fileAppend, %TimerIsPaused%, %CS%TimerIsPaused.log
            fileAppend, %GlobalTimerMinR%, %CS%GlobalTimerMinR.log
            fileAppend, %GlobalSecondDisplay%, %CS%GlobalSecondDisplay.log
            3String=Timer Paused and Saved
            3Time:=40*1 ;; 40 = 1 second
            GuiConF(3,3,3String,-1)
            return
        } else if (TimerIsPaused=1) {
            ifExist %CS%GlobalTimerMInutes.log
            {
                fileRead, GlobalTimerMInutes, %CS%GlobalTimerMInutes.log
            } else {
             goto Timer_Load_Error
            }
            ifExist %CS%GlobalTimerMinR.log
            {
                fileRead, GlobalTimerMinR, %CS%GlobalTimerMinR.log
            } else {
             goto Timer_Load_Error
            }    
            ifExist %CS%GlobalSecondDisplay.log
            {
                fileRead, GlobalSecondDisplay, %CS%GlobalSecondDisplay.log
            } else {
             goto Timer_Load_Error
            }    
            fileDelete, %CS%TimerIsPaused.log
            fileDelete, %CS%GlobalTimerMinR.log
            fileDelete, %CS%GlobalSecondDisplay.log
            TimerIsRunning:=1
            TimerIsPaused:=0
            SetTimer, UpdateOSD2, on

            3String=Timer Resumed
            3Time:=40*1 ;; 40 = 1 second
            GuiConF(3,3,3String,-1)
            return
    }
}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
caps_f:
Outputvar:=2
capslock & e::
if (WaitJustOneFuckingSecond>=0) {
    3String=Please Wait
    3Time:=40*1 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    return
} else {

    WaitJustOneFuckingSecond=1
    SetTimer, 1fuckingsecondtimer, on    
    if(TimerIsPaused=0 and TimerIsRunning=0) {
        goto SetTimer_Minutes
    } else {
        3String=Please clear current timer first.
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
    }
}

return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & q::
Keywait, q
timer_t:
if (WaitJustOneFuckingSecond>0 and TimerIsRunning=0) {
    3String=Please Wait
    3Time:=40*1 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    return
} else {
    WaitJustOneFuckingSecond:=2
    SetTimer, 1fuckingsecondtimer, on
    ifExist %CS%GlobalTimerMInutes.log
    {
        FileRead, GlobalTimerMInutes, %CS%GlobalTimerMInutes.log
    } else {
        goto SetTimer_Minutes
    }
    if (!GlobalTimerMInutes)
        goto SetTimer_Minutes
if (TimerIsRunning=0 and TimerIsPaused=0) {
    GlobalTotalSeconds:=GlobalTimerMInutes*60
    GlobalSecondsDisplayInit:=GlobalTotalSeconds-1
    GlobalSecondDisplay:=60
    TimerIsRunning:=1
    TimerIsPaused:=0
    TimerResetWarning:=0
    GoSub, UpdateOSD2
    SetTimer, UpdateOSD2, on

    if (NoAHKVars=0) {
        ifExist, E:\rsahkvars\TimerCleared.log
        {
            fileDelete, E:\rsahkvars\TimerCleared.log
        }
        fileAppend, 3, E:\rsahkvars\TimerCleared.log
    }
    PlaySound=0
    3String=A New timer has started
    3Time:=40*1 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    return    
    } else if(TimerTimeStr="TIME"){
            goto timerclear
    } else if(TimerIsPaused=1 and TimerResetWarning=0) {
        3String=Timer Paused - Caps+W to Resume - Caps+Q again to Reset
        3Time:=40*6
        GuiConF(3,3,3String,-1)
        TimerResetWarning++
        return     
    } else if ((TimerIsRunning=1 or TimerIsPaused=1) and TimerResetWarning=0) {
        3String=Timer currently running - Press Caps+Q again to reset.
        3Time:=40*1
        GuiConF(3,3,3String,-1)
        TimerResetWarning++
        return
    } else if (TimerResetWarning=1 and (TimerIsRunning=1 or TimerIsPaused>=1)) {
        goto timerclear
    }     
}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & 3::
    3String=3 to count up, 2 to clear.
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
        Input, Outputvar, L1 V T1
        if(Outputvar="3") {
thecounterupdo:
CounterVar=0
last_type:=%count_type%
WinGetActiveTitle, Title
if (!CounterFuncArray[count_type]) {
    CounterFuncArray[count_type]:=0
}

    CounterFuncArray[count_type]++
    counterkey=% CounterFuncArray[count_type]

} else if(Outputvar="2") {
        3String=Counter Cleared
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
        thecounterresetdo:
        CounterVar=0
        holdvar:=1
        if (CounterFuncArray[count_type]) {
            CounterFuncArray[count_type]:=0
        }
        counterkey=% CounterFuncArray[count_type]
    }
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#If KeysSet=2
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;Capslock & u::  ;;;;;;    <--- This is to toggle on/off the automatic window focus of runelite under the cursor
;Keywait, u
;    FileDelete, %CS%ActiveToggle.log
;    FileAppend, %ActiveToggle%, %CS%ActiveToggle.log
;            3String=No longer activating runelites under cursor
;        3Time:=40*2 ;; 40 = 1 second
;        GuiConF(3,3,3String,-1)
;if (ActiveToggle=1) {
;ActiveToggle:=0
;SetTimer, ActivateWinUM, off
;} else {
;            3String=Activating runelites under cursor
;        3Time:=40*2 ;; 40 = 1 second
;        GuiConF(3,3,3String,-1)
;ActiveToggle:=1
;SetTimer, ActivateWinUM, on
;}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------;-------------------;-------------------;
;        The keybind below make it so a window, any window    ;
;        cannot be interacted with, if keybind is pressed    ;
;        The window under the cursor window becomes disabled    ;
;        press it again, and it re-enables it.                ;
;-------------------;-------------------;-------------------;
Capslock & 3::
    MouseGetPos,,,guidUnderCursor
    WinGetTitle, TitleUnderCursor, ahk_id %guidUnderCursor%
for WinDisableKey, WinDisableVal in WinDisable {
    if (WinDisableVal=TitleUnderCursor) {
        Winset, enable, , %TitleUnderCursor%
        WinActivate, %TitleUnderCursor%
        3String=%TitleUnderCursor% ENABLED interaction.
        3Time:=40*4 ; 40 is one second
        GuiConF(3,3,3String,-1)
        WinDisable[WinDisableKey]:="REMOVEME"
        return
    }    
}
if (!WinDisableCounter or WinDisableCounter<0)
    WinDisableCounter:=0
WinDisableCounter++
WinDisable[WinDisableCounter]:=TitleUnderCursor
Winset, disable, , %TitleUnderCursor%
WinActivate, ahk_class Shell_TrayWnd
3String=%TitleUnderCursor% DISABLED interaction.
3Time:=40*4 ; 40 is one second
GuiConF(3,3,3String,-1)
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
RButton & WheelDown:: ;;window ontop or not
keywait, RButton
WinGetTitle, A_Title, A
    if (OnTopArray[A_Title]=1) {
    WinSet, AlwaysOnTop, Off, A

    3String=Always Ontop - OFF - for %A_Title%
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
        OnTopArray[A_Title]:=0
    } else { 
        WinSet, AlwaysOnTop, on, A
    OnTopArray[A_Title]:=1
    3String=Always Ontop - ON - for %A_Title%
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
for GuiKeyCheck, GuiValueCheck in GuiActiveArray {
    if instr(GuiKeyCheck,"Outline") { 
        Gui, %GuiKeyCheck%: +AlwaysOntop
    }
}
for GuiKeyCheck, GuiValueCheck in GuiActiveArray {    
    if !instr(GuiKeyCheck,"Outline") { 
        Gui, %GuiKeyCheck%: +AlwaysOntop
    }
}
}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
CapsLock & d::
Keywait, d
WinGetClass, Class, A
If !InStr(Class, FFCH) {
WinGetActiveTitle, TitleP
WinActivate, %FFCH%
} else { 
WinSet, Bottom,, %FFCH%
WinActivate, %TitleP%
}
Return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & W::
WinGetActiveTitle, aTitle5
WinGet, curtrans, Transparent, A
if (!curtrans)
    curtrans = 255
newtrans := curtrans - 8
if (newtrans>0) {
    WinSet, Transparent, %newtrans%, A
    3String=Window %aTitle5% Opacity Decreased %newtrans%.
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
} else {
    3String=Window %aTitle5% Opacity Reset.
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
    WinSet, Transparent, 255, A
    WinSet, Transparent, OFF, A
}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & E::
WinGetActiveTitle, aTitle5
WinGet, curtrans, Transparent, A
if (!curtrans)
    curtrans = 255
newtrans := curtrans + 16
if (newtrans>0) {
    WinSet, Transparent, %newtrans%, A
    3String=Window %aTitle5% Opacity Increased %newtrans%.
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
} else {
    3String=Window %aTitle5% Opacity Reset.
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
    WinSet, Transparent, 255, A
    WinSet, Transparent, OFF, A
}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & C::
MouseGetPos,,, WinUMID2
WinSet, Style, ^0xC00000, ahk_id %WinUMID2%
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
#If KeysSet=1 or KeysSet=2 or !KeySet
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;



capslock & 5::
CounterWinBack2:=0
CounterWinBack:=0
CounterWinBack3:=0
CounterWinBack4:=0
chaosBounce:=0
KeyCount:=0
setTimer, ChaosTimer, off
    for key, val in ChaosWindowGUIDArray { 
        KeyCount++
    }
    while (KeyCount>1) {
        ChaosWindowGUIDArray.removeat(KeyCount)
        KeyCount--
    }
return

Capslock & 4::
caps_5:
chaosBounce:=1
    MouseGetPos,,,ChaosWindowGUID
for key, val in ChaosWindowGUIDArray { 
    if (ChaosWindowGUID=val) {
        return
    }
}
;SetTimer, ActivateWinUM, off
sleep 50
CounterWinBack2++
CounterWinBack3++
ChaosWindowGUIDArray[CounterWinBack2]:=ChaosWindowGUID
winActivate, ahk_ID %ChaosWindowGUID%
        WinGetActiveStats, TitleNO, NOWidth, NOHeight, NoXW, NoXY
        WinName[CounterWinBack2]:=TitleNO
        WinNameNW[CounterWinBack2]:=NOWidth
        WinNameNH[CounterWinBack2]:=NOHeight
        WinNameNoXW[CounterWinBack2]:=NoXW
        WinNameNoXY[CounterWinBack2]:=NoXY
        MonArray:=monitorFunc()
;	for each, val in MonArray {
;		3String = %val% 
;    3Time:=40*3 ; 40 is one second
;    GuiConF(3,3,3String,-1)
;	sleep 3000
;	}

;MonArray := [TDISPLAYY,TDISPLAYX,TDISPLAYY2,TDISPLAYX2,TDISPLAYHeight,TDISPLAYWidth]

for key, val in MonArray {
    ChaosArray[CounterWinBack3]:=val
    CounterWinBack3++
}    
CounterWinBack3--    

                        ;6            7        1
                        ;12            13        
    AHKCHAOSID:=ChaosWindowGUIDArray[CounterWinBack2]
    ChaosX[CounterWinBack2]:=((ChaosArray[CounterWinBack3-4] + ChaosArray[CounterWinBack3]/2)-WinNameNW[CounterWinBack2]/2)
    ChaosY[CounterWinBack2]:=((ChaosArray[CounterWinBack3-5] + ChaosArray[CounterWinBack3-1]/2)-WinNameNH[CounterWinBack2]/2)

    WinMove, ahk_ID %AHKCHAOSID% , , % ChaosX[CounterWinBack2], % ChaosY[CounterWinBack2]
    RandyRand:=0
RandyRand:=Rand(1,4)
cRand1:=Rand(3.5,4.5)
if(RandyRand=1) {
chaosDirection[CounterWinBack2]:=-cRand1
chaosDirection2[CounterWinBack2]:=-cRand1
} else if(RandyRand=2) {
chaosDirection[CounterWinBack2]:=-cRand1
chaosDirection2[CounterWinBack2]:=cRand1
} else if(RandyRand=3) {
chaosDirection[CounterWinBack2]:=cRand1
chaosDirection2[CounterWinBack2]:=-cRand1
} else if(RandyRand=4) {
chaosDirection[CounterWinBack2]:=cRand1
chaosDirection2[CounterWinBack2]:=cRand1
}
chaosRandySkip:=1
sleep 100
setTimer, ChaosTimer, 50
setTimer, ChaosTimer, on
return                                                            

ChaosTimer:
for keyChaos, valChaos in ChaosWindowGUIDArray {
if (keyChaos>CounterWinBack2)
    return
if (stopToggle!=valChaos) {
if (chaosRandySkip!=1){
cRand:=Rand(3.5,4.5)
            if (ChaosX[keyChaos]>=(ChaosArray[keyChaos*6-2])-WinNameNW[keyChaos]) { 
                chaosDirection[keyChaos]:=-cRand
            } else if (ChaosX[keyChaos]<=(ChaosArray[keyChaos*6-4])) { 
                chaosDirection[keyChaos]:=cRand
            }
            if (ChaosY[keyChaos]>=(ChaosArray[keyChaos*6-1]/2)-(WinNameNH[keyChaos]/2)+85) { 
                chaosDirection2[keyChaos]:=-cRand
            } else if (ChaosY[keyChaos]<=-(ChaosArray[keyChaos*6-1]/2)+(WinNameNH[keyChaos]/2)+85) {
                chaosDirection2[keyChaos]:=cRand
            }
} else {
    chaosRandySkip:=0
}
ChaosX[keyChaos]:= chaosDirection[keyChaos] + ChaosX[keyChaos]
ChaosY[keyChaos]:= chaosDirection2[keyChaos] + ChaosY[keyChaos]
WinMove, ahk_ID %valChaos% , , % ChaosX[keyChaos] , % ChaosY[keyChaos]
}
}    
return


Capslock & A::
CapsA:
;SetTimer, ActivateWinUM, off
    sleep 50
    donesubcapsa:=1
    CounterWinBack++
    while (donesubcapsa=1)
        sleep 1
WinGet, ChaosWindowGUID , ID
stopToggle:=ChaosWindowGUID
        WinGetActiveStats, TitleNO2, NOWidth2, NOHeight2, NoXW2, NoXY2    


        WinName2[CounterWinBack]:=TitleNO2
        WinNameNW2[CounterWinBack]:=NOWidth2
        WinNameNH2[CounterWinBack]:=NOHeight2
        WinNameNoXW2[CounterWinBack]:=NoXW2
        WinNameNoXY2[CounterWinBack]:=NoXY2
        MonArray2:=monitorFunc()
        BlockInput, on
        mousemove, 0, 0
        WinMove A, , % (MonArray2[2] + MonArray2[6]/2)-NOWidth2/2, % (MonArray2[1] + MonArray2[5]/2)-NOHeight2/2
sleep 1    
coordmode, mouse, window
xRand:=Rand(0,NOWidth2)
yRand:=Rand(0,NOHeight2)
bRand:=Rand(1,4)
if(bRand=1) {
mousemove, 0-50, yRand
} else if(bRand=2) {
mousemove, NOWidth2+50, yRand
} else if(bRand=3) {
mousemove, xRand, NOHeight2+50
} else if(bRand=4) {
mousemove, xRand, 0-50
}
coordmode, mouse, screen
BlockInput, off
return        ;;;;


;;;;; APACHE PHP BROWSER BOT PARSE PAGES VIA PHP 
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;

;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;


WinBack:
WinBackTimerCounter++
if (WinBackTimerCounter=5) {
    for key, val in WinName {
        WinMove %val%, , % WinNameNoXW[key], % WinNameNoXY[key], % WinNameNW[key], % WinNameNH[key]
        sleep 200
    }
    CounterWinBack:=0 
    WinBackTimerCounter:=0
    setTimer, WinBack, off
}
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
CapsLock & y::
caps_y:
if (capsp_press!=2 and capsp_press!=2) {
    3String=Reloading...
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
    sleep 1500
    }
for key, value in WinDisable {
    3String=Reloading... Searching for disabled windows...
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
    sleep 200
    if (value!="REMOVEME") {
        WinSet, enable, , %value%
        3String=Reloading... window %value% enabled...
        3Time:=40*1 ; 40 is one second
        GuiConF(3,3,3String,-1)
        sleep 500
    }
}
for key, value in OnTopArray {
    3String=Reloading... Searching for On Top windows...
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
    sleep 200
    if (value=1){    
    winset, AlwaysOntop, Off, %key%
    3String=Reloading... ontop off for %key%...
    3Time:=40*1 ; 40 is one second
    GuiConF(3,3,3String,-1)
    sleep 500
    }
}
reload
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & B::
    3String=Press 1 to clear ALL settings, 2 to clear NON-ACCOUNT settings, anything else to cancel.
    3Time:=40*20 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    Input, Outputvar, L1
    if(Outputvar="1") {
        goto clearsettings
    } else if (Outputvar="2") {
        goto clearsettings
    } else {
        3String=Canceled.
        3Time:=40*2 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
    }
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
Capslock & V::
if (Debug=1) {
Debug:=0
GuiConF(5,2,-1,-1)
    3String=Debug Disabled.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
} else {
Debug:=1
    3String=Debug Enabled.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
}
return

Capslock & H::
MouseGetPos,,, WinUMID2
WinActivate, ahk_id %WinUMID2%
WinGet, ProcessID, PID, A
    Run cmd.exe /c taskkill /f /PID %ProcessID%
return
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
clearsettings:
if (capsm_press=2 or capsp_press=2) {
    if (capsm_press=2) {
        run cmd /c rd /s /q %CS%
        goto cl_set_msg
    }
    ifExist, %CS%RuneLiteDir.log
        fileDelete, %CS%RuneLiteDir.log
    IfExist %CS%FFCH.log
        fileDelete, %CS%FFCH.log
    ifExist %CS%TimerIsPaused.log
        fileDelete, %CS%TimerIsPaused.log
    ifExist %CS%GlobalTimerMInutes.log
        fileDelete, %CS%GlobalTimerMInutes.log
    ifExist %CS%GlobalTimerMinR.log
        fileDelete, %CS%GlobalTimerMinR.log
    ifExist %CS%GlobalSecondDisplay.log
        fileDelete, %CS%GlobalSecondDisplay.log

    ifExist %CS%ActiveToggle.log
        fileDelete, %CS%ActiveToggle.log
    ifExist %CS%GUI_Names.log
        fileDelete, %CS%GUI_Names.log
    ifExist %CS%OSD_MOVE2.log
        fileDelete, %CS%OSD_MOVE2.log
    ifExist %CS%OSD_MOVE.log
        fileDelete, %CS%OSD_MOVE.log
}
cl_set_msg:
    3String=settings cleared - reload in 5 seconds.
    3Time:=40*2 ;; 40 = 1 second
    GuiConF(3,3,3String,-1)
    sleep 2000
    goto caps_y
return
;-------------------------------------;-------------------------------------;-------------------------------------
Repaint:
if(!counterM2 or counterM2<0 or counterM2>=counterMM)
    counterM2:=0
counterM2++
if (hdd_frame[counterM2]="destroyed")
    return
zoom = 3
Rx3 := % ResX[counterM2]
Ry3 := % ResY[counterM2]

if (MouseFollowMag>=1 and MouseFollowMagID=CounterM2 and MouseFollowMagID) {
    MouseGetPos x2x2, y2y2
    zoom := 3
    Zx[MouseFollowMagID] := ResX[MouseFollowMagID]/zoom
    Zy[MouseFollowMagID] := ResY[MouseFollowMagID]/zoom
    if (MouseFollowMag=1) {
        x2[MouseFollowMagID] := x2x2-Zx[MouseFollowMagID]+(ResX[MouseFollowMagID]/zoom)/2
        y2[MouseFollowMagID] := y2y2-Zy[MouseFollowMagID]+(ResY[MouseFollowMagID]/zoom)
    } else if (MouseFollowMag=2) {
        x2[MouseFollowMagID] := 4ThreeX-Zx[MouseFollowMagID]+(ResX[MouseFollowMagID]/zoom)/2
        y2[MouseFollowMagID] := 4ThreeY-Zy[MouseFollowMagID]+(ResY[MouseFollowMagID]/zoom)
    }
}
xz := % x2[counterM2]-Zy[counterM2]
   yz := % y2[counterM2]-Zy[counterM2]
   DllCall("gdi32.dll\StretchBlt"
   , UInt,hdc_frame[counterM2]
   , Int,0
   , Int,0
   , Int,2*Rx3
   , Int,2*Ry3
   , UInt,hdd_frame[counterM2]
   , UInt,xz
   , UInt,yz
   , Int,2*Zx[counterM2]
   , Int,2*Zy[counterM2]
   , UInt,0xCC0020) 
Return
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
Timer_Load_Error:
        3String=Error loading any previous timer.
        3Time:=40*1 ;; 40 = 1 second
        GuiConF(3,3,3String,-1)
        fileDelete, %CS%TimerIsPaused.log
        fileDelete, %CS%GlobalTimerMinR.log
        fileDelete, %CS%GlobalSecondDisplay.log
        SetTimer, UpdateOSD2, off
        TimerIsRunning:=0
        TimerIsPaused:=0
        TimerResetWarning=0
        GlobalSecondsDisplayInit:=GlobalTotalSeconds
        GlobalSecondsInitMin:=
        GlobalTimerMinR:=
        GlobalSecondDisplay:=60
        fileDelete, %CS%TimerIsPaused.log
        fileDelete, %CS%GlobalTimerMinR.log
        fileDelete, %CS%GlobalSecondDisplay.log
return
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;

;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
;subhere
SetTimer_Minutes:
        if (GlobalSecondsDisplayInit<=0 or timerMessage=TIME) {
                SetTimer, UpdateOSD2, off
                GlobalSecondDisplay:=60
                MouseGetPos, MgetX, MgetY
                MgetX2:=MgetX+10
                MgetY2:=MgetY+10
                InputBox, GlobalTimerMInutes_input, Countdown Timer, number of minutes., , 200, 125, MgetX2, MgetY2
                GlobalTimerMInutes := % GlobalTimerMInutes_input
                    If (!GlobalTimerMInutes) {
                        3String=No Time was entered returning.
                        3Time:=40*1 ;; 40 = 1 second
                        GuiConF(3,3,3String,-1)
                        CapsTAccTimersCounter:=0
                        return
                    }
                fileDelete, %CS%GlobalTimerMInutes.log
                sleep 250
                fileAppend, %GlobalTimerMInutes%, %CS%GlobalTimerMInutes.log
                if (TimerIsRunning=1 or TimerIsPaused=1)
                    GoSub timerclear
                Goto, timer_t
            } else {
                3String=Timer Running - Caps+Q to Reset
                3Time:=40*1 ;; 40 = 1 second
                GuiConF(3,3,3String,-1)
        }
return
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
;subhere
timerclear:
PlaySound:=2
SetTimer, AlarmSound, off
SetTimer, UpdateOSD2, off
TimerIsRunning:=0
TimerIsPaused:=0
TimerResetWarning=0
GlobalSecondsDisplayInit:=GlobalTotalSeconds
GlobalSecondsInitMin:=
GlobalTimerMinR:=
GlobalSecondDisplay:=
fileDelete, %CS%TimerIsPaused.log
fileDelete, %CS%GlobalTimerMinR.log
fileDelete, %CS%GlobalSecondDisplay.log    
GuiConF(2,2,-1,-1)    
WaitJustOneFuckingSecond=3
SetTimer, 1fuckingsecondtimer, on
3String=Timer Cleared!
3Time:=40*1 ;; 40 = 1 second
GuiConF(3,3,3String,-1)
WaitJustOneFuckingSecond=0                
return
;-------------------------------------;-------------------------------------
;-----------------------------------
;-----------Functions---------
;------------------------
Rand( a=0.0, b=1 ) {
   IfEqual,a,,Random,,% r := b = 1 ? Rand(0,0xFFFFFFFF) : b
   Else Random,r,a,b
   Return r
}
/*; RANDOM FUNCTION EXAMPLES
Rand() ; - A random float between 0.0 and 1.0 (many uses)
Rand(6) ; - A random integer between 1 and 6 (die roll)
Rand("") ; - New random seed (selected randomly)
Rand("", 12345) ; - New random seed (set explicitly)
Rand(50, 100) ; - Random integer between 50 and 100 (typical use)
*/
RandColor() {
    Random, vRand, 0x4FFFFF, 0xAFFFFF
    color = % Format("{:06X}", vRand)
return color
}

RandColor2() {
    ;Random, vRand, 0, 0xFFFFFF
    Random, vRand, 0x4FFFFF, 0xAFFFFF
    color = % Format("{:06X}", vRand)
return color


}

GuiRandColor(GuiNumber) {
if (GuiNumber) {
    Gui, %GuiNumber%: Default
    Random, vRand, 0x33DE10, 0x33DF10
    color = % Format("{:06X}", vRand)
    GuiControl, +c%color%, MyText
}
}
GuiWhiteColor(GuiNumber) {
if (GuiNumber) {
    Gui, %GuiNumber%: Default
    ;Random, vRand, 0x33DE10, 0x33DF10
    ;color = % Format("{:06X}", vRand)
    GuiControl, +cWhite, MyText
}
    return
}
RandomStr(l = 16, i = 48, x = 122) { ; length, lowest and highest Asc value
    Loop, %l% {
        Random, r, i, x
        s .= Chr(r)
    }
    Return, s
}

monitorFunc() { 
MonArray:=Array()
    CoordMode, Mouse, Screen
        MouseGetPos, NoX, NoY
        SysGet, monCount, MonitorCount
        Loop %monCount%
        {     
        SysGet, curMon, Monitor, %a_index%
            if ( NoX >= curMonLeft and NoX <= curMonRight and NoY >= curMonTop and NoY <= curMonBottom )
                {
                    TDISPLAYY      := curMonTop ; can't be less than
                    TDISPLAYX      := curMonLeft ; can't be less than
                    TDISPLAYY2        := curMonBottom ; can't be greater
                    TDISPLAYX2        := curMonRight ; can't be greater
                    TDISPLAYHeight := curMonBottom - curMonTop
                    TDISPLAYWidth  := curMonRight  - curMonLeft
                    
MonArray := [TDISPLAYY,TDISPLAYX,TDISPLAYY2,TDISPLAYX2,TDISPLAYHeight,TDISPLAYWidth]
;msgbox, % TDISPLAYY " " TDISPLAYX  " "   TDISPLAYY2  " "   TDISPLAYX2  " "   TDISPLAYHeight  " "   TDISPLAYWidth
            }
        }

return MonArray
}

; msgbox, % RegExReplace(RandomStr(), "\W", "i")
BuildGUI(GuiNumber) {
global GuiActiveArray
global WaitJustOneFuckingSecond
if (GuiNumber!=0 and GuiNumber) {
    CustomColor = 000000 ;
    Gui, %GuiNumber%: Destroy
    Gui, %GuiNumber%: New, +LastFound -Caption +ToolWindow +AlwaysOnTop +E0x20
    Gui, %GuiNumber%: Color, 000000
    if (GuiNumber=1) {
        Gui, %GuiNumber%: Font, s18, Magneto ; Matura MT Script Capitals ; DejaVu Sans
        Gui, %GuiNumber%: Add, Text, vMyText +cWhite, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    } else if (GuiNumber=3 or GuiNumber=5) {
        Gui, %GuiNumber%: Font, s11, OCR A Std ; Fixedsys ; DejaVu Sans
        Gui, %GuiNumber%: Add, Text, vMyText +cWhite, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    } else if (Substr(GuiNumber,1,1)="_") { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
        Gui, %GuiNumber%: Font, s56 ; Mistral ; Franklin Gothic Book ;Corbel
        Gui, %GuiNumber%: Add, Text, vMyText +cblack, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        GuiActiveArray[GuiNumber]:=2 ; set to dot id on active array to 2 for removal later
        WinSet, TransColor, %CustomColor% 255
        return
    } else if (Substr(GuiNumber,1,4)="Note") { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
        Gui, %GuiNumber%: Font, s14, OCR A Std ; Mistral ; Franklin Gothic Book ;Corbel
        Gui, %GuiNumber%: Add, Text, vMyText +cblack, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        GuiActiveArray[GuiNumber]:=3 ; set to dot id on active array to 2 for removal later
        WinSet, TransColor, %CustomColor% 255
        return
    } else if (Substr(GuiNumber,1,4)="Temp") { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
        Gui, %GuiNumber%: Font, s36, OCR A Std ; Mistral ; Franklin Gothic Book ;Corbel
        Gui, %GuiNumber%: Add, Text, vMyText +cblack, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        GuiActiveArray[GuiNumber]:=4 ; set to dot id on active array to 2 for removal later
        WinSet, TransColor, %CustomColor% 255
        return
        } else {
        Gui, %GuiNumber%: Font, s14, OCR A Std ; Mistral ; Franklin Gothic Book ;Corbel
        Gui, %GuiNumber%: Add, Text, vMyText +cblack, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        
    }
WinSet, TransColor, %CustomColor% 255
GuiActiveArray[GuiNumber]:=1
    if (GuiNumber>NumAccs) {
        Gui, %GuiNumber%: Hide
        WaitJustOneFuckingSecond:=2
        SetTimer, 1fuckingsecondtimer, on
        
    }
}
return
}
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;;-;-;-;-;-;-;-;-;-;-;-
OutlineBuilder(GuiNumber) {
global GuiActiveArray
OutlineBuilder:
CustomColor2 = 0B0D0F ;
OutlineCounter:=0
While (OutlineCounter<4) {
OutlineCounter++
GuiOutlineID=%GuiNumber%Outline%OutlineCounter%
GuiActiveArray[GuiOutlineID]:=1
if (Substr(GuiOutlineID,1,1)=Chr(8226)) ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
    GuiActiveArray[GuiOutlineID]:=2 ; for dots when 2 then remove , then set to 0 , it is how they are identified during this process
if (Substr(GuiOutlineID,1,4)="Temp") ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
    GuiActiveArray[GuiOutlineID]:=4 ; for dots when 2 then remove , then set to 0 , it is how they are identified during this process

Gui, %GuiOutlineID%: Default
Gui, %GuiOutlineID%: Destroy
Gui, %GuiOutlineID%: New, +LastFound -Caption +ToolWindow +AlwaysOnTop +E0x20
Gui, %GuiOutlineID%: Color, %CustomColor2%
if (GuiNumber=3 or GuiNUmber=5) {
Gui, %GuiOutlineID%: Font, Bold s11, OCR A Std ; Fixedsys ; DejaVu Sans
Gui, %GuiOutlineID%: Add, Text, vMyText +c0A0F0A, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
} else if (GuiNumber=1) {
Gui, %GuiOutlineID%: Font, s18, Magneto
Gui, %GuiOutlineID%: Add, Text, vMyText +c0A0F0A, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
} else if(Substr(GuiOutlineID,1,4)="Temp")  {
Gui, %GuiOutlineID%: Font, s36, OCR A Std ; Fixedsys ; DejaVu Sans
Gui, %GuiOutlineID%: Add, Text, vMyText +c0B0D0F, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
} else if(Substr(GuiOutlineID,1,1)="_")  {
Gui, %GuiOutlineID%: Default
Gui, %GuiOutlineID%: Font, s8 ; Fixedsys ; DejaVu Sans
Gui, %GuiOutlineID%: Add, Text, vMyText +c0B0D0F, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
WinSet, TransColor, %CustomColor2% 255
GuiControl, +c0A0B0C, MyText
    return
} else if(Substr(GuiOutlineID,1,1)=Chr(8226) or Substr(GuiOutlineID,1,1)="X")  { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
Gui, %GuiOutlineID%: Default
Gui, %GuiOutlineID%: Font, s57 ; Fixedsys ; DejaVu Sans
Gui, %GuiOutlineID%: Add, Text, vMyText +c0B0D0F, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
WinSet, TransColor, %CustomColor2% 255
GuiControl, +c0A0B0C, MyText
    return
} else  {

Gui, %GuiOutlineID%: Font, Bold s14, OCR A Std ; Fixedsys ; DejaVu Sans
Gui, %GuiOutlineID%: Add, Text, vMyText +c0B0D0F, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
}
WinSet, TransColor, %CustomColor2% 255
GuiControl, +c0A0B0C, MyText
}
return
}
;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;;-;-;-;-;-;-;-;-;-;-;-
/*
examples:
Hide a GUI - GuiConF(GUI,2,-1,-1)
Set Text - GuiConF(GUI,3,TEXT,-1)
Show Gui - GuiConF(GUI,1,X,Y)
dots built differently, exceptions made
*/
GuiConF(GuiVar,ConType,xLoc,yLoc) {
Global NumAccs
Global DotCounter
    if (GuiVar and xLoc and yLoc) { 
        if (ConType=1) {
            xFLoc1:=xLoc+2
            xFLoc2:=xLoc-2
            yFLoc1:=yLoc+2
            yFLoc2:=yLoc-2
            if (SubStr(GuiVar,1,1)!=Chr(8226) and Substr(GuiVar,1,1)!="X") ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
                Gui, %GuiVar%: Show, x%xLoc% y%yLoc% NoActivate
            GuiVarCounter:=0
            
            while (GuiVarCounter<=4) {
                GuiVarCounter++            
                
                                ;Shift bottom Left
                if (GuiVarCounter=2 and SubStr(GuiVar,1,1)!="_") { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
                    Gui, %GuiVar%Outline%GuiVarCounter%: Show, x%xFLoc1% y%yFLoc2% NoActivate
                }
                    ;shift top left
                    if (GuiVarCounter=3 and SubStr(GuiVar,1,1)!="_") { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
                        Gui, %GuiVar%Outline%GuiVarCounter%: Show, x%xFLoc2% y%yFLoc1% NoActivate
                    }
                if (GuiVar!=1) {
                    ;Shift Top Right
                if (GuiVarCounter=1) {
                        
                        if (SubStr(GuiVar,1,1)="_") { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
                        ;msgbox, % xFLoc3
                            xFLoc1 := xFLoc1+61
                        if (DotCounter<100)
                            xFLoc1 := xFLoc1+4
                        if (DotCounter<10)
                            xFLoc1 := xFLoc1+4
                        yFLoc1 := yFLoc1+70
                            Gui, %GuiVar%Outline%GuiVarCounter%: Show, x%xFLoc1% y%yFLoc1% NoActivate
                    return
                    } else if (SubStr(GuiVar,1,1)=Chr(8226) or Substr(GuiVar,1,1)="X") { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
                        Gui, %GuiVar%Outline1: Default
            GuiControl,, MyText, % Chr(8226)
            Gui, %GuiVar%Outline%GuiVarCounter%: Show, x%xFLoc1% y%yFLoc1% NoActivate
            return
                        } 
                    Gui, %GuiVar%Outline%GuiVarCounter%: Show, x%xFLoc1% y%yFLoc1% NoActivate
                    }
                ;Shift Bottom Right
                    if (GuiVarCounter=4 and SubStr(GuiVar,1,1)!="_") { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
                        Gui, %GuiVar%Outline%GuiVarCounter%: Show, x%xFLoc2% y%yFLoc2% NoActivate
                    }
                }
            }
        } else if (ConType=2) {

            Gui, %GuiVar%: Hide
        if (SubStr(GuiVar,1,1)=Chr(8226) or Substr(GuiVar,1,1)="X") ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
            return
            if (SubStr(GuiVar,1,1)="_") { ; For Dots outlines they have less GUI, only 1 outline, 1 text, 1 dot, built seperately.
                Gui, %GuiVar%Outline1: Hide
                return
            }
            GuiVarCounter:=0
            while (GuiVarCounter<=4) {
                GuiVarCounter++
                Gui, %GuiVar%Outline%GuiVarCounter%: Hide
            }
        } else if (ConType=3) {

            Gui, %GuiVar%: Default
            GuiControl,, MyText, %xLoc%
            if (SubStr(GuiVar,1,1)="_") {            
                        DotCounter++
                        Gui, %GuiVar%Outline1: Default
                        GuiControl,, MyText, %DotCounter%
            return
            }
            GuiVarCounter:=0
            while (GuiVarCounter<=4) {
                GuiVarCounter++
                Gui, %GuiVar%Outline%GuiVarCounter% : Default
                GuiControl,, MyText, %xLoc%
            }
        } else if (ConType=4) {
            GuiVarCounter:=0
            while (GuiVarCounter<=4) {
            GuiVarCounter++
                if (xLoc=1) {
                Gui, %GuiVar%Outline%GuiVarCounter% : +AlwaysOnTop
                    if (GuivarCounter=4)
                        Gui, %GuiVar%: +AlwaysOnTop
                    
                } else if (xLoc=0) {
                Gui, %GuiVar%Outline%GuiVarCounter% : -AlwaysOnTop
                    if (GuivarCounter=4)
                        Gui, %GuiVar%: -AlwaysOnTop

                }
            }
        }
    }
    return
}
Odd(n)
{
    return n&1
}
Even(n)
{
    return mod(n, 2) = 0
}



;-------;-------------------;-------------------;    
;-----------------;-------------------;-------------------;
;--------------Timers---------------;-------------------;-------------------;
;--------------------------------------;-------------------;

;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
TimersCheck:
if ((GUI2ActiveMouse!=0 or (3Time>=0) or tickHUD!=0 or Debug!=0)) {
    SetTimer, Three, on
} 
if (Debug=1) {
    if (DebugPriority<=1) {
        DebugPriority:=1
        DebugCycle++
        if (DebugCycle=1) {
            5String=X: GUI2ActiveMouse %GUI2ActiveMouse% - 3Time %3Time% - MouseMessages %MouseMessages%
        } else if (DebugCycle=2) {
            DebugCycle:=0
            5String=X: tickHUD %tickHUD% - Debug %Debug% - RuneLite Window Count %RuneliteWindowCount% %RuneliteDWindowCount%
        }
    }
    if (DebugPriority=10) {
    5String=A Add to clipboard, S remove from clipboard, Caps + scroll up/down select saved
    GuiWhiteColor(5)
    } else {
    
    GuiRandColor(5)
    
    }
    GuiConF(5,3,5String,-1)
}
return
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
Three:

;critical


    if (GUI2ActiveMouse=1 and GlobalTotalSeconds and TimerIsRunning=1) {
    if(stopThreeGo!=1)
        MouseGetPos, ThreeX, ThreeY
                MgetX2:=ThreeX+10
                MgetY2:=ThreeY+18
                GuiConF(2,1, MgetX2, MgetY2)            
    } else if (!GlobalTotalSeconds) {
            GuiConF(2,2,-1,-1)
    }
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
    if (3Time>=0 and MouseMessages!=0) {
    if(stopThreeGo!=1)
        MouseGetPos, ThreeX, ThreeY
        3Time--
        if (3Time>=5) { 
            GuiConF(3,1,ThreeX-10,ThreeY+50)
        } else {
            GuiConF(3,2,-1,-1)
            capsp_press:=0
        }
    }
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
if (tickHUD=1 and tickLimit!=NaN) {
    if(stopThreeGo!=1)
        MouseGetPos, ThreeX, ThreeY
        if (tickDisplaySetting=1) {
        4ThreeX:=ThreeX-78
        4ThreeY:=ThreeY-50
        }
        if (initTick>=1)
            GuiConF(4,1,4ThreeX,4ThreeY)
} else if (tickDisplaySetting=2) {


        if (initTick>=1 and tickHUD=1) {
            if (boredCounter>=(TDISPLAYWidth/2)-50) {
                boredDirection:=Rand(-1.5,-0.5)
            } else if (boredCounter<=-(TDISPLAYWidth/2)+50) {
                boredDirection:=Rand(0.5,1.5)
            }
            if (boredCounter2>=(TDISPLAYHeight/2)-20) {
                boredDirection2:=Rand(-1.5,-0.5)
            } else if (boredCounter2<=-(TDISPLAYHeight/2)+15) {
                boredDirection2:=Rand(0.5,1.5)
            }
            boredCounter:=boredCounter+boredDirection*Rand(3,7)
            boredCounter2:=boredCounter2+boredDirection2
            BoredTickX:=floor((TickCurDisplayWidth/2)+boredCounter)-60+TickCurDisplayX
            BoredTickY:=floor((TickCurDisplayHeight/2)-boredCounter2)-25+TickCurDisplayY
            GuiConF(4,1,BoredTickX,BoredTickY)
        }
        if (Debug=1 and DebugPriority<=2) {
            fBC2:=floor(boredCounter2)
            fBC:=floor(boredCounter)
            fBD:=floor(boredDirection)
            fBD2:=floor(boredDirection2)
            DebugPriority:=2
            5String=X: %ThreeX% %4ThreeX% Y: %ThreeY% %4ThreeY% - B: %fBD% %fBD2% %fBC% %fBC2%
        }
} else if (tickDisplaySetting=3) {
    ThreeSinCosCounter+=10
    r:=100
    dir:=1
    4ThreeX:=(ThreeX+r*cos(((ThreeSinCosCounter-1)/(2*r*3.1416))))
    4ThreeY:=(ThreeY+dir*r*sin(((ThreeSinCosCounter-1)/(2*r*3.1416))))
    if (initTick>=1)
        GuiConF(4,1,4ThreeX-73,4ThreeY-10)

    if (Debug=1 and DebugPriority<=2) {
        DebugPriority:=2
        5String=X: %ThreeX% - %SinCosX% --- Y: %ThreeY% - %SinCosY% 
    }
}

;-;-;-;-;-;-;-;-;-;-;-;-;-;-;--;-;-
if (Debug=1) {    
    if(stopThreeGo!=1)
        MouseGetPos, ThreeX, ThreeY
        5ThreeX:=ThreeX-275
        5ThreeY:=ThreeY-50
        GuiConF(5,1,5ThreeX,5ThreeY)
}
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-
if ((GUI2ActiveMouse=0 and 3Time<0 and tickHUD=0 and Debug=0)) {
    SetTimer, Three, off
    return
}
return



SaveWait2:
SaveWaitCounter2--
if (SaveWaitCounter2<=0) {
    SetTimer, SaveWait2, off
}
return
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;    
MsgboxMove:
    IfWinNotExist, %MsgboxMove_String%
        return 
SetTimer, MsgboxMove, off
MouseGetPos, MouseX, MouseY
MsgBoxMoveMGPX:=MouseX-20
MsgBoxMoveMGPY:=MouseY-20
WinMove, %MsgboxMove_String%, , %MsgBoxMoveMGPX%, %MsgBoxMoveMGPY%
if (ChangeBtnNames=1) {
    ChangeBtnNames:=0
    WinActivate %MsgboxMove_String%
    sleep 100
    ControlSetText, Button1, &%Btn1_Name%
    ControlSetText, Button2, &%Btn2_Name%    
}
return

;-------------------------------------;-------------------------------------;-------------------------------------
;----------------------------------- UpdateOSD2 for Timer OSD MM:SS formatting    ----------------------------------                                
;-------------------------------------;-------------------------------------;-------------------------------------

UpdateOSD2:
if(TimerIsPaused=1) {
GuiConF(2,2,-1,-1)
    return
}
Gui, 2: Default
Gui2Color = % RandColor()
GuiControl, +c%Gui2Color%, MyText
if(GlobalSecondsDisplayInit<=0 and GlobalSecondsDisplayInit!=-1){
    GlobalSecondsDisplayInit:=-1
    GlobalSecondDisplay:=
    GlobalSecondsInitMin:=
    GlobalTimerMinR:=
    SetTimer, UpdateOSD2, 150
    return
} else {
    if (GlobalSecondsDisplayInit=GlobalSecondsDisplayInit)
        SetTimer, UpdateOSD2, 1000
    GlobalSecondDisplay--
    GlobalSecondsDisplayInit--
    GlobalSecondsInitMin:=GlobalSecondsDisplayInit/60
    GlobalTimerMinR:=Floor(GlobalSecondsInitMin)
        if ( !GlobalSecondDisplay or GlobalSecondDisplay<0) {
        if (GlobalSecondsDisplayInit>0) {
                GlobalSecondDisplay:=59
            } else {
                GlobalSecondDisplay=0
            }
        }
}
     if (TimerIsRunning=1) { 
            if (GlobalSecondsDisplayInit>0) {
                if(GlobalSecondDisplay<10){
                    TimerTimeStr=%GlobalTimerMinR%:0%GlobalSecondDisplay%
                } else {
                    TimerTimeStr=%GlobalTimerMinR%:%GlobalSecondDisplay%
                }        
            }
                if (GlobalSecondsDisplayInit<=0) {
                        TimerTimeStr=TIME
                        
                        if (colorswap=0) {
                            colorswap:=1
                                if(PlaySound=0) { 
                                PlaySound=1
                                SetTimer, AlarmSound, 4000
                                SetTimer, AlarmSound, on
                            }
                            GuiControl, +cRED, MyText
                        } else {
                            colorswap:=0
                            GuiControl, +cWHITE, MyText
                        }
                } else {
                ifExist, E:\rsahkvars\TimerCleared.log
                    fileDelete, E:\rsahkvars\TimerCleared.log
                }
        }
    if (NoAHKVars=0) {
        ifNotExist, %SavedVarsDir%\TimerTime.log
            FileAppend, %TimerTimeStr%, %SavedVarsDir%\TimerTime.log
        ifNotExist, %SavedVarsDir%\TimerTime2.log
            FileAppend, %TimerTimeStr%, %SavedVarsDir%\TimerTime2.log
        ifNotExist, %SavedVarsDir%\TimerTime3.log
            FileAppend, %TimerTimeStr%, %SavedVarsDir%\TimerTime3.log
    }
    GuiConF(2,3,TimerTimeStr,-1)
return
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;

AlarmSound:
if (PlaySound=1) {
    SoundDir=%A_WinDir%\Media\Alarm10.wav
    SoundPlay, %SoundDir%, wait
} else {
    PlaySound:=2
    SetTimer, AlarmSound, off    
}
return
;--------
;-------------------;-------------------;-------------------;
;-------------------;-------------              ------------;
;-------------------;-------------------;-------------------;
;                    If window under mouse                    ;
;                is a runelite window, make it active.        ;
;-------------------;-------------------;------
;ActivateWinUM:
;if (IsRunelite=1) {
;    MouseGetPos,,, WinUMID
;if (WinUMID!=P_WinUMID) {
;        P_WinUMID=%WinUMID%
;        MouseGetPos,,,,WinCLASS
;        WinGetClass, P_WinCLASS, A
;        ;DebugPriority:=7
;        ;5String:= % P_WinCLASS
;    if(WinCLASS="SunAwtCanvas2" and P_WinCLASS="SunAwtFrame") {
;    WinGetTitle, titleMPOS, ahk_id %WinUMID%
;        for key, value in WinDisable {
;            if (value=titleMPOS) {
;                3Time:=20 ; 40 is one second
;                GuiConF(3,3,"Window Disabled",-1)
;                return
;            }
;        }
;            WinActivate, ahk_id %WinUMID%
;            
;        
;} ; else if (WinCLASS and WinCLASS!="") {
; sleep 200
;}
;}

return
;-------------------------------------;-------------------------------------;-------------------------------------
;------------------ UpdateOSD Getting current window and choosing when and where to draw    ----------------------                            
;-------------------------------------;-------------------------------------;-------------------------------------

UpdateOSD:
    if (NoAHKVars=0) {
    ifExist, %CS%reloadmsg.txt
    {
        FileDelete, %CS%reloadmsg.txt
        3String=Reloading Logins OBS Twitch PC2 PC3 PC4...
        3Time:=40*1 ; 40 is one second
        GuiConF(3,3,3String,-1)
    }
}
WinGetActiveTitle, Title 
        
;    prevent when a window is ontop, from the gui getting stuck under it
if (OnTopArray[Title]=1) {

    for GuiKeyCheck, GuiValueCheck in GuiActiveArray {
        if instr(GuiKeyCheck,"Outline") { 
            Gui, %GuiKeyCheck%: +AlwaysOntop
        }
    }
    for GuiKeyCheck, GuiValueCheck in GuiActiveArray {    
        if !instr(GuiKeyCheck,"Outline") { 
            Gui, %GuiKeyCheck%: +AlwaysOntop
            
        }
    }
OnTopArray[Title]:=2
}
 if OnTopArray[O_Title]=2 {
    OntopArray[O_Title]:=1
}

            GuiConF(2,2,-1,-1)
            GUI2ActiveMouse:=0

        GuiConF(1,2,-1,-1)

    return
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;        

1fuckingsecondtimer:
WaitJustOneFuckingSecond--
if (WaitJustOneFuckingSecond<=2) {
}
if (WaitJustOneFuckingSecond<=-1) {
    SetTimer, 1fuckingsecondtimer, off
}
return
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;
;-------------------;-------------------;-------------------;



;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;-------------------------------------;
tickHUD:
if (tickLimit!=NaN and tickHUD=1) {
    tickCounter++
    TickTockTickTock++
    if (tickLimit>1 and tickCounter>tickLimit) {
        tickCounter=1
    }

        if (TickTockTickTock=1) 
            TockTockTickText=/  %tickCounter%  /    
        if (TickTockTickTock=2)
            TockTockTickText=|  %tickCounter%  |
        if (TickTockTickTock=3)
            TockTockTickText=\  %tickCounter%  \
        if (TickTockTickTock=4) {
            TockTockTickText=-- %tickCounter% --
            TickTockTickTock:=0
        }
GuiRandColor(4)
GuiConF(4, 3, TockTockTickText, -1)
} else { 
setTimer, tickHUD, off
GuiConF(4,2,-1,-1)
tickCounter:=0
}
initTick++
return
