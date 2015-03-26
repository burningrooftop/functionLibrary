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
Returns the library version (currently set to 7).

### Checksum Functions

#### adler32(str$)
Returns the adler32 checksum of **str$**.

### File Path Function

#### basename$(path$)
Returns the filename portion of the pathname **path$**.

#### dirname$(path$)
Returns the directory portion of the pathname **path$**.

#### extension$(path$)
Returns the file extension (ie the part of the filename after the '.') of **path$**.

#### pathSeparator$()
Returns the path separator for the operating system being used ("/" for linux and Mac OS X, "\" for windows).

### HTML Helper Functions

#### escapeHTML$(str$)
Returns **str$** with characters <, >, &, ", ' encoded to HMTM entities.

### String Functions

#### getPrefix$(str$, match$)
Returns the portion of **str$** before **match$** or "" if **match$** is not found.

#### getSuffix$(str$, match$)
Returns the portion of **str$** after **match$** or "" if **match$** is not found.

#### extract$(str$, s$, e$)
Returns the portion of **str$** between **s$** and **e$** or "" if either **s$** or **e$** is not found.

#### replace$(str$, match$, rep$)
Returns **str$** with first occurance of **match$** repaced by **rep$**. If **match$** is not found,
**str$** is returned unchanged.

#### replaceAll$(str$, match$, rep$)
Returns **str$** with all occurances of **match$** replaced by **rep$**. If **match$** is not found,
**str$** is returned unchanged.

### SQLite Helper Functions

quote$(str$)
Returns **str$** enclosed in single quotes. Any single quotes in **str$** with be doubled up (escaped).

### URL Helper Functions

#### getUrlParam$(params$, key$)
Returns the value of the URL parameter **key$**.

#### urlDecode$(str$)
Returns **str$** with URL encoded characters decoded.

### urlEncode$(str$)
Returns **str$** encoded for use in a URL.
