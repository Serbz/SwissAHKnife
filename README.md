# SwissAHKnife
desktop and window management, various toolsets, HUD
*opt* some runelite functions for painting OSD names, assisting with window focus and placement geared towards people playing multiple accounts

;  Usage:  (required AHK v1.1.31+)

     Capslock + Space - CHANGES THE KEY MODE !!! - Three modes, OSD, Window Management
     
     OSD MODE KEYS: (KeySet=1)
         CAPSLOCK + 
         F - Changes the Capslock + Left/Right Mouse button and C key modes (Markers, Magnifiers, Counters, Notes)
         X - Creates a tick counter, offers options if active to change style, remove the counter, or change the tick count limit.
         Z - Offers options for hiding, sticking cursor objects (messages/timers/etc) and nameplates
         E - Sets either the Account Specific countdown timer start time or the same for the Global Timer.
         W - Pauses/Unpauses the global timer
         T - Creates or removes an account specific timer
         Q - Creates or removes the Global Timer
         3 - Either counts the account specific counter up, or clears it - These are attached to nameplates, if nameplates are hidden these are too.
         Up, Down, Left, Right - Move the nameplates and attached displays on the runelite windows, these locations are saved.
     
     
     WINDOW MANAGEMENT KEYS: (KeySet=2)
         CAPSLOCK + 
         G - Sets window to be focused one controller input, if set to windows shell (taskbar) it will be ignored
         U - Toggles on/off the automatic window focus of runelite under the cursor
         3 - Disable/enable a window under the cursor
         Q - Set a window to be always ontop or not
         R - Save RUNELITE window locations or move to saved runelite window locations
         W - Bring window opacity down
         E - Reset window opacity to 255 (opaque)
           C - Toggles the window's border and title bar


     GLOBAL KEYS
         Capslock alone - Cycles through runelite window focus, priority on next account window if active else search for empty runelite (not logged in)
         CAPSLOCK + 
         D - Bring firefox/chrome into focus
         Y - Reloads the script
         B - Clears script settings, either all or all non-account settings    
         N - Kills all runelite windows without warning
         H - Kills the window, any window, even explorer, that is under the cursor without warning.
        (DISABLED) A - Hides a window off screen, press again to bring it back
         4 - Makes the window under the cursor bounce around the screen, Capslock+5 to stop all bouncing windows.
         V - Toggles Debug OSD
         

  

-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C3
---------------
This is the current version.


B3
---------------
Changed all keybinds, 2-3 layers
added macro builder
mouse sets 1-3 do work, but are commented for now
removed some things causing problems on tick counter
restructured entire file, focused on responsiveness and as close to 0ms mouse accuracy as possible
increased threads per hotkey and changed intervals

A6.
---------------
Nike'd the caps+H
Created Temp variables in some for loops to prevent loops overlapping and causing some variables to change when they shouldn't
Added searching for ontop windows to the reload function
When displaying a window ontop, you will still be able to see the gui now instead of the gui being stuck underneath it.
Nearly removed the please wait times on the global timer (its much faster)
Changed the way text outlines are created and drawn
Changed the way GUI's are removed/hidden/shown/added (Enabling the easy addition of future GUI)
Changed When starting an account specific timer, with no time set now, it will prompt for a time as usual, but will start the timer afterward as well.
Fixed GUI: 0 trying to exist (causing tons of error messages)
Fixed when sometimes pausing the timer while attached to the cursor, the timer actually just stopping the change of location of the timer, meanwhile the timer would continue running.
Fixed when setting a new global timer time, and the timer was running and attached to the cursor, the timer would freeze.
Fixed timer not clearing text outlines
Fixed Gui's not showing ontop of windows that are shown ontop
Fixed Global timer displaying 60 when it should be 59, or 59 when it should be 60
Added Capslock + B, tick counter, Left Alt + B changes its display mode, Capslock + N selects a new tick limit
Added a gui specifically for debug messages, Capslock + U enables them.
Various small optimizations, but didn't note them, IE. added GuiConF() which is a new function to handle GUI much better than before.


A503 513
----------------------------------------------------

Account Specific timer functions operate on for loops, intialization of one now is a while loop.
    Moved drawing of timers into a function paired with global UpdateOSD timer so
    there is no delay when moving the GUI around.
Added rudimentary Outlines around GUI 3, and 2, which are the global timers and the mouse tooltip messages
Capslock F now will change the next Account Specific Timer Time that is created.
Added Capslock C which will hide Mouse Tooltip messages
Added Capslock H which will offer to kill the process of the window under the cursor, press again to confirm.
Fixed an issue where some variables may be written to the script directory not C:\Serbz_multilog
Fixed an issue where the Account specific timer belonging to the last account in the Account Array would not
    Be created properly or drawn, and would also interrupt and remove the timer belongong to the first
    Account in the Account Array
Added a sound that plays at the end of an Account specific timer
If the file favicon.ico exists in the directory C:\Serbz_Multilog\ as C:\Serbz_Multilog\favicon.ico
    It will now be set as the script icon rather than the defaul AHK green bordered, white, capital, H.


A420, 421, 422.
----------------------------------------------------

Your usernames do not need to be entered at all anymore, your usernames are automatically added as played.
Account Setup Removed.
Fixed another problem with the global timer, where if the .log didn't exist it would get stuck in a loop
Removed msgbox left in a for statement
Changed the way GUI 1 is Hidden/Destroyed/Built to remove the blank ahk windows from the task bar
Fixed the global timer not setting as ontop
fixed not being able to reset the account specific timers


A418 - https://pastebin.com/m5ygrkaV
----------------------------------------------------

Account specific timers are funcional!
Each account can have its own timer, global timer is still a thing.
Fixed saving of the UI position, increased the amount of pixels it moves per key press as well.
Added Firefox or chrome first run question, caps d will now function with the one you select
added keys for clearing some or all of the settings
Fixed various different global timer bugs, where GUI failed destroy/build
Fixed an issue where deactivating a window did not work
Fixed unintentional issue with capslock+enter
Every dialogue box should now open at the cursor position
Added a delay to the reload for debugging reasons
Added Mouse tooltips for functions that were missing them.


A332 - https://pastebin.com/TgypMUMx
----------------------------------------------------

Every Hotkey is a capslock hotkey now
Various bugs fixed with the timer, hiding displays, and messages
Some more old hotkeys were removed
The timer's reset key was merged with capslock Q


A330 - https://pastebin.com/TgypMUMx
----------------------------------------------------

Re-wrote how the GUI is built
Removed OBS and Twitch binds/functions/variables
Removed Login functions
Removed Window position functions
Re-wrote timer, fixing bugs and adding color
Added options to timer for window placement
Added GUI 3, status messages


A120 & A121 - https://pastebin.com/eYrgizfQ <-121
----------------------------------------------------

Added GUI Controls
Added an initial setup for account names so it will work for not just me
Changed many static variabls to dynamic
The twitch/obs timers are set to off by default.

