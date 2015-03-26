' functionLibrary test suite

global testnum, testok, testfailed

run "functionLibrary", #lib

call assertn #lib version(), 7
call assertn #lib isnull(), 0
call assert #lib debug$(), "Function Library"

call assert #lib basename$("/path/to/a/file.ext"), "file.ext"
call assert #lib basename$("file.ext"), "file.ext"

call assert #lib dirname$("/path/to/a/file.ext"), "/path/to/a"
call assert #lib dirname$("file.ext"), "."

call assert #lib extension$("/path/to/a/file.ext"), "ext"
call assert #lib extension$("/path/to/a/file"), ""
call assert #lib extension$("/path/to.ext/file"), ""

call assert #lib getPrefix$("Hello world!", "apple"), ""
call assert #lib getPrefix$("Hello world!", "H"), ""
call assert #lib getPrefix$("Hello world!", "llo"), "He"
call assert #lib getPrefix$("Hello World!", "!"), "Hello World"

call assert #lib getSuffix$("Hello world!", "apple"), ""
call assert #lib getSuffix$("Hello World!", "H"), "ello World!"
call assert #lib getSuffix$("Hello world!", "llo"), " world!"
call assert #lib getSuffix$("Hello World!", "!"), ""

call assert #lib urlEncode$("abcdefghijklmnopqrstuvwxyz"), "abcdefghijklmnopqrstuvwxyz"
call assert #lib urlEncode$("ABCDEFGHIJKLMNOPQRSTUVWXYZ"), "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
call assert #lib urlEncode$("0123456789-_.~"), "0123456789-_.~"
call assert #lib urlEncode$("!#$&'()*+,/:;=?@[] "), "%21%23%24%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40%5B%5D%20"

call assert #lib urlDecode$("abcdefghijklmnopqrstuvwxyz"), "abcdefghijklmnopqrstuvwxyz"
call assert #lib urlDecode$("ABCDEFGHIJKLMNOPQRSTUVWXYZ"), "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
call assert #lib urlDecode$("0123456789-_.~"), "0123456789-_.~"
call assert #lib urlDecode$("%21%23%24%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40%5B%5D%20"), "!#$&'()*+,/:;=?@[] "

call summary

sub assert in$, expected$
  testnum = testnum + 1
  print "Test "; testnum; " got <"; in$; ">, expected <"; expected$; "> - ";
  if in$ <> expected$ then
    testfailed = testfailed + 1
    print " FAILED"
  else
    testok = testok + 1
    print " Passed"
  end if
end sub

sub assertn in, expected
  call assert str$(in), str$(expected)
end sub

sub summary
  print
  print "===================================="
  print testnum; " tests run"
  print testok; " test passed"
  print testfailed; " tests failed"
  print "===================================="
end sub
