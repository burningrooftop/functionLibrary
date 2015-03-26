' Run BASIC Common Functions Library
' ------------------------------------

global PATHSEPARATOR$

if Platform$ = "windows" then
  PATHSEPARATOR$ = "\"
else
  PATHSEPARATOR$ = "/"
end if

function version()
  ' Return the library version
  version = 7
end function

function isnull()
  isnull = 0
end function

function debug$()
  debug$ = "Function Library"
end function

' ------------------
' Checksum Functions
' ------------------

function adler32(s$)
  ' Returns the Adler-32 checksum of s$.
  s1 = 1
  for i = 1 to len(s$)
    s1 = s1 + asc(mid$(s$, i, 1)) mod 65521
    s2 = (s2 + s1) mod 65521
  next i
  adler32 = (s2 * 65536) + s1
end function

' -------------------
' File Path Functions
' -------------------

function basename$(path$)
  ' Return the filename portion of a path
  for i = len(path$) to 1 step -1
    if mid$(path$, i, 1) = PATHSEPARATOR$ then exit for
  next i
  if i = 1 and mid$(path$, i ,1) <> PATHSEPARATOR$ then
    basename$ = path$
  else
    basename$ = mid$(path$, i + 1)
  end if
end function

function dirname$(path$)
  ' Return the directory portion of a path
  for i = len(path$) to 1 step -1
    if mid$(path$, i, 1) = PATHSEPARATOR$ then exit for
  next i
  if i = 1 then
    if mid$(path$, i, 1) = PATHSEPARATOR$ then
      dirname$ = PATHSEPARATOR$
    else
      dirname$ = "."
    end if
  else
    dirname$ = mid$(path$, 1, i - 1)
  end if
end function

function extension$(path$)
  ' Return the file extension (if any)
  for i = len(path$) to 1 step -1
    c$ = mid$(path$, i, 1)
    if c$ = "." then
      extension$ = t$
      exit for
    end if
    if c$ = PATHSEPARATOR$ then exit for
    t$ = c$ + t$
  next i
end function

function pathSeparator$()
  ' Return the path seperator ("/" for linux and Mac OS X, "\" for Windows)
  pathSeparator$ = PATHSEPARATOR$
end function

' --------------
' HTML Functions
' --------------

function escapeHTML$(str$)
  ' Return the string str$ with characters <, >, &, ", ' encoded to HMTM entities
  for i = 1 to len(str$)
    c$ = mid$(str$, i, 1)
    select case c$
      case "<"
        c$ = "&lt;"
      case ">"
        c$ = "&gt;"
      case "&"
        c$ = "&amp;"
      case """"
        c$ = "&quot;"
      case "'"
        c$ = "&#39;"
    end select
    escapeHTML$ =escapeHTML$ + c$
  next i
end function

' ----------------
' String Functions
' ----------------

function getPrefix$(str$, match$)
  ' Return the portion of str$ before match$ or "" if match$ not found
  i = instr(str$, match$)
  if i < 2 then
    getPrefix$ = ""
  else
    getPrefix$ = mid$(str$, 1, i - 1)
  end if
end function

function getSuffix$(str$, match$)
  ' Return the portion of str$ after match$ or "" if match$ not found
  i = instr(str$, match$)
  if i < 1 then
    getSuffix$ = ""
  else
    getSuffix$ = mid$(str$, i + len(match$))
  end if
end function

function extract$(str$, s$, e$)
  ' Return the portion of str$ between s$ and e$
  extract$ = getPrefix$(getSuffix$(str$, s$), e$)
end function

function replace$(str$, match$, rep$)
  ' Return str$ with first occurance of match$ repaced by rep$
  i = instr(str$, match$)
  if i > 0 then
    replace$ = left$(str$, i - 1) + rep$ + mid$(str$, i + len(match$))
  else
    replace$ = str$
  end if
end function

function replaceAll$(str$, match$, rep$)
  ' Return str$ with all occurances of match$ replaced by rep$
  i = instr(str$, match$)
  while i <> 0
    replaceAll$ = replaceAll$ + left$(str$, i - 1) + rep$
    str$ = mid$(str$, i + len(match$))
    i = instr(str$, match$)
  wend
  replaceAll$ = replaceAll$ + str$
end function

' ----------------
' SQLite Functions
' ----------------

function quote$(str$)
  ' Return str$ enclosed in single quotes. Any single quotes in str$ with be doubled up
  if instr(str$, "'") = 0 then
    quote$ = "'" + str$ + "'"
  else
    quote$ = "'" + replaceAll$(str$, "'", "''") + "'"
  end if
end function

' -------------
' URL Functions
' -------------
 
function getUrlParam$(params$, key$)
  ' Return the value of the URL parameter key$
  while 1
    i = i + 1
    w$ = word$(params$, i, "&")
    if w$ = "" then exit while
    k$ = word$(w$, 1, "=")
    if upper$(key$) = upper$(k$) then
      getUrlParam$ = word$(w$, 2, "=")
      exit while
    end if
  next
  getUrlParam$ = urlDecode$(getUrlParam$)
end function

function urlDecode$(str$)
  ' Return str$ with URL encoded characters decoded
  i = 1
  while i <= len(str$)
    c$ = mid$(str$, i, 1)
    if c$ = "+" then
      ' Convert + to space
      c$ = " "
    end if
    if c$ = "%" then
      ' Found an encoded character
      d$ = mid$(str$, i + 1, 2)
      h = hexdec(d$)
      if h <> 0 then
        c$ = chr$(h)
        i = i + 2
      end if
    end if
    urlDecode$ = urlDecode$ + c$
    i = i + 1
  next
end function

function urlEncode$(str$)
  ' Return str$ encoded for use in a URL
  for i = 1 to len(str$)
    c$ = mid$(str$, i, 1)
    if instr("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.~", c$) = 0  then
      urlEncode$ = urlEncode$ + "%" + dechex$(asc(c$))
    else
      urlEncode$ = urlEncode$ + c$
    end if
  next i
end function
