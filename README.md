# functionLibrary
Library of common functions for Run Basic

## Usage

```
run "functionLibrary", #lib

print #lib basename$("/some/path/to/a/file") ' print "file"
print #lib prefix$("Hello world!", " world") ' print "Hello"
```

## Functions

####isnull()
Always returns 0.

####debug$()
Returns "Function Library"

####version()
Returns the library version (currently set to 8).

### Checksum Functions

#### adler32(str$)
Returns the adler32 checksum of **str$**.

### Date Functions

#### formatDate$(d$, format$)
Returns the date *d$* formatted acording to *format$*. *d$* may be in either Run Basic (MM/DD/YYYY) or SQLite (YYYY-MM-DD) format. *format$* is processed as follows:

dd = day of month (eg. 4)
DD = day of month zero-padded (eg. 04)
mm = month number (eg. 3)
MM = month number zero-padded (eg. 03)
mon = Month name abbreviated, lower case (eg. mar)
Mon = Month name abbreviated, initial capital (eg. Mar)
MON = Month name abbreviated, upper case (eg. MAR)
month = Month name, lower case (eg. march)
Month = Month name, initial capital (eg March)
MONTH = Month name, upper case (eg. MARCH)
yy = last 2 digits of the year (eg. 7)
YY = last two digits of year zero-padded (eg. 07)
cc = century (eg. 20)
CC = century zero-padded (eg. 20)
yyyy = year (eg. 2007)
YYYY = year zero-padded (eg. 2007)

Any other characters are returned unchanged.

### File Path Function

#### setPathSeparator(str$)
Sets the path separator to **str$**.

#### basename$(path$)
Returns the filename portion of the pathname **path$**.

#### dirname$(path$)
Returns the directory portion of the pathname **path$**. If there is no directory portion, returns ".".

#### extension$(path$)
Returns the file extension (ie the part of the filename after the '.') of **path$**.

#### pathSeparator$()
Returns the path separator for the operating system being used ("/" for linux and Mac OS X, "\" for windows).

### HTML Helper Functions

#### escapeHTML$(str$)
Returns **str$** with characters <, >, &, ", ' encoded to HMTM entities.

### String Functions

#### hex$(str$)
Returns the hexidecial representation of *str$*.

#### upto$(str$, match$)
Returns the portion of **str$** before **match$** or "" if **match$** is not found. Same as **getPrefix$()**.

#### getPrefix$(str$, match$)
Returns the portion of **str$** before **match$** or "" if **match$** is not found. Same as **upto$()**.

#### after$(str$, match$)
Returns the portion of **str$** after **match$** or "" if **match$** is not found. Same as **getSuffix$()**.

#### afterLast$(str$, match$)
Returns the portion of **str$** after the last occurence of **match$** or "" if **match$** is not found.

#### getSuffix$(str$, match$)
Returns the portion of **str$** after **match$** or "" if **match$** is not found.

#### endswith(str$, match$)
Returns 1 if the rightmost portion of **str$** is **match$**, otherwise it returns 0.

#### extract$(str$, s$, e$)
Returns the portion of **str$** between **s$** and **e$** or "" if either **s$** or **e$** is not found.

#### ldap$(str$, padlen, padstr$)
Returns *str$* left padded with *padstr$* to the length *padlen*.

#### rpad$(str$, padlen, padstr$)
Returns *str$* right padded with *padstr$* to the length *padlen*.

#### remchar(str$, removeThese$)
Return **str$** with all **removeThese$** characters removed

#### replace$(str$, match$, rep$)
Returns **str$** with first occurance of **match$** repaced by **rep$**. If **match$** is not found,
**str$** is returned unchanged.

#### replaceAll$(str$, match$, rep$)
Returns **str$** with all occurances of **match$** replaced by **rep$**. If **match$** is not found,
**str$** is returned unchanged.

#### startsWith$(str$, match$)
Returns 1 if the leftmost portion of **str$** is **match$**, otherwise it returns 0.

#### randomCharacter$()
Returns a random printable ASCII character.

#### randomString$(n)
Returns a string of *n* random printable ASCII characters.

### SQLite Helper Functions

#### quote$(str$)
Returns **str$** enclosed in single quotes. Any single quotes in **str$** with be doubled up (escaped).

### URL Helper Functions

#### getUrlParam$(params$, key$)
Returns the value of the URL parameter **key$**.

#### urlDecode$(str$)
Returns **str$** with URL encoded characters decoded.

### urlEncode$(str$)
Returns **str$** encoded for use in a URL.
