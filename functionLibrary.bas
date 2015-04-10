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

' --------------
' Date Functions
' --------------

function formatDate$(d$, format$)
  ' convert date from YYYY-MM-DD or MM/DD/YYYY format to the supplied format
  if instr(d$, "-") <> 0 then
    ' YYYY-MM-DD
    dd = val(word$(d$, 3, "-"))
    mm = val(word$(d$, 2, "-"))
    yyyy = val(word$(d$, 1, "-"))
    cc = int(yyyy / 100)
    yy = yyyy - (cc * 100)
  else
    if instr(d$, "/") <> 0 then 
      ' MM/DD/YYYY
      dd = val(word$(d$, 2, "/"))
      mm = val(word$(d$, 1, "/"))
      yyyy = val(word$(d$, 3, "/"))
      cc = int(yyyy / 100)
      yy = yyyy - (cc * 100)
    else
      ' Unknown format - return unchanged
      formatDate$ = d$
      goto [unknownFormat]
    end if
  end if

  i = 1
  while i <= len(format$)
    select case mid$(format$, i, 4)
      case "yyyy"
        formatDate$ = formatDate$ + str$(yyyy)
        i = i + 4
      case "YYYY"
        formatDate$ = formatDate$ + right$("0000" + str$(yyyy), 4)
        i = i + 4
      case else
        select case mid$(format$, i, 2)
          case "cc"
            formatDate$ = formatDate$ + str$(cc)
            i = i + 2
          case "CC"
            formatDate$ = formatDate$ + right$("00" + str$(cc), 2)
            i = i + 2
          case "dd"
            formatDate$ = formatDate$ + str$(dd)
            i = i + 2
          case "DD"
            formatDate$ = formatDate$ + right$("00" + str$(dd), 2)
            i = i + 2
          case "mm"
            formatDate$ = formatDate$ + str$(mm)
            i = i + 2
          case "MM"
            formatDate$ = formatDate$ + right$("00" + str$(mm), 2)
            i = i + 2
          case "yy"
            formatDate$ = formatDate$ + str$(yy)
            i = i + 2
          case "YY"
            formatDate$ = formatDate$ + right$("00" + str$(yy), 2)
            i = i + 2
          case else
            formatDate$ = formatDate$ + mid$(format$, i, 1)
            i = i + 1
        end select
    end select
  wend
[unknowFormat]
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
  if PATHSEPARATOR$ = "\" and mid$(basename$, 2, 1) = ":" then
    ' Strip drive letter
    basename$ = mid$(basename$, 3)
  end if
end function

function dirname$(path$)
  ' Return the directory portion of a path
  for i = len(path$) to 1 step -1
    if mid$(path$, i, 1) = PATHSEPARATOR$ then exit for
    if PATHSEPARATOR$ = "\" and mid$(path$, i, 1) = ":" then exit for
  next i
  if i = 1 then
    if mid$(path$, i, 1) = PATHSEPARATOR$ then
      dirname$ = PATHSEPARATOR$
    else
      dirname$ = "."
    end if
  else
    if PATHSEPARATOR$ = "\" and mid$(path$, i, 1) = ":" then
      dirname$ = mid$(path$, 1, i) + "."
    else
      dirname$ = mid$(path$, 1, i - 1)
    end if
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

function setPathSeparator(delim$)
  ' Override the path separator. Return 1 if delim$ is "/" or "\", otherwise return 0
  if delim$ = "/" or delim$ = "\" then
    PATHSEPARATOR$ = delim$
    setPathSeparator = 1
  end if
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

function hex$(str$)
  ' Return hexidecimal representation of str$
  for i = 1 to len(str$)
    hex$ = hex$ + dechex$(asc(mid$(str$, i, 1)))
  next i
end function

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

function lpad$(str$, padlen, padstr$)
  ' Return str$ left padded to length padlen using the string padstr$
  if len(str$) < padlen then
    lpad$ = padstr$
    while len(str$) + len(lpad$) < padlen
      lpad$ = lpad$ + padstr$
    wend
    lpad$ = left$(lpad$, padlen - len(str$)) + str$
  else
    lpad$ = str$
  end if
end function

function rpad$(str$, padlen, padstr$)
  ' Return str$ right padded to length padlen using the string padstr$
  if len(str$) < padlen then
    rpad$ = str$
    while len(rpad$) < padlen
      rpad$ = rpad$ + padstr$
    wend
    rpad$ = left$(rpad$, padlen)
  else
    rpad$ = str$
  end if
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

function randomCharacter$()
  ' Return a random printable character
  randomCharacter$ = chr$(rnd(1) * 94 + 33)
end function

function randomString$(n)
  ' Return a random string of n printable characters
  for i = 1 to n
    randomString$ = randomString$ + randomCharacter$()
  next i
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
