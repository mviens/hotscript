/*
There should be no reason to edit this file directly.

To add user-defined hotkeys, edit the file   : HotScriptKeys.ahk
To add user-defined hotstrings, edit the file: HotScriptStrings.ahk
To change global values, edit the file       : HotScript.ini

For further information, assistance or bug-reporting,
please contact Mike Viens. (mike.viens@pearson.com)
*/

#Include %A_ScriptDir%
#Hotstring EndChars -()[]{}<>!@$%^&*_=+|:'"/\,.?! `n`t;
#MaxHotkeysPerInterval 200
#NoEnv
#SingleInstance force
#Warn
Autotrim, off
ListLines, off
SendMode Input
SetBatchLines -1
SetKeyDelay, -1
SetTitleMatchMode, Regex
SetWinDelay, 0

/*
Things todo/fix/check
===============================================================
Full help screen
    On help screen, add keyboard handling
        LV should get focus
        Down arrow should focus the grid
        Enter should run the currently selected row
            What if no row is currently selected?
                Do nothing, exit, or select first row?
*/


;__________________________________________________
;private variables
COMMENT_HEADER_LINE := " " . repeatStr("-", 70)
LINE_SEP := repeatStr("·", 165)
MENU_SEP := "-"
MY_VERSION := "20131211.beta1"
MY_TITLE := "Mike's HotScript"
QUICK_SPLASH_TITLE := "QuickSplash"
USER_KEYS := A_ScriptDir . "\HotScriptKeys.ahk"
USER_STRINGS := A_ScriptDir . "\HotScriptStrings.ahk"
JiraPanels := {format:"", formatBlue:"", formatGreen:"", formatRed:"", formatYellow:""}

Config := Object()
Config.file :=
Config.enableHkAction := true
Config.enableHkDos := true
Config.enableHkEpp := true
Config.enableHkMisc := true
Config.enableHkMovement := true
Config.enableHkTransform := true
Config.enableHsAlias := true
Config.enableHsAutoCorrect := true
Config.enableHsCode := true
Config.enableHsDates := true
Config.enableHsDos := true
Config.enableHsHtml := true
Config.enableHsJira := true
Config.enableHsSql := true
Config.hkSessionCount := 0
Config.hsSessionCount := 0
Config.hkTotalCount := 0
Config.hsTotalCount := 0
Config.jiraPanels := new JiraPanels
Config.quickLookupSites :=
Config.version :=

Coords := {height:0, width:"", x:0, y:0}
MonitorInfo := {idx:0, name:"", height:0, width:0, top:0, bottom:0, left:0, right:0, workHeight:0, workWidth:0, workTop:0, workBottom:0, workLeft:0, workRight:0}

configDefault := new Config
configDefault.file := A_ScriptDir . "\HotScriptDefault.ini"
configUser := new Config
configUser.file := A_ScriptDir . "\HotScriptUser.ini"
hiddenWindows :=
lvKeys :=
lvStrings :=
monitors := Object()
refreshMonitorInterval := 120000 ; 2 minutes (in milliseconds)
quickText :=
vkDelim := " " ; this is not a space, but Alt+0160


;__________________________________________________
;Auto-run code goes here
init()

;__________________________________________________
;HotStrings
#Include *i HotScriptStrings.ahk
; Aliases
;--------
#If, toBool(configUser.enableHsAlias)
    :*:bbl:: ;; be back later
        addHotString()
        sendText("be back later")
        return
    :*:bbs:: ;; be back soon
        addHotString()
        sendText("be back soon")
        return
    :*:bi5:: ;; back in 5 minutes...
        addHotString()
        sendText("back in 5 minutes...")
        return
    :*c:brb:: ;; be right back
        addHotString()
        sendText("be right back")
        return
    :*:brt:: ;; be right there
        addHotString()
        sendText("be right there")
        return
    :*:chpl:: ;; Comment header for Perl
       addHotString()
       sendText("#" . COMMENT_HEADER_LINE, "{Enter}")
       sendText("#  ", "{Enter}")
       sendText("#" . COMMENT_HEADER_LINE, "{Up}{End}")
       return
    :*:chsql:: ;; Comment header for SQL
       addHotString()
       sendText("--" . COMMENT_HEADER_LINE, "{Enter}")
       sendText("--  ", "{Enter}")
       sendText("--" . COMMENT_HEADER_LINE, "{Up}{End}")
       return
    :*:crg:: ;; Code review is good.
        addHotString()
        sendText("Code review is good.")
        return
    :*:g2g:: ;; Good to go.
        addHotString()
        sendText("Good to go.")
        return
    :*:gtg:: ;; Got to go.
        addHotString()
        sendText("Got to go.")
        return
    :*:idk:: ;; I don't know.
        addHotString()
        sendText("I don't know.")
        return
    :*:lmc:: ;; Let me check on that, please wait...
        addHotString()
        sendText("Let me check on that, please wait...")
        return
    ::nm:: ;; never mind...
        addHotString()
        sendText("never mind...")
        return
    :*:nmif:: ;; Never mind, I found it.
        addHotString()
        sendText("Never mind, I found it.")
        return
    :*:np:: ;; no problem
        addHotString()
        sendText("no problem")
        return
    :*:nw:: ;; no worries
        addHotString()
        sendText("no worries")
        return
    :*:okt:: ;; OK, thanks...
        addHotString()
        sendText("OK, thanks...")
        return
    :*:thx:: ;; thanks
        addHotString()
        sendText("thanks")
        return
    ::ty:: ;; Thank you.
        addHotString()
        sendText("Thank you.")
        return
    :*:thok:: ;; That's OK...
        addHotString()
        sendText("That's OK...")
        return
    :*:yw:: ;; You're welcome.
        addHotString()
        sendText("You're welcome.")
        return
    :*:wyb:: ;; Please let me know when you are back...
        addHotString()
        sendText("Please let me know when you are back...")
        return
#If
; Auto-correct
;-------------
#If, toBool(configUser.enableHsAutoCorrect)
    :*c:cL:: ;; change "cL" to "c:"
        addHotString()
        Send, c{:}
        return
