![](http://i.imgur.com/hMl5pXg.png)
# HotScript User Manual - v1.20160406.3

Copyright &copy; 2013-2017

---

## WORK IN PROGRESS

This documentation is incomplete and should be considered a work-in-progress.


## Introduction

HotScript will allow you to do more in less time, accurately and consistently. It will reduce mistakes. It will increase your productivity. You will be able to quickly and easily perform complex tasks and data transformation. Working with HotScript is very easy and natural. The more you embrace using it, the more you will find you don't want to use Windows without it.


## Features

HotScript has a wide assortment of features and functionality already built in.  Because it would be impossible to predict what every user's need may be, HotScript was designed to allow a user to create their own functionality.  Any user-defined functions may be easily shared with other users and teams, allowing for consistent behavior and increased productivity for all.


#### Automate Tasks

* Perform repetitive tasks easily
* Assign actions to any keystrokes
* Easily reproduce repetitive text
* Produce templates
* Create aliases for common phrases
* Eliminate common typing mistakes
* Quickly search anything, anywhere
* Automate any functionality within Windows


#### Interact with and Control Windows

* Move/resize windows with simple keystrokes
* Enhanced Windows clipboard capabilities
* Excellent multi-monitor support
* Control the mouse pointer from the keyboard
* Toggle/change window transparency
* Force a window to always be on top
* Zoom any portion of the screen
* Hide/restore any window


#### Transform Text

* Convert to UPPER/lower/Sentence/iNVERT/Title case
* Encrypt/decrypt
* Natural sort ascending or descending
* Auto-number lines (or remove it)
* Wrap in quotes, brackets or parenthesis
* Wrap text to width or unwrap
* Convert to or from HTML/XML tags


#### Extend and Customize

* Create shortcut keys for any application
* Create user-defined keys and text
* Create user-defined variables and functions
* Create custom templates for anything
* Create custom UI functionality
* Fully user extendable and customizable
* User-defined customizations are kept during upgrades


## Installation

* Download and install <a href="https://autohotkey.com/download/ahk-install.exe">AutoHotKey</a>.
* Download <a href="https://github.com/mviens/hotscript/raw/master/HotScript.ahk">HotScript.ahk</a>.  (Right-click this link and choose "Save as")
* Create a separate folder for HotScript and move HotScript.ahk (the file downloaded above) into that folder.
* Double-click HotScript.ahk to launch it for the first time. Some setup will automatically occur.


## Quick Start

If you are eager to get started and want to begin using HotScript immediately, this is the minimal information to help you will need.

#### Definitions

| Term | Description |
| --- | --- |
| HotKey | A combination of multiple keys, that when pressed produces an action. |
| HotString | A combination of some characters, that when typed produces an action. |
| Modifier key | A key that alters the primary key. The modifiers are `Ctrl`, `Alt`, `Shift` and `Win`.  The order in which the modifier keys is pressed is not important, as long as they are pressed **_before_** the primary key. <br/><br/>**Correct Examples:** <br/><br/> &nbsp; &nbsp; &nbsp; &nbsp; `Ctrl-Alt-Shift-Win-P` <br/> &nbsp; &nbsp; &nbsp; &nbsp; `Alt-Ctrl-Win-Shift-P` <br/> &nbsp; &nbsp; &nbsp; &nbsp; `Win-Shift-Alt-Ctrl-P` <br/><br/>**Incorrect Examples:** <br/><br/> &nbsp; &nbsp; &nbsp; &nbsp; `Ctrl-P-Alt-Shift-Win` <br/> &nbsp; &nbsp; &nbsp; &nbsp; `Ctrl-Alt-P-Shift-Win` <br/> &nbsp; &nbsp; &nbsp; &nbsp; `Ctrl-Alt-Shift-P-Win` |
| Left / Right | Many keyboards have multiple of the same keys, like the `Shift` and `Alt` keys.  It is possible to configure HotScript to use a specific key, such as the left `Alt` key.  This is done by using the first letter of the desired side, such as `LAlt` or `RShift`. |
| Directory / Folder | Used interchangeably, but typically `directory` is used when in a DOS window and `folder` is used when in Windows Explorer.  This is not completely rigid but is followed as much as possible.  They both mean the same thing. |

#### Usage 

When HotScript is running, there will be no typical user interface or display -- this is normal.  Instead, there will be a new icon in the Windows System tray, which is a red and white chili pepper.

Hovering over this icon will show both the version of HotScript as well as the version of AutoHotKey.  This icon may be right-clicked which will show some menu options. 

Press `Ctrl-Win-H` to show/hide the help screen.


## HotKeys

Every key combination was carefully selected to have meaning, which helps it to be remembered more easily.  When application, a memory trigger will be provided to help you remember/associate why the particular key combination was used.

With all the software in existence, it would not be possible to avoid key combination collisions.  With the exception of just one HotKey (Win-Pause), all key combinations may be changed by the user in the `HotScriptUser.ini` file.

HotKeys of a related nature have been grouped into sections.  Any section may be disabled within the `HotScriptUser.ini` file and all HotKeys within that section would be disabled.  These sections are:

| Section | Description |
| --- | --- |
| Action | Performs an action, such as executing an application. |
| DOS | Only active within a DOS/PowerShell prompt. |
| HotScript | HotKeys specific to HotScript. |
| Miscellaneous | Anything not described by another section. |
| Text | Convenient text manipulation. |
| Transform | Transforms selected text in a particular manner. |
| Windows | Movement and resizing of application windows. |


## Special window markers

A few of HotScript's functions will prepend a special marker to the title of a window.  They are to help indicate that the window is in a particular state.  When the function is turned off, the marker will be removed.

| Marker | HotKey | Indicator For | Description |
| --- | --- | --- | --- |
| ![](http://i.imgur.com/tCGUVTt.png) | `Win-A` | Always-on-Top | <a href="http://www.fileformat.info/info/unicode/char/16c2/index.htm">Runic Letter E</a> |
| ![](http://i.imgur.com/zU2pnSB.png) | `Ctrl-Win-A` | Click-through | <a href="http://www.fileformat.info/info/unicode/char/16be/index.htm">Runic Letter Naudiz Nyd Naud N</a> |
| ![](http://i.imgur.com/dRleqag.png) | n/a | Pinned | <a href="http://www.fileformat.info/info/unicode/char/1368/index.htm">Ethiopic Paragraph Separator</a> <br/><br/> *This is reserved for future functionality.* |
| ![](http://i.imgur.com/VD3SYlF.png) | `Win-T` <br/> `Win--` <br/> `Win-+` <br/> `Win-MouseWheel` | Transparent | <a href="http://www.fileformat.info/info/unicode/char/2261/index.htm">Identical To</a> <br/><br/> In addition to the marker, the transparency percentage will also be displayed. |


#### Action keys

The `Win` key is frequently used to execute actions because Windows is being instructed to perform some task like executing something.  If Windows is supposed to do something, it makes sense to use the `Win` key as much as possible.

| Key | Description | Memory Trigger |
| --- | --- | --- |
| `Win-A` | Toggles a window to be always-on-top.  When enabled, the title bar of window will have a marker prepended to the window's title to indicate the window is in always-on-top mode.  A brief message will be shown on screen whenever this mode is turned on or off.  When it is on, the window will always appear on top of other windows. | A = Always-on-top |
| `Ctrl-Win-A` | Toggles a window to allow click-through.  When enabled, the title bar of window will have a marker prepended to the window's title to indicate the window is in always-on-top mode.  A brief message will be shown on screen whenever this mode is turned on or off.  When it is on, the window pass any clicks it receives to any window that is underneath it.  This is commonly used in conjunction with always-on-top and/or transparent modes. |  |
| `Win-C` | Launches Windows Calculator. | C = Calculator |
| `Win-D` | Launches a DOS window. | D = DOS |
| `Alt-Win-D` | From within Windows Explorer, launches a DOS window for the directory that is being viewed. | Alt-D = Alt DOS |
| `Win-E` | Launches the configured editor.  This defaults to Notepad but may be modified within the `HotScriptUser.ini` file. | E = Editor |
| `Win-G` | This HotKey can be thought of as either "Google" or "Go" and is intelligently multi-functional, whose action will depend upon the currently selected text. <table><tr><td>Selected Text</td><td>Action</td></tr><tr><td>None</td><td>Prompt user for text</td></tr><tr><td>Something that looks like a web address (URL)</td><td>Launches the default browser and goes to the URL</td></tr><tr><td>File, directory or UNC path</td><td>Launches Windows Explorer for the location</td></tr><tr><td>Everything else</td><td>Launches the default browser and does a Google search</td></tr></table> | G = Google or Go |
| `Win-M` | Launches Windows Character Map. | M = Map |
| `Win-Q` | Performs a multi-functional quick lookup using the currently selected text. <table><tr><td>Selected Text</td>Action<td></td></tr><tr><td>None</td><td>Prompt user for text</td></tr><tr><td>Everything else</td><td>Displays a popup menu of available actions/searches</td></tr></table> Available actions or searches are: <ul><li>Jira</li><li>Confluence</li><li>Google</li><li>Google Maps</li><li>Google Images</li><li>Google Translate</li><li>Dictionary</li><li>IMBD</li><li>Thesaurus</li><li>Urban Dictionary</li><li>Wikipedia</li><li>Youtube</li><li>As Application</li></ul> Actions may be added or removed in the `HotScriptUser.ini` file. | Q = Quick Lookup |
| `Win-S` | Launches Windows Services. | S = Services |
| `Alt-Win-S` | Launches Windows Explorer into the user's Startup folder. | Alt-S = Startup |
| `Win-X` | Launches Windows Explorer. | X = eXplorer |
| `Win-PrintScreen` | Launches Windows Snipping Tool. |  |
| `Left-Ctrl` + `Right-Ctrl` | Launch Control Panel. | Control-Control = Control Panel |
| `Alt-Apps` | Hides/Shows the icons on the Windows desktop. |  |


#### DOS keys

The `Alt` key is frequently used to execute keys within DOS.  The expectation is that some alternate meaning is behind the key, hence `Alt` was used when applicable.

| Key | Description | Memory Trigger |
| --- | --- | --- |
| `Alt-C` | Sends: `"copy "` | C = Copy |
| `Alt-D` | Executes the PUSHD command to the user's Downloads directory. | D = Downloads |
| `Ctrl-Delete` | Deletes the text from the cursor to the end of the line. |  |
| `Ctrl-End` | Scrolls the window to the bottom. | Common Windows action |
| `Ctrl-Home` | Scrolls the window to the top. | Common Windows action |
| `Alt-M` | Sends: `"move "` | M = Move |
| `Alt-P` | Sends: `"pushd "` | P = Push |
| `Ctrl-P` | Executes the POPD command, returning to the last PUSHed directory. | Ctrl-P = POP |
| `Alt-PageDown` | Scroll down one page. |  |
| `Ctrl-PageDown` | Scroll down one page. |  |
| `Shift-PageDown` | Scroll down one page. |  |
| `Alt-PageUp` | Scroll up one page. |  |
| `Ctrl-PageUp` | Scroll up one page. |  |
| `Shift-PageUp` | Scroll up one page. |  |
| `Alt-R` | Sends: `"cd\"` + `{Enter}` - which changes to the root directory of the current drive. | R = Root |
| `Alt-T` | Sends: `"type "` | T = Type |
| `Alt-Up` | Changes the current directory to the parent directory. | Up = up one level |
| `Alt-.` | Changes the current directory to the parent directory. | . = "cd .." |
| `Ctrl-V` | Pastes the text from the Windows Clipboard. | Common Windows action |
| `Shift-Insert` | Pastes the text from the Windows Clipboard. | Common Windows action |
| `Alt-X` | Sends: `"exit"` + `{Enter}` | X = eXit |


#### HotScript keys

There are no designated modifier keys assigned for HotScript because with so many other important functions, and a limited number of key combinations, the importance here is to use key not common to other applications or ones that may be highly desirable for users to create their own HotKeys.

| Key | Description | Memory Trigger |
| --- | --- | --- |
| `Alt-Win-H` | Launches Windows Explorer into the HotScript folder. | Alternate + Windows + HotScript |
| `Ctrl-Win-H` | Toggle the help screen to be displayed or hidden.  Once displayed, it may also be closed by pressing `Escape`. | Alternate Help |
| `Win-H` | Show the help screen while these keys are pressed.  This will also hide the help menu if it was shown using `Ctrl-Win-H`. | H = Help |
| `Win-1` | Launch help for AutoHotKey. |  |
| `Win-2` | Reload HotScript.  This is necessary if any changes have been made to any of the user-defined files. |  |
| `Win-3` | Launch the configured editor and open `HotScript.ahk`. |  |
| `Win-4` | Launch the configured editor and open `HotScriptKeys.ahk`. |  |
| `Win-5` | Launch the configured editor and open `HotScriptStrings.ahk`. |  |
| `Win-6` | Launch the configured editor and open `HotScriptVariables.ahk`. |  |
| `Win-7` | Launch the configured editor and open `HotScriptFunctions.ahk`. |  |
| `Win-8` | Launch the configured editor and open `HotScriptUser.ini`. |  |
| `Win-9` | Launch the configured editor and open `HotScriptDefault.ini`. |  |
| `Win-0` | Launch the default browser and go to the HotScript home page. |  |
| `Ctrl-Win-F12` | Show the value of a variable within HotScript.  This is useful during debugging. |  |
| `Win-F12` | Exit HotScript. |  |
| `Win-Pause` | Toggle HotScript between paused and enabled.  When paused, the only key that is still active is this one so that HotScript may be reenabled. |  |
| `` Win-` `` | Launch <a href="https://technet.microsoft.com/en-us/sysinternals/debugview.aspx">DebugView</a>.  This is useful during debugging.  The output can be seen by making calls to `debug()`.| |


#### Miscellaneous keys

The Miscellaneous keys is a grouping of anything that doesn't fit into another category, so trying to use a common key modifier for this group would be rather pointless and very difficult.

| Key | Description | Memory Trigger |
| --- | --- | --- |
| `Ctrl-Alt-A` | Copies the currently selected text to the Windows Clipboard, but instead of replacing what was already in the Clipboard, it appends the selected text to it. | A = Append |
| `Ctrl-Alt-C` | Copies the currently selected text to the Windows Clipboard and replaces the selected text with what was already in the Clipboard, essentially swapping the two. | `Ctrl-C` = copy; `Ctrl-Alt-C` = alternate copy |
| `Ctrl-Alt-D` | In Windows Explorer, create a new directory.  It saves time from moving you hand from the keyboard, finding the mouse cursor, right-clicking in the proper location, selecting "New", then selecting "Folder".  If you do this many times a day, it becomes tiresome. | D = Directory |
| `Ctrl-Alt-F` | In Windows Explorer, create a new file.  It saves time from moving you hand from the keyboard, finding the mouse cursor, right-clicking in the proper location, selecting "New", then selecting "Text Document".  If you do this many times a day, it becomes tiresome, plus a ".txt" file is not always wanted. | F = File |
| `Ctrl-Alt-V` | Pastes the current Windows Clipboard as text only.  This is useful for stripping out any formatting from some applications.  This also works for filenames selected in Windows Explorer; the entire list of files will be converted to text and shown using the full path. | `Ctrl-V` = paste; `Ctrl-Alt-V` = alternate paste |
| `Ctrl-Alt-X` | Cuts the currently selected text to the Windows Clipboard, but instead of replacing what was already in the Clipboard, it appends the selected text to it. | `Ctrl-X` = cut; `Ctrl-Alt-X` = alternate cut. |
| `Win-Enter` | Pastes an new-line character.  Useful is some applications where pressing Enter may cause a default action, such as a web page or chat application. |  |
| `Win-Tab` | Pastes a Tab character.  Useful is some applications where pressing Tab may cause a default action or move the cursor to a new input field. |  |
| `Win-V` | Preview the Windows Clipboard.  This only works on text or anything that can be converted to text, such as files. | `Ctrl-V` = paste; `Win-V` = preview paste |
| `Win-Z` | Creates a small zoom window.  `Spacebar` toggles the following of the mouse cursor.  In follow mode, `Shift-MouseWheel` increases/decreases the window size.  In stationary mode, `MouseWheel` will zoom in/out of the text.  `Escape` closes the window.  <br/><br/> *There is a known issue with some video drivers where the text will not display correctly when in follow mode.  A solution is being researched.* | Z = Zoom |
| `Alt-Win-ARROW` | ARROW is `Up`, `Down`, `Left` or `Right`.  Moves the cursor one pixel in the direction of the arrow key.  Sometimes doing work that requires extreme precision if hard to do with the mouse, so this feature allows very specific mouse movement.|  |
| `Ctrl-Alt-Win-ARROW` | ARROW is `Up`, `Down`, `Left` or `Right`.  Drags (click and hold) the cursor one pixel in the direction of the arrow key.  Sometimes doing work that requires extreme precision if hard to do with the mouse, so this feature allows very specific mouse movement. |  |


#### Text keys

| Key | Description | Memory Trigger |
| --- | --- | --- |
| `Alt-Delete` | Deletes the current line. |  |
| `Alt-Down` | Move the current line down. |  |
| `Alt-Up` | Move the current line up. |  |
| `Ctrl-Shift-Up` | Duplicates the current line. |  |


#### Transform keys

The combination of `Ctrl` and `Shift` keys are frequently used transform selected text.  In a sense, transforming is "shifting" the text and the user is in "control" of it, so these two key modifiers match nicely to this group.

**Every HotKey in this section relies on having some text selected.**

| Key | Description | Memory Trigger |
| --- | --- | --- |
| `` Ctrl-Shift-` `` | Escape text |  |
| `Ctrl-Shift-A` | Sort ascending - case-insensitive | A = Ascending |
| `Ctrl-Alt-Shift-A` | Sort ascending - case-sensitive | `Alt-A` = Alternate Ascending |
| `Ctrl-Shift-D` | Sort descending - case-insensitive | D = Descending |
| `Ctrl-Alt-Shift-D` | Sort ascending - case-sensitive | `Alt-D` = Alternate Descending |
| `Ctrl-Shift-E` | Encrypt or decrypt.  This is a very loose interpretation of "encrypt".  At best, it will keep family/friends/coworkers from reading the original text.  But anyone with access to HotScript would be able to convert it back into the original text.  <br/><br/> *A future update is planned for supporting much more secure encryption.* |  |
| `Ctrl-Shift-I` |  |  |
| `Ctrl-Shift-L` |  |  |
| `Ctrl-Alt-N` |  |  |
| `Ctrl-Alt-Shift-N` |  |  |
| `Ctrl-Shift-N` |  |  |
| `Ctrl-Shift-O` |  |  |
| `Ctrl-Shift-R` |  |  |
| `Ctrl-Shift-S` |  |  |
| `Ctrl-Shift-T` |  |  |
| `Ctrl-Shift-U` |  |  |
| `Ctrl-Alt-W` |  |  |
| `Ctrl-Shift-W` |  |  |
| `Alt-Shift-,` | `Shift` + `,` would produce the tag character `,`.  Looking at the keys, it would be necessary to hold `Shift` to produce this character, so keeping that in mind, it will be easier to remember which key to press |  |
| `Alt-Shift-.` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |


#### Windows keys

| Key | Description | Memory Trigger |
| --- | --- | --- |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |
| `` |  |  |


## HotStrings

Some text...


## Help Screen

Press `Ctrl-Win-H` to show/hide the help screen.  This shows the help screen in an always-on-top manner.  The window is centered on the active monitor and may not be moved using traditional means because it has no title bar.  The window may be moved using HotScript's window management keys.  

The help screen is divided into HotKeys and HotStrings.  To switch between them using only the keyboard, press `Ctrl-PageUp` or `Ctrl-PageDown`.  When the help screen is showing, it may be closed by press `Escape`.

To momentarily show the help screen, press and hold `Win-H`.  This will show the help screen for as long as both keys are held.  This is useful when a quick glance is needed.


#### Abbreviations

In order to save critical space, the modifier keys have been abbreviated.

| Modifier | Description |
| --- | --- |
| [C] | Control |
| [A] | Alt |
| [S] | Shift |
| [W] | Win |
| [L] | Left |
| [R] | Right |


# TODO
- Sections may move around because of available space 
- Describe *special* items, like: KEY, TAG and {red-space} "&#160;"
- Can right-click and print
- HotScript (in the upper right) is a link


## Files

HotScript will automatically create several files when it is executed for the first time.

| File          | Description |
| ------------- | ----------- |
| HotScript.ico | This file is the icon image that is shown in the Window System Tray.  It is also used in any dialogs that are created by HotScript. The image is of a chili pepper and looks like this: <br/><br/> ![](http://i.imgur.com/F1Jv5Wj.png) <br/><br/> *This file will be created by HotScript if it does not exist and will be recreated by newer versions of HotScript.* |
| HotScriptDefault.ini | This file contains the default values for all of the settings used by HotScript. <br/><br/> This file should **_never_** be edited by the user.  If you wish to change a value, copy the specific section/setting from this file into the `HotScriptUser.ini` file. <br/><br/> *This file will be created by HotScript if it does not exist and will be recreated by newer versions of HotScript.* |
| HotScriptFunctions.ahk | This file should contain all user-defined functions. <br/><br/> *This file will be created by HotScript if it does not exist, but it will not be overwritten if it already exists.* |
| HotScriptKeys.ahk | This file should contain all user-specific HotKeys. <br/><br/> *This file will be created by HotScript if it does not exist, but it will not be overwritten if it already exists.* |
| HotScriptStrings.ahk | This file should contain all user-specific HotStrings. <br/><br/> *This file will be created by HotScript if it does not exist, but it will not be overwritten if it already exists.* |
| HotScriptUser.ini | This file contains all user-specific settings, allowing for upgrading to newer versions of HotScript without worrying about overwriting existing settings. <br/><br/> To override a setting defined in `HotScriptDefault.ini`, copy the relevant section/setting from there into this file and change the value. <br/><br/> *This file will be created by HotScript if it does not exist, but it will not be overwritten if it already exists.* |
| HotScriptVariables.ahk | . <br/><br/> *This file will be created by HotScript if it does not exist, but it will not be overwritten if it already exists.* |

common
- Any functions available within HotScript are available for use here, too.  
- For changes to take effect, HotScript must be reloaded. 

Creates auto-start shortcut...


## Configuration

Some text...


## API

Code looks like this:

```AutoHotkey
StrLen(myStr)
```

## FAQ

Some text...


## Known Issues

Some text...


## Future Enhancements

Some text...


## Contact

If you have questions, need assistance or would like to request new functionality, please send email to <a href="mailto:hotscript.help@gmail.com?Subject=Question%20about%20HotScript">hotscript.help@gmail.com</a>.


### Professional Services

There is no one better to help you with development of custom functionality and modules than the very people who have created HotScript.  Our team is available to help you with the following:

- Development of custom automation solutions
- Implement new functionality
- Create reusable modules for distribution to 
- Training on HotScript
- Analysis of user workflow and identifying areas for productivity enhancement 
- Debugging of user-created functionality
- Priority technical support
