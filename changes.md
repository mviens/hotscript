![](http://i.imgur.com/hMl5pXg.png)

# HotScript - Historical Changes
Copyright &copy; 2013-2017

---
# <a name="1.20170813.1">Version 1.20170813.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Win</kbd> + <kbd>Esc</kbd> to toggle the Windows Desktop. If no applications have been launched or activated while viewing the Desktop, pressing the HotKey again will restore all windows to their previous state.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Win</kbd> + <kbd>U</kbd> to convert the highlighted text or the text contents from the Windows Clipboard into a shortened URL. The original text must be a valid URL. If no matching text is selected or on the Window Clipboard, a dialog will be displayed prompting for the input. Once the shortened URL has been generated, a dialog will display showing the original URL and the shortened URL (as clickable links). There is a button to copy the shortened URL to the Windows Clipboard.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added DOS mouse HotKey <kbd>Back</kbd> button to move up one directory level. It is the same as the existing HotKeys of <kbd>Alt</kbd> + <kbd>Up</kbd> and <kbd>Alt</kbd> + <kbd>.</kbd> but accessible via a mouse button.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added DOS HotKey <kbd>Ctrl</kbd> + <kbd>.</kbd> to run Explorer for the current folder.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed the output of DOS HotKey <kbd>Alt</kbd> + <kbd>R</kbd> from `cd\` to `cd \`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Removed two entries (`Jira` and `Confluence`) from Quick Lookup <kbd>Win</kbd> + <kbd>Q</kbd> that were not applicable to most users.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed <kbd>Back</kbd> and <kbd>Forward</kbd> mouse buttons not working as they used to in EditPad Pro. This was caused by the new mouse HotKeys added in [1.20170425.1](#1.20170425.1). This is a temporary fix that uses an aggregate function to check for various active windows and executing the correct action. The long-term solution is to add support for multiple HotKeys to share the key(s) but yet have different conditions upon which they will be triggered. For now, this solution will suffice.

## HotStrings

<img src="https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40"/>

> The ending character after typing a fraction is now preserved.

<img src="https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136"/>

> Some ending characters, specifically `! # ^ + { }`, were not being rendered for several built-in HotStrings. This was caused by a change from version [1.20170626.1](#1.20170626.1).
 
## Variables

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added several global variables for use with Windows API calls:
> * `WM_COMMAND`
> * `WM_HSCROLL`
> * `WM_VSCROLL`
> * `WS_CHILD`
> * `WS_DISABLED`
> * `WS_EX_APPWINDOW`
> * `WS_EX_CONTROLPARENT`
> * `WS_EX_TOOLWINDOW`
> * `WS_POPUP`
> * `WS_VISIBLE`

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `addQuickLookup()` - Adds a new action to the HotKey <kbd>Win</kbd> + <kbd>Q</kbd> for Quick Lookup
> * `getEndChar()` - returns the last character typed that triggered a HotString
> * `isActiveRdp()` - returns `true` if the active window is Windows Remote Desktop, otherwise `false`
> * `isActiveSsh()` - returns `true` if the active window is an SSH DOS-like client (currently Putty and Kitty), otherwise `false`
> * `isWin10()` - returns `true` if the operating system is Windows 10, otherwise `false`
> * `shortenUrl()` - returns a shortened URL for the specified text

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed `hotString()` to capture the last character typed (in the same way as `A_EndChar`). It is accessible by calling `getEndChar()` or in the variable `hs.vars.endChar`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed `hotString()` to be smarter about how to render HotStrings. With the change to `hotString()` made in version [1.20170626.1](#1.20170626.1), the new method simulated typing each character which allowed for embedding keystrokes within the text, but this was much slower. In versions previous to [1.20170626.1](#1.20170626.1), all text was pasted and was much faster, but did not allow keystrokes to be embedded. Now, HotScript will decide which method to use depending upon the contents of the string to be rendered. For strings that do not have embedded keystrokes, the faster paste method will be used. When keystrokes are embedded, the slower method must be used, but this typically is only used for shorter strings anyway. Strings starting with `{RAW}` will use the paste method after removing the `{RAW}` prefix.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Improved handling within `getSelectedText()` for DOS windows. Any selected text within the DOS window should be properly detected and returned, whereas this was previously ignored for all DOS windows. This makes it far easier to select a path or some text and use the <kbd>Win</kbd> + <kbd>G</kbd> HotKey.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Removed some unnecessary code and variables from `ask()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Reverted change to `ClipWait()` from version [1.20170614.1](#1.20170614.1), so it now uses a 0.1 second delay. Certain HotKeys and HotStrings were taking too long to execute with 2 seconds.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Removed a small (unnecessary) wait within `pasteText()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed `pasteText()` to allow it to paste text within SSH apps.

<img src="https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136"/>

> Fixed an issue in `hkMiscCenterMouseWindow()` when triggered within an RDP session and HotScript was running both locally and remotely. The function would get executed first remotely then locally, causing the cursor to be centered on the screen instead of the window. The fix is to detect if the local window is an RDP session and also maximized. If so, then no action is run on the local instance, allowing the remote instance to properly handle moving the cursor to be centered within the remote window.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with `pasteText()` not working for SSH applications like Putty.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added window group for SSH apps (SshGroup). Currently only Putty and Kitty are defined.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added window group for Remote Desktop apps (RdpGroup). Currently only Microsoft Remote Desktop is defined.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed the delay for window functions from 0ms to 250ms. This should help with some applications not getting focused when launched via HotKey or with focusing application windows in general.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Moved some definitions for Windows API calls from being local variables to global.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed all Windows API calls from `SendMessage` to `PostMessage`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `changes.txt` to `changes.md` (this file).

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Refactored the historical changes (this file) to be more visually readable when viewed through GitHub.

<img src='https://img.shields.io/badge/-NOTES&nbsp;&nbsp;-B10DC9.svg?colorA=B10DC9'/>

With the change to `hotString()` made in version [1.20170626.1](#1.20170626.1), for simple text replacement strings, be aware that the following characters are treated as being special:  `! # ^ + { }`

> If any of these characters appear anywhere within the string, they will not be included in the output by default. There are a few ways to control how these characters will be handled. Below are a few examples:
>
> ```js
> hotString("test1", "a+bc{left}d!#^{}")
> hotString("test2", "{raw}a+bc{left}d!#^{}")
> hotString("test3", "a+bc{left}d{!}{#}{^}{{}{}}")
> ```
>
> * `test1` will act upon and interpret special characters. The output would be: `aBdc`
> * `test2` will treat the string literally because it starts with `{raw}`. The output would be: `a+bc{left}d!#^{}`
> * `test3` allows for both interpretation and literal strings. The output would be: `aBd!#^{}c`
>
> To allow for both interpretation as well as literal strings, any of the special characters must be escaped by surrounding that character with open and close curly brackets `{}`, even the open or close curly brackets themselves. For example: `{!} {#} {^} {+} {{} {}}`

---
# <a name="1.20170705.1">Version 1.20170705.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKeys to resize (stretch) a window to an edge of the monitor. This greatly adds to the customizable nature of resizing to a grid. With this new feature, it is possible to move a window somewhere within the grid and then resize it in one direction taking up the remainder of the height or width.
>
> * <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>Up</kbd> - Expand the current window to the top edge of the screen
> * <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>Left</kbd> - Expand the current window to the left edge of the screen
> * <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>Right</kbd> - Expand the current window to the right edge of the screen
> * <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>Down</kbd> - Expand the current window to the bottom edge of the screen

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> When using Quick Resolution (<kbd>Ctrl</kbd> + <kbd>Win</kbd> + <kbd>R</kbd>), width and height values are now saved/populated when invoking it again. This allows for easily changing just one of the previously entered values without needing to enter both. The saved value is only during runtime. If HotScript is reloaded, the values will not be retained.

## Functions

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `getWindowInfo()` to no longer require an `hWnd` parameter. It will now default to the active window if no parameter is specified.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Minor changes for Windows 10 adjustments when resizing windows into a grid or to an edge. If the Windows taskbar is at the bottom (the default), then moving a window to the bottom of the monitor would cause the resize area for that window to be inaccessible.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with not properly saving/restoring the `CoordModeMouse` value.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor code cleanup for consistency.

---
# <a name="1.20170626.1">1.20170626.1</a>

## HotStrings

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added DOS HotString `rd ` which will append `/s `.

## Functions

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `hotKeyAction()` to be able to support AutoHotkey-style named keys. This allows `hotString()` definitions to also use the named keys. An example is:
>
> ```js
> hotString("@test", "Line 1{Enter 2}Line 3{Enter 2}Line{Tab 4}5{Enter}")
> ```

---
# <a name="1.20170614.1">Version 1.20170614.1</a>

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `showWindow()` - makes a window visible that was previously hidden
> * `sortByValue()` - sorts an object or associative array by its values rather than by its keys

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> If the specified window cannot be found, `showWindowInfo()` will no longer display a dialog, because it just contained blank values anyway, which is not helpful.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Increased the timeout of `ClipWait()` to 2 seconds. This may help with some computers having issues with copy/paste functions.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed `Run()` to wait (up to 2 seconds) for the program to become active before returning.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `arrangeToGrid()` to take an additional parameter to indicate if windows should be sorted alphabetically by the window title.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `arrangeToGrid()` to allow for the first parameter (`winMatch`) to be an array containing `hWnd` values or an object containing window title(s) as a key and `hWnd` value(s) to be assigned to each key. This allows for passing in already known `hWnd` values. One use for this could be writing a custom function to launch several applications, saving the `hWnd` values into an array and passing them into `arrangeToGrid()`.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> As part of the `DosGroup`, any window created by Dell's `Apntex.exe` will now be ignored. This application identifies itself as a `ConsoleWindowClass` which should be restricted to DOS-like windows. It was causing things like the <kbd>Win</kbd> + <kbd>D</kbd> HotKey needing to be pressed twice, so now it is ignored.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor code cleanup for consistency.

---
# <a name="1.20170606.1">Version 1.20170606.1</a>

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `arrangeToGrid()` - arranges windows to a grid
> * `moveToMonitor()` - moves a window to the specified monitor

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `moveToMonitor()` to `moveWindow()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added an additional parameter to `pad()` to allow the padding character to be specified.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor code cleanup for consistency.

<img src='https://img.shields.io/badge/-NOTES&nbsp;&nbsp;-B10DC9.svg?colorA=B10DC9'/>

To use `arrangeToGrid()` function, a HotKey will need to be created. This function takes three parameters: `winMatch`, `dimension` and `sortByTitle`

> `winMatch` is any legal syntax for "WinTitle".
>
> See the AutoHotkey help for "WinTitle" - https://autohotkey.com/docs/misc/WinTitle.htm
> *HotScript uses the "RegEx" mode of searching for WinTitle values.*
>
> `dimension` is in the format of `CxR` (Columns and Rows) with a minimum of 1 and maximum of 4
> Any value less than 1 will be set to 1.
> Any value greater than 4 will be set to 4.
> Any values not conforming to the format of `CxR` will result in an exception being thrown.
>
> `sortByTitle` is optional and defaults to `true`. When `true`, any windows found will be arranged by according to how each of their titles would be sorted (ascending only). When `false`, any windows found will be arranged according to the z-order of each window. The z-order may be influenced by clicking on each of the windows to be arranged in the reverse order of how you would like them to be arranged. This is because the last window touched is the first to be acted upon.
>
> Typically, this function would be used to arrange a group of similar windows, such as Notepad. Below is some sample code that would arrange all instance of Notepad in a 3x2 grid across all monitors, if necessary.
>
> First, define a HotKey (put this in `HotScriptKeys.ahk`):
>
> ```js
> hotKey("^#n", "arrangeNotepad")
>```
>
> Next, create the function (put this in `HotScriptFunctions.ahk`):
>
> ```js
> arrangeNotepad() {
>     arrangeToGrid("ahk_exe i)Notepad.exe", "3x2")
> }
> ```
>
> `arrangeToGrid()` will start arranging windows on the first monitor. If more windows are found than will fit the specified grid, if other monitors are attached, they will also be used. If the number of windows found exceeds all available grid positions for all monitors, the remaining windows will not be moved/resized and will remain exactly as they were.
>
> The placement of the windows within the grid will be from top-to-bottom and left-to-right, starting with the monitor that Windows identifies as being the primary.

---
# <a name="1.20170525.1">Version 1.20170525.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following HotKeys for DOS:
> * <kbd>Ctrl</kbd> + <kbd>Down</kbd> - Scroll the screen down one line
> * <kbd>Ctrl</kbd> + <kbd>Up</kbd> - Scroll the screen up one line

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Moved the following HotKeys out of the "Action Keys" section:
> * <kbd>Win</kbd> + <kbd>A</kbd> (Toggle always-on-top) to the "Window Keys" section
> * <kbd>Ctrl</kbd> + <kbd>Win</kbd> + <kbd>A</kbd> (Toggle click-through) to the "Window Keys" section
> * <kbd>Alt</kbd> + <kbd>Apps</kbd> (Toggle desktop icons) to the "Miscellaneous Keys" section

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed the following HotKeys for DOS (these were duplicates of <kbd>Ctrl</kbd> + <kbd>PgUp</kbd> and <kbd>Ctrl</kbd> + <kbd>PgDn</kbd>):
> * <kbd>Alt</kbd> + <kbd>PgDn</kbd> (Scroll down one page)
> * <kbd>Shift</kbd> + <kbd>PgDn</kbd> (Scroll down one page)
> * <kbd>Alt</kbd> + <kbd>PgUp</kbd> (Scroll up one page)
> * <kbd>Shift</kbd> + <kbd>PgUp</kbd> (Scroll up one page)

---
# <a name="1.20170425.1">Version 1.20170425.1</a>

## HotStrings

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed `rcX#-` and `rsXYZ~#-` to properly capture the typed number.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added mouse HotKey <kbd>Back</kbd> button for going up one folder level while in Explorer.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added mouse HotKey <kbd>Forward</kbd> button for going to the previous folder while in Explorer.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `containsEol()` - return `true` if the specified string contains an end-of-line character (Windows/DOS, Unix or Mac), otherwise `false`
> * `getHwndForPid()` - returns the `hWnd` for the specified process ID
> * `group()` - convenience function to generate an "ahk_group" string
> * `isActiveExplorer()` - returns `true` if the active window is Windows Explorer, otherwise `false`

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Code refactoring using the new functions.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor code cleanup for consistency.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with <kbd>Shift</kbd> + <kbd>Win</kbd> + <kbd>NumPad7/8/9</kbd> keys being triggered as though they were <kbd>Shift</kbd> + <kbd>Win</kbd> + <kbd>NumPad4/5/6</kbd> even though the actual keys were never defined as a HotKey. This seems to be a limitation of AutoHotkey itself. Because of this issue, it will be difficult to assign user-defined HotKeys to these particular combinations.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with using <kbd>Win</kbd> + <kbd>G</kbd> when the active window is a DOS window and a process was running. The process would be terminated because HotScript tries to determine any selected text by issuing a <kbd>Ctrl</kbd> + <kbd>C</kbd>.

---
# <a name="1.20170405.1">Version 1.20170405.1</a>

## HotStrings

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed the order of repeat character from `rc#-X` to `rcX#-` which types more naturally.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed the order of repeat string from `rs#-XYZ` to `rsXYZ~#-` which types more naturally.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `getSelfHwnd()`

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added optimizations to `repeatStr()` that allow it to run faster and more efficiently when the repeat count of the string is greater than 10.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added safety checking for auto-updates of both AutoHotkey and HotScript which should prevent future errors from occurring, which at times would leave HotScript not fully functional. If HotScript detects there is something wrong with the update of either, a window will be displayed indicating the issue and a request to post a message to the forum (so it is brought to our attention and can be fixed).

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified some URLs from "http" to "https".

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor code cleanup for consistency.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed an issue with auto-updating AutoHotkey, which was caused by a change to their website.

---
# <a name="1.20170328.1">Version 1.20170328.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added mouse HotKey <kbd>Ctrl</kbd> + <kbd>Win</kbd> + <kbd>Left</kbd> button to center the mouse pointer on the current screen.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added mouse HotKey <kbd>Shift</kbd> + <kbd>Win</kbd> + <kbd>Left</kbd> button to center the mouse pointer on the current screen.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Space</kbd> to be <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Space</kbd> for deleting blank lines.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Backspace</kbd> to be <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Backspace</kbd> for sending <kbd>End</kbd>, <kbd>Backspace</kbd>, and <kbd>Down</kbd>.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>End</kbd> to be <kbd>Alt</kbd> + <kbd>End</kbd> for sending <kbd>Up</kbd>, <kbd>End</kbd>, and <kbd>Delete</kbd>.

## HotStrings

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `rc#-X` to repeat a character any number of times. The HotString trigger breaks down as follows:  
>
>     rc  -->  repeat character
>     #   -->  any positive number 1..9999999
>     -   -->  any symbol or whitespace separator (see below for valid choices)
>     X   -->  the letter to be repeated
>
> It is necessary to have some type of separator between the number and the character because the character itself may be a number and there would be no way to distinguish between the number of times to repeat and the actual character to repeat.
>
> ### Valid Separators
>
>     symbols   :  `~!@#$%^&*()-_=+[]{};:'",.<>/?
>     whitespace:  Space, Tab, or Enter
>
> **Note:** when repeating values above 1 million times, it will take longer to produce the string, which depends on the speed of your computer -- be patient.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `rs#-XYZ~` to repeat a string any number of times. The HotString trigger breaks down as follows:
>
>     rs  -->  repeat string
>     #   -->  any positive number 1..9999999
>     -   -->  any symbol or whitespace separator (see above for valid choices)
>     XYZ -->  the string to be repeated (may contain any characters, except ~)
>     ~   -->  To signal the end of the string, the ~ character was chosen
>
> It is necessary to have some type of separator between the number and the start of the string because the string itself may start with a number and there would be no way to distinguish between the number of times to repeat and the first character of the string.
>
> It is not possible to paste any text into this HotString.
>
> **Note:** when repeating values, that larger the string, the longer it will take to produce the final string, which depends on the speed of your computer -- be patient. Also, it is easy to run out of memory trying to repeat a large string many times.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> For HotStrings in DOS, they were not getting properly reset when <kbd>ESC</kbd> was pressed which would result in the HotString not being executed when it should.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> `hsRepeatString()` - Associated with built-in HotString `rs#-XYZ~`
> `runCapture()` - Runs a DOS command, captures the output and returns it

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified isProcessSuspended() to hopefully execute slightly faster.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified runTarget() to more often be successful in activating the newly launched application. The PID for the launched application will now be returned by the function.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added additional information to help screen to differentiate when to scroll the mouse wheel and when to tilt the mouse wheel. Open-ended arrows are used to indicate mouse wheel activity, whereas closed-ended arrows represent keys to be pressed.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified the URL for Google Image Quick Lookup from `http://images.google.com/images?q=@selection@` to `https://www.google.com/search?q=@selection@&tbm=isch`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified all Google/YouTube URLs for Quick Lookup to use `https`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Corrected the arrows on the help screen for scrolling left/right <kbd>Ctrl</kbd> + <kbd>WheelUp</kbd> and <kbd>Ctrl</kbd> + <kbd>WheelDown</kbd>. The previous arrows were pointing in the wrong direction.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Adjusted some of the colors of the help screen.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor code cleanup for consistency.

---
# <a name="1.20170305.1">Version 1.20170305.1</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added tray menu option for launching the HotScript live chat in the default browser.

---
# <a name="1.20170304.1">Version 1.20170304.1</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added tray menu option for launching the HotScript forums in the default browser.

---
# <a name="1.20170303.2">Version 1.20170303.2</a>

## Functions

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Fixed issue with `centerMouse()` not calculating correct center when using multiple monitors.

---
# <a name="1.20170303.1">Version 1.20170303.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>CapsLock</kbd> to center the mouse pointer on the current screen.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Shift</kbd> + <kbd>CapsLock</kbd> to center the mouse pointer in the current window.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `centerMouse()` - centers the mouse either on the screen or within a window
> * `hkMiscCenterMouseScreen()` - Associated with built-in HotKey <kbd>Ctrl</kbd> + <kbd>CapsLock</kbd>  
> * `hkMiscCenterMouseWindow()` - Associated with built-in HotKey <kbd>Shift</kbd> + <kbd>CapsLock</kbd>

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified the function signature of `MouseClickDrag()` and `MouseMove()` to use `relative` as a boolean flag instead of `R`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed very minor typo in `showWindowInfo()`.

---
# <a name="1.20170302.1">Version 1.20170302.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Delete</kbd> to delete text to the start of the line. This also works in DOS.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Backspace</kbd> to delete the last character on a line and move the cursor down one line.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>End</kbd> to join lines of text by sending <kbd>Up</kbd> + <kbd>End</kbd> + <kbd>Delete</kbd>. This works if the cursor is on the first line, last line, or any place within text. Pressing the HotKey repeatedly will eventually join all lines.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified <kbd>Ctrl</kbd> + <kbd>Delete</kbd> when used in Microsoft Word to be one character less, which is necessary to avoid deleting a paragraph marker. It should still function as expected even if the current line does not have a paragraph marker.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Removed <kbd>Ctrl</kbd> + <kbd>Delete</kbd> from "DOS Keys" of help screen. It still works the same, but was redundant to the same entry in "Text Keys".

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> * Added the following functions:
> * `hkTextDeleteToSol()` - Associated with HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Delete</kbd>
> * `hkTextEndBackspaceDown()` - Associated with HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Backspace</kbd>
> * `hkTextUpEndDelete()` - Associated with HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>End</kbd>

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed `hkDosDeleteToEol()` and moved the functionality into `hkTextDeleteToEol()`.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added window group for Microsoft Word (MSWordGroup) and for Microsoft Excel (MSExcelGroup).

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Moved some sections around on the help screen to allow for future entries on some of the more popular/active sections.

---
# <a name="1.20170226.1">Version 1.20170226.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>M</kbd> to uppercase MySQL keywords and functions for any selected text.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `upperCaseMySql()` - For the selected text, any MySql keywords are converted to uppercase
> * `upperCaseSqlWords()` - shared function for `upperCaseMySql()` and `upperCaseOracle()`

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Refactored the common parts of `upperCaseOracle()` into `upperCaseSqlWords()`.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added configuration option `mySqlTransformRemainderToLower` which will set to lowercase any text that was selected that is not a MySql keyword or function.

---
# <a name="1.20170225.1">Version 1.20170225.1</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Corrected issue with `hotString()` where some regex-based HotStrings were not working properly.

---
# <a name="1.20170206.3">Version 1.20170206.3</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>.</kbd> to delete whitespace at the end of each line of text that is selected. If no text is selected, all text will automatically become selected, then whitespace
will be deleted.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Space</kbd> to delete all blanks lines from text that is selected. If no text is selected, all text will automatically become selected, then blank lines will be deleted.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the necessary support functions for resizing windows to `1x4`, `2x4`, `4x1` and `4x2`.

## Miscellaneous

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Corrected the dimension calculations associated with 2x4 and 4x2.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed bug introduced in [1.20170205.1](#1.20170205.1) where anything relying on isActiveDos() would not function properly. This was most noticeable with HotStrings not working in DOS.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed bug introduced in [1.20170119.1](#1.20170119.1) where many of the window resizing HotKeys would not move/resize the window, but would instead paste the name of the function related to the HotKey.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed a very old bug where typing the trigger of a HotString that ends with a Tab character, HotScript would go into an infinite loop of holding down the <kbd>Shift</kbd> and <kbd>Left</kbd> keys. This has been changed to ignore the HotString (only when it ends in a Tab character and only when in a DOS window). It seems far more likely the intent from the user would be filename/directory completion.

---
# <a name="1.20170205.1">Version 1.20170205.1</a>

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * deepCopy() - creates a deep copy of an object or array
> * equals() - used to check two variables for equality
> * equalsIgnoreCase() - used to check two variables for equality, ignoring case for strings
> * getHwnd() - gets the handle of a window
> * getWindowInfo() - gets information for a window
> * merge() - merges an object or array with the specified values
> * mergeArray() - merges an array with the specified values
> * mergeObject() - merges an object with the specified values
> * isWindowVisible() - returns true if the specified window is visible
> * toHex() - converts an integer value into its equivalent hex value

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added window resizing dimensions: `1x4`, `2x4`, `4x1` and `4x2`. There is not a HotKey for these because there are no remaining good combinations to be used. There is however a feature in the works to allow for easily choosing screens dimensions which will free up most of the HotKeys currently used by window resizing/positioning. Stay tuned! You may create a HotKey for any of these new options.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added much more information to showWindowInfo().

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `getActiveMonitor()` to `getMonitorForWindow()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `contains()` to handle arrays and objects. This also affects `containsIgnoreCase()`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed a minor formatting bug with `toString()`.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Refined the help screen to combine similar HotKeys to use less space. Improved consistency for HotKeys that have more than one combination. Better use of colors. The more complex HotKeys should be easier to understand. It is just a quick help screen and not meant to be full documentation.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Some internal refactoring for consistency and reliability.

---
# <a name="1.20170119.1">Version 1.20170119.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> New HotKeys for wrapping text in symbols. Previous only a few symbols were supported: `[] {} () <> ' "`. Now all symbols from the US keyboard are supported: ` `` ~ ! @ # $ % ^ & * () - _ = + [] {} \ | ; : ' " <> , . / ?`. The HotKeys are <kbd>Ctrl</kbd> + <kbd>Win</kbd> + <kbd>SYMBOL</kbd> for wrapping all of the selected text (or just the current line if no text is selected), or <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>SYMBOL</kbd> for wrapping each individual line. As a result the previously defined HotKeys for wrapping text have been changed.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Insert</kbd> as an additional HotKey for "Copy Append". The existing HotKey of <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>C</kbd> still works. The reason for the new one is for long-time users of DOS where we learned <kbd>Ctrl</kbd> + <kbd>Insert</kbd> (copy) and <kbd>Shift</kbd> + <kbd>Insert</kbd> (paste). Some habits cannot be changed! FYI - these legacy HotKeys are still supported by Windows (thankfully).

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed HotKey for escaping text for AHK from <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>\`</kbd> to <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>\`</kbd>.

## HotStrings

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@bullet` to generate a bullet character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@club` to generate a club character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@copy` to generate a Copyright character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@diam` to generate a diamond character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@ellip` to generate a ellipsis character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@heart` to generate a heart character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@mdash` to generate a MDash character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@ndash` to generate a NDash character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@reg` to generate a Registered character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@spade` to generate a spade character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@tm` to generate a Trademark character.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@uniXXXX` to generate the Unicode character represented by the hex value XXXX.

## Functions

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Consolidated functionality of several "one-off" functions into `hkTransformWrap()`. This function now handles all traditional symbols that have keys on a standard US keyboard.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed obsolete functions:
> * `hkTransformWrapEachInBrackets()`
> * `hkTransformWrapEachInCurlys()`
> * `hkTransformWrapEachInParenthesis()`
> * `hkTransformWrapEachInDoubleQuotes()`
> * `hkTransformWrapEachInSingleQuotes()`
> * `hkTransformWrapEachInTags()`
> * `hkTransformWrapInBrackets()`
> * `hkTransformWrapInCurlys()`
> * `hkTransformWrapInParenthesis()`
> * `hkTransformWrapInDoubleQuotes()`
> * `hkTransformWrapInSingleQuotes()`
> * `hkTransformWrapInTags()`

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed a bug with `output()` that would cause any thread that called it to stop working.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed a bug with `runFunction()` and `showVariable()` that would (rarely) cause the buttons displayed on the dialog to be in the wrong location or the wrong size.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Refined the help screen to show better information (color, symbols, etc) using less space. As a result, the help screen is now a little smaller, allowing it to fit onto laptop displays (1366x768) without being cut off.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified the configuration for HotKeys that have more than one HotKey associated to it. The entries were written as `hkWindowLeft-1` and `hkWindowLeft-2`, but are now written as `hkWindowLeft-01` and `hkWindowLeft-02` to allow them to be sorted properly in the `HotScriptDefault.ini` file.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor code cleanup.

---
# <a name="1.20170110.1">Version 1.20170110.1</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added tray menu option for checking for a new version of HotScript. This is different than the automated daily check because it will always compare the current version against the latest version even if the automated check has already run for the day. The automated check runs once once per day.

---
# <a name="1.20170109.1">Version 1.20170109.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>F12</kbd> to run an internal function. This is primarily for debugging your own functions but may have other uses. It is still experimental and does not (yet) support parameters.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `output()` - Displays the specified string in a window
> * `runFunction()` - Executes a function by name (does not yet support parameters)

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed `message()` to return the name of button that was clicked, which eliminates the need to use `IfMsgBox`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed an issue with `centerControls()` being unable to detect windows whose title contains certain symbols. This would cause the controls to be incorrect displayed in the dialog.

---
# <a name="1.20161229.1">Version 1.20161229.1</a>

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added support to `menuBuilder()` for menus to automatically include an icon if the corresponding function name is defined. A different icon can show for when the function is defined as well as for when it is not. Within the primary menu object, use the `runIcon` and `warnIcon` boolean flags to enable displaying the icons.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed a minor cosmetic issue in `menuBuilder()` where the primary menu color would increment by one for each time the menu was shown instead of always showing the first defined color.

---
# <a name="1.20161228.1">Version 1.20161228.1</a>

## HotStrings

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed the comment header for Perl and SQL to use the correct indentation.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * isArray() - returns `true` if the specified value is an array
> * isEmpty() - returns `true` if an empty string or empty object/array
> * menuBuilder() - takes an object parameter describing the menu to be built and creates it
> * menuHandler() - companion to `menuBuilder()`, it handles all actions of the menu dynamically calling functions
> * toSafeName() - used by `menuBuilder()` to generate dynamic, yet safe, function names for each menu item

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `toString()` to use the correct brackets for the object type, when applicable:
`[]` for array, `{}` for objects and `<>` for all other objects. **Note:** empty arrays cannot be
properly detected and will show as empty objects.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Add a constant `hs.const.MENU_COLORS` for menu colors. There are seven pre-defined colors:
> * yellow (FFFEE3)
> * blue (D7DEEF)
> * red (FFE2E3)
> * green (D9F4DC)
> * purple (E4D6EF)
> * cyan (D2EAEC)
> * orange (FFE3D1)

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified the creation of `HotScriptFunctions.ahk`, `HotScriptKeys.ahk`, `HotScriptStrings.ahk`, and `HotScriptVariables.ahk` to use correct Windows line ending characters (CRLF) instead of Unix/Linux line-endings (LF).

---
# <a name="1.20161014.1">Version 1.20161014.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified the behavior of `checkVersions()`, because as of version 1.1.24.02, AutoHotkey has changed the filename of their installation file. This was causing HotScript to fail when it detected a new version of AutoHotkey to be installed. Previously, new versions of AutoHotkey were named like `AutoHotkey112401_Install.exe` but is now available as `AutoHotkey_1.1.24.02_setup.exe`. For existing users of HotScript, the best solution for now is to manually download and install the new version of AutoHotkey and then manually install the new version of HotScript. While this should only affect a small number of users, it is inconvenient. This should no longer happen regardless of the name of the AutoHotkey installation. Further verification checks are being done to validate that any new version of AutoHotkey that is downloaded is a valid file.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed action for DOS HotKey <kbd>Alt</kbd> + <kbd>Up</kbd> (or <kbd>Alt</kbd> + <kbd>.</kbd>) to run `cd ..` instead of `cd..`.  Linux/Unix wants the space between the `d` and `.` whereas DOS did not care. This is helpful for DOS windows running SSH (like Putty) to access a Linux/Unix server.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added some additional checking with Delete Word `Ctrl-D` to determine is Microsoft's Visual Studio Code is the active Window. If so, need to treat it differently because <kbd>Ctrl</kbd> + <kbd>C</kbd>, from `getSelectedText()`, will copy the entire line if there is no selection. This is a temporary workaround until a better solution can be found.

## Functions

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `findOrRunByExe()` to `findAndRun()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Moved error logic from `hkActionWindowsSnip()` to `findAndRun()`.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed unnecessary functions:
> * `StringLower()`
> * `StringUpper()`

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Made a minor change to the help screen for to indicate that no additional modifier key is required for "Row 1" on HotKeys that resize the window to `3x4`, `4x3` and `4x4`.

---
# <a name="1.20160711.1">Version 1.20160711.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Restored original functionality of <kbd>Alt</kbd> + <kbd>Down</kbd> within Windows Explorer. Previously it was trying to execute the functionality for "Move line down", but this made no sense in Explorer.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Restored original functionality of <kbd>Alt</kbd> + <kbd>Up</kbd> within Windows Explorer. Previously it was trying to execute the functionality for "Move line up", but this made no sense in Explorer.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Restored original functionality of <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> within Windows Explorer. Previously it was trying to execute the functionality for "Encrypt text", but this made no sense in Explorer.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Restored original functionality of <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>N</kbd> within Windows Explorer. Previously it was trying to execute the functionality for "Auto-Number (1)", but this made no sense in Explorer.

## Functions

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `message()` to accept `title`, `options` and `timeout`. These have default values, so no changes are required for existing usages.
<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with auto-update not working correctly.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified to run with admin privileges because of a few small writes to the registry. This eliminates the need to modify the shortcut to allow access.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> The Windows link (shortcut) file to auto-run HotScript will now only be created if it does not exist instead of every time HotScript is executed or reloaded.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified the URL pointing to GitHub from `release` to `master`. This should have no effect as both branches were kept in sync. Eventually `release` will be phased out and a new `beta` branch may be available for anyone interested in using the latest and greatest development version (which is what I use everyday). This will be an opt-in setting eventually.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified the help screen from `Level 1-4` to read `Row 1-4` to help clarify the meaning as the optional modifier keys for resizing `3x4`, `4x3` and `4x4`.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed some old, commented out code.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

Added missing reference to "$" in the documentation within `HotScriptKeys.ahk`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed minor issue in the documentation within `HotScriptKeys.ahk` that incorrectly referred to HotStrings.

---
# <a name="1.20160710.1">Version 1.20160710.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added window resizing dimensions: `1x3`, `2x3`, `3x1`, `3x2`, `3x4`, `4x3`, and `4x4`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added window resizing options for resizing to max height or max width. With multiple monitors, these functions will toggle between resizing between the current monitor and all monitors. The HotKeys are <kbd>Shift</kbd> + <kbd>Win</kbd> + <kbd>Left</kbd> + <kbd>Right</kbd> for resizing to max width and <kbd>Shift</kbd> + <kbd>Win</kbd> + <kbd>Up</kbd> + <kbd>Down</kbd> for resizing to max height. It is necessary to press both arrow keys **SIMULTANEOUSLY** or this HotKey will not be triggered. This is different than the existing HotKeys resizing to `2x2`, where you may press <kbd>Shift</kbd> + <kbd>Win</kbd> + <kbd>ARROW1</kbd> then <kbd>ARROW2</kbd> separately (but still holding the others).

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>MouseWheelUp</kbd> and <kbd>Ctrl</kbd> + <kbd>MouseWheelDown</kbd> to scroll horizontally left/right, respectively.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>D</kbd> to delete from the current cursor position to the next word. It is important to note that different applications treat <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Right</kbd> somewhat differently. As much as possible, consistency was implemented to overcome this. To see some of the differences between applications, see the comments in `hkTextDeleteWord()`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with <kbd>Ctrl</kbd> + <kbd>Delete</kbd> where it was not issuing the correct keystrokes to delete the text.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

>  Added the following functions:
> * extractLocationAndResize() - Responsible for moving and resizing windows to a grid position
> * getSelf() - returns the name of the function; increase the number to identify further up the call chain
> * getStackTrace() - generates a stacktrace message
> * horizontalScroll() - scrolls a window left or right horizontally
> * isActiveCalculator() - returns `true` if the active window is Windows Calculator
> * isWord() - returns `true` if the specified string contains only word characters (letters, digits, and underscores)

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `getVarType()` to better distinguish between a string and a function.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `runTarget()` to wait for the application for 1 second instead of indefinitely.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `isCalculatorNotActive()` to `isNotActiveCalculator()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `toString()` to more accurately display the name of a function.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed `resizeTo()`. It was replaced with `extractLocationAndResize()`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

>  Fixed a small bug in `toString()` where labels were not being processed correctly.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified wait time of `ClipWait()` from 0.5 seconds to 0.05 seconds. This increases the speed of several operations like swapping selection with the clipboard, appending to the clipboard, getting the selected text and pasting text. These same operations are used by other functions as well as some HotKeys.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Throughout HotScript, when searching for named applications, they are no longer case-sensitive.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> The help screen is now created (internally) only once instead of everytime it is displayed.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> The help screen will now be displayed on the active monitor instead of only the primary monitor.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor code cleanup and changes for consistency.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Delete</kbd> (Delete to end-of-line) to the help screen. This HotKey had been implemented for quite a while, but was erroneously omitted from the help screen.

---
# <a name="1.20160619.1">Version 1.20160619.1</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> After upgrading to a new version of HotScript, a dialog will be displayed asking if the list of changes should be displayed. This is only applicable if `enableVersionCheck` is set to `true`. This will take effect for versions later than this one.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added brief (2 second) notification that HotScript is being upgraded to a new version. This is only applicable if `enableAutoUpdate` is set to `true`. This will take effect for versions later than this one.


<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue broken in [1.20160618.1](#1.20160618.1) where user configuration values would be incorrectly removed from `HotScriptUser.ini`.

---
# <a name="1.20160618.1">Version 1.20160618.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Win</kbd> + <kbd>/</kbd> to display information about the current window.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> All HotKeys are now defined using `hotKey()` instead of the manner expected by AHK.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added `768x1024` and `custom` options to the Quick Resolution menu.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>,</kbd> and <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>.</kbd> not working.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified auto-update to download to a temporary filename instead of HotScript.ahk and to test the integrity of the file. This was necessary because occassionally GitHub may be unavailable and the downloaded file would actually be GitHub's HTML error page.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added configuration value to save the last date that a new version was checked for. This allows HotScript to now only search for a new version once per day instead of every reload.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Increased MaxHotkeysPerInterval (currently every 2 seconds) from 200 to 500.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Refactored the code for creating the help screen to only generate the content once, which should allow the screen to not only be displayed faster, but also may fix the issue with the help screen randomly appearing as blank.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Miscellaneous code cleanup.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed obsolete configuration values for `inputBoxFieldFont` and `inputBoxOptions`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with `enableHsVariables` not being saved properly.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

Fixed issue with some configuration values being saved to `HotScriptUser.ini` when they should not.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `centerControls()` - 
> * `clipboardAppend()` - Copies or cuts the selected text to any text already on the Windows clipboard
> * `debugVar()` - Shows a global variable's value
> * `hotKey()` - Dynamically registers a HotKey
> * `showWindowInfo()` - Shows information about the specified window; used by HotKey <kbd>Win</kbd> + <kbd>/</kbd>

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Refactored `ask()` to support multi-line input as well as regular or monospace font.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Refactored `registerHotkey()` into `hotKey()`, with better support for conditions and parameters.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `centerWindow()` to be able to specify the monitor number for which to center the window.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `checkVersions()` only execute once per day.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added an `options` parameter to `FileRead()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added a parameter to `resizeWindow()` to indicate if the window should be centered after resizing it.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Refactored `toString()` to eliminate the depth restriction for objects and to indicate if a value is a
function or label.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed the wrapper function `StringReplace()`, because AHK has a built-in function called `StrReplace()`.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed old migration code for version 1.20131211.2.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed `isWindow()`.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed `resizeToResolution()`. It was redundant to `resizeWindow()`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with `getIndent1()` sometimes returning an empty string. It now will always return some value.

---
# <a name="1.20160406.3">Version 1.20160406.3</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with endless loop restarting/updating. The version file was updated but the internal version was not, so HotScript thought there was always a newer version to be downloaded.

---
# <a name="1.20160406.2">Version 1.20160406.2</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added a constant `hs.const.INDENT` for a default indent of 4 spaces.

## Functions

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `getIndent()` to check if the active window is a DOS window. If so, it will use the new default constant value of 4 spaces, otherwise it will try to determine the indent level from the active window.

---
# <a name="1.20160406.1">Version 1.20160406.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>A</kbd> to sort the selected text as case-sensitive in ascending order.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd> to sort the selected text as case-sensitive in descending order.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>A</kbd> to (sort the selected text in ascending order) to be as case-insensitive.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd> to (sort the selected text in descending order) to be as case-insensitive.

## HotStrings

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed the auto-correct HotString of `[a-z]L` to now be restricted to a word boundary, so that typing values such as `StrLen` will no longer cause the HotString to be triggered.

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added missing HTML tag `thead` to HotString help screen.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor code cleanup.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `compareStrAscNoCase()` - compares two strings in ascending order as case-insensitive

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Numerous minor refinements to several of the `hsXxxYyy()` functions to produce better output, especially within editors that have varying degrees of sophistication (or a complete lack of, such as Notepad).

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `getIndent()` to handle different editors, producing a much more reliable determination of the current indentation level.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with `hsCodeFunction()`, used by the `func(` HotString, not replacing `func` with `function`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with `hsCommentHeaderPerl()` and `hsCommentHeaderSql()` leaving the cursor on the wrong line.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed `getIndent()` where if the start of a line contained more than only whitespace, the wrong indent value was being used.

---
# <a name="1.20160404.1">Version 1.20160404.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> The HotKey <kbd>Win</kbd> + <kbd>Pause</kbd> was incorrectly wrapped by the `enableHkMisc` variable. If this variable was disabled, the <kbd>Win</kbd> + <kbd>Pause</kbd> HotKey (which pauses HotScript) would not be enabled. This is the only HotKey that is hard-coded and cannot be user-modified. While the <kbd>Win</kbd> + <kbd>Pause</kbd> HotKey could be overridden by some other function, it is not (currently) possible to reassign HotScript's pause function to another key combination due to the restrictions of AHK's `Suspend` command.

## HotStrings

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed the auto-correct HotString of `cL` to now include all drive letters (a-z).

## Variables

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added `replaceMode` to the `hs.const` object.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Made the `$` variable to be truly global. This variable is populated by hotString() when using regular expression HotStrings. Do **NOT** use this variable name for your own values.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `getIndent()` - Returns the amount of whitespace indentation for the current line
> * `getIndent1()` - Returns one indentation level of whitespace; typically used with the value from `getIndent()`
> * `hsCodeBlock()` - Used to complete `for(`, `if(`, and `while(` HotStrings 
> * `hsCodeElseIf()` - Used to complete `elif` HotString
> * `hsCodeFunction()` - Used to complete `func(` HotString
> * `hsCodeIfElse()` - Used to complete `ifel` HotString
> * `hsCodeStringFormat()` - Used to complete `sf.` HotString
> * `hsCodeSwitch()` - Used to complete `switch(` HotString
> * `hsCodeSysOut()` - Used to complete `sysout` HotString
> * `hsCommentHeaderHtml()` - Used to complete `chh` HotString
> * `hsCommentHeaderJava()` - Used to complete `chj` HotString
> * `hsCommentHeaderPerl()` - Used to complete `chp` HotString
> * `hsCommentHeaderSql()` - Used to complete `chs` HotString
> * `hsHtmlA()` - Used to complete `<a` HotString
> * `hsHtmlComment()` - Used to complete `<!-` HotString
> * `hsHtmlHeader()` - Used to complete `<h(1-6)` HotString
> * `hsHtmlHtml()` - Used to complete `<html` HotString
> * `hsHtmlInput()` - Used to complete `<input` HotString
> * `hsHtmlLink()` - Used to complete `<link` HotString
> * `hsHtmlList()` - Used to complete `<ol` and `<ul` HotStrings
> * `hsHtmlOptGroup()` - Used to complete `<optg` HotString
> * `hsHtmlSelect()` - Used to complete `<select` HotString
> * `hsHtmlSource()` - Used to complete `<source` HotString
> * `hsHtmlStyle()` - Used to complete `<style` HotString
> * `hsHtmlTable()` - Used to complete `<table` HotString
> * `hsHtmlTagAbbr()` - Used to complete `<but`, `<cap`, `<field`, `<foot`, `<opti`, and `<sum` HotStrings
> * `hsHtmlTagBlock()` - Used to complete `<block`, `<body`, `<div`, `<form`, `<header`, `<hgroup`, `<script`, `<section`, `<tbody`, `<tfoot`, and `<thead` HotStrings 
> * `hsHtmlTagFor()` - Used to complete `<label` HotString
> * `hsHtmlTagNoEndChar()` - Used to complete `<b`, `<head`, `<i`, `<li`, `<p`, `<q`, `<th`, and `<u` HotStrings
> * `hsHtmlTagSimple()` - Used to complete `<big`, `<code`, `<del`, `<em`, `<legend`, `<pre`, `<small`, `<span`, `<strong`, `<sub`, `<sup`, `td`, and `<title` HotStrings
> * `hsHtmlTagSrc()` - Used to complete `<iframe` and `<img` HotStrings
> * `hsHtmlTextarea()` - Used to complete `<texta` HotString
> * `hsHtmlTr()` - Used to complete `<tr` HotString
> * `hsJiraCode()` - Used to complete `{code`, `{java`, `{js`, `{sql` and `{xml` HotStrings
> * `hsJiraColor()` - Used to complete `{color` HotString
> * `hsJiraNoFormat()` - Used to complete `{nof` HotString
> * `hsJiraPanel()` - Used to complete `{bpan` `{gpan`, `{pan`, `{rpan` and `{ypan` HotStrings
> * `hsJiraQuote()` - Used to complete `{quo` HotString
> * `hsJiraSpecialPanel()` - Used to complete `{info`, `{note`, `{tip` and `{warn` HotStrings
> * `hsJiraTable()` - Used to complete `{table` HotString

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Swapped position of `clear` and `condition` in the function definition of `hotString()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `hsBackInX()` to `hsAliasBackInX()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `sendJiraCode()` to `hsJiraCode()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `sendJiraPanel()` to `hsJiraPanel()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `sendJiraSpecialPanel()` to `hsJiraSpecialPanel()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `templateJiraTable()` to `hsJiraTable()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor change to prepended text in `debug()`.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed obsolete function `hkToStr()`.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added a link on the help screen to open the HotScript home page in the default browser.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added an option on the tray icon to display the help screen.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Refactored all internal HotStrings to use `hotString()` instead of the mechanism used by AHK. This will help with some future changes as well as reducing the amount of code. It should now be possible to define any HotString using `hotString()`, which can have much more flexibility than offered by AHK. I strongly recommend converting your existing user-defined HotStrings to use this new method. When using `hotString()`, `addHotString()` no longer needs to be called to update the metrics.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Rearranged the help screen for HotStrings.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Trying to fix a bug when showing the help screen. Randomly the screen will show without the text displayed. If you click and drag with the mouse, the text will show. Still working on this issue, but it seems better.

---
# <a name="1.20160326.1">Version 1.20160326.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>C</kbd> to copy/append text to the clipboard. This does NOT work for files.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>V</kbd> to swap the currently selected text into the clipboard, replacing the selected text with the previous contents of the clipboard.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>X</kbd> to cut/append text to the clipboard. This does NOT work for files.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Win</kbd> + <kbd>ARROW</kbd> to move the current window to the edge of the screen, without resizing it.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Win</kbd> + <kbd>M</kbd> to run Character Map.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>H</kbd> to run Windows Explorer in the HotScript folder.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>S</kbd> to run Windows Explorer in the Startup folder.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Win</kbd> + <kbd>`</kbd> to run DebugView.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified the HotKeys for dragging the mouse from <kbd>Ctrl</kbd> + <kbd>Win</kbd> + <kbd>ARROW</kbd> to <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>ARROW</kbd> to avoid collision with the new "Move to Edge" HotKeys.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Moved the HotKey definitions for dragging the mouse into the appropriate section `Miscellaneous`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed HotKey for "Toggle Minimized" from <kbd>Win</kbd> + <kbd>M</kbd> to <kbd>Ctrl</kbd> + <kbd>Win</kbd> + <kbd>M</kbd>.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed HotKey <kbd>Win</kbd> + <kbd>V</kbd> (Preview Clipboard) to indicate if the data is complex and therefore cannot be previewed.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added back previous error checking when running Snipping Tool via <kbd>Win</kbd> + <kbd>PrintScreen</kbd> for Windows 2008 but also added checking for Windows 2012.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Deleted the `hkCustom` HotKey section (and configuration setting), moving the only remaining entry into the hkText section.

## HotStrings

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@dob` to use the variable `MY_DOB`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@pw` to use the variable `MY_PASSWORD`. The value is encrypted using the same function as <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> and will be unencrypted when this HotString is used.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@w` to use the variable `MY_WORK_EMAIL`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotStrings for the following fractions: `1/6`, `1/5`, `2/8`, `2/6`, `2/5`, `2/4`, `3/6`, `4/8`, `3/5`, `4/6`, `6/8`, `4/5`, and `5/6`. Some fractions may be reduced are will therefore use the reduced fraction, for example: `4/8` will return the fraction for `1/2`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed trigger for fractions to start with some type of separator (`3 1/2` instead of `31/2`).

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed several HotStrings (`@addr`, `@ip`, `@me`, `@sig`) to be case-sensitive.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed how fraction HotStrings are defined; they now use `hotString()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed how date and time HotStrings are defined; they now use `hotString()`.

## Variables

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added global variable `MY_DOB`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added global variable `MY_PASSWORD`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added global variable `MY_WORK_EMAIL`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added configuration setting `enableHsVariables` for enabling/disabling HotStrings for HotScript `MY_xxxxxx` variables.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Any `MY_xxxxxx` variables (in `HotScriptVariables.ahk`) will now be automatically added with a default value if they are missing. This means that there is no longer a need to manually edit this file to add new variables that will be supported in future versions of HotScript, but this file will still need to be edited by the user to provide the appropriate real values to be used.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `getActiveProcessID()` - Returns the PID for the active process
> * `getActiveProcessName()` - Returns the name for the active process
> * `getDateString()` - Returns the current date in the format of `MM/DD/YYYY`
> * `getDayString()` - Returns the name for the current day of the week
> * `getDddString()` - Returns the three-letter abbreviation for the current day of the week
> * `getDtmsString()` - Returns `getDtsString()` + `_` + `getTmsString()`
> * `getDtsString()` - Returns the current date stamp in the format of `YYYYMMDD`
> * `getMmmString()` - Returns the three-letter abbreviation for the current month
> * `getMonthString()` - Returns the name for the current month
> * `getNowString()` - Returns `getDateString()` + ` at ` + `getTimeString()`
> * `getTimeString()` - Returns the current time in the format of `HH:MM:SS` (24-hour)
> * `getTmsString()` - Returns the current time stamp in the format of `HHMMSS` (24-hour)
> * `isActiveDos()` - Returns `true` if the active window is part of `DOSGroup`
> * `isCalculatorNotActive()` - Return `true` if the active window is not Windows Calculator
> * `moveToEdge()` - Moves a window to either the top, bottom, left, or right edge of the screen
> * `pad()` - Adds padding to either the left or right side of a string value
> * `parseTemplate()` - Replaces tokens with actual values within a template

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added support for user-defined initialization function called `userInit()`. Because of how AutoHotkey works, do not define HotKeys or HotStrings within the `userInit()` function. These should be placed in `HotScriptKeys.ahk` or `HotScriptStrings.ahk`. Failure to do so will almost certainly cause significant parts of HotScript to stop functioning.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `toBool()` to return `true` if the value is a number and greater than zero.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `hotString()` to use any return value from a named function as the replacement text.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Renamed `showDebugVar()` to `showVariable()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Improved output of `showVariable()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Improved output of `toString()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Enhanced output of `templateHtml()`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `resizeTo()` for Windows 10. This affects all window movement HotKeys. Windows 10 puts transparent borders around non-maxmimied windows along the left, right and bottom of a window. When these windows line up next to each other, "gaps" appear which show whatever is underneath the windows. I found this quite annoying, so the math was changed for Windows 10 to accommodate these gaps. The coordinates are adjusted as follows:  X +6, Y +1, Width +16, Height +9.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added "Historical changes" to the HotScript tray menu.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Huge refactor of the help screen! To switch between tabs with keyboard use <kbd>Ctrl</kbd> + <kbd>PgUp</kbd> or <kbd>Ctrl</kbd> + <kbd>PgDn</kbd>. Press <kbd>ESC</kbd> to close.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed configuration setting for `enableAutoUpdate` from `false` to `true`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added `#32770` (Open/Save dialog) as a member of the `ExplorerGroup`.

---
# <a name="1.20151030.2">Version 1.20151030.2</a>

## HotStrings

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with the `bi##` HotString not displaying the `##`.

---
# <a name="1.20151030.1">Version 1.20151030.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>D</kbd> to create a folder (directory) in Explorer or on the desktop.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>F</kbd> to create a file in Explorer or on the desktop.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Alt</kbd> + <kbd>Win</kbd> + <kbd>D</kbd> to open a DOS window to the current path in Explorer, if it is the active Window.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * createNewInExplorer() - Creates either a new file or directory within Windows Explorer
> * createNewOnDesktop() - Creates either a new file or directory on the Windows Desktop
> * getExplorerPath() - Returns the current path being viewed within Windows Explorer
> * getUniqueNewName() - Given a base name, will return a guaranteed unique file or directory name (prevents duplicates)
> * selectInExplorer() - Selects item(s) within Windows Explorer
> * selectOnDesktop() - Selects item(s) on the Windows Desktop

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Improved the ability to launch Explorer via Win-X. Now it will activate an existing window, if it exists but is not focused. The default starting location will be the root of the `SystemDrive` (as defined by Windows) instead of `C:\`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Modified `runDos()` to accept a `path`, which will be the active directory when DOS is executed.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Increased sleep time from 100ms to 250ms when launching an application to allow more time for the window to exist. This may help with certain issues where the application is launched, but is not activated (focused).

---
# <a name="1.20151027.1">Version 1.20151027.1</a>

## HotStrings

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@me` to use the variable `MY_NAME`

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@sig` to use the variable `MY_SIGNATURE`

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `#/#%` which divides two numbers and returns the result as a percent

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `#%#` which returns the percentage of the first number in relation to the second number

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `lmk`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `vg`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Internal changes to `@ip` to allow it to be easily overridden with a custom function

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added a `.` to the end of some of the aliases on the help screen to signify that an ending character is needed

## Variables

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added global variable `MY_NAME`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added global variable `MY_SIGNATURE`.

## Functions

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor change within `hotString()` to call `addHotString()` only if any conditional function returns true

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor renaming of variables and optimization within `hotString()`

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed `GetKeyState()` because it now conflicts with AutoHotkey's internal function with the same name

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed `getHotKeySections()` because it was an obsolete function from a very old version

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added missing HotString `@#` to the help screen

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Minor internal changes to how the headers of the `HotScript-*.ahk` files are written

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added additional information to the headers of `HotScript-Strings.ahk` to include dynamic HotStrings

---
# <a name="1.20151018.1">Version 1.20151018.1</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey `Win`+`0` to launch the HotScript homepage.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added smarter control to `Win`+`G` to allow running of files/directories (if they exist) or UNC paths.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Swapped `Win`+`6` and `Win`+`8` to allow `Win`+`8` and `Win`+`9` to be next grouped together.

## HotStrings

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@#` to use the variable `MY_PHONE`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed a known limitation of being unable to use a tab as an ending character to a dynamic HotString. This was only an issue for HotStrings that would be replaced (rather than just appending text). Because some editors can be configured to insert (a variable number of) spaces instead of a tab, it was not easily knowable how much backspacing was required in order to erase the trigger string. While this is now slightly slower than normal (only when using a tab), it is working correctly. The reason for it being slower is that the text entered must be selected one character at a time until the start of the trigger can be found.

## Variables

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added global variable `MY_PHONE`.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `isDirectory()` - Returns `true` if the specified string is a directory
> * `isFile()` - Returns `true` if the specified string is a file
> * `isUNC()` - Returns `true` if the specified string is a UNC path

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with `ask()` returning any value entered even if the user closed dialog, click cancel or pressed `Escape`.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added menu item to launch the HotScript homepage from the system tray icon.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added configuration flag to disabling auto-updates (auto-update is on by default - may be disabled via `enableAutoUpdate` in `HotScriptUser.ini`).

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added ability to create an auto-startup link (may be disabled via `enableAutoStart` in `HotScriptUser.ini`).

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added status (`enabled` or `suspended`) to system tray icon tooltip.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> After upgrading the version of AutoHotkey, the downloaded installer will be deleted.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed warning message about being unable to obtain version information if an internet connection is not available at startup.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed unwanted menu items from the system tray icon.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Made changes that may have finally corrected intermittent issues with pasting text to a DOS window.

---
# <a name="1.20150910.2">Version 1.20150910.2</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> When pasting text to DOS that was created using a continuation section, the EOL needs to be converted to CRLF.

---
# <a name="1.20150910.1">Version 1.20150910.1</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Increased delay to select the last known window when restoring previously minimized windows (via `Win`+`M`).

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with pasting large text in a DOS window. There is no longer a size limit.

---
# <a name="1.20150907.4">Version 1.20150907.4</a>

## Miscellaneous

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed issue with auto-update getting wrongly disabled.

---
# <a name="1.20150907.3">Version 1.20150907.3</a>

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey `Win`+`M` for toggling windows minimized/restored.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKeys `Ctrl`+`Home` and `Ctrl-End` for scrolling to top or bottom of a DOS window.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Improved scrolling within a DOS window for `PgUp` and `PgDn` functionality. It now scrolls exactly one page regardless of the actual size of the window.

---
# <a name="1.20150907.1">Version 1.20150907.1</a>

## HotStrings

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@@` to use the variable `MY_EMAIL`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@addr` to use the variable `MY_ADDRESS`.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Started preparation of changing HotStrings from internally hard-coded to be user configurable. This means HotStrings may now be defined via a regular expression (regex), which adds tremendous power and flexibility. While it can also mean slightly more work to setup very complex HotStrings, many more things can be achieved. This functionality is only in the beginning stages - much more work needs to be done here.

## Variables

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added global variable `MY_EMAIL`.
> Added global variable `MY_ADDRESS`.

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `getVarType()` - returns the type for the specified variable (`Function`, `Label`, `Number`, `Object`, or `String`)
> * `urlToVar()` - returns the result of an HTTP request

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added version checking and simple updating (at startup/reload) for both AutoHotkey and HotScript. A prompt is shown to the user with the current/new versions and asks for permission to download/install the new version(s).

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added new configuration setting `enableVersionCheck` to disable version checking.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

- Added window marker &#x1368; for `Pinned`, which is a feature that _may_ be implemented in a future release.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed several window marker symbols:
> - (Always-on-top) from &#x2020; to &#x16C2;
> - (Click-through) from &#x2021; to &#x16be;
> - (Transparent)   from &#x00B1; to &#x2261;

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> A warning message (about instability) is now displayed when pasting large amounts of text (> 4K) into a DOS window

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed a small error on the quick help screen - `Resize to NE` and `Resize to NW` were reversed.

---
# <a name="1.20150821.2">Version 1.20150821.2</a>

## Early Development

<img src='https://img.shields.io/badge/-NOTES&nbsp;&nbsp;-B10DC9.svg?colorA=B10DC9'/>

> Changes in versions from 1.20131211.2 through 1.20150821.2 were not maintained separately and are listed below as belonging to a single version.

---

## HotKeys

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Win</kbd> + <kbd>R</kbd> for quickly resizing the active window to popular  or custom sizes.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added Hotkey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Up</kbd> to duplicate the current line.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Win</kbd> + <kbd>T</kbd> to toggle the window transparency to 50%.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Win</kbd> + <kbd>A</kbd> to toggle click-through for the active window.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added DOS HotKey <kbd>Alt</kbd> + <kbd>Up</kbd> to go parent directory, which is the same as the existing HotKey <kbd>Alt</kbd> + <kbd>.</kbd>.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added DOS HotKey <kbd>Ctrl</kbd> + <kbd>Delete</kbd> to delete to end-of-line.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added DOS HotKey <kbd>Ctrl</kbd> + <kbd>PgDn</kbd> to scroll window down. <kbd>Alt</kbd> + <kbd>PgDn</kbd> and <kbd>Shift</kbd> + <kbd>PgDn</kbd> also work.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added DOS HotKey <kbd>Ctrl</kbd> + <kbd>PgUp</kbd> to scroll window up. <kbd>Alt</kbd> + <kbd>PgUp</kbd> and <kbd>Shift</kbd> + <kbd>PgUp</kbd> also work.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added DOS HotKey <kbd>Ctrl</kbd> + <kbd>V</kbd> to paste text (for Windows versions previous to 10).

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd> to escape text for use within continuation sections.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added `DECODE` and `STDDEV` keywords to the HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd> for transforming Oracle keywords to upper case.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added 467 more keywords to the HotKey <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd> for transforming Oracle keywords to upper case.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Wrapping transformations now toggle, meaning they either add or remove the symbols to be wrapped.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Wrapping transformations now have an option for wrapping each line of selected text

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed HotKey for <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>[</kbd> that used to wrap in `{}` to now wrapping in  `[]`.

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed the following HotKeys:
> * <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>,</kbd>
> * <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd>
> * <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>
> * <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd>

<img src='https://img.shields.io/badge/-REMOVE&nbsp;&nbsp;-FF851B.svg?colorA=FF851B'/>

> Removed certain HotKeys that are fairly specialized and of little interest to the typical users of HotScript
> * <kbd>Win</kbd> + <kbd>F</kbd> (Run FileLocator Pro)
> * <kbd>Win</kbd> + <kbd>P</kbd> (Run Perforce)
> * <kbd>Win</kbd> + <kbd>R</kbd> (Run RegexBuddy)

## HotStrings

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added common fractions `1/8`, `1/4`, `1/3`, `3/8`, `1/2`, `5/8`, `2/3`, `3/4`, `7/8`. Typing one of these HotStrings will produce the actual fraction symbol. The window in which this is types must support UTF-8 characters or else some of the fraction symbols will be displayed as a box.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added HotString `@ip` that will produce the first IP address used by the computer.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed HTML and XML HotStrings containing attributes to use `'` instead of `"`.

<img src='https://img.shields.io/badge/-FIX&nbsp;&nbsp;-FF4136.svg?colorA=FF4136'/>

> Fixed HotStrings not working in a DOS window (paste vs `SendInput`).

## Functions

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the following functions:
> * `arrayToList()` - converts an array of items into a delimited list
> * `debug()` - creates logging statements during development (requires DebugView from Microsoft)
> * `escapeText()` -  can work both as a function returning a value or for selected text 
> * `getVar()` - returns the value of the specified global variable (supports values nested within objects)

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added a 2nd (optional) parameter to `pasteText()` for how long to delay.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added a 3rd (optional) parameter to `sendText()` for how long to delay.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Added a 4th (optional) parameter to `pasteTemplate()` for how long to delay.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed `pasteTemplate()` to adjust the EOL character to Windows `CRLF`.

## Miscellaneous

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added support for user-defined functions via the new file `HotScriptFunctions.ahk`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added support for user-defined variables via the new file `HotScriptVariables.ahk`.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added several new selections within Quick Lookup <kbd>Win</kbd> + <kbd>Q</kbd>:
> * Thesaurus
> * Urban Dictionary
> * Google Translate
> * Google Maps

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added `ArrayList` class to be able to add key/value pairs to an array, but have the items stay in the order in which they are inserted. AutoHotkey's array will always sort entries by the key.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the version of AutoHotkey to HotScript's tray icon title.

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> At startup, the following registry settings will be changed:
> * the default editor for AutoHotkey script files is changed to the configured editor
> * the taskbar grouping of AutoHotkey scripts is turned off, to allow each script to display its own icon

<img src='https://img.shields.io/badge/-NEW&nbsp;&nbsp;-0074D9.svg?colorA=0074D9'/>

> Added the History section to the wiki.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed the quick help screen to hide information for disabled sections.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Improved the ability to properly detect the presence (or lack of) DOS windows.

<img src='https://img.shields.io/badge/-CHANGE&nbsp;&nbsp;-2ECC40.svg?colorA=2ECC40'/>

> Changed automatic updating of monitor information (number, resolution, placement) from 2 minutes to 30 seconds.

---
# <a name="1.20131211.1">Version 1.20131211.1</a>

## Early Development

<img src='https://img.shields.io/badge/-NOTES&nbsp;&nbsp;-B10DC9.svg?colorA=B10DC9'/>

> Changes were not recorded for versions 1.20130514.1 through 1.20131211.1. 