#If
;Code
;----
#If, toBool(configUser.enableHsDates)
    :*b0:for(:: ;; auto-completion of a 'for' block
    :*b0:for (:: ;; auto-completion of a 'for' block
    :*b0:if(:: ;; auto-completion of an 'if' block
    :*b0:if (:: ;; auto-completion of an 'if' block
    :*b0:while(:: ;; auto-completion of a 'while' block
    :*b0:while (:: ;; auto-completion of a 'while' block
        addHotString()
        sendText(") {", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("}", "{Up 2}{End}{Left 3}")
        return
    :*:func(:: ;; auto-completion of an 'function' block
    :*:func (:: ;; auto-completion of an 'function' block
        addHotString()
        sendText("function () {", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("}", "{Up 2}{End}{Left 4}")
        return
    :*:ifel:: ;; auto-completion of an 'if/else' block
        addHotString()
        sendText("if () {", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("}", "{Enter}")
        sendText("else {", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("}", "{Up 5}{End}{Left 3}")
        return
    :*b0:switch(:: ;; auto-completion of a 'switch' block
    :*b0:switch (:: ;; auto-completion of a 'switch' block
        addHotString()
        sendText(") {", "{Enter}{Tab}")
        sendText("case x:", "{Enter}{Tab}")
        sendText("break;", "{Enter}{Backspace}")
        sendText("default:", "{Enter}{Tab}")
        sendText("break;", "{Enter}{Backspace 2}")
        sendText("}", "{Up 5}{End}{Left 3}")
        return
    :*:sf.:: ;; String.format("", )
        addHotString()
        sendText("String.format("""", )", "{Left 4}")
        return
    :*:sysout:: ;; System.out.println("");
        addHotString()
        sendText("System.out.println("""");", "{Left 3}")
        return
    :*:@html:: ;; a basic HTML template
        addHotString()
        sendText("<!DOCTYPE html>", "{Enter}")
        sendText("<html>", "{Enter}{Tab}")
        sendText("<script>", "{Enter}{Tab}")
        sendText("function test() {", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("}", "{Enter}{Backspace}")
        sendText("</script>", "{Enter}{Backspace}")
        sendText("<body>", "{Enter}{Tab}")
        sendText("<input type=""button"" value=""Test"" onclick=""test()""/>", "{Enter}{Backspace}")
        sendText("</body>", "{Enter}")
        sendText("</html>", "{Enter}{Up 3}{End}{Home}")
        return
    :*:@java:: ;; a basic Java class template
        addHotString()
        sendText("import java.io.*;", "{Enter}")
        sendText("import java.util.*;", "{Enter 2}")
        sendText("public class Test {", "{Enter}{Tab}")
        sendText("public static void main(String[] args) {", "{Enter}{Tab}")
        sendText("System.out.println("""");", "{Enter}{Backspace}")
        sendText("}", "{Enter}{Backspace}")
        sendText("}", "{Enter}{Up 3}{End}{Home}")
        return
#If
;Date and Time
;-------------
#If, toBool(configUser.enableHsDates)
    :*:dts:: ;; datestamp - the current date as 'YYYYMMDD'
        addHotString()
        sendText(A_YYYY . A_MM . A_DD)
        return
    :*:dtms:: ;; datetimestamp - the current date and time as 'YYYYMMDD_24MMSS'
        addHotString()
        sendText(A_YYYY . A_MM . A_DD . "_" . A_Hour . A_Min . A_Sec)
        return
    :*:tms:: ;; timestamp - the current time as '24MMSS'
        addHotString()
        sendText(A_Hour . A_Min . A_Sec)
        return
    :*:@date:: ;; the current date as 'MM/DD/YYYY'
        addHotString()
        sendText(A_MM . "/" . A_DD . "/" . A_YYYY)
        return
    :*:@day:: ;; the current date as the name of the day
        addHotString()
        sendText(A_DDDD)
        return
    :*:@ddd:: ;; the current date as the abbreviated name of the day
        addHotString()
        sendText(A_DDD)
        return
    :*:@mmm:: ;; the current date as the abbreviated name of the month
        addHotString()
        sendText(A_MMM)
        return
    :*:@month:: ;; the current date as the name of the month
        addHotString()
        sendText(A_MMMM)
        return
    :*:@now:: ;; the current date and time as 'MM/DD/YYYY at 24:MM:SS'
        addHotString()
        sendText(A_MM . "/" . A_DD . "/" . A_YYYY . " at " . A_Hour . ":" . A_Min . ":" . A_Sec)
        return
    :*:@time:: ;; the current time as '24:MM:SS'
        addHotString()
        sendText(A_Hour . ":" . A_Min . ":" . A_Sec)
        return
#If
;DOS
;---
#If, toBool(configUser.enableHsDos)
    #IfWinActive ahk_class ConsoleWindowClass
        :*b0:cd :: ;; Appends '/d' onto 'cd ' commands to allow changing drive++DOS only
            addHotString()
            Send, /d{Space}
            return
    #IfWinActive
#If
;HTML
;----
#If, toBool(configUser.enableHsHtml)
    :?*b0:<a :: ;; auto-completion of the HTML 'a' tag (with 'href' attribute)
        addHotString()
        sendText("href=""""></a>", "{Left 4}")
        return
    :?b0o:<b:: ;; auto-completion of the HTML 'b' tag
        addHotString()
        sendText("></b>", "{Left 4}")
        return
    :?*b0:<big:: ;; auto-completion of the HTML 'big' tag
        addHotString()
        sendText("></big>", "{Left 6}")
        return
    :?*b0:<block:: ;; auto-completion of the HTML 'blockquote' tag
        addHotString()
        sendText("quote>", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</blockquote>", "{Up}{End}")
        return
    :?*b0:<body:: ;; auto-completion of the HTML 'body' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</body>", "{Up}{End}")
        return
    :?*b0:<br:: ;; auto-completion of the HTML 'br' tag
    :?*b0:<hr:: ;; auto-completion of the HTML 'hr' tag
        addHotString()
        sendText("/>")
        return
    :?*b0:<but:: ;; auto-completion of the HTML 'button' tag
        addHotString()
        sendText("ton></button>", "{Left 9}")
        return
    :?*b0:<cap:: ;; auto-completion of the HTML 'caption' tag
        addHotString()
        sendText("tion></caption>", "{Left 10}")
        return
    :?*b0:<code:: ;; auto-completion of the HTML 'code' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</code>", "{Up}{End}")
        return
    :?*b0:<del:: ;; auto-completion of the HTML 'del' tag
        addHotString()
        sendText("></del>", "{Left 6}")
        return
    :?*b0:<div:: ;; auto-completion of the HTML 'div' tag (with 'id' attribute)
        addHotString()
        sendText(" id="""">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</div>", "{Up}{End}")
        return
    :?*b0:<em:: ;; auto-completion of the HTML 'em' tag
        addHotString()
        sendText("></em>", "{Left 5}")
        return
    :?*b0:<field:: ;; auto-completion of the HTML 'fieldset' tag
        addHotString()
        sendText("set>", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</fieldset>", "{Up}{End}")
        return
    :?*b0:<foot:: ;; auto-completion of the HTML 'footer' tag
        addHotString()
        sendText("er>", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</footer>", "{Up}{End}")
        return
    :?*b0:<form:: ;; auto-completion of the HTML 'form' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</form>", "{Up}{End}")
        return
    :?*b0:<h1:: ;; auto-completion of the HTML 'h1' tag
        addHotString()
        sendText("></h1>", "{Left 5}")
        return
    :?*b0:<h2:: ;; auto-completion of the HTML 'h2' tag
        addHotString()
        sendText("></h2>", "{Left 5}")
        return
    :?*b0:<h3:: ;; auto-completion of the HTML 'h3' tag
        addHotString()
        sendText("></h3>", "{Left 5}")
        return
    :?*b0:<h4:: ;; auto-completion of the HTML 'h4' tag
        addHotString()
        sendText("></h4>", "{Left 5}")
        return
    :?*b0:<h5:: ;; auto-completion of the HTML 'h5' tag
        addHotString()
        sendText("></h5>", "{Left 5}")
        return
    :?*b0:<h6:: ;; auto-completion of the HTML 'h6' tag
        addHotString()
        sendText("></h6>", "{Left 5}")
        return
    :?b0o:<head:: ;; auto-completion of the HTML 'head' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</head>", "{Up}{End}")
        return
    :?*b0:<header:: ;; auto-completion of the HTML 'header' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</header>", "{Up}{End}")
        return
    :?*b0:<hgroup:: ;; auto-completion of the HTML 'hgroup' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</hgroup>", "{Up}{End}")
        return
    :?*b0:<html:: ;; auto-completion of the HTML 'body' tag (with nested 'body' tag)
        addHotString()
        sendText(">", "{Enter}")
        sendText("<body>", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</body>", "{Enter}")
        sendText("</html>", "{Up 2}{End}")
        return
    :?b0o:<i:: ;; auto-completion of the HTML 'i' tag
        addHotString()
        sendText("></i>", "{Left 4}")
        return
    :?*b0:<iframe:: ;; auto-completion of the HTML 'iframe' tag
    :?*b0:<img:: ;; auto-completion of the HTML 'img' tag (with 'src' attribute)
        addHotString()
        sendText(" src=""""/>", "{Left 3}")
        return
    :?*b0:<input:: ;; auto-completion of the HTML 'input' tag (with 'type', 'name', 'id' and 'value' attributes)
        addHotString()
        sendText(" type="""" name="""" id="""" value=""""/>", "{End}{Home}{Right 13}")
        return
    :?*b0:<label:: ;; auto-completion of the HTML 'label' tag (with 'for' attribute)
        addHotString()
        sendText(" for=""""/>", "{Left 3}")
        return
    :?*b0:<legend:: ;; auto-completion of the HTML 'legend' tag
        addHotString()
        sendText("></legend>", "{Left 9}")
        return
    :?b0o:<li:: ;; auto-completion of the HTML 'li' tag
        addHotString()
        sendText("></li>", "{Left 5}")
        return
    :?*b0:<link:: ;; auto-completion of the HTML 'link' tag (with 'rel', 'type' and 'href' attributes)
        addHotString()
        sendText(" rel=""stylesheet"" type=""text/css"" href=""""/>", "{Left 3}")
        return
    :?*b0:<ol:: ;; auto-completion of the HTML 'ol' tag
        addHotString()
        sendText(">", "{Enter}{Tab}")
        sendText("<li></li>", "{Enter}{Backspace}")
        sendText("</ol>", "{Up}{End}{Left 5}")
        return
    :?*b0:<optg:: ;; auto-completion of the HTML 'optgroup' tag (with nested 'option' tag)
        addHotString()
        sendText("roup>", "{Enter}{Tab}")
        sendText("<option></option>", "{Enter}{Backspace}")
        sendText("</optgroup>", "{Up}{End}{Left 9}")
        return
    :?*b0:<opti:: ;; auto-completion of the HTML 'option' tag
        addHotString()
        sendText("on></option>", "{Left 9}")
        return
    :?b0o:<p:: ;; auto-completion of the HTML 'p' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</p>", "{Up}{End}")
        return
    :?*b0:<pre:: ;; auto-completion of the HTML 'pre' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</pre>", "{Up}{End}")
        return
    :?b0o:<q:: ;; auto-completion of the HTML 'q' tag
        addHotString()
        sendText("></q>", "{Left 4}")
        return
    :?*b0:<script:: ;; auto-completion of the HTML 'script' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</script>", "{Up}{End}")
        return
    :?*b0:<section:: ;; auto-completion of the HTML 'section' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</section>", "{Up}{End}")
        return
    :?*b0:<select:: ;; auto-completion of the HTML 'sel' tag (with 'name' and 'id' attributes and nested 'option' tag)
        addHotString()
        sendText(" name="""" id="""">", "{Enter}{Tab}")
        sendText("<option></option>", "{Enter}{Backspace}")
        sendText("</select>", "{Up}{End}{Left 9}")
        return
    :?*b0:<small:: ;; auto-completion of the HTML 'small' tag
        addHotString()
        sendText("></small>", "{Left 8}")
        return
    :?*b0:<source:: ;; auto-completion of the HTML 'source' tag (with 'type' and 'src' attributes)
        addHotString()
        sendText(" type="""" src=""""/>", "{Left 3}")
        return
    :?*b0:<span:: ;; auto-completion of the HTML 'span' tag (with 'id' attribute)
        addHotString()
        sendText(" id=""""></span>", "{Left 7}")
        return
    :?*b0:<strong:: ;; auto-completion of the HTML 'strong' tag
        addHotString()
        sendText("></strong>", "{Left 9}")
        return
    :?*b0:<style:: ;; auto-completion of the HTML 'style' tag (with 'type' attribute)
        addHotString()
        sendText(" type=""text/css"">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</style>", "{Up}{End}")
        return
    :?*b0:<sub:: ;; auto-completion of the HTML 'sub' tag
        addHotString()
        sendText("></sub>", "{Left 6}")
        return
    :?*b0:<sum:: ;; auto-completion of the HTML 'summary' tag
        addHotString()
        sendText("mary></summary>", "{Left 10}")
        return
    :?*b0:<sup:: ;; auto-completion of the HTML 'sup' tag
        addHotString()
        sendText("></sup>", "{Left 6}")
        return
    :?*b0:<table:: ;; auto-completion of the HTML 'table' tag (with nested 'tr' and 'td' tags)
        addHotString()
        sendText(">", "{Enter}{Tab}")
        sendText("<tr>", "{Enter}{Tab}")
        sendText("<td>", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</td>", "{Enter}{Backspace}")
        sendText("</tr>", "{Enter}{Backspace}")
        sendText("</table>", "{Up 3}{End}")
        return
    :?*b0:<tbody:: ;; auto-completion of the HTML 'tbody' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</tbody>", "{Up}{End}")
        return
    :?*b0:<td:: ;; auto-completion of the HTML 'td' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</td>", "{Up}{End}")
        return
    :?*b0:<tfoot:: ;; auto-completion of the HTML 'tfoot' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</tfoot>", "{Up}{End}")
        return
    :?b0o:<th:: ;; auto-completion of the HTML 'th' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</th>", "{Up}{End}")
        return
    :?*b0:<thead:: ;; auto-completion of the HTML 'thead' tag
        addHotString()
        sendText(">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</thead>", "{Up}{End}")
        return
    :?*b0:<tr:: ;; auto-completion of the HTML 'tr' tag
        addHotString()
        sendText(">", "{Enter}{Tab}")
        sendText("<td>", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</td>", "{Enter}{Backspace}")
        sendText("</tr>", "{Up 2}{End}")
        return
    :?*b0:<texta:: ;; auto-completion of the HTML 'textarea' tag (with 'rows' and 'cols' attributes)
        addHotString()
        sendText("rea rows="""" cols="""">", "{Enter}{Tab}{Enter}{Backspace}")
        sendText("</textarea>", "{Up}{End}")
        return
    :?*b0:<title:: ;; auto-completion of the HTML 'title' tag
        addHotString()
        sendText("></title>", "{Left 8}")
        return
    :?b0o:<u:: ;; auto-completion of the HTML 'u' tag
        addHotString()
        sendText("></u>", "{Left 4}")
        return
    :?*b0:<ul:: ;; auto-completion of the HTML 'ul' tag
        addHotString()
        sendText(">", "{Enter}{Tab}")
        sendText("<li></li>", "{Enter}{Backspace}")
        sendText("</ul>", "{Up}{End}{Left 5}")
        return
    :?*:<xml:: ;; auto-complettion of the XML header in UTF-8
        addHotString()
        sendText("<?xml version=""1.0"" encoding=""UTF-8""?>", "{Enter}")
        return
#If
;Jira
;----
#If, toBool(configUser.enableHsJira)
    :*b0:{color:: ;; a pair of {color} tags++used by Jira/Confluence
        addHotString()
        sendText(":}{color}", "{Left 8}")
        return
    :*:{bpan:: ;; a pair of {panel} tags with blue background++used by Jira/Confluence
        addHotString()
        pval := configUser.jiraPanels.formatBlue
        sendJiraPanel(configUser.jiraPanels.formatBlue)
        return
    :*:{gpan:: ;; a pair of {panel} tags with green background++used by Jira/Confluence
        addHotString()
        sendJiraPanel(configUser.jiraPanels.formatGreen)
        return
    :*:{info:: ;; a pair of {info} tags++used by Jira/Confluence
        addHotString()
        sendJiraSpecialPanel("info")
        return
    :*:{java:: ;; a pair of {code} tags for Java++used by Jira/Confluence
        addHotString()
        sendJiraCode("Java")
        return
    :*:{js:: ;; a pair of {code} tags for JavaScript++used by Jira/Confluence
        addHotString()
        sendJiraCode("JavaScript")
        return
    :*b0:{nof:: ;; a pair of {noformat} tags++used by Jira/Confluence
        addHotString()
        sendText("ormat}", "{Enter}")
        sendText("{noformat}", "{Enter}{Up}{End}{Home}")
        return
    :*:{note:: ;; a pair of {note} tags++used by Jira/Confluence
        addHotString()
        sendJiraSpecialPanel("note")
        return
    :*:{pan:: ;; a pair of {panel} tags++used by Jira/Confluence
        addHotString()
        sendJiraPanel(configUser.jiraPanels.format)
        return
    :*b0:{quo:: ;; a pair of {quote} tags++used by Jira/Confluence
        addHotString()
        sendText("te}", "{Enter}")
        sendText("{quote}", "{Enter}{Up}{End}{Home}")
        return
    :*:{rpan:: ;; a pair of {panel} tags with red background++used by Jira/Confluence
        addHotString()
        sendJiraPanel(configUser.jiraPanels.formatRed)
        return
    :*:{sql:: ;; a pair of {code} tags for SQL++used by Jira/Confluence
        addHotString()
        sendJiraCode("SQL")
        return
    :*:{tip:: ;; a pair of {tip} tags++used by Jira/Confluence
        addHotString()
        sendJiraSpecialPanel("tip")
        return
    :*:{warn:: ;; a pair of {warning} tags++used by Jira/Confluence
        addHotString()
        sendJiraSpecialPanel("warning")
        return
    :*:{xml:: ;; a pair of {code} tags for XML++used by Jira/Confluence
        addHotString()
        sendJiraCode("XML")
        return
    :*:{ypan:: ;; a pair of {panel} tags with yellow background++used by Jira/Confluence
        addHotString()
        sendJiraPanel(configUser.jiraPanels.formatYellow)
        return
#If
;SQL
;---
#If, toBool(configUser.enableHsSql)
    :*:sela:: ;; 'select all' SQL template
        addHotString()
        sendText("SELECT *", "{Enter}")
        sendText("FROM ", "{Enter}")
        sendText("WHERE ", "{Up}{End}")
        return
    :*:selc:: ;; 'select count' SQL template
        addHotString()
        sendText("SELECT count(*)", "{Enter}")
        sendText("FROM ", "{Enter}")
        sendText("WHERE ", "{Up}{End}")
        return
    :*:selw:: ;; 'select where' SQL template
        addHotString()
        sendText("SELECT ", "{Enter}")
        sendText("FROM ", "{Enter}")
        sendText("WHERE ", "{Up}{End}")
        return
#If


;__________________________________________________
;HotKeys
#Include *i HotScriptKeys.ahk
;Action
;------
#If, toBool(configUser.enableHkAction)
    #a:: ;; toggles the 'always-on-top' mode of the active window
        addHotKey()
        toggleAlwaysOnTop()
        return
    #c:: ;; activate or launch Calculator
        addHotKey()
        findOrRunByExe("calc")
        return
    #d:: ;; activate or launch a DOS window
        addHotKey()
        runDos()
        return
    #e:: ;; activate or launch the editor++currently EditPad Pro
        addHotKey()
        runEditPadPro()
        return
    #f:: ;; activate or launch FileLocator Pro
        addHotKey()
        runFileLocatorPro()
        return
    #g:: ;; launch the selected text in Google or as a standlone link++prompt if no selection
        addHotKey()
        runSelectedText()
        return
    #h:: ;; show the quick help screen (until released)
        addHotKey()
        showQuickHelp(true)
        return
    !#h:: ;; show the quick help screen (toggle)
        addHotKey()
        showQuickHelp(false)
        return
    ^#h:: ;; show the full help screen
        addHotKey()
        showFullHelp()
        return
    #p:: ;; activate or launch Perforce
        addHotKey()
        runPerforce()
        return
    #q:: ;; quick lookup of selected text++prompt if no selection
        addHotKey()
        runQuickLookup()
        return
    #r:: ;; activate or launch RegexBuddy
        addHotKey()
        runRegexBuddy()
        return
    #s:: ;; launch Services
        addHotKey()
        runServices()
        return
    #v:: ;; previews the contents of the clipboard
        addHotKey()
        showClipboard()
        return
    #x:: ;; launch Windows Explorer
        addHotKey()
        runTarget("explorer.exe C:\")
        return
    #z:: ;; create a zoom window (MouseWheel/Shift-MouseWheel/Space/Escape)
        addHotKey()
        zoomStart()
        return
    #1:: ;; activates or launches the AutoHotKey help file
        addHotKey()
        runAhkHelp()
        return
    #2:: ;; reloads this script (to apply any changes that have been made)
        addHotKey()
        selfReload()
        return
    #3:: ;; edits this script
        addHotKey()
        runEditPadPro()
        Edit
        return
    #delete:: ;; hide the current window
        addHotKey()
        hideWindow()
        return
    #enter:: ;; creates a linebreak (for when pressing Enter does some action)
        addHotKey()
        sendText("`r`n")
        return
    ;#f10::ListHotkeys
    ;#f11::ListVars
    #f12:: ;; exits this script, restoring original keyboard functionality
        addHotKey()
        stop()
        return
    ^#f12:: ;; Debug only - display the value of any internal variable
        addHotKey()
        showDebugVar()
        return
    #insert:: ;; restore all previously hidden windows
        addHotKey()
        restoreHiddenWindows()
        return
    #-:: ;; toggles the visibility of the desktop icons
    #numpadsub:: ;; toggles the visibility of the desktop icons
        addHotKey()
        toggleDesktopIcons()
        return
    #printscreen:: ;; run the Windows snipping tool
        addHotKey()
        Run snippingtool
        return
    #tab:: ;; creates a tab (for when pressing Tab does some action)
        addHotKey()
        sendText("`t")
        return
#If
;DOS
;---
#If, toBool(configUser.enableHkDos) && WinActive("ahk_class ConsoleWindowClass")
    !c:: ;; "copy "++DOS only
        addHotKey()
        Send, copy{Space}
        return
    !d:: ;; changes to the 'Downloads' directory for the current user++DOS only
        addHotKey()
        Send, pushd `%USERPROFILE`%\Downloads{Enter}
        return
    !m:: ;; "move "++DOS only
        addHotKey()
        Send, move{Space}
        return
    !p:: ;; "pushd "++DOS only
        addHotKey()
        Send, pushd{Space}
        return
    ^p:: ;; returns (popd) to most recently 'pushed' directory++DOS only
        addHotKey()
        Send, popd{Enter}
        return
    !r:: ;; changes to the root directory of the current drive++DOS only
        addHotKey()
        Send, cd\{Enter}
        return
    !s:: ;; executes the 'src' batch file++DOS only
        addHotKey()
        Send, src{Enter}
        return
    !t:: ;; "type "++DOS only
        addHotKey()
        Send, type{Space}
        return
    !u:: ;; executes the 'utils' batch file, which discovers the path to 'Utils' and changes to it++DOS only
        addHotKey()
        Send, utils{Enter}
        return
    !x:: ;; executes the 'exit' command++DOS only
        addHotKey()
        Send, exit{Enter}
        return
#If
;EditPadPro
;----------
#If, toBool(configUser.enableHkEpp) && WinActive("ahk_exe i)EditPadPro\d*\.exe")
    xbutton1:: ;; moves to previous file++EditPad Pro only
        addHotKey()
        Send, +{F6}
        return
    xbutton2:: ;; moves to next file++EditPad Pro only
        addHotKey()
        Send, {F6}
        return
    !delete:: ;; remaps Alt-Delete to Ctrl-Alt-Y++EditPad Pro only
        addHotKey()
        Send, ^!y
        return
    !down:: ;; remaps Alt-Down to Ctrl-Alt-Down++EditPad Pro only
        addHotKey()
        Send, ^!{Down}
        return
    !up:: ;; remaps Alt-Up to Ctrl-Alt-Up++EditPad Pro only
        addHotKey()
        Send, ^!{Up}
        return
    ^d:: ;; remaps Ctrl-D to Ctrl-Delete++EditPad Pro only
        addHotKey()
        Send, ^{Delete}
        return
    ^delete:: ;; remaps Ctrl-Delete to Ctrl-Shift-Delete++EditPad Pro only
        addHotKey()
        Send, ^+{Delete}
        return
    ^g:: ;; clones Ctrl-G as Alt-G++EditPad Pro only
        addHotKey()
        Send, !g
        return
#If
;Misc
;----
#If, toBool(configUser.enableHkMisc)
    ^!v:: ;; pastes contents as plain text
        addHotKey()
        sendText(ClipBoard)
        return
    ^rctrl:: ;; launch Control Panel
        addHotKey()
        runTarget("Control Panel")
        return
    #pause:: ;; toggles suspension of this script
        Suspend
        addHotKey()
        toggleSuspend()
        return
#If
;Movement
;--------
#If, toBool(configUser.enableHkMovement)
    wheelleft:: ;; move the current window to the left monitor
    #left:: ;; move the current window to the left monitor
        addHotKey()
        moveToMonitor("A", -1)
        return
    wheelright:: ;; move the current window to the right monitor
    #right:: ;; move the current window to the right monitor
        addHotKey()
        moveToMonitor("A", 1)
        return
    #down:: ;; minimize the current window
        addHotKey()
        minimize()
        return
    #home:: ;; centers the current window
        addHotKey()
        centerWindow()
        return
    #up:: ;; maximize the current window
        addHotKey()
        maximize()
        return
    !wheeldown:: ;; scroll down one page (PageDown)
        Send, {PgDn}
        return
    !wheelup:: ;; scroll up one page (PageUp)
        Send, {PgUp}
        return
    !#down:: ;; move the mouse down 1 pixel
        addHotKey()
        MouseMove, 0, 1, 0, R
        return
    !#left:: ;; move the mouse left 1 pixel
        addHotKey()
        MouseMove, -1, 0, 0, R
        return
    !#right:: ;; move the mouse right 1 pixel
        addHotKey()
        MouseMove, 1, 0, 0, R
        return
    !#up:: ;; move the mouse up 1 pixel
        addHotKey()
        MouseMove, 0, -1, 0, R
        return
    ^#down:: ;; drag the mouse down 1 pixel
        addHotKey()
        MouseClickDrag, Left, 0, 0, 0, 1, 0, R
        return
    ^#left:: ;; drag the mouse left 1 pixel
        addHotKey()
        MouseClickDrag, Left, 0, 0, -1, 0, 0, R
        return
    ^#right:: ;; drag the mouse right 1 pixel
        addHotKey()
        MouseClickDrag, Left, 0, 0, 1, 0, 0, R
        return
    ^#up:: ;; drag the mouse up 1 pixel
        addHotKey()
        MouseClickDrag, Left, 0, 0, 0, -1, 0, R
        return
    +#down:: ;; resize window to 50% anchored to the bottom
        addHotKey()
        resizeTo("B")
        return
    +#left:: ;; resize window to 50% anchored to the left
        addHotKey()
        resizeTo("L")
        return
    +#right:: ;; resize window to 50% anchored to the right
        addHotKey()
        resizeTo("R")
        return
    +#up:: ;; resize window to 50% anchored to the top
        addHotKey()
        resizeTo("T")
        return
#If
;Transform
;---------
#If, toBool(configUser.enableHkTransform)
    ^+a:: ;; sorts (naturally) the currently selected text in ascending order
        addHotKey()
        sortSelected()
        return
    ^+b:: ;; wraps selected text (or whole line) in brackets
    ^+[:: ;; wraps selected text (or whole line) in brackets
    ^+]:: ;; wraps selected text (or whole line) in brackets
        addHotKey()
        wrapSelected("[", "]")
        return
    ^+d:: ;; sorts (naturally) the currently selected text in descending order
        addHotKey()
        sortSelected("d")
        return
    ^+e:: ;; encrypts/decrypts the currently selected text (not secure!)
        addHotKey()
        cryptSelected()
        return
    ^+i:: ;; converts the currently selected text to "iNVERTED cASE"
        addHotKey()
        transformSelected("I")
        return
    ^!n:: ;; strips prepended numbers from the selected lines
        addHotKey()
        numberRemoveSelected()
        return
    ^+n:: ;; prepends numbers to the selected lines
        addHotKey()
        numberSelected()
        return
    ^!+n:: ;; prepends numbers to the selected lines (prompts for starting #)
        addHotKey()
        numberSelectedPrompt()
        return
    ^+o:: ;; converts the currently selected text containing Oracle keywords to upper case
        addHotKey()
        upperCaseOracle()
        return
    ^+9:: ;; wraps selected text (or whole line) in parenthesis
    ^+0:: ;; wraps selected text (or whole line) in parenthesis
    ^+p:: ;; wraps selected text (or whole line) in parenthesis
        addHotKey()
        wrapSelected("(", ")")
        return
    ^+q:: ;; wraps selected text (or whole line) in quotes
    ^+':: ;; wraps selected text (or whole line) in quotes
        addHotKey()
        wrapSelected("""", """")
        return
    ^+r:: ;; reverses the currently selected text
        addHotKey()
        transformSelected("R")
        return
    ^+s:: ;; converts the currently selected text to "Sentence case"
        addHotKey()
        transformSelected("S")
        return
    ^+t:: ;; converts the currently selected text to "Title Case"
        addHotKey()
        transformSelected("T")
        return
    ^+w:: ;; wrap selected text to the specified width
        addHotKey()
        lineWrapSelected()
        return
    ^!w:: ;; unwrap selected lines that were previously wrapped
        addHotKey()
        lineUnwrapSelected()
        return
    !+,:: ;; removes HTML/XML tags from the currently selected text
    !+.:: ;; removes HTML/XML tags from the currently selected text
        addHotKey()
        untagifySelected()
        return
    ^+,:: ;; converts the currently selected text to HTML/XML tags
    ^+.:: ;; converts the currently selected text to HTML/XML tags
        addHotKey()
        tagifySelected()
        return
#If
;Transform (but not in EPP)
;--------------------------
#If, toBool(configUser.enableHkTransform) && !WinActive("ahk_exe i)EditPadPro\d*\.exe")
    ^+l:: ;; converts the currently selected text to "lower case"++except EditPad Pro
        addHotKey()
        transformSelected("L")
        return
    ^+u:: ;; converts the currently selected text to "UPPER CASE"++except EditPad Pro
        addHotKey()
        transformSelected("U")
        return
#If

;__________________________________________________
;functions
addHotKey() {
    global configUser
    configUser.hkSessionCount++
    configUser.hkTotalCount++
    value := configUser.hkTotalCount
    file := configUser.file
    IniWrite, %value%, %file%, config, hkTotalCount
}

addHotString() {
    global configUser
    configUser.hsSessionCount++
    configUser.hsTotalCount++
    value := configUser.hsTotalCount
    file := configUser.file
    IniWrite, %value%, %file%, config, hsTotalCount
}

ask(title, prompt, width:=250, height:=125, defaultValue:="") {
    orig_hWnd := WinExist("A")
    coord := getCenter(width, height)
    x := coord.x
    y := coord.y
    InputBox, value, %title%, %prompt%,, %width%, %height%, %x%, %y%,,, %defaultValue%
    WinActivate, ahk_id %orig_hWnd%
    value := Trim(value)
    return value
}

centerWindow(title:="A") {
    WinGetPos, winX, winY, winW, winH, %title%
    coord := getCenter(winW, winH)
    WinMove, %title%,, coord.x, coord.y
}

compareStrAsc(a, b) {
    return compareStr(a, b, "A")
}

compareStrDesc(a, b) {
    return compareStr(a, b, "D")
}

compareStr(a, b, direction:="A") {
    static regexComp := "(\d+|\D+)(.*)"
    result := 0
    direction := setCase(direction, "U")
    direction := (direction == "D" ? "D" : "A")
    a := stripEol(a)
    b := stripEol(b)
    if (RegExMatch(a, regexComp, a) + RegExMatch(b, regexComp, b)) {
        if (direction == "A") {
            result := a1 > b1 ? 1 : a1 < b1 ? -1 : compareStr(a2, b2, direction)
        }
        else {
            result := a1 > b1 ? -1 : a1 < b1 ? 1 : compareStr(a2, b2, direction)
        }
    }
    return result
}

contains(str, values*) {
    result := false
    for index, value in values {
        if (IsObject(value)) {
            for key, val in value {
                if (InStr(val, str)) {
                    result := true
                }
            }
        }
        else {
            result := InStr(value, str)
        }
    }
    return result
}

createUserFiles() {
    file := A_ScriptDir . "\HotScriptKeys.ahk"
    if (FileExist(file) == "") {
        FileAppend,
(
; All user-defined hotkeys should be declared below.
; Functions defined in HotScript are available for use here.

`/`*
    `#  - Win
    `!  - Alt
    `^  - Control
    `+  - Shift
    `<  - left key
    `>  - right key
    `*  - wild card `(fire even if extra modifier keys are pressed`)
    `~  - do not block native key function
    UP - fire upon key release instead of key press
`*`/

`/`*
Each hotkey should use the following format:

`^`!`+`m`:`: ;; a simple test key defined in an external file
    addHotKey`(`)
    showSplash`("This hotkey was defined by an external script!"`)
    return
`*`/

), %file%
    }
    file := A_ScriptDir . "\HotScriptStrings.ahk"
    if (FileExist(file) == "") {
        FileAppend,
(
; All user-defined hotstrings should be declared below.
; Functions defined in HotScript are available for use here.

`/`*
    `* `(asterisk`): An ending character `(e.g. space, period, or enter`) is not required to trigger the hotstring.

    `? `(question mark`): The hotstring will be triggered even when it is inside another word`; that is, when the character typed immediately before it is alphanumeric.

    B0 `(B followed by a zero`): Automatic backspacing is not done to erase the abbreviation you type.

    C1: Do not conform to typed case.
    Use this option to make auto-replace hotstrings case insensitive and prevent them from conforming to the case of the characters you actually type.
    Case-conforming hotstrings `(which are the default`) produce their replacement text in all caps if you type the abbreviation in all caps.
    If you type only the first letter in caps, the first letter of the replacement will also be capitalized `(if it is a letter`).
    If you type the case in any other way, the replacement is sent exactly as defined.

    O: Omit the ending character of auto-replace hotstrings when the replacement is produced.
    This is useful when you want a hotstring to be kept unambiguous by still requiring an ending character, but don't actually want the ending character to be shown on the screen.
`*`/

`/`*
Each hotstring should use the following format:

`:`*`:hw.`:`: ;; Hello World.
    addHotString`(`)
    sendText`("Hello World."`)
    return
`*`/

), %file%
    }
}

crypt(text) {
    result :=
    Loop, Parse, text
    {
        ascii := Asc(A_LoopField)
        if (ascii < 32) {
            result .= A_LoopField
        }
        else {
            result .= Chr(Asc(A_LoopField) ^ 129)
        }
    }
    return result
}

cryptSelected() {
    selText := getSelectedText()
    if (selText != "") {
        replaceSelected(crypt(selText))
    }
}

dragMouse() {
    MouseClickDrag, Left, 0, 1, 0, R
}

endsWith(str, value, caseInsensitive:="") {
    if (toBool(caseInsensitive)) {
        str := setCase(str, "L")
        value := setCase(value, "L")
    }
    StringRight, tmp, str, StrLen(value)
    result := (tmp == value)
    return result
}

extractKeys(lines) {
    global vkDelim
    keyList :=
    Loop, Parse, lines, `n, `r
    {
        line :=
        if (SubStr(Trim(A_LoopField), 1, 2) == ";;") {
            ;add description lines
            line := A_Index . vkDelim . SubStr(Trim(A_LoopField), 3) . "`n"
        }
        else if (SubStr(Trim(A_LoopField), 1, 1) == ";") {
            ;ignore commented lines
            line :=
        }
        else if (RegExMatch(Trim(A_LoopField), "^\s*(?<hk>[^: ]+(\s&\s)*[^:, ]*)::(?<cmd>.*?)(?:(?<=\s);;(?<desc>.*))?$", _)) {
            ;hotkeys
            line := A_Index . vkDelim . "hk" . vkDelim . _hk . vkDelim . (_desc ? _desc : _cmd) . "`n"
        }
        else if (RegExMatch(Trim(A_LoopField), "^\s*:(?<opt>[^:, ]*):(?<hs>[^:]+)::(?<rep>.*?)(?:(?<=\s);;(?<desc>.*))?$", _)) {
            ;hotstrings
            line := A_Index . vkDelim . "hs" . vkDelim . _hs . vkDelim . (_desc ? _desc : _rep) . vkDelim . _opt . "`n"
        }
        if (line != "") {
            keyList .= line
        }
    }
    return keyList
}

findOrRunByExe(name) {
    exe := name . ".exe"
    regExe := "i)" . exe
    if (WinExist("ahk_exe " . regExe)) {
        WinActivate
    }
    else {
        runTarget(exe)
    }
}

getActiveMonitor(hWnd:="A") {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    monIdx := 1
    VarSetCapacity(monInfo, 40)
    NumPut(40, monInfo)

    if (monitorHandle := DllCall("MonitorFromWindow", "uint", hWnd, "uint", 0x2))
        && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monInfo) {
        monitorLeft   := NumGet(monInfo,  4, "Int")
        monitorTop    := NumGet(monInfo,  8, "Int")
        monitorRight  := NumGet(monInfo, 12, "Int")
        monitorBottom := NumGet(monInfo, 16, "Int")
        workLeft      := NumGet(monInfo, 20, "Int")
        workTop       := NumGet(monInfo, 24, "Int")
        workRight     := NumGet(monInfo, 28, "Int")
        workBottom    := NumGet(monInfo, 32, "Int")
        isPrimary     := NumGet(monInfo, 36, "Int") & 1
        SysGet, monitorCount, MonitorCount
        Loop, %monitorCount%
        {
            SysGet, curMon, Monitor, %A_Index%
            if (monitorLeft == curMonLeft && monitorTop == curMonTop && monitorRight == curMonRight && monitorBottom == curMonBottom) {
                monIdx := A_Index
                break
            }
        }
    }
    return monIdx
}

getCenter(winW, winH, monitor:="A") {
    global Coords
    global monitors
    if (monitor == "A") {
        monitor := getActiveMonitor()
    }
    else {
        if (monitor < monitors.count) {
            monitor := 1
        }
        else if (monitor > monitors.count) {
            monitor := monitors.count
        }
    }
    coord := new Coords
    targetMon := monitors[monitor]
    newX := targetMon.left + (targetMon.workWidth / 2) - (winW / 2)
    newY := targetMon.top + (targetMon.workHeight / 2) - (winH / 2)
    coord.x := newX
    coord.y := newY
    return coord
}

getEol(text) {
    eol_win := "`r`n"
    eol_nix := "`n"
    eol_mac := "`r"
    if (InStr(text, eol_win)) {
        ; check this first because it contains both
        eol := eol_win
    }
    else if (InStr(text, eol_nix)) {
        eol := eol_nix
    }
    else if (InStr(text, eol_mac)) {
        eol := eol_mac
    }
    else {
        ; otherwise, default to Windows
        eol := eol_win
    }
    return eol
}

getListSize(list, delim:="") {
    delim := (delim == "" ? "`r`n" : delim)
    tmpCount := 0
    Loop, Parse, list, %delim%
    {
        tmpCount++
    }
    return tmpCount
}

getSelectedText() {
    prevClipboard := ClipboardAll
    Clipboard :=
    Sleep 20
    Send ^c
    ClipWait, 0
    selText := (ErrorLevel ? "" : Clipboard)
    Clipboard := prevClipboard
    prevClipboard :=
    return selText
}

getSelectedTextOrPrompt(title) {
    selText := getSelectedText()
    if (selText == "") {
        hWnd := WinExist("A")
        selText := ask(title, "Please enter a phrase or value...", 500)
        WinActivate, ahk_id %hWnd%
    }
    return selText
}

hideWindow() {
    global hiddenWindows
    hWnd := WinExist("A")
    if (IsWindow(hWnd)) {
        hiddenWindows .= (hiddenWindows ? "|" : "") . hWnd
        WinHide, ahk_id %hWnd%
        GroupActivate, AllWindows, R
    }
}

hkToStr(key) {
    static regexKeys :=
    static regexUpper :=
    if (regexKeys == "") {
        regexKeys := "i)(a)(dd|lt|pp[1-2]|pps)|(b)(ack|reak|rowser_|s|utton)|(c)(aps|lear|ontrol|trl)|(d)(el|elete|iv|n|ot|own)|(e)(nd|nter|sc|scape)|(f)([1-9]\b|1[0-9]\b|2[0-4]\b|avorites|orward)|(h)(elp|ome)|(i)(ns|nsert)|(joy)([1-9]\b|[1-2][0-9]\b|3[0-2]\b)|(k)(ey)|(l)(aunch_|eft|ock)|(la)(lt)|(lb)(utton)|(lc)(ontrol|trl)|(ls)(hift)|(lw)(in)|(m)(ail|edia_?|ult|ute)|(mb)(utton)|(n)(ext|um)|(p)(ad\d?|ause|g|lay_?|rev|rint)|(r)(efresh|eturn|ight)|(ra)(lt)|(rb)(utton)|(rc)(ontrol|trl)|(rs)(hift)|(rw)(in)|(s)(creen|croll|earch|hift|leep|pace|top|ub)|(sc)(\d{3}\b)|(t)(ab)|(u)(p)|(vk)([\da-f]{2}\b)|(v)(olume_)|(w)(heel|in)|(xb)(utton\d?)|(\b[a-z]\b)"
        regexUpper := "$U{1}${2}$U{3}${4}$U{5}${6}$U{7}${8}$U{9}${10}$U{11}${12}$U{13}${14}$U{15}${16}$U{17}${18}$U{19}${20}$U{21}${22}$U{23}${24}$U{25}${26}$U{27}${28}$U{29}${30}$U{31}${32}$U{33}${34}$U{35}${36}$U{37}${38}$U{39}${40}$U{41}${42}$U{43}${44}$U{45}${46}$U{47}${48}$U{49}${50}$U{51}${52}$U{53}${54}$U{55}${56}$U{57}${58}$U{59}${60}$U{61}${62}$U{63}${64}$U{65}${66}$U{67}${68}$U{69}${70}$U{71}${72}$U{73}${74}$U{75}${76}$U{77}${78}$U{79}${80}$U{81}${82}$U{83}${84}$U{85}${86}$U{87}${88}$U{89}${90}$U{91}${92}$U{93}${94}$U{95}${96}$U{97}${98}$U{99}${100}"
    }

    hook := (InStr(key, "$") ? " [hook]" : "")
    StringReplace, key, key, $,
    StringReplace, key, key, ^, Ctrl-
    StringReplace, key, key, !, Alt-
    StringReplace, key, key, +, Shift-
    StringReplace, key, key, #, Win-
    StringReplace, key, key, &, +
    key := RegExReplace(key, regexKeys, regexUpper)
    return (key . hook)
}

iniReadValue(config, section, key, defaultValue:="") {
    file := config.file
    IniRead, value, %file%, %section%, %key%, %defaultValue%
    return value
}

init() {
    global MY_TITLE
    global refreshMonitorInterval

    loadConfig()
    createUserFiles()
    icoDll := A_WinDir . "\system32\wmploc.dll"
    if (FileExist(icoDLL)) {
        Menu, Tray, Icon, %icoDll%, 16
    }
    Menu, Tray, Tip, %MY_TITLE%
    GoSub, initMonitors
    SetTimer, initMonitors, %refreshMonitorInterval%
}

iniWriteValue(config, section, key, value) {
    file := config.file
    IniWrite, %value%, %file%, %section%, %key%
}

isUrl(text) {
    ; this does not support mailto urls (yet!)
    result := RegExMatch(text, "i)^(?:\b[a-z\d.-]+://[^<>\s]+|\b(?:(?:(?:[^\s!@#$%^&*()_=+[\]{}\|;:'"",.<>/?]+)\.)+(?:ac|ad|aero|ae|af|ag|ai|al|am|an|ao|aq|arpa|ar|asia|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|biz|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|cat|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|coop|com|co|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|info|int|in|io|iq|ir|is|it|je|jm|jobs|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mobi|mo|mp|mq|mr|ms|mt|museum|mu|mv|mw|mx|my|mz|name|na|nc|net|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pro|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tel|tf|tg|th|tj|tk|tl|tm|tn|to|tp|travel|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|xn--0zwm56d|xn--11b5bs3a9aj6g|xn--80akhbyknj4f|xn--9t4b11yi5a|xn--deba0ad|xn--g6w251d|xn--hgbk6aj7f53bba|xn--hlcj6aya9esc7a|xn--jxalpdlp|xn--kgbechtv|xn--zckzah|ye|yt|yu|za|zm|zw)|(?:(?:[0-9]|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.){3}(?:[0-9]|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]))(?:[;/][^#?<>\s]*)?(?:\?[^#<>\s]*)?(?:#[^<>\s]*)?(?!\w))$", matchStr)
    return (result == 1)
}

isWindow(hWnd) {
    WinGet, s, Style, ahk_id %hWnd%
    return (s & 0xC00000 ? (s & 0x80000000 ? 0 : 1) : 0)
}

lineUnwrapSelected() {
    selText := getSelectedText()
    StringReplace selText, selText, %A_Space%`r`n, %A_Space%, All
    pasteText(selText)
}

lineWrapSelected() {
    selText := getSelectedText()
    static width := 80
    tmpWidth := ask("Enter Width", "Maximum number of characters per line:", width)
    if (ErrorLevel) {
        return
    }
    width := tmpWidth
    tmpWidth := "(?=.{" . width + 1 . ",})(.{1," . width - 1 . "}[^ ]) +"
    selText := RegExReplace(selText, tmpWidth, "$1 `r`n")
    pasteText(selText)
}

listToArray(list, delim:="") {
    delim := (delim == "" ? "`r`n" : delim)
    arr := Object()
    Loop, Parse, list, %delim%
    {
        arr[A_Index] := A_LoopField
    }
    return arr
}

loadConfig() {
    global MY_VERSION
    global configDefault
    global configUser
    file := configDefault.file
    saveDefault := false
    if (FileExist(configDefault.file) == "") {
        saveDefault := true
    }
    else {
        ; check version of default
        defaultVer := IniReadValue(configDefault, "config", "version")
        if (MY_VERSION != defaultVer) {
            ; different version so need to delete it
            FileDelete, %file%
            saveDefault := true
        }
    }
    ; load from default config first
    configDefault.hkTotalCount := IniReadValue(configDefault, "config", "hkTotalCount", configDefault.hkTotalCount)
    configDefault.hsTotalCount := IniReadValue(configDefault, "config", "hsTotalCount", configDefault.hsTotalCount)
    configDefault.enableHkAction := IniReadValue(configDefault, "config", "enableHkAction", configDefault.enableHkAction)
    configDefault.enableHkDos := IniReadValue(configDefault, "config", "enableHkDos", configDefault.enableHkDos)
    configDefault.enableHkEpp := IniReadValue(configDefault, "config", "enableHkEpp", configDefault.enableHkEpp)
    configDefault.enableHkMisc := IniReadValue(configDefault, "config", "enableHkMisc", configDefault.enableHkMisc)
    configDefault.enableHkMovement := IniReadValue(configDefault, "config", "enableHkMovement", configDefault.enableHkMovement)
    configDefault.enableHkTransform := IniReadValue(configDefault, "config", "enableHkTransform", configDefault.enableHkTransform)
    configDefault.enableHsAlias := IniReadValue(configDefault, "config", "enableHsAlias", configDefault.enableHsAlias)
    configDefault.enableHsAutoCorrect := IniReadValue(configDefault, "config", "enableHsAutoCorrect", configDefault.enableHsAutoCorrect)
    configDefault.enableHsCode := IniReadValue(configDefault, "config", "enableHsCode", configDefault.enableHsCode)
    configDefault.enableHsDates := IniReadValue(configDefault, "config", "enableHsDates", configDefault.enableHsDates)
    configDefault.enableHsDos := IniReadValue(configDefault, "config", "enableHsDos", configDefault.enableHsDos)
    configDefault.enableHsHtml := IniReadValue(configDefault, "config", "enableHsHtml", configDefault.enableHsHtml)
    configDefault.enableHsJira := IniReadValue(configDefault, "config", "enableHsJira", configDefault.enableHsJira)
    configDefault.enableHsSql := IniReadValue(configDefault, "config", "enableHsSql", configDefault.enableHsSql)
    configDefault.jiraPanels.format := IniReadValue(configDefault, "jira", "panelFormat", "borderStyle=solid| borderColor=#9EB6D4| titleBGColor=#C0CFDD| bgColor=#E0EFFF")
    configDefault.jiraPanels.formatBlue := IniReadValue(configDefault, "jira", "panelFormatBlue", "borderStyle=solid| borderColor=#99BCE8| titleBGColor=#C2D8F0| bgColor=#DFE9F6")
    configDefault.jiraPanels.formatGreen := IniReadValue(configDefault, "jira", "panelFormatGreen", "borderStyle=solid| borderColor=#9EC49F| titleBGColor=#BBDABE| bgColor=#DDFADE")
    configDefault.jiraPanels.formatRed := IniReadValue(configDefault, "jira", "panelFormatRed", "borderStyle=solid| borderColor=#DF9898| titleBGColor=#DFC7C7| bgColor=#FFE7E7")
    configDefault.jiraPanels.formatYellow := IniReadValue(configDefault, "jira", "panelFormatYellow", "borderStyle=solid| borderColor=#F7DF92| titleBGColor=#DFDFBD| bgColor=#FFFFDD")

    quickLookupSitesFromIni(configDefault)
    if (configDefault.quickLookupSites == "") {
        defaultSites =
        (LTrim
            &Jira
            http://jira.powerschool.com/browse/@selection@
            &Confluence
            http://confluence.powerschool.com/dosearchsite.action?queryString=@selection@
            As &Application
            @selection@
            -
            -
            &Google
            http://www.google.com/search?q=@selection@
            Google &Images
            http://images.google.com/images?q=@selection@
            -
            -
            &Dictionary
            http://dictionary.reference.com/browse/@selection@
            &Wikipedia
            http://en.wikipedia.org/w/wiki.phtml?search=@selection@
            I&MDB
            http://www.imdb.com/find?q=@selection@
            &YouTube
            http://www.youtube.com/results?search_query=@selection@
            -
            -
            AutoHotkey Manual
            http://www.autohotkey.com/docs/commands/@selection@.htm
            AutoHotKey Forum
            http://www.google.com/search?ie=utf-8&num=100&oe=utf-8&q=@selection@ site:autohotkey.com/forum/
            -
            -
            Cancel
            Cancel
        )
        configDefault.quickLookupSites := defaultSites
    }
    if (saveDefault) {
        saveConfig(configDefault)
    }
    ; now load from the user config, using the values from default if necessary
    configUser.hkTotalCount := IniReadValue(configUser, "config", "hkTotalCount", configDefault.hkTotalCount)
    configUser.hsTotalCount := IniReadValue(configUser, "config", "hsTotalCount", configDefault.hsTotalCount)
    configUser.enableHkAction := IniReadValue(configUser, "config", "enableHkAction", configDefault.enableHkAction)
    configUser.enableHkDos := IniReadValue(configUser, "config", "enableHkDos", configDefault.enableHkDos)
    configUser.enableHkEpp := IniReadValue(configUser, "config", "enableHkEpp", configDefault.enableHkEpp)
    configUser.enableHkMisc := IniReadValue(configUser, "config", "enableHkMisc", configDefault.enableHkMisc)
    configUser.enableHkMovement := IniReadValue(configUser, "config", "enableHkMovement", configDefault.enableHkMovement)
    configUser.enableHkTransform := IniReadValue(configUser, "config", "enableHkTransform", configDefault.enableHkTransform)
    configUser.enableHsAlias := IniReadValue(configUser, "config", "enableHsAlias", configDefault.enableHsAlias)
    configUser.enableHsAutoCorrect := IniReadValue(configUser, "config", "enableHsAutoCorrect", configDefault.enableHsAutoCorrect)
    configUser.enableHsCode := IniReadValue(configUser, "config", "enableHsCode", configDefault.enableHsCode)
    configUser.enableHsDates := IniReadValue(configUser, "config", "enableHsDates", configDefault.enableHsDates)
    configUser.enableHsDos := IniReadValue(configUser, "config", "enableHsDos", configDefault.enableHsDos)
    configUser.enableHsHtml := IniReadValue(configUser, "config", "enableHsHtml", configDefault.enableHsHtml)
    configUser.enableHsJira := IniReadValue(configUser, "config", "enableHsJira", configDefault.enableHsJira)
    configUser.enableHsSql := IniReadValue(configUser, "config", "enableHsSql", configDefault.enableHsSql)
    configUser.jiraPanels.format := IniReadValue(configUser, "jira", "panelFormat", configDefault.jiraPanels.format)
    configUser.jiraPanels.formatBlue := IniReadValue(configUser, "jira", "panelFormatBlue", configDefault.jiraPanels.formatBlue)
    configUser.jiraPanels.formatGreen := IniReadValue(configUser, "jira", "panelFormatGreen", configDefault.jiraPanels.formatGreen)
    configUser.jiraPanels.formatRed := IniReadValue(configUser, "jira", "panelFormatRed", configDefault.jiraPanels.formatRed)
    configUser.jiraPanels.formatYellow := IniReadValue(configUser, "jira", "panelFormatYellow", configDefault.jiraPanels.formatYellow)
    quickLookupSitesFromIni(configUser)
    if (configUser.quickLookupSites == "") {
        configUser.quickLookupSites := configDefault.quickLookupSites
    }
    ; save after loading to make sure any new values are persisted
    saveConfig(configUser, configDefault)
}

maximize(hWnd:="") {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    if (isWindow(hWnd)) {
        WinGet, minMaxState, MinMax, ahk_id %hWnd%
        if (minMaxState == 1) {
            WinRestore, ahk_id %hWnd%
        }
        else {
            WinMaximize, ahk_id %hWnd%
        }
    }
}

minimize(hWnd:="") {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    if (isWindow(hWnd)) {
        WinGet, minMaxState, MinMax, ahk_id %hWnd%
        if (minMaxState == -1) {
            WinRestore, ahk_id %hWnd%
        }
        else {
            WinMinimize, ahk_id %hWnd%
        }
    }
}

moveToMonitor(hWnd:="", direction:=1, keepRelativeSize:=true) {
    hWnd := setCase(Trim(hWnd), "U")
    if (hWnd == "" || hWnd == "A") {
        hWnd := WinExist("A")
    }
    else if (hWnd == "M") {
        MouseGetPos, MouseX, MouseY, hWnd
    }
    direction := (direction == -1 ? -1 : 1)
    if (!WinExist("ahk_id " . hWnd)) {
        SoundPlay, *64
        ;MsgBox, 16, moveToMonitor() - Error, Specified window does not exist.`nWindow ID = %hWnd%
        return 0
    }

    SysGet, monCount, MonitorCount
    if (monCount <= 1) {
        return 1
    }

    Loop, %monCount%
    {
        SysGet, Monitor%A_Index%, MonitorWorkArea, %A_Index%
        Monitor%A_Index%Width := Monitor%A_Index%Right - Monitor%A_Index%Left
        Monitor%A_Index%Height := Monitor%A_Index%Bottom - Monitor%A_Index%Top
    }
    WinGet, origMinMax, MinMax, ahk_id %hWnd%
    if (origMinMax == -1) {
        return 0
    }
    if (origMinMax == 1) {
        WinRestore, ahk_id %hWnd%
    }
    WinGetPos, WinX, WinY, WinW, WinH, ahk_id %hWnd%
    WinCenterX := WinX + WinW / 2
    WinCenterY := WinY + WinH / 2
    curMonitor := 0
    Loop, %monCount%
    {
        if ((WinCenterX >= Monitor%A_Index%Left) && (WinCenterX < Monitor%A_Index%Right) && (WinCenterY >= Monitor%A_Index%Top) && (WinCenterY < Monitor%A_Index%Bottom)) {
            curMonitor := A_Index
            break
        }
    }

    nextMonitor := curMonitor + direction
    if (nextMonitor > monCount) {
        nextMonitor := 1
    }
    else if (nextMonitor <= 0) {
        nextMonitor := monCount
    }

    WinMoveX := (WinX - Monitor%curMonitor%Left) * Monitor%NextMonitor%Width // Monitor%curMonitor%Width + Monitor%NextMonitor%Left
    WinMoveY := (WinY - Monitor%curMonitor%Top) * Monitor%NextMonitor%Height // Monitor%curMonitor%Height + Monitor%NextMonitor%Top

    if (keepRelativeSize) {
        WinMoveW := WinW * Monitor%NextMonitor%Width // Monitor%curMonitor%Width
        WinMoveH := WinH * Monitor%NextMonitor%Height // Monitor%curMonitor%Height
    }
    else {
        WinMoveW := WinW
        WinMoveH := WinH
    }

    WinMove, ahk_id %hWnd%,, WinMoveX, WinMoveY, WinMoveW, WinMoveH
    if (origMinMax == 1) {
        WinMaximize, ahk_id %hWnd%
    }
    return 1
}

numberRemoveSelected() {
    selText := getSelectedText()
    if (selText == "") {
        Send, {End}{Home}+{End}
        selText := getSelectedText()
    }
    if (selText != "") {
        eol := getEol(selText)
        first := true
        newText :=
        Loop, Parse, selText, `n, `r
        {
            if (first) {
                first := false
            }
            else {
                newText .= eol
            }
            newText .= RegexReplace(A_LoopField, "^\d+\.\s?", "")
        }
        replaceSelected(newText)
    }
}

numberSelected(start:="1") {
    selText := getSelectedText()
    if (selText == "") {
        Send, {End}{Home}+{End}
        selText := getSelectedText()
    }
    if (selText != "") {
        eol := getEol(selText)
        hasEol := endsWith(selText, eol)
        if (hasEol) {
            selText := SubStr(selText, 1, StrLen(selText) - StrLen(eol))
        }
        first := true
        newText :=
        count := start
        Loop, Parse, selText, `n, `r
        {
            newText .= count . ". " . A_LoopField . eol
            count++
        }
        if (!hasEol) {
            newText := SubStr(newText, 1, StrLen(newText) - StrLen(eol))
        }
        replaceSelected(newText)
    }
}

numberSelectedPrompt() {
    promptNumber:
    start := ask("Auto-Number", "Starting number", 1)
    if (ErrorLevel) {
        return
    }
    if start is not integer
    {
        Sleep, 100
        MsgBox, Invalid starting number (%start%) - must be an integer.
        goto promptNumber
    }
    else {
        numberSelected(start)
    }
}

pasteText(text:="")
{
    if (text != "") {
        prevClipboard := ClipboardAll
        Clipboard :=
        Sleep 20
        Clipboard := text
        Send, ^v
        Sleep 200 ; wait or the clipboard is replaced with previous before it gets a chance to paste it, resulting in pasting the original clipboard
        Clipboard := prevClipboard
        prevClipboard :=
    }
    else {
        Send, {Del}
    }
    return
}

qmenuCreate(menuName, menuDef, menuLabel)
{
    global MENU_SEP
    Loop Parse, menuDef, `n
    {
        if (Mod(A_Index, 2) == 1) {
            qtext := (A_LoopField == MENU_SEP ? "" : A_LoopField)
            Menu, %menuName%, Add, %qtext%, %menuLabel%
        }
    }
}

qmenuRun(idx) {
    global configUser
    global quickText
    menuDef := configUser.quickLookupSites
    Loop Parse, menuDef, `n
    {
        if (idx * 2 == A_Index) {
            if (A_LoopField != "Cancel") {
                StringReplace, command, A_LoopField, @selection@, %quickText%, All
                Run, %command%
                break
            }
        }
    }
}

quickLookupSitesFromIni(config) {
    file := config.file
    allSites := ""
    IniRead, sites, %file%, quickLookup
    Loop Parse, sites, `n
    {
        value := Trim(SubStr(A_LoopField, (InStr(A_LoopField, "=") + 1)))
        if (value != "") {
            allSites .= value . "`n"
        }
    }
    config.quickLookupSites := allSites
}

quickLookupSitesToIni(config) {
    file := config.file
    sites := config.quickLookupSites
    keyCount := 1
    key := ""
    IniDelete, %file%, quickLookup
    Loop Parse, sites, `n
    {
        value := Trim(A_LoopField)
        if (value != "") {
            key := "site" . keyCount . (endsWith(key, "Name") ? "URL" : "Name")
            iniWriteValue(config, "quickLookup", key, value)
            if (endsWith(key, "URL")) {
                keyCount++
            }
        }
    }
}

readKeysFromFile(script) {
    static file :=
    static formatted :=
    if (file == "" || file != script) {
        FileRead, contents, %script%
        formatted := extractKeys(contents)
        file := script
    }
    return formatted
}

refreshMonitors() {
    ; why does the timer to initMonitors call a label?
    ;       Because timers can only call labels.
    ; why does the label initMonitors call this function?
    ;       Because labels are global, and therefore so are any variables it creates, which can collide with other variables.
    global MonitorInfo
    global monitors
    SysGet, monCount, MonitorCount
    SysGet, monPrimary, MonitorPrimary
    monitors.count := monCount
    monitors.primary := monPrimary
    Loop % monitors.count
    {
        SysGet, monName, MonitorName, %A_Index%
        SysGet, mon, Monitor, %A_Index%
        SysGet, monWork, MonitorWorkArea, %A_Index%

        curMon := new MonitorInfo
        curMon.idx := A_Index
        curMon.name := monName
        curMon.left := monLeft
        curMon.right := monRight
        curMon.top := monTop
        curMon.bottom := monBottom
        curMon.height := (monBottom - monTop)
        curMon.width := (monRight - monLeft)
        curMon.workLeft := monWorkLeft
        curMon.workRight := monWorkRight
        curMon.workTop := monWorkTop
        curMon.workBottom := monWorkBottom
        curMon.workHeight := (monWorkBottom - monWorkTop)
        curMon.workWidth := (monWorkRight - monWorkLeft)
        monitors[curMon.idx] := curMon
    }
}

repeatStr(value, count) {
    result :=
    Loop, %count%
    {
        result .= value
    }
    return result
}

replaceSelected(text) {
    pasteText(text)
    ;len := StrLen(text)
    ; TODO - how to select multiple lines?
    ; get text before pasting
    ;   create an array to store leftCount
    ;   in a loop
    ;       increment leftCount for everything that is not an EOL
    ;           once an EOL is found, create new array entry for leftCount
    ;   after pasting, for each value in the array
    ;       do a Shift-Left x leftCount
    ;       then one more to handle the EOL
    ;Send, {Left %len%}+{Right %len%}
}

resizeTo(anchor) {
    global monitors
    anchor := setCase(anchor, "U")
    curMonitor := getActiveMonitor()
    curMon := monitors[curMonitor]

    hWnd := WinExist("A")
    if (anchor == "T") {
        newX := curMon.workLeft
        newY := curMon.workTop
        newH := (curMon.workHeight / 2)
        newW := curMon.workWidth
    }
    else if (anchor == "B") {
        newX := curMon.workLeft
        newY := (curMon.workTop + (curMon.workHeight / 2))
        newH := (curMon.workHeight / 2)
        newW := curMon.workWidth
    }
    else if (anchor == "R") {
        newX := (curMon.workLeft + (curMon.workWidth / 2))
        newY := curMon.workTop
        newH := curMon.workHeight
        newW := (curMon.workWidth / 2)
    }
    else {
        newX := curMon.workLeft
        newY := curMon.workTop
        newH := curMon.workHeight
        newW := (curMon.workWidth / 2)
    }
    WinGet, minMaxState, MinMax, ahk_id %hWnd%
    if (minMaxState == 1) {
        WinRestore, ahk_id %hWnd%
    }
    WinMove, ahk_id %hWnd%,, %newX%, %newY%, %newW%, %newH%
}

restoreHiddenWindows() {
    global hiddenWindows
    Loop, Parse, hiddenWindows, |
    {
        WinShow, ahk_id %A_LoopField%
        WinActivate, ahk_id %A_LoopField%
    }
    hiddenWindows :=
}

reverse(str) {
    result :=
    eol := getEol(str)
    StringReplace, str, str, %eol%, % Chr(29), All
    Loop, parse, str
    {
        result := A_LoopField . result
    }
    StringReplace, result, result, % Chr(29), %eol%, All
    return result
}

runAhkHelp() {
    if (WinExist("AutoHotkey Help")) {
        WinActivate
    }
    else {
        SplitPath A_AhkPath, , ahkPath
        runTarget(ahkPath . "\AutoHotkey.chm")
    }
}

runDos() {
    isExist := WinExist("ahk_class ConsoleWindowClass")
    isActive := WinActive("ahk_class ConsoleWindowClass")
    if (isExist && not isActive) {
        ; activate it only if it exists but does not have focus
        WinActivate
    }
    else {
        ; create it if it does not exist or was already focused and user wants another instance
        EnvGet, sysDrive, SystemDrive
        workDir := sysDrive . "\"
        runTarget("cmd.exe", workDir)
    }
}

runEditPadPro() {
    regExe := "i)EditPadPro\d*\.exe"
    if (WinExist("ahk_exe " . regExe)) {
        WinActivate
    }
    else {
        RegRead, epp, HKEY_CLASSES_ROOT, editpad\shell\open\command
        if (ErrorLevel) {
            MsgBox, Unable to determine path to EditPad Pro...
        }
        else {
            param := """`%1"""
            if (InStr(epp, param)) {
                StringTrimRight, exe, epp, 5
            }
            else {
                exe := epp
            }
            runTarget(exe)
        }
    }
}

runFileLocatorPro() {
    regExe := "i)FileLocatorPro.exe"
    if (WinExist("ahk_exe " . regExe)) {
        WinActivate
    }
    else {
        RegRead, exe, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\FileLocatorPro.exe
        if (ErrorLevel) {
            MsgBox, Unable to determine path to FileLocatorPro...
        }
        else {
            runTarget(exe)
        }
    }
}

runHotkey(label) {
    if (IsLabel(label)) {
        Gui, Cancel
        Gosub, %label%
    }
    else {
        MsgBox, Unable to find label for: [%label%]
    }
}

runPerforce() {
    regExe := "i)p4v.exe"
    if (WinExist("ahk_exe " . regExe)) {
        WinActivate
    }
    else {
        RegRead, exe, HKEY_LOCAL_MACHINE, SOFTWARE\Wow6432Node\Perforce\Environment, P4INSTROOT
        if (ErrorLevel) {
            MsgBox, Unable to determine path to Perforce...
        }
        else {
            runTarget(exe)
        }
    }
}

runQuickLookup() {
    global configUser
    global quickText
    quickText := getSelectedTextOrPrompt("Quick Lookup")
    quickText := Trim(quickText, " `t`r`n")
    if (quickText != "") {
        quickText := urlEncode(quickText)
        qmenuCreate("qlookupMenu", configUser.quickLookupSites, "QuickLookup")
        Menu qlookupMenu, Color, FFFFDD
        Menu qlookupMenu, Show
        Menu qlookupMenu, Delete
    }
}

runRegexBuddy() {
    regExe := "i)RegexBuddy\d*\.exe"
    if (WinExist("ahk_exe " . regExe)) {
        WinActivate
    }
    else {
        RegRead, exe, HKEY_CLASSES_ROOT, regexbuddy\shell\open\command
        if (ErrorLevel) {
            MsgBox, Unable to determine path to RegexBuddy...
        }
        else {
            param := """`%1"""
            if (InStr(exe, param)) {
                StringTrimRight, exe, exe, 5
            }
            runTarget(exe)
        }
    }
}

runSelectedText() {
    selText := getSelectedTextOrPrompt("Google Search")
    selText := Trim(selText, " `t`r`n")
    if (selText != "") {
        if (isUrl(selText)) {
            if (!startsWith(selText, "http", true) && !startsWith(selText, "ftp", true) && !startsWith(selText, "www.", true)) {
                selText := "http://" . selText
            }
            Run, %selText%
        }
        else {
            searchText := urlEncode(selText)
            Run, http://www.google.com/search?q=%searchText%
        }
    }
}

runServices() {
    title := "Services"
    if (WinExist("Services")) {
        WinActivate
    }
    else {
        runTarget("services.msc")
    }
}

runTarget(target, workDir:="") {
    Run, %target%, %workDir%, , pid
    Sleep 200
    WinActivate, ahk_pid %pid%
}

saveConfig(config, defaultConfig:=0) {
    global MY_VERSION
    file := config.file
    ; always save these values
    iniWriteValue(config, "config", "hkTotalCount", config.hkTotalCount)
    iniWriteValue(config, "config", "hsTotalCount", config.hsTotalCount)
    if (defaultConfig == 0) {
        ; save it, since nothing to compare against
        iniWriteValue(config, "config", "version", MY_VERSION)
        iniWriteValue(config, "config", "enableHkAction", config.enableHkAction)
        iniWriteValue(config, "config", "enableHkDos", config.enableHkDos)
        iniWriteValue(config, "config", "enableHkEpp", config.enableHkEpp)
        iniWriteValue(config, "config", "enableHkMisc", config.enableHkMisc)
        iniWriteValue(config, "config", "enableHkMovement", config.enableHkMovement)
        iniWriteValue(config, "config", "enableHsAlias", config.enableHsAlias)
        iniWriteValue(config, "config", "enableHsAutoCorrect", config.enableHsAutoCorrect)
        iniWriteValue(config, "config", "enableHsCode", config.enableHsCode)
        iniWriteValue(config, "config", "enableHsDates", config.enableHsDates)
        iniWriteValue(config, "config", "enableHsDos", config.enableHsDos)
        iniWriteValue(config, "config", "enableHsHtml", config.enableHsHtml)
        iniWriteValue(config, "config", "enableHsJira", config.enableHsJira)
        iniWriteValue(config, "config", "enableHsSql", config.enableHsSql)
        iniWriteValue(config, "jira", "panelFormat", config.jiraPanels.format)
        iniWriteValue(config, "jira", "panelFormatBlue", config.jiraPanels.formatBlue)
        iniWriteValue(config, "jira", "panelFormatGreen", config.jiraPanels.formatGreen)
        iniWriteValue(config, "jira", "panelFormatRed", config.jiraPanels.formatRed)
        iniWriteValue(config, "jira", "panelFormatYellow", config.jiraPanels.formatYellow)
        quickLookupSitesToIni(config)
    }
    else {
        ; compare current against default, saving only the values that are different
        if (config.enableHkAction != defaultConfig.enableHkAction) {
            iniWriteValue(config, "config", "enableHkAction", config.enableHkAction)
        }
        if (config.enableHkDos != defaultConfig.enableHkDos) {
            iniWriteValue(config, "config", "enableHkDos", config.enableHkDos)
        }
        if (config.enableHkEpp != defaultConfig.enableHkEpp) {
            iniWriteValue(config, "config", "enableHkEpp", config.enableHkEpp)
        }
        if (config.enableHkMisc != defaultConfig.enableHkMisc) {
            iniWriteValue(config, "config", "enableHkMisc", config.enableHkMisc)
        }
        if (config.enableHkMovement != defaultConfig.enableHkMovement) {
            iniWriteValue(config, "config", "enableHkMovement", config.enableHkMovement)
        }
        if (config.enableHsAlias != defaultConfig.enableHsAlias) {
            iniWriteValue(config, "config", "enableHsAlias", config.enableHsAlias)
        }
        if (config.enableHsAutoCorrect != defaultConfig.enableHsAutoCorrect) {
            iniWriteValue(config, "config", "enableHsAutoCorrect", config.enableHsAutoCorrect)
        }
        if (config.enableHsCode != defaultConfig.enableHsCode) {
            iniWriteValue(config, "config", "enableHsCode", config.enableHsCode)
        }
        if (config.enableHsDates != defaultConfig.enableHsDates) {
            iniWriteValue(config, "config", "enableHsDates", config.enableHsDates)
        }
        if (config.enableHsDos != defaultConfig.enableHsDos) {
            iniWriteValue(config, "config", "enableHsDos", config.enableHsDos)
        }
        if (config.enableHsHtml != defaultConfig.enableHsHtml) {
            iniWriteValue(config, "config", "enableHsHtml", config.enableHsHtml)
        }
        if (config.enableHsJira != defaultConfig.enableHsJira) {
            iniWriteValue(config, "config", "enableHsJira", config.enableHsJira)
        }
        if (config.enableHsSql != defaultConfig.enableHsSql) {
            iniWriteValue(config, "config", "enableHsSql", config.enableHsSql)
        }
        if (config.jiraPanels.format != defaultConfig.jiraPanels.format) {
            iniWriteValue(config, "jira", "panelFormat", config.jiraPanels.format)
        }
        if (config.jiraPanels.formatBlue != defaultConfig.jiraPanels.formatBlue) {
            iniWriteValue(config, "jira", "panelFormatBlue", config.jiraPanels.formatBlue)
        }
        if (config.jiraPanels.formatGreen != defaultConfig.jiraPanels.formatGreen) {
            iniWriteValue(config, "jira", "panelFormatGreen", config.jiraPanels.formatGreen)
        }
        if (config.jiraPanels.formatRed != defaultConfig.jiraPanels.formatRed) {
            iniWriteValue(config, "jira", "panelFormatRed", config.jiraPanels.formatRed)
        }
        if (config.jiraPanels.formatYellow != defaultConfig.jiraPanels.formatYellow) {
            iniWriteValue(config, "jira", "panelFormatYellow", config.jiraPanels.formatYellow)
        }
        if (config.quickLookupSites != defaultConfig.quickLookupSites) {
            quickLookupSitesToIni(config)
        }
    }
}

selfReload() {
    showSplash("Reloading script...")
    Reload
    Sleep 1000
    MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
    IfMsgBox, Yes
    {
        runEditPadPro()
        Edit
    }
}

sendJiraCode(type) {
    global configUser
    sendText("{code:" . setCase(type, "L") . "| title=" . type . " snippet| " . configUser.jiraPanels.format . "}", "{Enter}")
    sendText("{code}", "{Enter}{Up}{End}{Home}")
}

sendJiraPanel(panelFormat) {
    sendText("{panel:title=Title| " . panelFormat . "}", "{Enter}")
    sendText("{panel}", "{Enter}{Up}{End}{Home}")
}

sendJiraSpecialPanel(type) {
    sendText("{" . type . ":title=" . setCase(type, "S") . " Title}", "{Enter}")
    sendText("{" . type . "}", "{Enter}{Up}{End}{Home}")
}

sendText(text, keys:="") {
    pasteText(text)
    if (keys != "") {
        Send, %keys%
    }
}

setCase(value, case) {
    StringUpper case, case
    result :=
    if (case == "I") {
        Loop, Parse, value
        {
            if A_LoopField is upper
            {
                result .= Chr(Asc(A_LoopField) + 32)
            }
            else if A_LoopField is lower
            {
                result .= Chr(Asc(A_LoopField) - 32)
            }
            else {
                result .= A_LoopField
            }
        }
    }
    else if (case == "L") {
        StringLower, result, value
    }
    else if (case == "S") {
        StringLower, result, value
        result := RegExReplace(result, "((?:^|[.!?]\s+)[a-z])", "$u1")
        result := RegExReplace(result, "(\bi\b)", "$u1")
    }
    else if (case == "T") {
        StringUpper, result, value, T
    }
    else if (case == "U") {
        StringUpper, result, value
    }
    else {
        result := value
    }
    return result
}

showArray(array, depth:=6, indent:="") {
    list := ""
    for key, value in array {
        list .= "`t" . indent . key
        if (IsObject(value) && depth > 1) {
            list .= "`n" . showArray(value, depth - 1, indent . "`t")
        }
        else {
            list .= "`t= [" . value . "]`n"
        }
    }
    return list
}

showClipboard() {
    global LINE_SEP
    global QUICK_SPLASH_TITLE
    clipPreview := (Clipboard == "" ? "{Empty}" : Clipboard)
    header := "Clipboard preview:`n" . LINE_SEP
    Progress, B1 C00 CT000000 CWFFFFDD FM11 FS10 W1200 WM1200 ZH0, %clipPreview%, %header%, %QUICK_SPLASH_TITLE%, Courier New
    centerWindow(QUICK_SPLASH_TITLE)
    KeyWait, v
    Progress, off
}

showDebugVar() {
    global
    local val
    varName := ask("Debug", "Please enter the name of the variable to inspect:", 330)
    if (varName != "") {
        if (IsObject(%varName%)) {
            val := "`n" . showArray(%varName%)
        }
        else {
            val := %varname%
        }
        MsgBox % "DEBUG: " . varName . " = [" . val . "]"
    }
}

showFullHelp() {
    global MY_TITLE
    global MY_VERSION
    global configUser
    global vkDelim
    Gui, destroy
    Gui, Font, s10
    Gui, Font, w500
    Gui, Add, Text, center cBlue y3 w800, Double-click an entry to execute the action.
    Gui, Add, Tab2, h30 w115 x5 y18, Keys|Strings
    Gui, Tab, Keys
    Gui, Add, ListView, vlvKeys glvHelp r5 Grid Sort AltSubmit -Multi -Resize x5 y41 h608 w900, Definition|Line|Key(s)|Comment|Description
    Gui, Tab, Strings
    Gui, Add, ListView, vlvStrings glvHelp r5 Grid Sort AltSubmit -Multi -Resize x5 y41 h608 w900, Definition|Line|Trigger|Options|Comment|Description

    keys := readKeysFromFile(A_ScriptFullPath)
    Loop, Parse, keys, `n, `r
    {
        ; initialize vars because StringSplit doesn't
        key_field1 :=
        key_field2 :=
        key_field3 :=
        key_field4 :=
        key_field5 :=
        StringSplit, key_field, A_LoopField, %vkDelim%
        ; rows below trim spaces
        line := key_field1
        type := key_field2
        kdef := key_field3
        desc := key_field4
        comment :=
        pos := InStr(desc, "++")
        if (pos) {
            comment := SubStr(desc, pos + 2)
            desc := SubStr(desc, 1, pos - 1)
        }
        if (kdef != "") {
            if (type == "hk") {
                hkFull := hkToStr(kdef)
                Gui, ListView, lvKeys
                LV_Add("", kdef, line, hkFull, comment, desc)
            }
            else if (type == "hs") {
                trigger := kdef
                options := key_field5
                kdef := ":" . options . ":" . trigger
                Gui, ListView, lvStrings
                LV_Add("", kdef, line, trigger, options, comment, desc)
            }
        }
    }
    Gui, ListView, lvKeys
    LV_ModifyCol(1, "0")                    ;definition
    LV_ModifyCol(2, "0 Center")             ;line
    LV_ModifyCol(3, "AutoHdr Logical Sort") ;named keys
    LV_ModifyCol(4, "AutoHdr Logical")      ;comment
    LV_ModifyCol(5, "AutoHdr Logical")      ;description

    Gui, ListView, lvStrings
    LV_ModifyCol(1, "0")                    ;definition
    LV_ModifyCol(2, "0 Center")             ;line
    LV_ModifyCol(3, "AutoHdr Logical Sort") ;trigger
    LV_ModifyCol(4, "AutoHdr")              ;options
    LV_ModifyCol(5, "AutoHdr Logical")      ;comment
    LV_ModifyCol(6, "AutoHdr Logical")      ;description

    Gui, -MinimizeBox
    Gui, -MaximizeBox

    hkSession := toComma(configUser.hkSessionCount)
    hkTotal := toComma(configUser.hkTotalCount)
    hsSession := toComma(configUser.hsSessionCount)
    hsTotal := toComma(configUser.hsTotalCount)
    helpTitle := MY_TITLE . " v" . MY_VERSION . " (AHK v" . A_AhkVersion . ")                Session Usage:  " . hkSession . " hotkeys, " . hsSession . " hotstrings            Total Usage:  " . hkTotal . " hotkeys, " . hsTotal . " hotstrings"

    activeMon := getActiveMonitor()
    Gui, Show, , %helpTitle%
    centerWindow("A")
}

showQuickHelp(waitforKey) {
    global LINE_SEP
    global QUICK_SPLASH_TITLE
    static isShowing := false
    if (isShowing) {
        KeyWait, h
        Progress, off
        isShowing := false
        return
    }

    col1Line := "---------------------------------------------`t"
    col2Line := "-------------------------------------`t"

    spacer1 := "`t`t`t`t`t`t"
    spacer2 := "`t`t`t`t`t"

    hkActionHelp =
    ( LTrim
        Action hotkeys`t`t`t`t`t
        %col1Line%
        Win-A`t`tToggles 'always-on-top' mode`t
        Win-C`t`tRun/activate Calculator`t`t
        Win-D`t`tRun/activate a DOS window`t
        Win-E`t`tRun/activate EditPad Pro`t
        Win-F`t`tRun/activate FileLocatorPro`t
        Win-G`t`tGo or Google selected text`t
        AltWin-H`tToggle quick help`t`t
        CtrlWin-H`tShow full help`t`t`t
        Win-H`t`tShow quick help`t`t`t
        Win-P`t`tRun/activate Perforce`t`t
        Win-Q`t`tQuick lookup selected text`t
        Win-R`t`tRun/activate RegexBuddy`t`t
        Win-S`t`tRun/activate Windows Services`t
        Win-V`t`tPreview the clipboard (text)`t
        Win-X`t`tRun Windows Explorer`t`t
        Win-Z`t`tCreate zoom window`t`t
        Win-1`t`tRun/activate the AHK help`t
        Win-2`t`tReload this script`t`t
        Win-3`t`tEdit this script`t`t
        Win-Delete`tHide current window`t`t
        Win-Enter`tPastes 'enter'`t`t`t
        Win-F12`t`tExit this script`t`t
        Win-Insert`tRestore hidden windows`t`t
        Win-Minus`tHide/show desktop icons`t`t
        Win-PrintScreen`tRun Windows snipping tool`t
        Win-Tab`t`tPastes a 'tab'`t`t`t
        %spacer1%
    )

    hkDosHelp =
    ( LTrim
        DOS hotkeys`t`t`t`t
        %col2Line%
        Alt-C`t"copy "`t`t`t`t
        Alt-D`tPush dir./change to Downloads`t
        Alt-M`t"move "`t`t`t`t
        Alt-P`t"pushd "`t`t`t
        Alt-R`tChange to the root directory`t
        Alt-S`tRun 'src'`t`t`t
        Alt-T`t"type "`t`t`t`t
        Alt-U`tRun 'utils'`t`t`t
        Alt-X`tRun 'exit'`t`t`t
        Ctrl-P`tPops to last directory`t`t
        %spacer2%
    )

    hkEppHelp =
    ( LTrim
        EditPad Pro hotkeys`t`t`t`t
        %col2Line%
        Alt-Delete`tDelete line`t`t`t
        Alt-Down`tMove line down`t`t`t
        Alt-Up`t`tMove line up`t`t`t
        Ctrl-D`t`tDelete word`t`t`t
        Ctrl-Delete`tDelete to EOL`t`t`t
        Ctrl-G`t`tGo to line`t`t`t
        XButton1`tPrevious file`t`t`t
        XButton2`tNext file`t`t`t
    )

    hkMiscHelp =
    ( LTrim
        %spacer2%
        Miscellaneous hotkeys`t`t`t
        %col2Line%
        Win-Pause`tPause this script`t`
        Ctrl-RCtrl`tRun Control Panel`t
        CtrlAlt-V`tPaste as text`t`t
    )

    hkMoveHelp =
    ( LTrim
        Movement hotkeys`t`t`t
        %col2Line%
        WheelLeft`tMove to left monitor`t
        WheelRight`tMove to right monitor`t
        Win-Down`tMinimize the window`t
        Win-Home`tCenter current window`t
        Win-Left`tMove to left monitor`t
        Win-Right`tMove to right monitor`t
        Win-Up`t`tMaximize the window`t
        Alt-WheelDown`tPageDown`t`t
        Alt-WheelUp`tPageUp`t`t`t
        AltWin-Down`tMove mouse 1px down`t
        AltWin-Left`tMove mouse 1px left`t
        AltWin-Right`tMove mouse 1px right`t
        AltWin-Up`tMove mouse 1px up`t
        CtrlWin-Down`tDrag mouse 1px down`t
        CtrlWin-Left`tDrag mouse 1px left`t
        CtrlWin-Right`tDrag mouse 1px right`t
        CtrlWin-Up`tDrag mouse 1px up`t
        ShiftWin-Down`tResize to 50`% (bottom)`t
        ShiftWin-Left`tResize to 50`% (left)`t
        ShiftWin-Right`tResize to 50`% (right)`t
        ShiftWin-Up`tResize to 50`% (top)`t
    )

    hkXformHelp =
    ( LTrim
        Transform hotkeys`t`t`t
        %col2Line%
        CtrlShift-'`tWrap in ""`t`t
        AltShift-,`tUntag-ify text`t`t
        AltShift-.`tUntag-ify text`t`t
        CtrlShift-,`tTag-ify text`t`t
        CtrlShift-.`tTag-ify text`t`t
        CtrlShift-[`tWrap in []`t`t
        CtrlShift-]`tWrap in []`t`t
        CtrlShift-0`tWrap in ()`t`t
        CtrlShift-9`tWrap in ()`t`t
        CtrlShift-A`tSort ascending`t`t
        CtrlShift-B`tWrap in []`t`t
        CtrlShift-D`tSort descending`t`t
        CtrlShift-E`tEncrypt text`t`t
        CtrlShift-I`tiNVERT cASE`t`t
        CtrlShift-L`tlower case`t`t
        CtrlAlt-N`tAuto-Denumber`t`t
        CtrlAltShift-N`tAuto-number (prompt)`t
        CtrlShift-N`tAuto-number (1)`t`t
        CtrlShift-O`tOracle words to UPPER`t
        CtrlShift-P`tWrap in ()`t`t
        CtrlShift-Q`tWrap in ""`t`t
        CtrlShift-R`tReverse text`t`t
        CtrlShift-S`tSentence case`t`t
        CtrlShift-T`tTitle Case`t`t
        CtrlShift-U`tUPPER case`t`t
        CtrlAlt-W`tUnwrap text`t`t
        CtrlShift-W`tWrap text at width`t`t
    )

    hkCol1 := hkActionHelp
    hkCol2 := hkMoveHelp . "`n" . hkMiscHelp
    hkCol3 := hkXformHelp
    hkCol4 := hkDosHelp . "`n" . hkEppHelp

    hkArr1 := listToArray(hkCol1)
    hkArr2 := listToArray(hkCol2)
    hkArr3 := listToArray(hkCol3)
    hkArr4 := listToArray(hkCol4)

    hkResult :=
    for key, value in hkArr1
    {
        hkResult .= RTrim(value . hkArr2[key] . hkArr3[key] . hkArr4[key]) . "`n"
    }

    hsAliasHelp =
    ( LTrim
        Alias hotstrings`t`t`t`t
        %col1line%
        bbl`tbe back later`t`t`t`t
        bbs`tbe back soon`t`t`t`t
        brb`tbe right back`t`t`t`t
        brt`tbe right there`t`t`t`t
        crg`tCode review is good.`t`t`t
        g2g`tGood to go.`t`t`t`t
        gtg`tGot to go.`t`t`t`t
        idk`tI don't know.`t`t`t`t
        lmc`tLet me check on that, please wait...`t
        nm.`tnever mind...`t`t`t`t
        nmif`tNever mind, I found it.`t`t`t
        np`tno problem`t`t`t`t
        nw`tno worries`t`t`t`t
        okt`tOK, thanks...`t`t`t`t
        thok`tThat's OK...`t`t`t`t
        thx`tthanks`t`t`t`t`t
        ty.`tThank you.`t`t`t`t
        yw`tYou're welcome`t`t`t`t
        wyb`tPlease let me know when you are back.`t
        %spacer1%
        %spacer1%
    )

    hsAutoCorHelp =
    ( LTrim
        %spacer2%
        Auto-correct hotstrings`t`t`t
        %col2line%
        cL`tc:`t`t`t`t
        %spacer2%
        %spacer2%
        %spacer2%
        %spacer2%
        %spacer2%
        %spacer2%
        %spacer2%
    )

    hsCodeHelp =
    ( LTrim
        Code hotstrings`t`t`t`t
        %col2line%
        chpl`t`tComment header (Perl)`t
        chsql`t`tComment header (SQL)`t
        for (`t`t'for' block`t`t
        func (`t`t'function' block`t
        if (`t`t'if' block`t`t
        ifel`t`t'if/else' block`t`t
        sf.`t`tString.format("", )`t
        switch (`t'switch' block`t`t
        sysout`t`tSystem.out.println("");`t
        while (`t`t'while' block`t`t
        @html`t`tHTML template`t`t
        @java`t`tJava template`t`t
    )

    hsDateHelp =
    ( LTrim
        Date/Time hotstrings`t`t`t
        %col2line%
        dtms`t'YYYYMDD_24MMSS'`t`t
        dts`t'YYYYMMDD'`t`t`t
        tms`t'24MMSS'`t`t`t
        @date`t'MM/DD/YYYY'`t`t`t
        @day`tDay name`t`t`t
        @ddd`tDay name (abbr.)`t`t
        @mmm`tMonth name (abbr.)`t`t
        @month`tMonth name`t`t`t
        @now`t'MM/DD/YYYY at 24:MM:SS'`t
        @time`t'24:MM:SS'`t`t`t
    )

    hsDosHelp =
    ( LTrim
        %spacer2%
        DOS hotstrings`t`t`t`t
        %col2line%
        cd`tcd /d`t`t`t`t
    )

    hsHtmlHelp =
    ( LTrim
        %spacer2%
        HTML/XML hotstrings`t`t`t
        %col2line%
        a/b/big/block/body/br/but/cap/code`t
        del/div/em/field/foot/form/h[1-6]`t
        head/heaer/hgroup/hr/html/i/iframe`t
        img/input/label/legend/li/link/ol`t
        optg/opti/p/pre/q/script/section`t
        select/small/source/span/strong`t
        style/sub/sum/sup/table/tbody/td`t
        texta/tfoot/th/title/tr/u/ul/xml`t
        %spacer2%
    )

    hsJiraHelp =
    ( LTrim
        Jira/Confluence hotstrings`t`t
        %col2line%
        `{color`t'color' tags`t`t`t
        `{bpan`t'panel' tags (in blue)`t`t`t
        `{gpan`t'panel' tags (in green)`t`t`t
        `{java`t'code' tags for Java`t`t
        `{js`t'code' tags for JavaScript`t
        `{nof`t'noformat' tags`t`t`t
        `{pan`t'panel' tags`t`t`t
        `{quo`t'quote' tags`t`t`t
        `{rpan`t'panel' tags (in red)`t`t`t
        `{sql`t'code' tags for SQL`t`t
        `{xml`t'code' tags for XML`t`t
        `{ypan`t'panel' tags (in yellow)`t`t`t
    )

    hsSqlHelp =
    ( LTrim
        %spacer2%
        SQL hotstrings`t`t`t`t
        %col2line%
        sela`t'select all' template`t`t
        selc`t'select count' template`t`t
        selw`t'select where' template`t`t
        %spacer2%
        %spacer2%
        %spacer2%
    )

    hsCol1 := hsAliasHelp
    hsCol2 := hsCodeHelp . "`n" . hsAutoCorHelp
    hsCol3 := hsDateHelp . "`n" . hsHtmlHelp
    ;hsCol4 := hsJiraHelp . "`n" . hsSqlHelp . "`n" . hsDosHelp
    hsCol4 := hsJiraHelp . "`n" . hsSqlHelp

    hsArr1 := listToArray(hsCol1)
    hsArr2 := listToArray(hsCol2)
    hsArr3 := listToArray(hsCol3)
    hsArr4 := listToArray(hsCol4)

    hsResult :=
    for key, value in hsArr1 {
        hsResult .= RTrim(value . hsArr2[key] . hsArr3[key] . hsArr4[key]) . "`n"
    }

    quickHelp := hkResult . LINE_SEP . "`n" . Trim(hsResult, " `t`r`n")
    Progress, B1 C00 CT000000 CWFFFFDD FM11 FS8 W1175 WM1200 ZH0, %quickHelp%,, %QUICK_SPLASH_TITLE%, Courier New
    isShowing := true
    centerWindow(QUICK_SPLASH_TITLE)
    if (waitForKey) {
        KeyWait, h
        isShowing := false
        Progress, off
    }
    return
}

showSplash(msg,timeout:=500) {
    global QUICK_SPLASH_TITLE
    SplashImage,, b1 cwff9999 fs12, %msg%,, %QUICK_SPLASH_TITLE%
    centerWindow(QUICK_SPLASH_TITLE)
    Sleep, %timeout%
    SplashImage, off
}

sortSelected(direction:="") {
    direction := setCase(direction, "L")
    method := "compareStr" . (direction == "d" ? "Desc" : "Asc")
    selText := getSelectedText()
    if (selText != "") {
        Sort, selText, F %method%
        replaceSelected(selText)
    }
}

startsWith(str, value, caseInsensitive:="") {
    if (toBool(caseInsensitive)) {
        str := setCase(str, "L")
        value := setCase(value, "L")
    }
    result := (SubStr(str, 1, StrLen(value)) == value)
    return result
}

stop() {
    global MY_VERSION
    global configUser
    hkSession := toComma(configUser.hkSessionCount)
    hkTotal := toComma(configUser.hkTotalCount)
    hsSession := toComma(configUser.hsSessionCount)
    hsTotal := toComma(configUser.hsTotalCount)
    MsgBox, , %MY_VERSION%, Shutting down...`n`nSession Usage`n    hotkeys: %hkSession%`n    hotstrings: %hsSession%`n`nTotal Usage`n    hotkeys: %hkTotal%`n    hotstrings: %hsTotal%
    ExitApp
}

stripEol(str) {
    StringReplace, str,str,`r,,All
    StringReplace, str,str,`n,,All
    return str
}

tagifySelected() {
    selText := getSelectedText()
    if (selText != "") {
        moveLeft := "{Left " . (StrLen(selText) + 3) . "}"
        sendText("<" . selText . "></" . selText . ">", moveLeft)
    }
}

toBool(value)
{
    StringLower, value, value
    value := Trim(value)
    result := false
    trueList := "1,active,enabled,on,t,true,y,yes"
    if value in %trueList%
    {
        result := true
    }
    return result
}

toComma(value) {
    value := RegExReplace(value, "(\d)(?=(?:\d{3})+(?:\.|$))", "$1,")
;    value := RegExReplace(value, "[1-9](?:\d{0,2})((?:,\d{3})*)(?:\.\d*[0-9])?|0?\.\d*[0-9]|0", "$1,")
    return value
}

toggleAlwaysOnTop() {
    marker := "† "
    hWnd := WinExist("A")
    WinGet, ExStyle, ExStyle, ahk_id %hWnd%
    state := (ExStyle & 0x8 ? "off" : "on")
    WinSet, AlwaysOnTop, %state%, ahk_id %hWnd%
    WinGetTitle, currentTitle, A
    if (state == "on") {
        title := (startsWith(currentTitle, marker) ? "" : marker) . currentTitle
    }
    else {
        title := (startsWith(currentTitle, marker) ? SubStr(currentTitle, StrLen(marker) + 1) : currentTitle)
    }
    WinSetTitle, A, , %title%
    showSplash("'Always-on-top' mode is " . state . "...")
}

toggleDesktopIcons() {
    ControlGet, hWnd, hWnd,, SysListView321, ahk_class Progman
    if (hWnd == "") {
        ControlGet, hWnd, hWnd,, SysListView321, ahk_class WorkerW
    }
    if (DllCall("IsWindowVisible", UInt, hWnd)) {
        WinHide, ahk_id %hWnd%
    }
    else {
        WinShow, ahk_id %hWnd%
    }
}

toggleSuspend() {
    global MY_TITLE
    msg := MY_TITLE . " is " . (A_IsSuspended ? "suspended" : "enabled") . "..."
    showSplash(msg)
}

transformSelected(type,types:="I|L|R|S|T|U") {
    type := setCase(type, "L")
    if (!InStr(types, type)) {
        MsgBox, 16, transformSelected() - Invalid parameter, illegal value for 'type' specified as: [%type%]
        return 0
    }
    selText := getSelectedText()
    if (selText != "") {
        if (type == "r") {
            replaceSelected(reverse(selText))
        }
        else {
            replaceSelected(setCase(selText, type))
        }
    }
}

untagifySelected() {
    selText := getSelectedText()
    if (selText != "") {
        pasteText(RegExReplace(selText, "(<[^>]+>)", ""))
    }
}

upperCaseOracle() {
    selText := getSelectedText()
    if (selText != "") {
        oracleWords := "i)\b(ACCESS|ACCOUNT|ACTIVATE|ADD|ADMIN|ADVISE|AFTER|ALL|ALL_ROWS|ALLOCATE|ALTER|ANALYZE|AND|ANY|ARCHIVE|ARCHIVELOG|ARRAY|ARRAYLEN|AS|ASC|AT|AUDIT|AUTHENTICATED|AUTHORIZATION|AUTOEXTEND|AUTOMATIC|AVG|BACKUP|BECOME|BEFORE|BEGIN|BETWEEN|BFILE|BITMAP|BLOB|BLOCK|BODY|BY|CACHE|CACHE_INSTANCES|CANCEL|CASCADE|CAST|CFILE|CHAINED|CHANGE|CHAR|CHAR_CS|CHARACTER|CHECK|CHECKPOINT|CHOOSE|CHUNK|CLEAR|CLOB|CLONE|CLOSE|CLOSE_CACHED_OPEN_CURSORS|CLUSTER|COALESCE|COBOL|COLUMN|COLUMNS|COMMENT|COMMIT|COMMITTED|COMPATIBILITY|COMPILE|COMPLETE|COMPOSITE_LIMIT|COMPRESS|COMPUTE|CONNECT|CONNECT_TIME|CONSTRAINT|CONSTRAINTS|CONTENTS|CONTINUE|CONTROLFILE|CONVERT|COST|COUNT|CPU_PER_CALL|CPU_PER_SESSION|CREATE|CURREN_USER|CURRENT|CURRENT_SCHEMA|CURSOR|CYCLE|DANGLING|DATABASE|DATAFILE|DATAFILES|DATAOBJNO|DATE|DBA|DBHIGH|DBLOW|DBMAC|DEALLOCATE|DEBUG|DEC|DECIMAL|DECLARE|DEFAULT|DEFERRABLE|DEFERRED|DEGREE|DELETE|DEREF|DESC|DIRECTORY|DISABLE|DISCONNECT|DISMOUNT|DISTINCT|DISTRIBUTED|DML|DOUBLE|DROP|DUMP|EACH|ELSE|ELSIF|ENABLE|END|ENFORCE|ENTRY|ESCAPE|EVENTS|EXCEPT|EXCEPTIONS|EXCHANGE|EXCLUDING|EXCLUSIVE|EXEC|EXECUTE|EXISTS|EXPIRE|EXPLAIN|EXTENT|EXTENTS|EXTERNALLY|FAILED_LOGIN_ATTEMPTS|FALSE|FAST|FETCH|FILE|FIRST_ROWS|FLAGGER|FLOAT|FLOB|FLUSH|FOR|FORCE|FOREIGN|FORTRAN|FOUND|FREELIST|FREELISTS|FROM|FULL|FUNCTION|GLOBAL|GLOBAL_NAME|GLOBALLY|GO|GOTO|GRANT|GROUP|GROUPS|HASH|HASHKEYS|HAVING|HEADER|HEAP|IDENTIFIED|IDGENERATORS|IDLE_TIME|IF|IMMEDIATE|IN|INCLUDING|INCREMENT|IND_PARTITION|INDEX|INDEXED|INDEXES|INDICATOR|INITIAL|INITIALLY|INITRANS|INNER|INSERT|INSTANCE|INSTANCES|INSTEAD|INT|INTEGER|INTERMEDIATE|INTERSECT|INTO|IS|ISOLATION|ISOLATION_LEVEL|JOIN|KEEP|KEY|KILL|LABEL|LANGUAGE|LAYER|LEFT|LESS|LEVEL|LIBRARY|LIKE|LIMIT|LINK|LIST|LISTS|LOB|LOCAL|LOCK|LOCKED|LOG|LOGFILE|LOGGING|LOGICAL_READS_PER_CALL|LOGICAL_READS_PER_SESSION|LONG|LOOP|MANAGE|MANUAL|MASTER|MAX|MAXARCHLOGS|MAXDATAFILES|MAXEXTENTS|MAXINSTANCES|MAXLOGFILES|MAXLOGHISTORY|MAXLOGMEMBERS|MAXSIZE|MAXTRANS|MAXVALUE|MEMBER|MIN|MINEXTENTS|MINIMUM|MINUS|MINVALUE|MLS_LABEL_FORMAT|MLSLABEL|MODE|MODIFY|MODULE|MOUNT|MOVE|MTS_DISPATCHERS|MULTISET|NATIONAL|NCHAR|NCHAR_CS|NCLOB|NEEDED|NESTED|NETWORK|NEW|NEXT|NOARCHIVELOG|NOAUDIT|NOCACHE|NOCOMPRESS|NOCYCLE|NOFORCE|NOLOGGING|NOMAXVALUE|NOMINVALUE|NONE|NOORDER|NOOVERRIDE|NOPARALLEL|NOPARALLEL|NORESETLOGS|NOREVERSE|NORMAL|NOSORT|NOT|NOTFOUND|NOTHING|NOWAIT|NULL|NUMBER|NUMERIC|NVARCHAR2|OBJECT|OBJNO|OBJNO_REUSE|OF|OFF|OFFLINE|OID|OIDINDEX|OLD|ON|ONLINE|ONLY|OPCODE|OPEN|OPTIMAL|OPTIMIZER_GOAL|OPTION|OR|ORDER|ORGANIZATION|OSLABEL|OUTER|OVERFLOW|OWN|PACKAGE|PARALLEL|PARTITION|PASSWORD|PASSWORD_GRACE_TIME|PASSWORD_LIFE_TIME|PASSWORD_LOCK_TIME|PASSWORD_REUSE_MAX|PASSWORD_REUSE_TIME|PASSWORD_VERIFY_FUNCTION|PCTFREE|PCTINCREASE|PCTTHRESHOLD|PCTUSED|PCTVERSION|PERCENT|PERMANENT|PLAN|PLSQL_DEBUG|POST_TRANSACTION|PRECISION|PRESERVE|PRIMARY|PRIOR|PRIVATE|PRIVATE_SGA|PRIVILEGE|PRIVILEGES|PROCEDURE|PROFILE|PUBLIC|PURGE|QUEUE|QUOTA|RANGE|RAW|RBA|READ|READUP|REAL|REBUILD|RECOVER|RECOVERABLE|RECOVERY|REF|REFERENCES|REFERENCING|REFRESH|RENAME|REPLACE|RESET|RESETLOGS|RESIZE|RESOURCE|RESTRICTED|RETURN|RETURNING|REUSE|REVERSE|REVOKE|RIGHT|ROLE|ROLES|ROLLBACK|ROW|ROWID|ROWLABEL|ROWNUM|ROWS|RULE|SAMPLE|SAVEPOINT|SB4|SCAN_INSTANCES|SCHEMA|SCN|SCOPE|SD_ALL|SD_INHIBIT|SD_SHOW|SECTION|SEG_BLOCK|SEG_FILE|SEGMENT|SELECT|SEQUENCE|SERIALIZABLE|SESSION|SESSION_CACHED_CURSORS|SESSIONS_PER_USER|SET|SHARE|SHARED|SHARED_POOL|SHRINK|SIZE|SKIP|SKIP_UNUSABLE_INDEXES|SMALLINT|SNAPSHOT|SOME|SORT|SPECIFICATION|SPLIT|SQL|SQL_TRACE|SQLBUF|SQLCODE|SQLERROR|SQLSTATE|STANDBY|START|STATEMENT_ID|STATISTICS|STOP|STORAGE|STORE|STRUCTURE|SUCCESSFUL|SUM|SWITCH|SYNONYM|SYSDATE|SYSDBA|SYSOPER|SYSTEM|TABLE|TABLES|TABLESPACE|TABLESPACE_NO|TABNO|TEMPORARY|THAN|THE|THEN|THREAD|TIME|TIMESTAMP|TO|TOPLEVEL|TRACE|TRACING|TRANSACTION|TRANSITIONAL|TRIGGER|TRIGGERS|TRUE|TRUNCATE|TX|TYPE|UB2|UBA|UID|UNDER|UNION|UNIQUE|UNLIMITED|UNLOCK|UNRECOVERABLE|UNTIL|UNUSABLE|UNUSED|UPDATABLE|UPDATE|USAGE|USE|USER|USING|VALIDATE|VALIDATION|VALUE|VALUES|VARCHAR|VARCHAR2|VARYING|VIEW|WHEN|WHENEVER|WHERE|WITH|WITHOUT|WORK|WRITE|WRITEDOWN|WRITEUP|XID|YEAR|ZONE)\b"
        inComment := false
        upper :=
        Loop, Parse, selText, `n
        {
            if (inComment) {
                pos := InStr(A_LoopField, "*/")
                if (pos > 0) {
                    line1 := Substr(A_LoopField, 1, (pos - 1))
                    line2 := Substr(A_LoopField, pos)
                    inComment := false
                }
                else {
                    line1 := A_LoopField
                    line2 :=
                }
                upper .= line1 . RegExReplace(line2, oracleWords, "$U{1}") . "`n"
            }
            else {
                pos := InStr(A_LoopField, "/*")
                if (pos > 0) {
                    line1 := Substr(A_LoopField, 1, (pos - 1))
                    line2 := Substr(A_LoopField, pos)
                    inComment := true
                }
                else {
                    pos := InStr(A_LoopField, "--")
                    if (pos > 0) {
                        line1 := Substr(A_LoopField, 1, (pos - 1))
                        line2 := Substr(A_LoopField, pos)
                    }
                    else {
                        line1 := A_LoopField
                        line2 :=
                    }
                }
                upper .= RegExReplace(line1, oracleWords, "$U{1}") . line2 . "`n"
            }
        }
        pasteText(upper)
    }
}

urlEncode(text) {
    StringReplace, text, text, `%, `%25, All ; This needs to be first
    StringReplace, text, text, `", `%22, All
    StringReplace, text, text, `#, `%23, All
    StringReplace, text, text, `$, `%24, All
    StringReplace, text, text, `&, `%26, All
    StringReplace, text, text, `', `%27, All
    StringReplace, text, text, `(, `%28, All
    StringReplace, text, text, `), `%29, All
    StringReplace, text, text, `+, `%2B, All
    StringReplace, text, text, `,, `%2C, All
    StringReplace, text, text, `/, `%2F, All
    StringReplace, text, text, `:, `%3A, All
    StringReplace, text, text, `;, `%3B, All
    StringReplace, text, text, `<, `%3C, All
    StringReplace, text, text, `=, `%3D, All
    StringReplace, text, text, `>, `%3D, All
    StringReplace, text, text, `?, `%3F, All
    StringReplace, text, text, `@, `%40, All
    StringReplace, text, text, ``, `%60, All
    StringReplace, text, text, %A_Tab%, %A_Space%, All
    StringReplace, text, text, %A_Space%, `%20, All
    StringReplace, text, text, `r`n, %A_Space%, All
    StringReplace, text, text, `r, %A_Space%, All
    StringReplace, text, text, `n, %A_Space%, All
    return text
}

wrapSelected(start, end) {
    selText := getSelectedText()
    if (selText == "") {
        Send, {End}{Home}+{End}
        selText := getSelectedText()
    }
    newText := start . selText . end
    pair := start . end
    if (newText != pair) {
        replaceSelected(newText)
        Send, {Left}{Right}
    }
}

zoomAdjust(direction) {
    static zoomFactor := 1.189207115 ; sqrt(sqrt(2))
    global zoomAmount
    if (direction == -1) {
        if (zoomAmount < 4) {
            zoomAmount *= zoomFactor
        }
    }
    else if (direction == 1) {
        if (zoomAmount > zoomFactor) {
            zoomAmount /= zoomFactor
        }
    }
}

zoomStart() {
    global zoomAmount := 2
    global zoomWindowDimension := 0
    global zoomWindowH := 100
    global zoomWindowW := 240
    global zoomFollow := true
    global zoomHdcFrame
    global zoomHddFrame

    Process, Priority,, High
    Hotkey, Escape, zoomExit, On
    Hotkey, Space, zoomToggleFollow, On
    Hotkey, WheelDown, zoomChange, On
    Hotkey, !Down, zoomChange, On
    Hotkey, WheelUp, zoomChange, On
    Hotkey, !Up, zoomChange, On
    Hotkey, +WheelDown, zoomWindowChange, On
    Hotkey, +Down, zoomWindowChange, On
    Hotkey, +WheelUp, zoomWindowChange, On
    Hotkey, +Up, zoomWindowChange, On

    Gui, 26: +AlwaysOnTop +Owner -Resize -ToolWindow +E0x00000020
    Gui, 26: Show, NoActivate W%zoomWindowW% H%zoomWindowH% X-10000 Y-10000, zoomWindow
    WinSet, Transparent, 254, zoomWindow
    Gui, 26: -Caption
    Gui, 26: +Border
    WinGet, zoomId, id
    zoomHddFrame := DllCall("GetDC", UInt, zoomId)
    WinGet, zoomId, id, zoomWindow
    zoomHdcFrame := DllCall("GetDC", UInt, zoomId)
    DllCall("gdi32.dll\SetStretchBltMode", UInt, zoomHdcFrame, Int, 4)
    GoSub, zoomRepaint
}


;--------------------------------------------------
;labels
;--------------------------------------------------
lvHelp:
    Gui, ListView, %A_GuiControl%
    if (A_GuiEvent == "DoubleClick") {
        LV_GetText(hkName, A_EventInfo)
        runHotkey(hkName)
    }
    else {
;        MsgBox, %A_GuiEvent% event for %A_GuiControl%
    }
    return

initMonitors:
    refreshMonitors()
    return

QuickLookup:
    qmenuRun(A_ThisMenuItemPos)
    return

zoomChange:
    StringLower zcKey, A_ThisHotKey
    if (zcKey == "wheelup" || zcKey == "!up") {
        direction := -1
    }
    else if (zcKey == "wheeldown" || zcKey == "!down") {
        direction := 1
    }
    if (direction) {
        zoomAdjust(direction)
    }
    return

zoomExit:
    SetTimer, zoomRepaint, Off
    DllCall("gdi32.dll\DeleteDC", UInt, zoomHdcFrame)
    DllCall("gdi32.dll\DeleteDC", UInt, zoomHddFrame)
    Gui, 26: Destroy
    Process, Priority,, Normal
    Hotkey, Escape,, Off
    Hotkey, Space,, Off
    Hotkey, WheelDown,, Off
    Hotkey, !Down,, Off
    Hotkey, WheelUp,, Off
    Hotkey, !Up,, Off
    Hotkey, +WheelDown,, Off
    Hotkey, +Down,, Off
    Hotkey, +WheelUp,, Off
    Hotkey, +Up,, Off
    return

zoomRepaint:
    CoordMode, Mouse, Screen
    MouseGetPos, zoomMouseX, zoomMouseY
    WinGetPos, tmpX, tmpY, zoomWindowW, zoomWindowH, zoomWindow

    if (zoomWindowDimension != 0)
    {
        zoomWindowW += zoomWindowDimension
        zoomWindowH += zoomWindowDimension
        zoomWindowDimension := 0
    }

    DllCall("gdi32.dll\StretchBlt"
        , UInt, zoomHdcFrame
        , Int , 2                                               ; nXOriginDest
        , Int , 2                                               ; nYOriginDest
        , Int , (zoomWindowW - 6)                               ; nWidthDest
        , Int , (zoomWindowH - 6)                               ; nHeightDest
        , UInt, zoomHddFrame                                    ; hdcSrc
        , Int , (zoomMouseX - (zoomWindowW / 2 / zoomAmount))   ; nXOriginSrc
        , Int , (zoomMouseY - (zoomWindowH / 2 / zoomAmount))   ; nYOriginSrc
        , Int , (zoomWindowW / zoomAmount)                      ; nWidthSrc
        , Int , (zoomWindowH / zoomAmount)                      ; nHeightSrc
        , UInt, 0xCC0020)                                       ; dwRop (raster operation)

    if (zoomFollow == 1) {
        WinMove, zoomWindow, , (zoomMouseX - zoomWindowW / 2), (zoomMouseY - zoomWindowH / 2), %zoomWindowW%, %zoomWindowH%
    }

    SetTimer, zoomRepaint, 10
    return

zoomToggleFollow:
    zoomFollow := !zoomFollow
    return

zoomWindowChange:
    StringLower zwcKey, A_ThisHotKey
    if (zwcKey == "+wheelup" || zwcKey == "+up") {
        zoomWindowDimension := 32
    }
    else if (zwcKey == "+wheeldown" || zwcKey == "+down") {
        zoomWindowDimension := -32
    }
    else {
        zoomWindowDimension := 0
    }
    GoSub, zoomRepaint
    return

#f8::
    pasteText(toComma(getSelectedText()))
    return
