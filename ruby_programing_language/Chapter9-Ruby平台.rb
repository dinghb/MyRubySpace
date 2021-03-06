#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap9.1 ×Ö·û´®String =============================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------


# ¼¸¸öµÚ3ÕÂµÄ·½·¨£¬ÐÂ½¨×Ö·û´®£¬Æ´½Ó×Ö·û´®
s = "hello"
s.concat(" world")    # Synonym for <<. Mutating append to s. Returns new s.
s.insert(5, " there") # Same as s[5] = " there". Alters s. Returns new s.
s.slice(0,5)          # Same as s[0,5]. Returns a substring.
s.slice!(5,6)         # Deletion. Same as s[5,6]="". Returns deleted substring.
s.eql?("hello world") # True. Same as ==.
"Ho! " * 3   #=> "Ho! Ho! Ho! "
"Hello from " + self.to_s   #=> "Hello from main"
a = "hello "
a << "world"   #=> "hello world"
a.concat(33)   #=> "hello world!"

# ¼¸¸ö»ñµÃ×Ö·û´®³¤¶ÈµÄ·½·¨
s.length         # => 5: counts characters in 1.9, bytes in 1.8
s.size           # => 5: size is a synonym
s.bytesize       # => 5: length in bytes; Ruby 1.9 only
s.empty?         # => false
"".empty?        # => true
---------------------------
# ÏÂÁÐ·½·¨ÓÃÓÚ²éÕÒºÍÌæ»»ÎÄ±¾
s = "hello"
# Finding the position of a substring or pattern match
s.index('l')         # => 2: index of first l in string
s.index(?l)          # => 2: works with character codes as well
s.index(/l+/)        # => 2: works with regular expressions, too
s.index('l',3)       # => 3: index of first l in string at or after position 3
s.index('Ruby')      # => nil: search string not found
s.rindex('l')        # => 3: index of rightmost l in string
s.rindex('l',2)      # => 2: index of rightmost l in string at or before 2

# Checking for prefixes and suffixes: Ruby 1.9 and later
s.start_with? "hell" # => true.  Note singular "start" not "starts"
s.end_with? "bells"  # => false

# Testing for presence of substring
s.include?("ll")     # => true: "hello" includes "ll"
s.include?(?H)       # => false: "hello" does not include character H

# Pattern matching with regular expressions
s =~ /[aeiou]{2}/    # => nil: no double vowels in "hello"
s.match(/[aeiou]/) {|m| m.to_s} # => "e": return first vowel

# Splitting a string into substrings based on a delimiter string or pattern
"this is it".split     # => ["this", "is", "it"]: split on spaces by default
"hello".split('l')     # => ["he", "", "o"]
"1, 2,3".split(/,\s*/) # => ["1","2","3"]: comma and optional space delimiter

# Split a string into two parts plus a delimiter. Ruby 1.9 only.
# These methods always return arrays of 3 strings:
"banana".partition("an")  # => ["b", "an", "ana"] 
"banana".rpartition("an") # => ["ban", "an", "a"]: start from right
"a123b".partition(/\d+/)  # => ["a", "123", "b"]: works with Regexps, too

# Search and replace the first (sub, sub!) or all (gsub, gsub!)
# occurrences of the specified string or pattern.
# More about sub and gsub when we cover regular expressions later.
s.sub("l", "L")            # => "heLlo": Just replace first occurrence
s.gsub("l", "L")           # => "heLLo": Replace all occurrences
s.sub!(/(.)(.)/, '\2\1')   # => "ehllo": Match and swap first 2 letters
s.sub!(/(.)(.)/, "\\2\\1") # => "hello": Double backslashes for double quotes

# sub and gsub can also compute a replacement string with a block
# Match the first letter of each word and capitalize it
"hello world".gsub(/\b./) {|match| match.upcase } # => "Hello World"
---------------------------
# ´¦Àí´óÐ¡Ð´µÄÒ»ÏµÁÐ·½·¨

# Case modification methods
s = "world"   # These methods work with ASCII characters only
s.upcase      # => "WORLD"
s.upcase!     # => "WORLD"; alter s in place
s.downcase    # => "world"
s.capitalize  # => "World": first letter upper, rest lower
s.capitalize! # => "World": alter s in place
s.swapcase    # => "wORLD": alter case of each letter

a = "hello"
a.capitalize!   #=> "Hello"
a               #=> "Hello"
a.capitalize!   #=> nil

# ´óÐ¡Ð´±È½Ï
# Case insensitive comparison. (ASCII text only)
# casecmp works like <=> and returns -1 for less, 0 for equal, +1 for greater
"world".casecmp("WORLD")  # => 0 
"a".casecmp("B")          # => -1 (<=> returns 1 in this case)
"abcdef" <=> "abcde"     #=> 1
"abcdef" <=> "abcdef"    #=> 0
"abcdef" <=> "abcdefg"   #=> -1
"abcdef" <=> "ABCDEF"    #=> 1
---------------------------
s = "hello\r\n"      # A string with a line terminator
s.chomp!             # => "hello": remove one line terminator from end
s.chomp              # => "hello": no line terminator so no change
s.chomp!             # => nil: return of nil indicates no change made
s.chomp("o")         # => "hell": remove "o" from end
$/ = ";"             # Set global record separator $/ to semicolon
"hello;".chomp       # => "hello": now chomp removes semicolons and end

# chop removes trailing character or line terminator (\n, \r, or \r\n)
s = "hello\n"
s.chop!              # => "hello": line terminator removed. s modified.
s.chop               # => "hell": last character removed. s not modified.
"".chop              # => "": no characters to remove
"".chop!             # => nil: nothing changed

# Strip all whitespace (including \t, \r, \n) from left, right, or both
# strip!, lstrip! and rstrip! modify the string in place.
s = "\t hello \n"   # Whitespace at beginning and end
s.strip             # => "hello"
s.lstrip            # => "hello \n"
s.rstrip            # => "\t hello"

# Left-justify, right-justify, or center a string in a field n-characters wide.
# There are no mutator versions of these methods. See also printf method.
s = "x"
s.ljust(3)          # => "x  "
s.rjust(3)          # => "  x"
s.center(3)         # => " x "
s.center(5, '-')    # => "--x--": padding other than space are allowed
s.center(7, '-=')   # => "-=-x-=-": multicharacter padding allowed
---------------------------
#×Ö·û´®¿ÉÒÔ°´×Ö½Ú»òÐÐ·½Ê½½øÐÐÃ¶¾Ù
s = "A\nB"                       # Three ASCII characters on two lines
s.each_byte {|b| print b, " " }  # Prints "65 10 66 "
s.each_line {|l| print l.chomp}  # Prints "AB"

# Sequentially iterate characters as 1-character strings
# Works in Ruby 1.9, or in 1.8 with the jcode library:
s.each_char { |c| print c, " " } # Prints "A \n B "

# Enumerate each character as a 1-character string
# This does not work for multibyte strings in 1.8
# It works (inefficiently) for multibyte strings in 1.9:
0.upto(s.length-1) {|n| print s[n,1], " "}

# In Ruby 1.9, bytes, lines, and chars are aliases
s.bytes.to_a                     # => [65,10,66]: alias for each_byte
s.lines.to_a                     # => ["A\n","B"]: alias for each_line
s.chars.to_a                     # => ["A", "\n", "B"] alias for each_char
---------------------------
# ´Ó×Ö·û´®½âÎöÊý×Ö
"10".to_i          # => 10: convert string to integer
"10".to_i(2)       # => 2: argument is radix: between base-2 and base-36
"10x".to_i         # => 10: nonnumeric suffix is ignored. Same for oct, hex
" 10".to_i         # => 10: leading whitespace ignored
"ten".to_i         # => 0: does not raise exception on bad input
"10".oct           # => 8: parse string as base-8 integer
"10".hex           # => 16: parse string as hexadecimal integer
"0xff".hex         # => 255: hex numbers may begin with 0x prefix
" 1.1 dozen".to_f  # => 1.1: parse leading floating-point number
"6.02e23".to_f     # => 6.02e+23: exponential notation supported

# °Ñ×Ö·û´®×ª»»³É·ûºÅµÄ·½·¨
"one".to_sym       # => :one -- string to symbol conversion
"two".intern       # => :two -- intern is a synonym for to_sym

"Koala".intern         #=> :Koala
s = 'cat'.to_sym       #=> :cat
s == :cat              #=> true
s = '@cat'.to_sym      #=> :@cat
s == :@cat             #=> true
'cat and dog'.to_sym   #=> :"cat and dog"
---------------------------
# Increment a string:
"a".succ                      # => "b": the successor of "a". Also, succ!
"aaz".next                    # => "aba": next is a synonym. Also, next!
"a".upto("e") {|c| print c }  # Prints "abcde. upto iterator based on succ.

# Reverse a string:
"hello".reverse     # => "olleh". Also reverse!

# Debugging
"hello\n".dump      # => "\"hello\\n\"": Escape special characters
"hello\n".inspect   # Works much like dump

# Translation from one set of characters to another
"hello".tr("aeiou", "AEIOU")  # => "hEllO": capitalize vowels. Also tr!
"hello".tr("aeiou", " ")      # => "h ll ": convert vowels to spaces
"bead".tr_s("aeiou", " ")     # => "b d": convert and remove duplicates

"hello".tr('aeiou', '*')    #=> "h*ll*"
"hello".tr('^aeiou', '*')   #=> "*e**o"
"hello".tr('el', 'ip')      #=> "hippo"
"hello".tr('a-y', 'b-z')    #=> "ifmmp"

# Checksums
"hello".sum          # => 532: weak 16-bit checksum
"hello".sum(8)       # => 20: 8 bit checksum instead of 16 bit
"hello".crypt("ab")  # => "abl0JrMf6tlhw": one way cryptographic checksum
                     # Pass two alphanumeric characters as "salt"
                     # The result may be platform-dependent

#Ñ¹ËõÖ¸¶¨ÖØ¸´×Ö·û´®
"hello".squeeze('a-z')  # => "helo": remove runs of letters. Also squeeze!
"yellow moon".squeeze                  #=> "yelow mon"
"  now   is  the".squeeze(" ")         #=> " now is the"
"putters shoot balls".squeeze("m-z")   #=> "puters shot balls"

# Counting letters, deleting letters, and removing duplicates
"hello".count('aeiou')  # => 2: count lowercase vowels
"hello".delete('aeiou') # => "hll": delete lowercase vowels. Also delete!

# When there is more than one argument, take the intersection.
# Arguments that begin with ^ are negated.
"hello".count('a-z', '^aeiou')   # => 3: count lowercase consonants
"hello".delete('a-z', '^aeiou')  # => "eo: delete lowercase consonants
---------------------------
# 9.1.1 ¸ñÊ½»¯ÎÄ±¾ Formatting Text

n, animal = 2, "mice"
"#{n+1} blind #{animal}"  # => '3 blind mice'
---------------------------
# ¸ñÊ½»¯ÎÄ±¾ÓÐÀûÓÚ£ºÒ».¾«È·¿ØÖÆ×Ö¶ÎµÈ¿í¡£¶þ.¿ÉÏÔÊ¾¸¡µãÊý¡£Èý.°Ñ×Ö·û´®ºÍÒª²åÈë
# µÄÖµ½âñî¿ª£¬ÓÐÀûÓÚ³ÌÐò¹ú¼Ê»¯¡£
# Alternatives to the interpolation above
printf('%d blind %s', n+1, animal)  # Prints '3 blind mice', returns nil
sprintf('%d blind %s', n+1, animal) # => '3 blind mice'
'%d blind %s' % [n+1, animal]  # Use array on right if more than one argument

# Formatting numbers
'%d' % 10         # => '10': %d for decimal integers
'%x' % 10         # => 'a': hexadecimal integers
'%X' % 10         # => 'A': uppercase hexadecimal integers
'%o' % 10         # => '12': octal integers
'%f' % 1234.567   # => '1234.567000': full-length floating-point numbers
'%e' % 1234.567   # => '1.234567e+03': force exponential notation
'%E' % 1234.567   # => '1.234567e+03': exponential with uppercase E
'%g' % 1234.567   # => '1234.57': six significant digits
'%g' % 1.23456E12 # => '1.23456e+12': Use %f or %e depending on magnitude

# Field width
'%5s' % '<<<'     # '  <<<': right-justify in field five characters wide
'%-5s' % '>>>'    # '>>>  ': left-justify in field five characters wide
'%5d' % 123       # '  123': field is five characters wide
'%05d' % 123      # '00123': pad with zeros in field five characters wide

# Precision
'%.2f' % 123.456  # '123.46': two digits after decimal place
'%.2e' % 123.456  # '1.23e+02': two digits after decimal = three significant digits
'%.6e' % 123.456  # '1.234560e+02': note added zero 
'%.4g' % 123.456  # '123.5': four significant digits

# Field and precision combined
'%6.4g' % 123.456 # ' 123.5': four significant digits in field six chars wide
'%3s' % 'ruby'    # 'ruby': string argument exceeds field width
'%3.3s' % 'ruby'  # 'rub': precision forces truncation of string

# Multiple arguments to be formatted
args = ['Syntax Error', 'test.rb', 20]  # An array of arguments
"%s: in '%s' line %d" % args    # => "Syntax Error: in 'test.rb' line 20" 
# Same args, interpolated in different order!  Good for internationalization.
"%2$s:%3$d: %1$s" % args        # => "test.rb:20: Syntax Error"
---------------------------
# 9.1.2 ´ò°üºÍ½â°ü¶þ½øÖÆ×Ö·û´®

a = [1,2,3,4,5,6,7,8,9,10]  # An array of 10 integers
b = a.pack('i10')           # Pack 10 4-byte integers (i) into binary string b
c = b.unpack('i*')          # Decode all (*) the 4-byte integers from b
c == a                      # => true

m = 'hello world'           # A message to encode
data = [m.size, m]          # Length first, then the bytes
template = 'Sa*'            # Unsigned short, any number of ASCII chars
b = data.pack(template)     # => "\v\000hello world"
b.unpack(template)          # => [11, "hello world"]
---------------------------





---------------------------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap9.2 ÕýÔò±í´ïÊ½Regular Expressions ==========================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------





---------------------------
/Ruby?/  # Matches the text "Rub" followed by an optional "y"
---------------------------
/ruby?/i  # Case-insensitive: matches "ruby" or "RUB", etc.
/./mu     # Matches Unicode characters in Multiline mode

# The end delimiter for a regexp can be followed by one or
# more single-letter options which control how the pattern can match
/pat/i - Ignore case
/pat/m - Treat a newline as a character matched by .
/pat/x - Ignore whitespace and comments in the pattern
/pat/o - Perform #{} interpolation only once

/a(?i:b)c/.match('aBc') #=> #<MatchData "aBc">,make the word d Case Insensitive
/a(?i:b)c/.match('abc') #=> #<MatchData "abc">

# egular expressions are assumed to use the source encoding.
# This can be overridden with one of the following modifiers.
/pat/u - UTF-8
/pat/e - EUC-JP
/pat/s - Windows-31J
/pat/n - ASCII-8BIT
---------------------------
%r|/|         # Matches a single slash character, no escape required
%r[</(.*)>]i  # Flag characters are allowed with this syntax, too
---------------------------
/\(\)/     # Matches open and close parentheses
/\\/       # Matches a single backslash
---------------------------
money = /[$\u20AC\u{a3}\u{a5}]/ # match dollar,euro,pound, or yen sign

prefix = ","
/#{prefix}\t/   # Matches a comma followed by an ASCII TAB character
---------------------------
[1,2].map{|x| /#{x}/}   # => [/1/, /2/]
[1,2].map{|x| /#{x}/o}  # => [/1/, /1/]
---------------------------
Regexp.new("Ruby?")                          # /Ruby?/
Regexp.new("ruby?", Regexp::IGNORECASE)      # /ruby?/i
Regexp.compile(".", Regexp::MULTILINE, "u")  # /./mu

# if options is not nil, the regexp will be case insensitive
r1 = Regexp.new('^a-z+:\s+\w+')           #=> /^a-z+:\s+\w+/
r2 = Regexp.new('cat', true)               #=> /cat/i
# If options is a Fixnum, it should be one or more of the constants Regexp::EXTENDED,
# Regexp::IGNORECASE, and Regexp::MULTILINE, or-ed together
r3 = Regexp.new('dog', Regexp::EXTENDED)   #=> /dog/x
r4 = Regexp.new(r2)                        #=> /cat/i

---------------------------
# Returns the set of bits corresponding to the options used when creating this Regexp
Regexp::IGNORECASE                  #=> 1
Regexp::EXTENDED                    #=> 2
Regexp::MULTILINE                   #=> 4

/cat/.options                       #=> 128
/cat/x.options                     #=> 131
Regexp.new('cat', true).options     #=> 129
Regexp.new('cat', 0, 's').options   #=> 384

r = /cat/x
Regexp.new(r.source, r.options)     #=> /cat/ix

---------------------------
# Returns the original string of the pattern.
/ab+c/x.source   #=> "ab+c"
---------------------------
# escape(str) => a_str
# quote(str) => a_str
# Escapes any characters that would have special meaning in a regular expression. 
# Returns a new escaped string, or self if no characters are escaped
Regexp.escape('\*?{}.')   #=> \\\\\*\?\{\}\.
Regexp.quote('\*?{}.')   #=> \\\\\*\?\{\}\.


pattern = "[a-z]+"                # One or more letters
suffix = Regexp.escape("()")      # Treat these characters literally
r = Regexp.new(pattern + suffix)  # /[a-z]+\(\)/
---------------------------
# Return a Regexp object that is the union of the given patterns
# If no patterns are given, returns /(?!)/.
Regexp.union                         #=> /(?!)/
Regexp.union("penzance")             #=> /penzance/
Regexp.union("a+b*c")                #=> /a\+b\*c/
Regexp.union("skiing", "sledding")   #=> /skiing|sledding/
Regexp.union(["skiing", "sledding"]) #=> /skiing|sledding/
Regexp.union(/dogs/, /cats/)         #=> /(?-mix:dogs)|(?i-mx:cats)/


# Match any one of five language names.
pattern = Regexp.union("Ruby", "Perl", "Python", /Java(Script)?/)
# Match empty parens, brackets, or braces. Escaping is automatic:
Regexp.union("()", "[]", "{}")   # => /\(\)|\[\]|\{\}/
---------------------------
# Literal characters
/ruby/             # Match "ruby". Most characters simply match themselves.
/&#xA5;/                # Matches Yen sign. Multibyte characters are suported
                   # in Ruby 1.9 and Ruby 1.8.

# Character classes
/[Rr]uby/          # Match "Ruby" or "ruby"
/rub[ye]/          # Match "ruby" or "rube"
/[aeiou]/          # Match any one lowercase vowel
/[0-9]/            # Match any digit; same as /[0123456789]/
/[a-z]/            # Match any lowercase ASCII letter
/[A-Z]/            # Match any uppercase ASCII letter
/[a-zA-Z0-9]/      # Match any of the above
/[^aeiou]/         # Match anything other than a lowercase vowel
/[^0-9]            # Match anything other than a digit

# Special character classes
/./                # Match any character except newline
/./m               # In multiline mode . matches newline, too
/\d/               # Match a digit /[0-9]/
/\D/               # Match a nondigit: /[^0-9]/
/\s/               # Match a whitespace character: /[ \t\r\n\f]/
/\S/               # Match nonwhitespace: /[^ \t\r\n\f]/
/\w/               # Match a single word character: /[A-Za-z0-9_]/
/\W/               # Match a nonword character: /[^A-Za-z0-9_]/
/\h/               # A hexdigit character ([0-9a-fA-F])
/\H/               # A non-hexdigit character ([^0-9a-fA-F])

# Repetition
/ruby?/            # Match "rub" or "ruby": the y is optional
/ruby*/            # Match "rub" plus 0 or more ys
/ruby+/            # Match "rub" plus 1 or more ys
/\d{3}/            # Match exactly 3 digits
/\d{3,}/           # Match 3 or more digits
/\d{3,5}/          # Match 3, 4, or 5 digits

# Nongreedy repetition: match the smallest number of repetitions
/<.*>/             # Greedy repetition: matches "<ruby>perl>"
/<.*?>/            # Nongreedy: matches "<ruby>" in "<ruby>perl>" 
                   # Also nongreedy: ??, +?, and {n,m}?

# Grouping with parentheses
/\D\d+/            # No group: + repeats \d
/(\D\d)+/          # Grouped: + repeats \D\d pair
/([Rr]uby(, )?)+/  # Match "Ruby", "Ruby, ruby, ruby", etc.

# Backreferences: matching a previously matched group again
/([Rr])uby&\1ails/ # Match ruby&rails or Ruby&Rails
/(['"])[^\1]*\1/   # Single or double-quoted string
                   #   \1 matches whatever the 1st group matched
                   #   \2 matches whatever the 2nd group matched, etc.

# Named groups and backreferences in Ruby 1.9: match a 4-letter palindrome
/(?<first>\w)(?<second>\w)\k<second>\k<first>/
/(?'first'\w)(?'second'\w)\k'second'\k'first'/ # Alternate syntax

# Alternatives
/ruby|rube/        # Match "ruby" or "rube"
/rub(y|le))/       # Match "ruby" or "ruble"
/ruby(!+|\?)/      # "ruby" followed by one or more ! or one ?

# Anchors: specifying match position
^       -  Matches beginning of line
$       -  Matches end of line
\A      -  Matches beginning of string.
\Z      -  Matches end of string. If string ends with a newline, it matches just before newline
\z      -  Matches end of string
\G      -  Matches point where last match finished
\b      -  Matches word boundaries when outside brackets; backspace (0x08) when inside brackets
\B      -  Matches non-word boundaries
(?=pat) -  Positive lookahead assertion: ensures that the following characters match pat, 
           but doesn't include those characters in the matched text
(?!pat) -  Negative lookahead assertion: ensures that the following characters do not match pat,
           but doesn't include those characters in the matched text
(?<=pat) - Positive lookbehind assertion: ensures that the preceding characters match pat, 
           but doesn't include those characters in the matched text
(?<!pat) - Negative lookbehind assertion: ensures that the preceding characters do not match pat, 
	       but doesn't include those characters in the matched text

# Anchors: specifying match position,Examplea for the using of Anchors
/^Ruby/            # Match "Ruby" at the start of a string or internal line
/Ruby$/            # Match "Ruby" at the end of a string or line
/\ARuby/           # Match "Ruby" at the start of a string
/Ruby\Z/           # Match "Ruby" at the end of a string
/\bRuby\b/         # Match "Ruby" at a word boundary
/\brub\B/          # \B is nonword boundary:
                   #   match "rub" in "rube" and "ruby" but not alone
/Ruby(?=!)/        # Match "Ruby", if followed by an exclamation point
/Ruby(?!!)/        # Match "Ruby", if not followed by an exclamation point



# Options:control how the pattern can match
/pat/i - Ignore case
/pat/m - Treat a newline as a character matched by .
/pat/x - Ignore whitespace and comments in the pattern
/pat/o - Perform #{} interpolation only once

# Special syntax with parentheses
/R(?#comment)/     # Matches "R". All the rest is a comment
/R(?i)uby/         # Case-insensitive while matching "uby"
/R(?i:uby)/        # Same thing
/rub(?:y|le))/     # Group only without creating \1 backreference

# The x option allows comments and ignores whitespace
/  # This is not a Ruby comment. It is a literal part
   # of the regular expression, but is ignored.
   R      # Match a single letter R
   (uby)+ # Followed by one or more "uby"s
   \      # Use backslash for a nonignored space
/x                 # Closing delimiter. Don't forget the x option!
---------------------------
# match(str) => matchdata or nil
# Returns a MatchData object describing the match, or nil if there was no match. 
# This is equivalent to retrieving the value of the special variable $~ following a normal match.
/(.)(.)(.)/.match("abc")[2]   #=> "b"
/hay/ =~ 'haystack'   #=> 0
/y/.match('haystack') #=> #<MatchData "y">

pattern = /Ruby?/i      # Match "Rub" or "Ruby", case-insensitive
pattern =~ "backrub"    # Returns 4.
"rub ruby" =~ pattern   # 0
pattern =~ "r"          # nil

# rxp === str => true or false
# Case Equality¡ªSynonym for Regexp#=~ used in case statements.
a = "HELLO"
case a
  when /^[a-z]*$/; print "Lower case\n"
  when /^[A-Z]*$/; print "Upper case\n"
  else;            print "Mixed case\n"
end            # =>  produce output:Upper case

---------------------------
"hello" =~ /e\w{2}/     # 1: Match an e followed by 2 word characters
$~.string               # "hello": the complete string
$~.to_s                 # "ell": the portion that matched
$~.pre_match            # "h": the portion before the match
$~.post_match           # "o": the portion after the match
---------------------------
# This is a pattern with three subpatterns
pattern = /(Ruby|Perl)(\s+)(rocks|sucks)!/ 
text = "Ruby\trocks!"     # Text that matches the pattern    
pattern =~ text           # => 0: pattern matches at the first character
data = Regexp.last_match  # => Get match details
data.size                 # => 4: MatchData objects behave like arrays
data[0]                   # => "Ruby\trocks!": the complete matched text
data[1]                   # => "Ruby": text matching first subpattern
data[2]                   # => "\t": text matching second subpattern
data[3]                   # => "rocks": text matching third subpattern
data[1,2]                 # => ["Ruby", "\t"]
data[1..3]                # => ["Ruby", "\t", "rocks"]
data.values_at(1,3)       # => ["Ruby", "rocks"]: only selected indexes
data.captures             # => ["Ruby", "\t", "rocks"]: only subpatterns
Regexp.last_match(3)      # => "rocks": same as Regexp.last_match[3]

# Start and end positions of matches
data.begin(0)             # => 0: start index of entire match
data.begin(2)             # => 4: start index of second subpattern
data.end(2)               # => 5: end index of second subpattern
data.offset(3)            # => [5,10]: start and end of third subpattern
---------------------------
# Ruby 1.9 only
pattern = /(?<lang>Ruby|Perl) (?<ver>\d(\.\d)+) (?<review>rocks|sucks)!/ 
if (pattern =~ "Ruby 1.9.1 rocks!")
  $~[:lang]            # => "Ruby"
  $~[:ver]             # => "1.9.1"
  $~["review"]         # => "rocks"
  $~.offset(:ver)      # => [5,10] start and end offsets of version number
end
# Names of capturing groups and a map of group names to group numbers
pattern.names          # => ["lang", "ver", "review"]
pattern.named_captures # => {"lang"=>[1],"ver"=>[2],"review"=>[3]}
---------------------------
# Ruby 1.9 only
if /(?<lang>\w+) (?<ver>\d+\.(\d+)+) (?<review>\w+)/ =~ "Ruby 1.9 rules!"
  lang     # => "Ruby"
  ver      # => "1.9"
  review   # => "rules"
end
---------------------------
# match(str) => matchdata or nil
# Returns a MatchData object describing the match, or nil if there was no match. 
/(.)(.)(.)/.match("abc")[2]   #=> "b"


if data = pattern.match(text)  # Or: data = text.match(pattern)
  handle_match(data)
end


pattern.match(text) {|data| handle_match(data) }
---------------------------
"ruby123"[/\d+/]              # "123"
"ruby123"[/([a-z]+)(\d+)/,1]  # "ruby"
"ruby123"[/([a-z]+)(\d+)/,2]  # "123"
---------------------------
r = "ruby123"
r.slice!(/\d+/)  # Returns "123", changes r to "ruby"
---------------------------
s = "one, two, three"
s.split            # ["one,","two,","three"]: whitespace delimiter by default
s.split(", ")      # ["one","two","three"]: hardcoded delimiter
s.split(/\s*,\s*/) # ["one","two","three"]: space is optional around comma
---------------------------
text = "hello world"
pattern = /l/
first = text.index(pattern)       # 2: first match starts at char 2
n = Regexp.last_match.end(0)      # 3: end position of first match
second = text.index(pattern, n)   # 3: search again from there
last = text.rindex(pattern)       # 9: rindex searches backward from end
---------------------------
phone = gets                    # Read a phone number
phone.sub!(/#.*$/, "")          # Delete Ruby-style comments
phone.gsub!(/\D/, "")           # Remove anything other than digits
---------------------------
text.gsub!("rails", "Rails")     # Change "rails" to "Rails" throughout
---------------------------
text.gsub!(/\brails\b/, "Rails") # Capitalize the word "Rails" throughout
---------------------------
text.gsub(/\bruby\b/i, '<b>\0</b>')
---------------------------
text.gsub(/\bruby\b/i, "<b>#{$&}</b>")
---------------------------
# Strip pairs of quotes from a string
re = /(?<quote>['"])(?<body>[^'"]*)\k<quote>/
puts "These are 'quotes'".gsub(re, '\k<body>')
---------------------------
# Use consistent capitalization for the names of programming languages
text = "RUBY Java perl PyThOn"         # Text to modify
lang = /ruby|java|perl|python/i        # Pattern to match
text.gsub!(lang) {|l| l.capitalize }   # Fix capitalization
---------------------------
pattern = /(['"])([^\1]*)\1/   # Single- or double-quoted string
text.gsub!(pattern) do
  if ($1 == '"')   # If it was a double-quoted string
    "'#$2'"        # replace with single-quoted
  else             # Otherwise, if single-quoted
    "\"#$2\""      # replace with double-quoted
  end
end
---------------------------






---------------------------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap9.3 Êý×ÖÏà¹ØµÄ·½·¨ ============================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------





---------------------------
# General Predicates
0.zero?        # => true (is this number zero?)
1.0.zero?      # => false
0.0.nonzero?   # => nil (works like false)
1.nonzero?     # => 1 (works like true)
1.integer?     # => true
1.0.integer?   # => false
1.scalar?      # => false: not a complex number. Ruby 1.9.
1.0.scalar?    # => false: not a complex number. Ruby 1.9.
Complex(1,2).scalar? # => true: a complex number. requires 'complex'.

# Integer predicates
0.even?        # => true (Ruby 1.9)
0.odd?         # => false

# Float predicates
ZERO, INF, NAN = 0.0, 1.0/0.0, 0.0/0.0  # Constants for testing

ZERO.finite?   # => true: is this number finite?
INF.finite?    # => false
NAN.finite?    # => false

ZERO.infinite? # => nil: is this number infinite? Positive or negative?
INF.infinite?  # => 1
-INF.infinite? # => -1
NAN.infinite?  # => nil

ZERO.nan?      # => false: is this number not-a-number?
INF.nan?       # => false
NAN.nan?       # => true
---------------------------
# Rounding methods
1.1.ceil     # =>  2: ceiling: smallest integer >= its argument
-1.1.ceil    # => -1: ceiling: smallest integer >= its argument
1.9.floor    # =>  1: floor: largest integer <= its argument
-1.9.floor   # => -2: floor: largest integer <= its argument
1.1.round    # =>  1: round to nearest integer
0.5.round    # =>  1: round toward infinity when halfway between integers 
-0.5.round   # => -1: or round toward negative infinity
1.1.truncate # =>  1: chop off fractional part: round toward zero
-1.1.to_i    # => -1: synonym for truncate
---------------------------
# Absolute value and sign
-2.0.abs     # => 2.0: absolute value
-2.0<=>0.0   # => -1: use <=> operator to compute sign of a number

# Constants
Float::MAX     # => 1.79769313486232e+308: may be platform dependent
Float::MIN     # => 2.2250738585072e-308
Float::EPSILON # => 2.22044604925031e-16: difference between adjacent floats
---------------------------
# Constants
Math::PI               # => 3.14159265358979
Math::E                # => 2.71828182845905

# Roots
Math.sqrt(25.0)        # => 5.0: square root
27.0**(1.0/3.0)        # => 3.0: cube root computed with ** operator

# Logarithms
Math.log10(100.0)      # => 2.0: base-10 logarithm
Math.log(Math::E**3)   # => 3.0: natural (base-e) logarithm
Math.log2(8)           # => 3.0: base-2 logarithm. Ruby 1.9 and later.
Math.log(16, 4)        # => 2.0: 2nd arg to log() is the base. Ruby 1.9.
Math.exp(2)            # => 7.38905609893065": same as Math::E**2

# Trigonometry
include Math           # Save typing: we can now omit Math prefix.
sin(PI/2)              # => 1.0: sine. Argument is in radians, not degrees.
cos(0)                 # => 1.0: cosine.
tan(PI/4)              # => 1.0: tangent.
asin(1.0)/PI           # => 0.5: arcsine. See also acos and atan.
sinh(0)                # => 0.0: hyperbolic sine. Also cosh, tanh.
asinh(1.0)             # => 0.0: inverse sinh. Also acosh, atanh.

# Convert cartesian point (x,y) to polar coordinates (theta, r)
theta = atan2(y,x)     # Angle between X axis and line (0,0)-(x,y)
r = hypot(x,y)         # Hypotenuse: sqrt(x**2 + y**2)

# Decompose float x into fraction f and exponent e, such that x = f*2**e
f,e = frexp(1024.0)    # => [0.5, 11]
x = ldexp(f, e)        # => 1024: compute x = f*2**e

# Error function
erf(0.0)               # => 0.0: error function
erfc(0.0)              # => 1.0: 1-erf(x): complementary error function
---------------------------
require "bigdecimal"      # Load standard library
dime = BigDecimal("0.1")  # Pass a string to constructor, not a Float
4*dime-3*dime == dime     # true with BigDecimal, but false if we use Float

# Compute monthly interest payments on a mortgage with BigDecimal.
# Use "Banker's Rounding" mode, and limit computations to 20 digits
BigDecimal.mode(BigDecimal::ROUND_MODE, BigDecimal::ROUND_HALF_EVEN)
BigDecimal.limit(20)
principal = BigDecimal("200000")  # Always pass strings to constructor
apr = BigDecimal("6.5")           # Annual percentage rate interest
years = 30                        # Term of mortgage in years
payments = years*12               # 12 monthly payments in a year
interest = apr/100/12             # Convert APR to monthly fraction
x = (interest+1)**payments        # Note exponentiation with BigDecimal
monthly = (principal * interest * x)/(x-1)  # Compute monthly payment
monthly = monthly.round(2)        # Round to two decimal places
monthly = monthly.to_s("f")       # Convert to human-readable string
---------------------------
require "complex"           # Complex is part of the standard library
c = Complex(0.5,-0.2)       # .5-.2i.  
z = Complex.new(0.0, 0.0)   # Complex.new also works, but is not required
10.times { z = z*z + c }    # Iteration for computing Julia set fractals
magnitude = z.abs           # Magnitude of a complex number
x = Math.sin(z)             # Trig functions work with Complex numbers
Math.sqrt(-1.0).to_s        # => "1.0i": square root of -1
Math.sqrt(-1.0)==Complex::I # => true
---------------------------
require "rational"           # Load the library
penny = Rational(1, 100)     # A penny is 1/100th
require "mathn"              # Makes integer division produce Rational values
nickel = 5/100
dime = 10/100
quarter = 1/4
change = 2*quarter + 3*penny # Rational result: 53/100
(1/2 * 1/3).to_s             # "1/6": mathn prints Rationals as fractions
---------------------------
require "matrix"

# Represent the point (1,1) as the vector [1,1]
unit = Vector[1,1]

# The identity transformation matrix
identity = Matrix.identity(2)  # 2x2 matrix
identity*unit == unit          # true: no transformation

# This matrix scales a point by sx,sy
sx,sy = 2.0, 3.0;
scale = Matrix[[sx,0], [0, sy]]
scale*unit             # => [2.0, 3.0]: scaled point

# This matrix rotates counterclockwise around the origin
theta = Math::PI/2     # 90 degrees
rotate = Matrix[[Math.cos(theta), -Math.sin(theta)],
                [Math.sin(theta),  Math.cos(theta)]]
rotate*unit            # [-1.0, 1.0]: 90 degree rotation

# Two transformations in one
scale * (rotate*unit)  # [-2.0, 3.0]
---------------------------
# ÓÃÈ«¾Öº¯ÊýKernel.rand²úÉúËæ»úÊý¡£Èô²»´ø²ÎÊý£¬Ëü·µ»ØÒ»¸ö´óÓÚ0.0
# ¶øÐ¡ÓÚ1.0µÄÎ±Ëæ»ú¸¡µãÊý¡£Èô¸ø¶¨Ò»¸öÕûÊý²ÎÊýmax£¬Ëü·µ»ØÒ»¸ö´óÓÚ0
# ¶øÐ¡ÓÚ|max|µÄÎ±Ëæ»úÕûÊý¡£
rand       # => 0.964395196505186
rand       # => 0.390523655919935
rand(100)  # => 81
rand(100)  # => 32
---------------------------
# È·¶¨Î±Ëæ»úÖÖ×Ó£¬Ôò¿ÉµÃµ½¿ÉÖØ¸´µÄÎ±Ëæ»úÐòÁÐ
srand(0)                # Known seed
[rand(100),rand(100)]   # => [44,47]: pseudorandom sequence
srand(0)                # Reset the seed to repeat the sequence
[rand(100),rand(100)]   # => [44,47]
---------------------------






---------------------------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap9.4 ÈÕÆÚºÍÊ±¼ä Dates and Times=================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------







---------------------------
# Creating Time objects
Time.now        # Returns a time object that represents the current time
Time.new        # A synonym for Time.now

Time.local(2007, 7, 8)          # July 8, 2007
Time.local(2007, 7, 8, 9, 10)   # July 8, 2007, 09:10am, local time
Time.utc(2007, 7, 8, 9, 10)     # July 8, 2007, 09:10 UTC
Time.gm(2007, 7, 8, 9, 10, 11)  # July 8, 2007, 09:10:11 GMT (same as UTC)

# One microsecond before the new millennium began in London
# We'll use this Time object in many examples below.
t = Time.utc(2000, 12, 31, 23, 59, 59, 999999)

# Components of a Time
t.year    # => 2000
t.month   # => 12: December
t.day     # => 31
t.wday    # => 0: day of week: 0 is Sunday
t.yday    # => 366: day of year: 2000 was a leap year
t.hour    # => 23: 24-hour clock
t.min     # => 59
t.sec     # => 59
t.usec    # => 999999: microseconds, not milliseconds
t.zone    # => "UTC": timezone name

# Get all components in an array that holds
# [sec,min,hour,day,month,year,wday,yday,isdst,zone]
# Note that we lose microseconds
values = t.to_a    # => [59, 59, 23, 31, 12, 2000, 0, 366, false, "UTC"]

# Arrays of this form can be passed to Time.local and Time.utc
values[5] += 1     # Increment the year
Time.utc(*values)  # => Mon Dec 31 23:59:59 UTC 2001

# Timezones and daylight savings time
t.zone       # => "UTC": return the timezone
t.utc?       # => true: t is in UTC time zone
t.utc_offset # => 0: UTC is 0 seconds offset from UTC
t.localtime  # Convert to local timezone. Mutates the Time object!
t.zone       # => "PST" (or whatever your timezone is)
t.utc?       # => false
t.utc_offset # => -28800: 8 hours before UTC
t.gmtime     # Convert back to UTC. Another mutator.
t.getlocal   # Return a new Time object in local zone
t.getutc     # Return a new Time object in UTC
t.isdst      # => false: UTC does not have DST. Note no ?.
t.getlocal.isdst # => false: no daylight savings time in winter.

# Weekday predicates: Ruby 1.9
t.sunday?    # => true
t.monday?    # => false
t.tuesday?   # etc.

# Formatting Times and Dates
t.to_s       # => "Sun Dec 31 23:59:59 UTC 2000": Ruby 1.8
t.to_s       # => "2000-12-31 23:59:59 UTC": Ruby 1.9 uses ISO-8601
t.ctime      # => "Sun Dec 31 23:59:59 2000": another basic format

# strftime interpolates date and time components into a template string
# Locale-independent formatting
t.strftime("%Y-%m-%d %H:%M:%S") # => "2000-12-31 23:59:59": ISO-8601 format
t.strftime("%H:%M")             # => "23:59": 24-hour time
t.strftime("%I:%M %p")          # => "11:59 PM": 12-hour clock

# Locale-dependent formats
t.strftime("%A, %B %d")         # => "Sunday, December 31"
t.strftime("%a, %b %d %y")      # => "Sun, Dec 31 00": 2-digit year
t.strftime("%x")                # => "12/31/00": locale-dependent format
t.strftime("%X")                # => "23:59:59"
t.strftime("%c")                # same as ctime

# Parsing Times and Dates
require 'parsedate'    # A versatile date/time parsing library
include ParseDate      # Include parsedate() as a global function
datestring = "2001-01-01"
values = parsedate(datestring)  # [2001, 1, 1, nil, nil, nil, nil, nil]
t = Time.local(*values)         # => Mon Jan 01 00:00:00 -0800 2001
s = t.ctime                     # => "Mon Jan  1 00:00:00 2001"
Time.local(*parsedate(s))==t    # => true

s = "2001-01-01 00:00:00-0500"  # midnight in New York
v = parsedate(s)                # => [2001, 1, 1, 0, 0, 0, "-0500", nil]
t = Time.local(*v)              # Loses time zone information!

# Time arithmetic
now = Time.now          # Current time
past = now - 10         # 10 seconds ago. Time - number => Time
future = now + 10       # 10 seconds from now Time + number => Time
future - now            # => 10  Time - Time => number of seconds

# Time comparisons
past <=> future         # => -1
past < future           # => true
now >= future           # => false
now == now              # => true

# Helper methods for working with time units other than seconds
class Numeric
  # Convert time intervals to seconds
  def milliseconds; self/1000.0; end
  def seconds; self; end
  def minutes; self*60; end
  def hours; self*60*60; end
  def days; self*60*60*24; end
  def weeks; self*60*60*24*7; end

  # Convert seconds to other intervals
  def to_milliseconds; self*1000; end
  def to_seconds; self; end
  def to_minutes; self/60.0; end
  def to_hours; self/(60*60.0); end
  def to_days; self/(60*60*24.0); end
  def to_weeks; self/(60*60*24*7.0); end
end

expires = now + 10.days     # 10 days from now
expires - now               # => 864000.0 seconds
(expires - now).to_hours    # => 240.0 hours

# Time represented internally as seconds since the (platform-dependent) epoch
t = Time.now.to_i    # => 1184036194 seconds since epoch
Time.at(t)           # => seconds since epoch to Time object
t = Time.now.to_f    # => 1184036322.90872: includes 908720 microseconds
Time.at(0)           # => Wed Dec 31 16:00:00 -0800 1969: epoch in local time
---------------------------






---------------------------------------------------------------------
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap9.5 Êý×éºÍ¼¯ºÏ Array and Collections==========================================

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------






---------------------------
(5..7).each {|x| print x }                 # Prints "567"
(5..7).each_with_index {|x,i| print x,i }  # Prints "506172"
---------------------------
(1..10).each_slice(4) {|x| print x } # Prints "[1,2,3,4][5,6,7,8][9,10]"
---------------------------
(1..5).each_cons(3) {|x| print x }    # Prints "[1,2,3][2,3,4][3,4,5]"
---------------------------
data = [1,2,3,4]                        # An enumerable collection
roots = data.collect {|x| Math.sqrt(x)} # Collect roots of our data
words = %w[hello world]                 # Another collection
upper = words.map {|x| x.upcase }       # Map to uppercase
---------------------------
(1..3).zip([4,5,6]) {|x| print x.inspect } # Prints "[1,4][2,5][3,6]"
(1..3).zip([4,5,6],[7,8]) {|x| print x}    # Prints "14725836"
(1..3).zip('a'..'c') {|x,y| print x,y }    # Prints "1a2b3c"
---------------------------
(1..3).to_a       # => [1,2,3]
(1..3).entries    # => [1,2,3]
---------------------------
require 'set'
(1..3).to_set     # => #<Set: {1, 2, 3}>
---------------------------
e = [1..10].to_enum              # Uses Range.each
e = "test".enum_for(:each_byte)  # Uses String.each_byte
e = "test".each_byte             # Uses String.each_byte
---------------------------
"Ruby".each_char.max       # => "y"; Enumerable method of Enumerator
iter = "Ruby".each_char    # Create an Enumerator
loop { print iter.next }   # Prints "Ruby"; use it as external iterator
print iter.next            # Prints "R": iterator restarts automatically
iter.rewind                # Force it to restart now
print iter.next            # Prints "R" again
---------------------------
# Print "0:R\n1:u\n2:b\n3:y\n"
#{}"Ruby".each_char.with_index.each {|c,i| puts "#{i}:#{c} }
---------------------------
w = Set['apple','Beet','carrot']  # A set of words to sort
w.sort                         # ['Beet','apple','carrot']: alphabetical
w.sort {|a,b| b<=>a }          # ['carrot','apple','Beet']: reverse
w.sort {|a,b| a.casecmp(b) }   # ['apple','Beet','carrot']: ignore case
w.sort {|a,b| b.size<=>a.size} # ['carrot','apple','Beet']: reverse length
---------------------------
# Case-insensitive sort
words = ['carrot', 'Beet', 'apple']
words.sort_by {|x| x.downcase}       # => ['apple', 'Beet', 'carrot']
---------------------------
primes = Set[2, 3, 5, 7]
primes.include? 2        # => true
primes.member? 1         # => false
---------------------------
# Find the first subarray that includes the number 1
data = [[1,2], [0,1], [7,8]]
data.find {|x| x.include? 1}     # => [1,2]
data.detect {|x| x.include? 3}   # => nil: no such element
---------------------------
data.find_index {|x| x.include? 1} # => 0: the first element matches
data.find_index {|x| x.include? 3} # => nil: no such element
---------------------------
(1..8).select {|x| x%2==0}    # => [2,4,6,8]: select even elements
(1..8).find_all {|x| x%2==1}  # => [1,3,5,7]: find all odd elements
---------------------------
primes = [2,3,5,7]
primes.reject {|x| x%2==0}  # => [3,5,7]: reject the even ones
---------------------------
(1..8).partition {|x| x%2==0}  # => [[2, 4, 6, 8], [1, 3, 5, 7]]
---------------------------
# Group programming languages by their first letter
langs = %w[ java perl python ruby ]
groups = langs.group_by {|lang| lang[0] }
groups # => {"j"=>["java"], "p"=>["perl", "python"], "r"=>["ruby"]}
---------------------------
# Returns an array of every element in enum for which Pattern === element.
# If the optional block is supplied, each matching element is passed to it,
# and the block¡¯s result is stored in the output array.
(1..100).grep 38..44   #=> [38, 39, 40, 41, 42, 43, 44]
c = IO.constants
c.grep(/SEEK/)         #=> [:SEEK_SET, :SEEK_CUR, :SEEK_END]
res = c.grep(/SEEK/) {|v| IO.const_get(v) }
res                    #=> [0, 1, 2]

langs = %w[ java perl python ruby ]
langs.grep(/^p/)                    # => [perl, python]: start with 'p'
langs.grep(/^p/) {|x| x.capitalize} # => [Perl, Python]: fix caps
data = [1, 17, 3.0, 4]
ints = data.grep(Integer)           # => [1, 17, 4]: only integers
small = ints.grep(0..9)             # [1,4]: only in range
---------------------------
p (1..5).first(2)      # => [1,2]
p (1..5).take(3)       # => [1,2,3]
p (1..5).drop(3)       # => [4,5]
---------------------------
[1,2,3,nil,4].take_while {|x| x }  # => [1,2,3]: take until nil
[nil, 1, 2].drop_while {|x| !x }   # => [1,2]: drop leading nils
---------------------------
[10, 100, 1].min    # => 1
['a','c','b'].max   # => 'c'
[10, 'a', []].min   # => ArgumentError: elements not comparable
---------------------------
langs = %w[java perl python ruby]    # Which has the longest name?
langs.max {|a,b| a.size <=> b.size } # => "python": block compares 2
langs.max_by {|word| word.length }   # => "python": Ruby 1.9 only
---------------------------
(1..100).minmax                   # => [1,100] min, max as numbers
(1..100).minmax_by {|n| n.to_s }  # => [1,99]  min, max as strings
---------------------------
c = -2..2
c.all? {|x| x>0}    # => false: not all values are > 0
c.any? {|x| x>0}    # => true: some values are > 0
c.none? {|x| x>2}   # => true: no values are > 2
c.one? {|x| x>0}    # => false: more than one value is > 0
c.one? {|x| x>2}    # => false: no values are > 2
c.one? {|x| x==2}   # => true: one value == 2
[1, 2, 3].all?      # => true: no values are nil or false
[nil, false].any?   # => false: no true values
[].none?            # => true: no non-false, non-nil values    
---------------------------
a = [1,1,2,3,5,8]
a.count(1)                # => 2: two elements equal 1
a.count {|x| x % 2 == 1}  # => 4: four elements are odd
---------------------------
# How many negative numbers?
(-2..10).inject(0) {|num, x| x<0 ? num+1 : num }  # => 2

# Sum of word lengths
%w[pea queue are].inject(0) {|total, word| total + word.length }  # => 11
---------------------------
sum = (1..5).inject {|total,x| total + x}  # => 15
prod = (1..5).inject {|total,x| total * x} # => 120
max = [1,3,2].inject {|m,x| m>x ? m : x}   # => 3
[1].inject {|total,x| total + x}           # => 1: block never called
---------------------------
sum = (1..5).reduce(:+)                    # => 15
prod = (1..5).reduce(:*)                   # => 120
letters = ('a'..'e').reduce("-", :concat)  # => "-abcde"
---------------------------




------------------------------------------------------------------------------------
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Array Êý×é========================================================================

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
------------------------------------------------------------------------------------




---------------------------
[1,2,3]             # Basic array literal
[]                  # An empty array
[]                  # Arrays are mutable: this empty array is different
%w[a b c]           # => ['a', 'b', 'c']: array of words
Array[1,2,3]        # => [1,2,3]: just like an array literal

# Creating arrays with the new() method
empty = Array.new             # []: returns a new empty array
nils = Array.new(3)           # [nil, nil, nil]: three nil elements
copy = Array.new(nils)        # Make a new copy of an existing array
zeros = Array.new(4, 0)       # [0, 0, 0, 0]: four 0 elements
count = Array.new(3){|i| i+1} # [1,2,3]: three elements computed by block

Array.new
Array.new(2)
Array.new(5, "A")
# only one copy of the object is created
a = Array.new(2, Hash.new)
a[0]['cat'] = 'feline'
a
a[1]['cat'] = 'Felix'
a

# here multiple copies are created
a = Array.new(2) { Hash.new }
a[0]['cat'] = 'feline'
a

squares = Array.new(5) {|i| i*i}
squares

copy = Array.new(squares)

# Be careful with repeated objects
a=Array.new(3,'a')  # => ['a','a','a']: three references to the same string
a[0].upcase!        # Capitalize the first element of the array
a                   # => ['A','A','A']: they are all the same string!
a=Array.new(3){'b'} # => ['b','b','b']: three distinct string objects
a[0].upcase!;       # Capitalize the first one
a                   # => ['B','b','b']: the others are still lowercase
---------------------------

# Element Assignment¡ªSets the element at index, or replaces a subarray
# starting at start and continuing for length elements,
# or replaces a subarray specified by range.
a = Array.new
a[4] = "4";                 #=> [nil, nil, nil, nil, "4"]
a[0, 3] = [ 'a', 'b', 'c' ] #=> ["a", "b", "c", nil, "4"]
a[1..2] = [ 1, 2 ]          #=> ["a", 1, 2, nil, "4"]
a[0, 2] = "?"               #=> ["?", 2, nil, "4"]
a[0..2] = "A"               #=> ["A", "4"]
a[-1]   = "Z"               #=> ["A", "Z"]
a[1..-1] = nil              #=> ["A"]

---------------------------
# Array length
[1,2,3].length     # => 3
[].size            # => 0: synonym for length
[].empty?          # => true
[nil].empty?       # => false
[1,2,nil].nitems   # => 2: number of non-nil elements          
[1,2,3].nitems {|x| x>2} # => 1: # of elts matching block (Ruby 1.9)

# count => int click to toggle source
# count(obj) =>int
# count { |item| block } =>int
# Returns the number of elements.
# If an argument is given, counts the number of elements which equals to obj
# If a block is given, counts the number of elements yielding a true value.
ary = [1, 2, 4, 2]
ary.count             # => 4
ary.count(2)          # => 2
ary.count{|x|x%2==0}  # => 3


# Indexing single elements
a = %w[a b c d]    # => ['a', 'b', 'c', 'd']
a[0]               # => 'a': first element
a[-1]              # => 'd': last element
a[a.size-1]        # => 'd': last element
a[-a.size-1]       # => 'a': first element
a[5]               # => nil: no such element
a[-5]              # => nil: no such element
a.at(2)            # => 'c': just like [] for single integer argument
a.fetch(1)         # => 'b': also like [] and at
a.fetch(-1)        # => 'd': works with negative args
a.fetch(5)         # => IndexError!: does not allow out-of-bounds
a.fetch(-5)        # => IndexError!: does not allow out-of-bounds
a.fetch(5, 0)      # => 0: return 2nd arg when out-of-bounds
a.fetch(5){|x|x*x} # => 25: compute value when out-of-bounds
a.first            # => 'a': the first element
a.last             # => 'd': the last element
a.choice           # Ruby 1.9: return one element at random

# Indexing subarrays
a[0,2]             # => ['a','b']: two elements, starting at 0
a[0..2]            # => ['a','b','c']: elements with index in range
a[0...2]           # => ['a','b']: three dots instead of two
a[1,1]             # => ['b']: single element, as an array
a[-2,2]            # => ['c','d']: last two elements
a[4,2]             # => []: empty array right at the end 
a[5,1]             # => nil: nothing beyond that
a.slice(0..1)      # => ['a','b']: slice is synonym for []
a.first(3)         # => ['a','b','c']: first three elements
a.last(1)          # => ['d']: last element as an array


a = [1, 2, 3, 4, 5, 0]
a.take(3)             # => [1, 2, 3]  ,Returns first 3 elements from array.

a = [ "a", "b", "c", "d", "e" ]
a[2] +  a[0] + a[1]    #=> "cab"
a[6]                   #=> nil
a[1, 2]                #=> [ "b", "c" ]
a[1..3]                #=> [ "b", "c", "d" ]
a[4..7]                #=> [ "e" ]
a[6..10]               #=> nil
a[-3, 3]               #=> [ "c", "d", "e" ]
# special cases
a[5]                   #=> nil
a[5, 1]                #=> []
a[5..10]               #=> []

# Extracting arbitrary values
a.values_at(0,2)         # => ['a','c']
a.values_at(4, 3, 2, 1)  # => [nil, 'd','c','b']
a.values_at(0, 2..3, -1) # => ['a','c','d','d']
a.values_at(0..2,1..3)   # => ['a','b','c','b','c','d']
---------------------------
a = [1,2,3]        # Start with this array
# Changing the value of elements
a[0] = 0           # Alter an existing element: a is [0,2,3]
a[-1] = 4          # Alter the last element: a is [0,2,4]
a[1] = nil         # Set the 2nd element to nil: a is [0,nil,4]

# Appending to an array
# Append¡ªPushes the given object on to the end of this array. 
a = [1,2,3]        # Start over with this array
a[3] = 4           # Add a fourth element to it: a is [1,2,3,4]
a[5] = 6           # We can skip elements: a is [1,2,3,4,nil,6]
a << 7             # => [1,2,3,4,nil,6,7]
a << 8 << 9        # => [1,2,3,4,nil,6,7,8,9] operator is chainable
a = [1,2,3]        # Start over with short array
a + a              # => [1,2,3,1,2,3]: + concatenates into new array
a.concat([4,5])    # => [1,2,3,4,5]: alter a in place: note no !
[ "a", "b" ].concat( ["c", "d"] ) #=> [ "a", "b", "c", "d" ]  Appends the elements in other_array to self.

# Inserting elements with insert
a = ['a', 'b', 'c']
a.insert(1, 1, 2)  # a now holds ['a',1,2,'b','c']. Like a[1,0] = [1,2]

# Removing (and returning) individual elements by index
a = [1,2,3,4,5,6]
a.delete_at(4)     # => 5: a is now [1,2,3,4,6]
a.delete_at(-1)    # => 6: a is now [1,2,3,4]
a.delete_at(4)     # => nil: a is unchanged

# Removing elements by value
a.delete(4)        # => 4: a is [1,2,3]
a[1] = 1           # a is now [1,1,3]
a.delete(1)        # => 1: a is now [3]: both 1s removed
a = [1,2,3]
a.delete_if {|x| x%2==1} # Remove odd values: a is now [2]
a.reject! {|x| x%2==0}   # Like delete_if: a is now []
 
# Removing elements and subarrays with slice!
a = [1,2,3,4,5,6,7,8]
a.slice!(0)        # => 1: remove element 0: a is [2,3,4,5,6,7,8]
a.slice!(-1,1)     # => [8]: remove subarray at end: a is [2,3,4,5,6,7]
a.slice!(2..3)     # => [4,5]: works with ranges: a is [2,3,6,7]
a.slice!(4,2)      # => []: empty array just past end: a unchanged
a.slice!(5,2)      # => nil: a now holds [2,3,6,7,nil]!


# Replacing subarrays with []=
# To delete, assign an empty array
# To insert, assign to a zero-width slice
a = ('a'..'e').to_a    # => ['a','b','c','d','e']
a[0,2] = ['A','B']     # a now holds ['A', 'B', 'c', 'd', 'e']
a[2...5]=['C','D','E'] # a now holds ['A', 'B', 'C', 'D', 'E']
a[0,0] = [1,2,3]       # Insert elements at the beginning of a
a[0..2] = []           # Delete those elements
a[-1,1] = ['Z']        # Replace last element with another
a[-1,1] = 'Z'          # For single elements, the array is optional
a[1,4] = nil           # Ruby 1.9: a now holds ['A',nil]
                       # Ruby 1.8: a now holds ['A']: nil works like []

# Other methods
a = [4,5]
a.replace([1,2,3])     # a now holds [1,2,3]: a copy of its argument
a                      # a now holds [1,2,3]

a.fill(0)              # a now holds [0,0,0]
a.fill(nil,1,3)        # a now holds [0,nil,nil,nil]
a.fill('a',2..4)       # a now holds [0,nil,'a','a','a']
a[3].upcase!           # a now holds [0,nil,'A','A','A']
a.fill(2..4) { 'b' }   # a now holds [0,nil,'b','b','b']
a[3].upcase!           # a now holds [0,nil,'b','B','b']
a.compact              # => [0,'b','B','b']: Returns a copy of self with all nil elements removed.
a.compact!             # Remove nils in place: a now holds [0,'b','B','b']
a.clear                # a now holds []

[ "a", nil, "b", nil, "c", nil ].compact  #=> [ "a", "b", "c" ]

# compact!·½·¨:Returns nil if no changes were made.
[ "a", nil, "b", nil, "c" ].compact! #=> [ "a", "b", "c" ]
[ "a", "b", "c" ].compact!           #=> nil

---------------------------
# Êä³öÓë±éÀú
a = ['a','b','c']
a.each {|x| print x }         # The basic each iterator prints "abc"
a.each {|x| print x, " -- " }      # =>"a -- b -- c --" 

# Same as Array#each, but passes the index of the element instead of the element itself.
a.each_index {|i| print i}         # Array-specific: prints "012"
a.each_index {|x| print x, " -- " }# =>"a -- b -- c --" 
a.each_with_index{|e,i| print e,i} # Enumerable: prints "a0b1c2"

# collect {|item| block } => an_array click to toggle source
# map {|item| block } => an_array
# Invokes block once for each element of self.
# Creates a new array containing the values returned by the block.
a.map {|x| x.upcase}               # Enumerable: returns ['A','B','C']
a.map! {|x| x.upcase}              # Array-specific: alters a in place
a.collect! {|x| x.downcase!}       # collect! is synonym for map!
a = [ "a", "b", "c", "d" ]
a.collect! {|x| x + "!" }          #=>  [ "a!", "b!", "c!", "d!" ]

a.reverse_each {|e| print e}       # Array-specific: prints "cba" 

a.cycle {|e| print e }             # Ruby 1.9: prints "abcabcabc..." forever
a.cycle(2) {|x| puts x }           # print, "abcabc",only twice

# Searching methods
a = %w[h e l l o]
a.include?('e')                    # => true
a.include?('w')                    # => false
a.index('l')                       # => 2: index of first match
a.index('L')                       # => nil: no match found
a.rindex('l')                      # => 3: search backwards
a.index {|c| c =~ /[aeiou]/}       # => 1: index of first vowel. Ruby 1.9.
a.rindex {|c| c =~ /[aeiou]/}      # => 4: index of last vowel. Ruby 1.9.

a = [ "a", "b", "c", "d", "e" ]
a.at(0)     #=> "a"  ,Returns the element at index 0
a.at(-1)    #=> "e"  ,Returns the element at index -1

# Sorting
a.sort     # => %w[e h l l o]: copy a and sort the copy
a.sort!    # Sort in place: a now holds ['e','h','l','l','o']
a = [1,2,3,4,5]               # A new array to sort into evens and odds
a.sort! {|a,b| a%2 <=> b%2}   # Compare elements modulo 2

# Shuffling arrays: the opposite of sorting; Ruby 1.9 only
a = [1,2,3]     # Start ordered
puts a.shuffle  # Shuffle randomly. E.g.: [3,1,2]. Also shuffle!
---------------------------
# Comparison¡ªReturns an integer (-1, 0, or +1) 
# if this array is less than, equal to, or greater than other_array.
[1,2] <=> [4,5]      # => -1 because 1 < 4
[1,2] <=> [0,0,0]    # => +1 because 1 > 0
[1,2] <=> [1,2,3]    # => -1 because first array is shorter
[1,2] <=> [1,2]      # => 0: they are equal
[1,2] <=> []         # => +1 [] always less than a nonempty array

# Equality¡ªTwo arrays are equal if they contain the same 
# number of elements and if each element is equal to
# (according to Object.==) the corresponding element in the other array.
[ "a", "c" ]    == [ "a", "c", 7 ]     #=> false
[ "a", "c", 7 ] == [ "a", "c", 7 ]     #=> true
[ "a", "c", 7 ] == [ "a", "d", "f" ]   #=> false
---------------------------
# push:Append¡ªPushes the given object(s) on to the end of this array.
# This expression returns the array itself, so several appends may be chained together.
a = []
a.push(1)     # => [1]: a is now [1]
a.push(2,3)   # => [1,2,3]: a is now [1,2,3]

# shift:Returns the first element of self and removes it
a = []
a.push(1)     # => [1]: a is [1]
a.push(2)     # => [1,2]: a is [1,2]
a.shift       # => 1: a is [2]
a.push(3)     # => [2,3]: a is [2,3]
a.shift       # => 2: a is [3]
a.shift       # => 3: a is []
a.shift       # => nil: a is []

# pop:Removes the last element from self and returns it, or nil if the array is empty.
# If a number n is given, returns an array of the last n elements
# (or less) just like array.slice!(-n, n) does.
a.pop         # => 3: a is now [1,2]
a.pop         # => 2: a is now [1]
a.pop         # => 1: a is now []
a.pop         # => nil: a is still []


---------------------------
# ¼¯ºÏ²Ù×÷£º½»¡¢²¢¡¢²¹¡¢²î¼¯
[1,3,5] & [1,2,3]           # => [1,3]: set intersection
[1,1,3,5] & [1,2,3]         # => [1,3]: duplicates removed
[1,3,5] | [2,4,6]           # => [1,3,5,2,4,6]: set union
[1,3,5,5] | [2,4,6,6]       # => [1,3,5,2,4,6]: duplicates removed
[1,2,3] - [2,3]             # => [1]: set difference
[1,1,2,2,3,3] - [2, 3]      # => [1,1]: not all duplicates removed
[ 1, 2, 3 ] + [ 4, 5 ]      #=> [ 1, 2, 3, 4, 5 ]

small = 0..10.to_a          # A set of small numbers
even = 0..50.map {|x| x*2}  # A set of even numbers
smalleven = small & even    # Set intersection
smalleven.include?(8)       # => true: test for set membership

[1, 1, nil, nil].uniq       # => [1, nil]: remove dups. Also uniq!
---------------------------
a = [1,2,3]

# Iterate all possible 2-element subarrays (order matters)
a.permutation(2) {|x| print x }  # Prints "[1,2][1,3][2,1][2,3][3,1][3,2]"

# È«ÅÅÁÐpermutation
a = [1, 2, 3]
a.permutation.to_a     #=> [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
a.permutation(1).to_a  #=> [[1],[2],[3]]
a.permutation(2).to_a  #=> [[1,2],[1,3],[2,1],[2,3],[3,1],[3,2]]
a.permutation(3).to_a  #=> [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
a.permutation(0).to_a  #=> [[]] # one permutation of length 0
a.permutation(4).to_a  #=> []   # no permutations of length 4

# Iterate all possible 2-element subsets (order does not matter)
a.combination(2) {|x| print x }  # Prints "[1, 2][1, 3][2, 3]"

# ×éºÏÊý
a = [1, 2, 3, 4]
a.combination(1).to_a  #=> [[1],[2],[3],[4]]
a.combination(2).to_a  #=> [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
a.combination(3).to_a  #=> [[1,2,3],[1,2,4],[1,3,4],[2,3,4]]
a.combination(4).to_a  #=> [[1,2,3,4]]
a.combination(0).to_a  #=> [[]] # one combination of length 0
a.combination(5).to_a  #=> []   # no combinations of length 5

# Return the Cartesian product of the two sets
a.product(['a','b'])       # => [[1,"a"],[1,"b"],[2,"a"],[2,"b"],[3,"a"],[3,"b"]]
[1,2].product([3,4],[5,6]) # => [[1,3,5],[1,3,6],[1,4,5],[1,4,6], etc... ] 
---------------------------
[[key1, value1], [key2, value2], [key3, value3], ...]
---------------------------
# assoc(obj) => an_array or nil
# Searches through an array whose elements are also arrays comparing obj with
# the first element of each contained array using obj.==
# Returns the first contained array that matches (that is, the first associated
# array), or nil if no match is found. See also Array#rassoc.
s1 = [ "colors", "red", "blue", "green" ]
s2 = [ "letters", "a", "b", "c" ]
s3 = "foo"
a  = [ s1, s2, s3 ]
a.assoc("letters")  #=> [ "letters", "a", "b", "c" ]
a.assoc("foo")      #=> nil


h = { :a => 1, :b => 2}   # Start with a hash
a = h.to_a                # => [[:b,2], [:a,1]]: associative array
a.assoc(:a)               # => [:a,1]: subarray for key :a
a.assoc(:b).last          # => 2: value for key :b
a.rassoc(1)               # => [:a,1]: subarray for value 1
a.rassoc(2).first         # => :b: key for value 2
a.assoc(:c)               # => nil
a.transpose               # => [[:a, :b], [1, 2]]: swap rows and cols
---------------------------
# Conversion to strings
[1,2,3].join              # => "123": convert elements to string and join
[1,2,3].join(", ")        # => "1, 2, 3": optional delimiter
[1,2,3].to_s              # => "[1, 2, 3]" in Ruby 1.9
[1,2,3].to_s              # => "123" in Ruby 1.8
[1,2,3].inspect           # => "[1, 2, 3]": better for debugging in 1.8

# Binary conversion with pack. See also String.unpack.
[1,2,3,4].pack("CCCC")    # => "\001\002\003\004"
[1,2].pack('s2')          # => "\001\000\002\000"
[1234].pack("i")          # => "\322\004\000\000"

# Other methods
[0,1]*3                   # => [0,1,0,1,0,1]: * operator repeats
[1, [2, [3]]].flatten     # => [1,2,3]: recursively flatten; also flatten!
[1, [2, [3]]].flatten(1)  # => [1,2,[3]]: specify # of levels; Ruby 1.9
[1,2,3].reverse           # => [3,2,1]: also reverse!
a=[1,2,3].zip([:a,:b,:c]) # => [[1,:a],[2,:b],[3,:c]]: Enumerable method
a.transpose               # => [[1,2,3],[:a,:b,:c]]: swap rows/cols
---------------------------





------------------------------------------------------------------------------------
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# hash ¹þÏ£ ========================================================================

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
------------------------------------------------------------------------------------




---------------------------

Hash["a", 100, "b", 200]       #=> {"a"=>100, "b"=>200}
Hash["a" => 100, "b" => 200]   #=> {"a"=>100, "b"=>200}
{ "a" => 100, "b" => 200 }     #=> {"a"=>100, "b"=>200}

{ :one => 1, :two => 2 }  # Basic hash literal syntax
{ :one, 1, :two, 2 }      # Same, with deprecated Ruby 1.8 syntax
{ one: 1, two: 2 }        # Same, Ruby 1.9 syntax. Keys are symbols.
{}                        # A new, empty, Hash object
Hash.new                  # => {}: creates empty hash
Hash[:one, 1, :two, 2]    # => {one:1, two:2}

puts :a=>1, :b=>2   # Curly braces omitted in invocation
puts a:1, b:2       # Ruby 1.9 syntax works too


h = Hash.new("Go Fish")
h["a"] = 100
h["b"] = 200
h["a"]           #=> 100
h["c"]           #=> "Go Fish"
# The following alters the single default object
h["c"].upcase!   #=> "GO FISH"
h["d"]           #=> "GO FISH"
h.keys           #=> ["a", "b"]

# While this creates a new default object each time
h = Hash.new { |hash, key| hash[key] = "Go Fish: #{key}" }
h["c"]           #=> "Go Fish: c"
h["c"].upcase!   #=> "GO FISH: C"
h["d"]           #=> "Go Fish: d"
h.keys           #=> ["c", "d"]

---------------------------
h = { :one => 1, :two => 2 }
# Element Reference¡ªRetrieves the value object corresponding to the key object
h[:one]       # => 1: find value associated with a key
h[:three]     # => nil: the key does not exist in the hash
h.assoc :one  # => [:one, 1]: find key/value pair with the key using ==. Ruby 1.9.

# index(value) => key 
# Returns the key for a given value. If not found, returns nil.
h.index 1     # => :one: search for key associated with a value
h.index 4     # => nil: no mapping to this value exists
h.rassoc 2    # => [:two, 2]: key/value pair matching with value. Ruby 1.9.

h = {"colors"  => ["red", "blue", "green"],
     "letters" => ["a", "b", "c" ]}
h.assoc("letters")  #=> ["letters", ["a", "b", "c"]]  ,Ruby 1.9.
h.assoc("foo")      #=> nil       ,Ruby 1.9.

a = {1=> "one", 2 => "two", 3 => "three", "ii" => "two"}
a.rassoc("two")    #=> [2, "two"] ,Ruby 1.9.
a.rassoc("four")   #=> nil  ,Ruby 1.9.

---------------------------
h = { :a => 1, :b => 2 }
# Checking for the presence of keys in a hash: fast
h.key?(:a)       # true: :a is a key in h
h.has_key?(:b)   # true: has_key? is a synonym for key?
h.include?(:c)   # false: include? is another synonym
h.member?(:d)    # false: member? is yet another synonym

# Checking for the presence of values: slow
h.value?(1)      # true: 1 is a value in h
h.has_value?(3)  # false: has_value? is a synonym for value?
---------------------------
# Returns the key of an occurrence of a given value. If the value is not found, returns nil.
h = { "a" => 100, "b" => 200, "c" => 300, "d" => 300 }
h.key(200)   #=> "b"
h.key(300)   #=> "c"
h.key(999)   #=> nil

# Returns a value from the hash for the given key.
h = { :a => 1, :b => 2 }
h.fetch(:a)      # => 1: works like [] for existing keys
h.fetch(:c)      # Raises IndexError for nonexistent key
h.fetch(:c, 33)  # => 33: uses specified value if key is not found
h.fetch(:c) {|k| k.to_s } # => "c": calls block if key not found

h = { "a" => 100, "b" => 200 }
h.fetch("a")                            #=> 100
h.fetch("z", "go fish")                 #=> "go fish"
h.fetch("z") { |el| "go fish, #{el}"}   #=> "go fish, z"

# The following example shows that an exception is raised
# if the key is not found and a default value is not supplied.
h = { "a" => 100, "b" => 200 }
h.fetch("z")            #=> prog.rb:2:in `fetch': key not found (KeyError) from prog.rb:2

# Makes hsh compare its keys by their identity,
# i.e. it will consider exact same objects as same keys.
h1 = { "a" => 100, "b" => 200, :c => "c" }
h1["a"]        #=> 100
h1.compare_by_identity
h1.compare_by_identity? #=> true
h1["a"]        #=> nil  # though it is "a",but it is different objects,so retrun nil
h1[:c]         #=> "c"  # same symbols are all same.
---------------------------
h = { :a => 1, :b => 2, :c => 3 }
h.values_at(:c)         # => [3]: values returned in an array
h.values_at(:a, :b)     # => [1, 2]: pass any # of args
h.values_at(:d, :d, :a) # => [nil, nil, 1]

# keys():Returns a new array populated with the keys from this has
h = { "a" => 100, "b" => 200, "c" => 300, "d" => 400 }
h.keys   #=> ["a", "b", "c", "d"]

# values():Returns a new array populated with the values from hsh
h = { "a" => 100, "b" => 200, "c" => 300 }
h.values   #=> [100, 200, 300]
---------------------------
# Deletes every key-value pair from hsh for which block evaluates to false.
# choose the hash which fit the condition.
# 
h = { :a => 1, :b => 2, :c => 3 }
h.select {|k,v| v % 2 == 0 } # => [:b,2] Ruby 1.8
h.select {|k,v| v % 2 == 0 } # => {:b=>2} Ruby 1.9
h.keep_if {|k,v| v % 2 == 0 } # => {:b=>2} ,keep_if  is a synonym for select

h = { "a" => 100, "b" => 200, "c" => 300 }
h.select {|k,v| k > "a"}  #=> {"b" => 200, "c" => 300}
h.select {|k,v| v < 200}  #=> {"a" => 100}
---------------------------
h = {}        # Start with an empty hash
h[:a] = 1     # Map :a=>1.  h is now {:a=>1}
h.store(:b,2) # More verbose: h is now {:a=>1, :b=>2}

h = { "a" => 100, "b" => 200 }
h["a"] = 9
h["c"] = 4
h   #=> {"a"=>9, "b"=>200, "c"=>4}
---------------------------
# Replace all of the pairs in h with those from another hash
h.replace({1=>:a, 2=>;b}  # h is now equal to the argument hash

h = { "a" => 100, "b" => 200 }
h.replace({ "c" => 300, "d" => 400 })   #=> {"c"=>300, "d"=>400}
---------------------------
# Merge hashes h and j into new hash k.  
# If h and j share keys, use values from j
k = h.merge(j)
{:a=>1,:b=>2}.merge(:a=>3,:c=>3)  # => {:a=>3,:b=>2,:c=>3}
h.merge!(j)   # Modifies h in place.

# If there is a block, use it to decide which value to use
h.merge!(j) {|key,h,j| h }      # Use value from h
h.merge(j) {|key,h,j| (h+j)/2 } # Use average of two values

h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 254, "c" => 300 }
h1.merge!(h2)      #=> {"a"=>100, "b"=>254, "c"=>300}

h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 254, "c" => 300 }
h1.merge!(h2) { |key, v1, v2| v1 }  #=> {"a"=>100, "b"=>200, "c"=>300}


# update is a synonym for merge!
h = {a:1,b:2}     # Using Ruby 1.9 syntax and omitting braces
h.update(b:4,c:9) {|key,old,new| old }  # h is now {a:1, b:2, c:9}
h.update(b:4,c:9) # h is now {a:1, b:4, c:9}
---------------------------
h = {:a=>1, :b=>2}
h[:a] = nil      # h now holds {:a=> nil, :b=>2 }
h.include? :a    # => true
h.delete :b      # => 2: returns deleted value: h now holds {:a=>nil}
h.include? :b    # => false
h.delete :b      # => nil: key not found
# Invoke block if key not found
h.delete(:b) {|k| raise IndexError, k.to_s } # IndexError!
---------------------------
# É¾³ýhashÏàÓ¦ÔªËØ
h = {:a=>1, :b=>2, :c=>3, :d=>"four"}
h.reject! {|k,v| v.is_a? String }  # => {:a=>1, :b=>2, :c=>3 } ,Equivalent to Hash#delete_if, but returns nil if no changes were made.
h.delete_if {|k,v| k.to_s < 'b' }  # => {:b=>2, :c=>3 }

h.reject! {|k,v| k.to_s < 'b' }    # => nil: no change
h.delete_if {|k,v| k.to_s < 'b' }  # => {:b=>2, :c=>3 }: unchanged hash

h.reject {|k,v| true }             # => {}: h is unchanged
---------------------------
h.clear    # h is now {}
h.reject {|k,v| true } # => {}: but h is unchanged
---------------------------
h = { :a=>1, :b=>2, :c=>3 }
# Size of hash: number of key/value pairs
h.length     # => 3
h.size       # => 3: size is a synonym for length
h.empty?     # => false
{}.empty?    # => true

h.keys       # => [:b, :c, :a]: array of keys
h.values     # => [2,3,1]: array of values

---------------------------
h = { :a=>1, :b=>2, :c=>3 }
h.to_a       # => [[:b,2],[:c,3],[:a,1]]: array of pairs

---------------------------
# Returns a new array that is a one-dimensional flattening of this hash.
# That is, for every key or value that is an array, extract its elements into the new array
# Unlike Array#flatten, this method does not flatten recursively by default. 
h = { :a=>1, :b=>2, :c=>3 }
h.flatten    # => [:b, 2, :c, 3, :a, 1]: flattened array. Ruby 1.9

h =  {1=> "one", 2 => [2,"two"], 3 => "three"}
h.flatten    # => [1, "one", 2, [2, "two"], 3, "three"]
# flatten(level) => an_array
# The optional level argument determines the level of recursion to flatten.
h.flatten(2) # => [1, "one", 2, 2, "two", 3, "three"]

---------------------------
h.sort       # => [[:a,1],[:b,2],[:c,3]]: sorted array of pairs
h.sort {|a,b| a[1]<=>b[1] } # Sort pairs by value instead of key
---------------------------
# µü´úÆ÷
h = { :a=>1, :b=>2, :c=>3 }

# The each() iterator iterates [key,value] pairs
h.each {|pair| print pair }    # Prints "[:a, 1][:b, 2][:c, 3]"

# It also works with two block arguments
h.each do |key, value|                
  print "#{key}:#{value} "     # Prints "a:1 b:2 c:3" 
end

# Iterate over keys or values or both
h.each_key {|k| print k }      # Prints "abc"
h.each_value {|v| print v }    # Prints "123"
h.each_pair {|k,v| print k,v } # Prints "a1b2c3". Like each
---------------------------
h = { :a=> 1, :b=>2 }
print h.shift[1] while not h.empty?   # Prints "12"
---------------------------
empty = {}
empty["one"]   # nil
---------------------------
empty = Hash.new(-1)   # Specify a default value when creating hash
empty["one"]           # => -1
empty.default = -2     # Change the default value to something else
empty["two"]           # => -2
empty.default          # => -2: return the default value
---------------------------
# If the key is not defined, return the successor of the key.
plus1 = Hash.new {|hash, key| key.succ }
plus1[1]      # 2
plus1["one"]  # "onf": see String.succ
plus1.default_proc  # Returns the Proc that computes defaults
plus1.default(10)   # => 11: default returned for key 10
---------------------------
# This lazily initialized hash maps integers to their factorials
fact = Hash.new {|h,k| h[k] = if k > 1: k*h[k-1] else 1 end }
fact      # {}: it starts off empty
fact[4]   # 24: 4! is 24
fact      # {1=>1, 2=>2, 3=>6, 4=>24}: the hash now has entries
---------------------------
fact.fetch(5)   # IndexError: key not found
---------------------------
key = {:a=>1}      # This hash will be a key in another hash!
h = { key => 2 }   # This hash has a mutable key
h[key]             # => 2: get value associated with key
key.clear          # Mutate the key
h[key]             # => nil: no value found for mutated key
h.rehash           # Fix up the hash after mutation
h[key]             # => 2: now the value is found again
---------------------------
h = {:a=>1, :b=>2}
h.invert        # => {1=>:a, 2=>:b}: swap keys and values
---------------------------
{:a=>1, :b=>2}.to_s    # => "a1b2" in Ruby 1.8; "{:a=>1, :b=>2}" in 1.9
{:a=>1, :b=>2}.inspect # => "{:a=>1, :b=>2}" for both versions
---------------------------




---------------------------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Set ¼¯ºÏ ==========================================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------





require 'set'
---------------------------
(1..5).to_set              # => #<Set: {5, 1, 2, 3, 4}>
[1,2,3].to_set             # => #<Set: {1, 2, 3}>
---------------------------
Set.new(1..5)              # => #<Set: {5, 1, 2, 3, 4}>
Set.new([1,2,3])           # => #<Set: {1, 2, 3}>
Set.new([1,2,3]) {|x| x+1} # => #<Set: {2, 3, 4}>
---------------------------
Set["cow", "pig", "hen"]   # => #<Set: {"cow", "pig", "hen"}>
---------------------------
s = Set.new(1..3)   # => #<Set: {1, 2, 3}>  
s.include? 1        # => true
s.member? 0         # => false: member? is a synonym
---------------------------
s = Set[2, 3, 5]
t = Set[2, 3, 5, 7]
s.subset? t            # => true
t.subset? s            # => false
s.proper_subset? t     # => true
t.superset? s          # => true
t.proper_superset? s   # => true
s.subset? s            # => true
s.proper_subset? s     # => false
---------------------------
s = Set[2, 3, 5]
s.length               # => 3
s.size                 # => 3: a synonym for length
s.empty?               # => false
Set.new.empty?         # => true
---------------------------
# Here are two simple sets
primes = Set[2, 3, 5, 7]
odds = Set[1, 3, 5, 7, 9]

# The intersection is the set of values that appear in both
primes & odds             # => #<Set: {5, 7, 3}>
primes.intersection(odds) # this is an explicitly named alias

# The union is the set of values that appear in either
primes | odds             # => #<Set: {5, 1, 7, 2, 3, 9}>
primes.union(odds)        # an explicitly named alias

# a-b: is the elements of a except for those also in b
primes-odds               # => #<Set: {2}>
odds-primes               # => #<Set: {1, 9}>
primes.difference(odds)   # A named method alias

# a^b is the set of values that appear in one set but not both: (a|b)-(a&b)
primes ^ odds             # => #<Set: {1, 2, 9}>
---------------------------
s = Set[]              # start with an empty set
s << 1                 # => #<Set: {1}>
s.add 2                # => #<Set: {1, 2}>: add is a synonym for <<
s << 3 << 4 << 5       # => #<Set: {5, 1, 2, 3, 4}>: can be chained
s.add 3                # => #<Set: {5, 1, 2, 3, 4}>: value unchanged
s.add? 6               # => #<Set: {5, 6, 1, 2, 3, 4}>
s.add? 3               # => nil: the set was not changed 
---------------------------
s = (1..3).to_set   # => #<Set: {1, 2, 3}>
s.merge(2..5)       # => #<Set: {5, 1, 2, 3, 4}>
---------------------------
s = (1..3).to_set   # => #<Set: {1, 2, 3}>
s.delete 1          # => #<Set: {2, 3}>
s.delete 1          # => #<Set: {2, 3}>: unchanged
s.delete? 1         # => nil: returns nil when no change
s.delete? 2         # => #<Set: {3}>: otherwise returns set
---------------------------
s = (1..3).to_set   # => #<Set: {1, 2, 3}>
s.subtract(2..10)   # => #<Set: {1}>
---------------------------
primes = Set[2, 3, 5, 7]       # set of prime numbers
primes.delete_if {|x| x%2==1}  # => #<Set: {2}>: remove odds
primes.delete_if {|x| x%2==1}  # => #<Set: {2}>: unchanged
primes.reject! {|x| x%2==1}    # => nil: unchanged

# Do an in-place intersection like this:
s = (1..5).to_set
t = (4..8).to_set
s.reject! {|x| not t.include? x}  # => #<Set: {5, 4}>
---------------------------
s = Set.new(1..3) # Initial set
s.replace(3..4)   # Replace all elements.  Argument is any enumerable
s.clear           # => #<Set: {}>
s.empty?          # => true
---------------------------
s = Set[1, 2, 3, 4, 5] # => #<Set: {5, 1, 2, 3, 4}>
s.each {|x| print x }  # prints "51234": arbitrary order before Ruby 1.9
s.map! {|x| x*x }      # => #<Set: {16, 1, 25, 9, 4}>
s.collect! {|x| x/2 }  # => #<Set: {0, 12, 2, 8, 4}>
---------------------------
s = (1..3).to_set
s.to_a          # => [1, 2, 3]
s.to_s          # => "#<Set:0xb7e8f938>": not useful
s.inspect       # => "#<Set: {1, 2, 3}>": useful       
s == Set[3,2,1] # => true: uses eql? to compare set elements
---------------------------
# Classify set elements as even or odd
s = (0..3).to_set     # => #<Set: {0, 1, 2, 3}>
s.classify {|x| x%2}  # => {0=>#<Set: {0, 2}>, 1=>#<Set: {1, 3}>}
---------------------------
s.divide {|x| x%2}  # => #<Set: {#<Set: {0, 2}>, #<Set: {1, 3}>}>
---------------------------
s = %w[ant ape cow hen hog].to_set # A set of words
s.divide {|x,y| x[0] == y[0]}      # Divide into subsets by first letter
# => #<Set:{#<Set:{"hog", "hen"}>, #<Set:{"cow"}>, #<Set:{"ape", "ant"}>}>
---------------------------
s = %w[ant ape cow hen hog].to_set # A set of words
t = s.divide {|x,y| x[0] == y[0]}  # Divide it into subsets
t.flatten!                         # Flatten the subsets
t == s                             # => true
---------------------------






---------------------------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap9.6 ÎÄ¼þÓëÄ¿Â¼ Files and Directories==========================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------







---------------------------
full = '/home/matz/bin/ruby.exe'
file=File.basename(full)     # => 'ruby.exe': just the local filename
File.basename(full, '.exe')  # => 'ruby': with extension stripped
dir=File.dirname(full)       # => '/home/matz/bin': no / at end
File.dirname(file)           # => '.': current directory
File.split(full)             # => ['/home/matz/bin', 'ruby.exe']
File.extname(full)           # => '.exe'
File.extname(file)           # => '.exe'
File.extname(dir)            # => ''
File.join('home','matz')     # => 'home/matz': relative
File.join('','home','matz')  # => '/home/matz': absolute
---------------------------
Dir.chdir("/usr/bin")      # Current working directory is "/usr/bin"
File.expand_path("ruby")       # => "/usr/bin/ruby"
File.expand_path("~/ruby")     # => "/home/david/ruby"
File.expand_path("~matz/ruby") # => "/home/matz/ruby"
File.expand_path("ruby", "/usr/local/bin") # => "/usr/local/bin/ruby"
File.expand_path("ruby", "../local/bin")   # => "/usr/local/bin/ruby"
File.expand_path("ruby", "~/bin")          # => "/home/david/bin/ruby"
---------------------------
File.identical?("ruby", "ruby")          # => true if the file exists
File.identical?("ruby", "/usr/bin/ruby") # => true if CWD is /usr/bin
File.identical?("ruby", "../bin/ruby")   # => true if CWD is /usr/bin
File.identical?("ruby", "ruby1.9")       # => true if there is a link
---------------------------
File.fnmatch("*.rb", "hello.rb")     # => true
File.fnmatch("*.[ch]", "ruby.c")     # => true
File.fnmatch("*.[ch]", "ruby.h")     # => true
File.fnmatch("?.txt", "ab.txt")      # => false
flags = File::FNM_PATHNAME | File::FNM_DOTMATCH
File.fnmatch("lib/*.rb", "lib/a.rb", flags)      # => true
File.fnmatch("lib/*.rb", "lib/a/b.rb", flags)    # => false
File.fnmatch("lib/**/*.rb", "lib/a.rb", flags)   # => true
File.fnmatch("lib/**/*.rb", "lib/a/b.rb", flags) # => true
---------------------------
# Get the names of all files in the config/ directory 
filenames = Dir.entries("config")        # Get names as an array
Dir.foreach("config") {|filename| ... }  # Iterate names
---------------------------
Dir['*.data']       # Files with the "data" extension
Dir['ruby.*']       # Any filename beginning with "ruby."
Dir['?']            # Any single-character filename
Dir['*.[ch]']       # Any file that ends with .c or .h
Dir['*.{java,rb}']  # Any file that ends with .java or .rb
Dir['*/*.rb']       # Any Ruby program in any direct sub-directory
Dir['**/*.rb']      # Any Ruby program in any descendant directory
---------------------------
Dir.glob('*.rb') {|f| ... }      # Iterate all Ruby files
Dir.glob('*')                    # Does not include names beginning with '.'
Dir.glob('*',File::FNM_DOTMATCH) # Include . files, just like Dir.entries
---------------------------
puts Dir.getwd          # Print current working directory
Dir.chdir("..")         # Change CWD to the parent directory
Dir.chdir("../sibling") # Change again to a sibling directory
Dir.chdir("/home")      # Change to an absolute directory
Dir.chdir               # Change to user's home directory
home = Dir.pwd          # pwd is an alias for getwd
---------------------------
f = "/usr/bin/ruby"      # A filename for the examples below

# File existence and types.
File.exist?(f)           # Does the named file exist? Also: File.exists?
File.file?(f)            # Is it an existing file?
File.directory?(f)       # Or is it an existing directory?
File.symlink?(f)         # Either way, is it a symbolic link?

# File size methods. Use File.truncate to set file size.
File.size(f)             # File size in bytes.
File.size?(f)            # Size in bytes or nil if empty file.
File.zero?(f)            # True if file is empty.

# File permissions. Use File.chmod to set permissions (system dependent).
File.readable?(f)        # Can we read the file?
File.writable?(f)        # Can we write the file? No "e" in "writable"
File.executable?(f)      # Can we execute the file?
File.world_readable?(f)  # Can everybody read it? Ruby 1.9.
File.world_writable?(f)  # Can everybody write it? Ruby 1.9.

# File times/dates. Use File.utime to set the times.
File.mtime(f)            # => Last modification time as a Time object
File.atime(f)            # => Last access time as a Time object
---------------------------
File.ftype("/usr/bin/ruby")    # => "link"
File.ftype("/usr/bin/ruby1.9") # => "file"
File.ftype("/usr/lib/ruby")    # => "directory"
File.ftype("/usr/bin/ruby3.0") # SystemCallError: No such file or directory
---------------------------
s = File.stat("/usr/bin/ruby")
s.file?             # => true
s.directory?        # => false
s.ftype             # => "file"
s.readable?         # => true
s.writable?         # => false
s.executable?       # => true
s.size              # => 5492
s.atime             # => Mon Jul 23 13:20:37 -0700 2007
---------------------------
# Testing single files
test ?e, "/usr/bin/ruby"   # File.exist?("/usr/bin/ruby")
test ?f, "/usr/bin/ruby"   # File.file?("/usr/bin/ruby")
test ?d, "/usr/bin/ruby"   # File.directory?("/usr/bin/ruby")
test ?r, "/usr/bin/ruby"   # File.readable?("/usr/bin/ruby")
test ?w, "/usr/bin/ruby"   # File.writeable?("/usr/bin/ruby")
test ?M, "/usr/bin/ruby"   # File.mtime("/usr/bin/ruby")
test ?s, "/usr/bin/ruby"   # File.size?("/usr/bin/ruby")

# Comparing two files f and g
test ?-, f, g              # File.identical(f,g)
test ?<, f, g              # File(f).mtime < File(g).mtime
test ?>, f, g              # File(f).mtime > File(g).mtime
test ?=, f, g              # File(f).mtime == File(g).mtime
---------------------------
# Create (or overwrite) a file named "test"
File.open("test", "w") {}
# Create (but do not clobber) a file named "test"
File.open("test", "a") {}
---------------------------
File.rename("test", "test.old")     # Current name, then new name
---------------------------
File.symlink("test.old", "oldtest") # Link target, link name
---------------------------
File.link("test.old", "test2")   # Link target, link name
---------------------------
File.delete("test2")   # May also be called with multiple args
File.unlink("oldtest") # to delete multiple named files
---------------------------
f = "log.messages"          # Filename
atime = mtime = Time.now    # New access and modify times
File.truncate(f, 0)         # Erase all existing content
File.utime(atime, mtime, f) # Change times
File.chmod(0600, f)         # Unix permissions -rw-------; note octal arg
---------------------------
Dir.mkdir("temp")                 # Create a directory
File.open("temp/f", "w") {}       # Create a file in it
File.open("temp/g", "w") {}       # Create another one
File.delete(*Dir["temp/*"])       # Delete all files in the directory
Dir.rmdir("temp")                 # Delete the directory
---------------------------






---------------------------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap9.7 ÊäÈë/Êä³ö Input/Output====================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------






---------------------------
f = File.open("data.txt", "r")   # Open file data.txt for reading
out = File.open("out.txt", "w")  # Open file out.txt for writing
---------------------------
File.open("log.txt", "a") do |log|      # Open for appending
  log.puts("INFO: Logging a message")   # Output to the file
end                                     # Automatically closed
---------------------------
# How long has the server been up?
uptime = open("|uptime") {|f| f.gets }
---------------------------
require "open-uri"                         # Required library
f = open("http://www.davidflanagan.com/")  # Webpage as a file
webpage = f.read                           # Read it as one big string
f.close                                    # Don't forget to close!
---------------------------
require "stringio"
input = StringIO.open("now is the time")  # Read from this string
buffer = ""
output = StringIO.open(buffer, "w")       # Write into buffer
---------------------------
f.set_encoding("iso-8859-1", "utf-8") # Latin-1, transcoded to UTF-8
f.set_encoding("iso-8859-1:utf-8")    # Same as above
f.set_encoding(Encoding::UTF-8)       # UTF-8 text
---------------------------
in = File.open("data.txt", "r:utf-8");           # Read UTF-8 text
out = File.open("log", "a:utf-8");               # Write UTF-8 text
in = File.open("data.txt", "r:iso8859-1:utf-8"); # Latin-1 transcoded to UTF-8 ---------------------------
File.open("data", "r:binary")  # Open a file for reading binary data</programlisting>

      <para>On Windows, you should open binary files with mode <literal role="keep-together">"rb:binary"</literal> or call <literal role="keep-together">binmode</literal> <indexterm>
          <primary>binmode method (IO)</primary>
        </indexterm>on the stream. This disables the automatic newline
      conversion performed by Windows, and is only necessary on that
      platform.</para>

      <para>Not every stream-reading method honors the encoding of a stream.
      Some lower-level reading methods take an argument that specifies the
      number of bytes to read. By their nature, these methods return unencoded
      strings of bytes rather than strings of text. The methods that do not
      specify a length to read do honor the encoding.</para>
    </sect2>

    <sect2>
      <title>Reading from a Stream</title>

      <para>The <literal>IO</literal> class<indexterm class="startofrange" id="ch09-streams">
          <primary>streams</primary>

          <secondary>reading from</secondary>
        </indexterm> defines a number of methods for reading from streams.
      They work only if the stream is readable, of course. You can read
      <indexterm>
          <primary>STDIN stream</primary>
        </indexterm><indexterm>
          <primary>ARGF stream</primary>
        </indexterm><indexterm>
          <primary>DATA stream</primary>
        </indexterm><indexterm>
          <primary>STDOUT stream</primary>
        </indexterm><indexterm>
          <primary>STDERR stream</primary>
        </indexterm>from <literal>STDIN</literal>, <literal>ARGF</literal>,
      and <literal>DATA</literal>, but not from <literal>STDOUT</literal> or
      <literal>STDERR</literal>. Files and <literal>StringIO</literal> objects
      are opened for reading by default, unless you explicitly open them for
      writing only.</para>

      <sect3 id="readinglines">
        <title>Reading lines</title>

        <para><literal>IO</literal> defines a number of ways to read lines
        from a stream:</para>

        <programlisting>lines = ARGF.readlines         # Read all input, return an array of lines
line = DATA.readline           # Read one line from stream
print l while l = DATA.gets    # Read until gets returns nil, at EOF
DATA.each {|line| print line } # Iterate lines from stream until EOF
DATA.each_line                 # An alias for each
DATA.lines                     # An enumerator for each_line: Ruby 1.9
---------------------------
print while DATA.gets
---------------------------
DATA.lineno = 0     # Start from line 0, even though data is at end of file
DATA.readline       # Read one line of data
DATA.lineno         # => 1
$.                  # => 1: magic global variable, implicitly set
---------------------------
data = IO.read("data")         # Read and return the entire file
data = IO.read("data", 4, 2)   # Read 4 bytes starting at byte 2
data = IO.read("data", nil, 6) # Read from byte 6 to end-of-file

# Read lines into an array
words = IO.readlines("/usr/share/dict/words")

# Read lines one at a time and initialize a hash
words = {}
IO.foreach("/usr/share/dict/words") {|w| words[w] = true}
---------------------------
# An alternative to text = File.read("data.txt")
f = File.open("data.txt")  # Open a file
text = f.read              # Read its contents as text
f.close                    # Close the file
---------------------------
f = File.open("data", "r:binary") # Open data file for binary reads 
c = f.getc                        # Read the first byte as an integer
f.ungetc(c)                       # Push that byte back
c = f.readchar                    # Read it back again
---------------------------
f.each_byte {|b| ... }      # Iterate through remaining bytes
f.bytes                     # An enumerator for each_byte: Ruby 1.9
---------------------------
f = File.open("data.bin", "rb:binary")  # No newline conversion, no encoding
magic = f.readbytes(4)       # First four bytes identify filetype
exit unless magic == "INTS"  # Magic number spells "INTS" (ASCII)
bytes = f.read               # Read the rest of the file
                             # Encoding is binary, so this is a byte string
data = bytes.unpack("i*")    # Convert bytes to an array of integers
---------------------------
o = STDOUT
# Single-character output
o.putc(65)         # Write single byte 65 (capital A)
o.putc("B")        # Write single byte 66 (capital B)
o.putc("CD")       # Write just the first byte of the string
---------------------------
o = STDOUT
# String output
o << x             # Output x.to_s 
o << x << y        # May be chained: output x.to_s + y.to_s
o.print            # Output $_ + $\
o.print s          # Output s.to_s + $\
o.print s,t        # Output s.to_s + t.to_s + $\
o.printf fmt,*args # Outputs fmt%[args]
o.puts             # Output newline
o.puts x           # Output x.to_s.chomp plus newline
o.puts x,y         # Output x.to_s.chomp, newline, y.to_s.chomp, newline
o.puts [x,y]       # Same as above
o.write s          # Output s.to_s, returns s.to_s.length
o.syswrite s       # Low-level version of write
---------------------------
f = File.open("test.txt")
f.pos        # => 0: return the current position in bytes
f.pos = 10   # skip to position 10
f.tell       # => 10: a synonym for pos
f.rewind     # go back to position 0, reset lineno to 0, also
f.seek(10, IO::SEEK_SET)  # Skip to absolute position 10
f.seek(10, IO::SEEK_CUR)  # Skip 10 bytes from current position
f.seek(-10, IO::SEEK_END) # Skip to 10 bytes from end
f.seek(0, IO::SEEK_END)   # Skip to very end of file
f.eof?                    # => true: we're at the end
---------------------------
pos = f.sysseek(0, IO::SEEK_CUR)  # Get current position
f.sysseek(0, IO::SEEK_SET)        # Rewind stream
f.sysseek(pos, IO::SEEK_SET)      # Return to original position
---------------------------
File.open("test.txt") do |f|
  # Use stream f here
  # Value of this block becomes return value of the open method
end # f is automatically closed for us here
---------------------------
begin
  f = File.open("test.txt")
  # use stream f here
ensure
  f.close if f
end
---------------------------
out.print 'wait>' # Display a prompt
out.flush         # Manually flush output buffer to OS
sleep(1)          # Prompt appears before we go to sleep

out.sync = true   # Automatically flush buffer after every write
out.sync = false  # Don't automatically flush
out.sync          # Return current sync mode
out.fsync         # Flush output buffer and ask OS to flush its buffers
                  # Returns nil if unsupported on current platform
---------------------------
f.eof?       # true if stream is at EOF
f.closed?    # true if stream has been closed
f.tty?       # true if stream is interactive
---------------------------






---------------------------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap9.8 ÍøÂç Networking===========================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------







---------------------------
require 'socket'
---------------------------
require 'socket'                # Sockets are in standard library

host, port = ARGV               # Host and port from command line

s = TCPSocket.open(host, port)  # Open a socket to host and port
while line = s.gets             # Read lines from the socket
  puts line.chop                # And print with platform line terminator
end
s.close                         # Close the socket when done
---------------------------
require 'socket'                  
host, port = ARGV                 
TCPSocket.open(host, port) do |s| # Use block form of open
  while line = s.gets             
    puts line.chop                
  end
end                               # Socket automatically closed
---------------------------
require 'socket'               # Get sockets from stdlib

server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                         # Infinite loop: servers run forever
  client = server.accept       # Wait for a client to connect
  client.puts(Time.now.ctime)  # Send the time to the client
  client.close                 # Disconnect from the client
}
---------------------------
ruby client.rb localhost 2000
---------------------------
require 'socket'                     # Standard library

host, port, request = ARGV           # Get args from command line

ds = UDPSocket.new                   # Create datagram socket
ds.connect(host, port)               # Connect to the port on the host
ds.send(request, 0)                  # Send the request text
response,address = ds.recvfrom(1024) # Wait for a response (1kb max)
puts response                        # Print the response
---------------------------
require 'socket'                     # Standard library

port = ARGV[0]                       # The port to listen on

ds = UDPSocket.new                   # Create new socket
ds.bind(nil, port)                   # Make it listen on the port
loop do                              # Loop forever
  request,address=ds.recvfrom(1024)  # Wait to receive something
  response = request.upcase          # Convert request text to uppercase
  clientaddr = address[3]            # What ip address sent the request?
  clientname = address[2]            # What is the host name?
  clientport = address[1]            # What port was it sent from
  ds.send(response, 0,               # Send the response back...
          clientaddr, clientport)    # ...where it came from
  # Log the client connection
  puts "Connection from: #{clientname} #{clientaddr} #{clientport}"
end
---------------------------
require 'socket'     # Sockets from standard library

host, port = ARGV    # Network host and port on command line

begin                # Begin for exception handling
  # Give the user some feedback while connecting.
  STDOUT.print "Connecting..."      # Say what we're doing
  STDOUT.flush                      # Make it visible right away
  s = TCPSocket.open(host, port)    # Connect
  STDOUT.puts "done"                # And say we did it

  # Now display information about the connection.
  local, peer = s.addr, s.peeraddr
  STDOUT.print "Connected to #{peer[2]}:#{peer[1]}"
  STDOUT.puts " using local port #{local[1]}"

  # Wait just a bit, to see if the server sends any initial message.
  begin
    sleep(0.5)                      # Wait half a second
    msg = s.read_nonblock(4096)     # Read whatever is ready
    STDOUT.puts msg.chop            # And display it
  rescue SystemCallError
    # If nothing was ready to read, just ignore the exception.
  end

  # Now begin a loop of client/server interaction.
  loop do
    STDOUT.print '> '   # Display prompt for local input
    STDOUT.flush        # Make sure the prompt is visible
    local = STDIN.gets  # Read line from the console
    break if !local     # Quit if no input from console

    s.puts(local)       # Send the line to the server
    s.flush             # Force it out

    # Read the server's response and print out.
    # The server may send more than one line, so use readpartial
    # to read whatever it sends (as long as it all arrives in one chunk).
    response = s.readpartial(4096) # Read server's response
    puts(response.chop)            # Display response to user
  end
rescue           # If anything goes wrong
  puts $!        # Display the exception to the user
ensure           # And no matter what happens
  s.close if s   # Don't forget to close the socket
end
---------------------------
# This server reads a line of input from a client, reverses
# the line and sends it back. If the client sends the string "quit"
# it disconnects. It uses Kernel.select to handle multiple sessions.

require 'socket'           

server = TCPServer.open(2000) # Listen on port 2000
sockets = [server]            # An array of sockets we'll monitor
log = STDOUT                  # Send log messages to standard out
while true                    # Servers loop forever
  ready = select(sockets)     # Wait for a socket to be ready
  readable = ready[0]         # These sockets are readable

  readable.each do |socket|         # Loop through readable sockets
    if socket == server             # If the server socket is ready
      client = server.accept        # Accept a new client
      sockets << client             # Add it to the set of sockets
      # Tell the client what and where it has connected.
      client.puts "Reversal service v0.01 running on #{Socket.gethostname}"
      # And log the fact that the client connected
      log.puts "Accepted connection from #{client.peeraddr[2]}"
    else                            # Otherwise, a client is ready
      input = socket.gets           # Read input from the client

      # If no input, the client has disconnected
      if !input   
        log.puts "Client on #{socket.peeraddr[2]} disconnected."
        sockets.delete(socket)      # Stop monitoring this socket
        socket.close                # Close it
        next                        # And go on to the next
      end

      input.chop!                   # Trim client's input
      if (input == "quit")          # If the client asks to quit
        socket.puts("Bye!");        # Say goodbye
        log.puts "Closing connection to #{socket.peeraddr[2]}"
        sockets.delete(socket)      # Stop monitoring the socket
        socket.close                # Terminate the session
      else                          # Otherwise, client is not quitting
        socket.puts(input.reverse)  # So reverse input and send it back
      end
    end
  end
end
---------------------------
require 'socket'           # We need sockets
 
host = 'www.example.com'   # The web server
port = 80                  # Default HTTP port
path = "/index.html"       # The file we want 

# This is the HTTP request we send to fetch a file
request = "GET #{path} HTTP/1.0\r\n\r\n"

socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)               # Send request
response = socket.read              # Read complete response
# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2) 
print body                          # And display it
---------------------------
require 'net/http'         # The library we need
host = 'www.example.com'   # The web server
path = '/index.html'       # The file we want 

http = Net::HTTP.new(host)      # Create a connection
headers, body = http.get(path)  # Request the file
if headers.code == "200"        # Check the status code   
                                # NOTE: code is not a number!
  print body                    # Print body if we got it
else                            # Otherwise
  puts "#{headers.code} #{headers.message}" # Display error message
end
---------------------------
require 'open-uri'
open("http://www.example.com/index.html") {|f|
  puts f.read
}
---------------------------





---------------------------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap9.9 Ïß³ÌºÍ²¢·¢ Threads and Concurrency=========================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------------------------------------------------------------------






---------------------------
# Thread #1 is running here
Thread.new {
  # Thread #2 runs this code
}
# Thread #1 runs this code
---------------------------
# Wait for all threads (other than the current thread and
# main thread) to stop running.
# Assumes that no new threads are started while waiting.
def join_all
  main = Thread.main        # The main thread
  current = Thread.current  # The current thread
  all = Thread.list         # All threads still running
  # Now call join on each thread
  all.each {|t| t.join unless t == current or t == main }
end
---------------------------
Thread.abort_on_exception = true
---------------------------
t = Thread.new { ... }
t.abort_on_exception = true
---------------------------
x = 0

t1 = Thread.new do
  # This thread can query and set the variable x
end

t2 = Thread.new do
  # This thread and also query and set x
  # And it can query and set t1 and t2 as well.   
end
---------------------------
n = 1
while n <= 3
  Thread.new { puts n }
  n += 1
end 
---------------------------
n = 1
while n <= 3
  # Get a private copy of the current value of n in x
  Thread.new(n) {|x| puts x }
  n += 1
end 
---------------------------
1.upto(3) {|n| Thread.new { puts n }}
---------------------------
Thread.current[:progress] = bytes_received
---------------------------
total = 0
download_threads.each {|t| total += t[:progress] }
---------------------------
total = 0
download_threads.each {|t| total += t[:progress] if t.key?(:progress)}
---------------------------
group = ThreadGroup.new
3.times {|n| group.add(Thread.new { do_task(n) }}
---------------------------
# Read files concurrently. Use with the "open-uri" module to fetch URLs.
# Pass an array of filenames. Returns a hash mapping filenames to content.
def conread(filenames)
  h = {}                            # Empty hash of results

  # Create one thread for each file
  filenames.each do |filename|      # For each named file
    h[filename] = Thread.new do     # Create a thread, map to filename
      open(filename) {|f| f.read }  # Open and read the file
    end                             # Thread value is file contents
  end

  # Iterate through the hash, waiting for each thread to complete.
  # Replace the thread in the hash with its value (the file contents)
  h.each_pair do |filename, thread| 
    begin
      h[filename] = thread.value    # Map filename to file contents
    rescue
      h[filename] = $!              # Or to the exception raised
    end
  end
end
---------------------------
require 'socket'

# This method expects a socket connected to a client.
# It reads lines from the client, reverses them and sends them back.
# Multiple threads may run this method at the same time.
def handle_client(c)
  while true
    input = c.gets.chop     # Read a line of input from the client
    break if !input         # Exit if no more input
    break if input=="quit"  # or if the client asks to.
    c.puts(input.reverse)   # Otherwise, respond to client.
    c.flush                 # Force our output out
  end
  c.close                   # Close the client socket
end


server = TCPServer.open(2000) # Listen on port 2000

while true                    # Servers loop forever
  client = server.accept      # Wait for a client to connect
  Thread.start(client) do |c| # Start a new thread 
    handle_client(c)          # And handle the client on that thread
  end
end
---------------------------
module Enumerable           # Open the Enumerable module
  def conmap(&block)        # Define a new method that expects a block
    threads = []            # Start with an empty array of threads
    self.each do |item|     # For each enumerable item
      # Invoke the block in a new thread, and remember the thread
      threads << Thread.new { block.call(item) }
    end
    # Now map the array of threads to their values 
    threads.map {|t| t.value } # And return the array of values
  end
end
---------------------------
module Enumerable
  def concurrently
    map {|item| Thread.new { yield item }}.each {|t| t.join }
  end
end
---------------------------
h.each_pair.concurrently {|*pair| process(pair)}
---------------------------
require 'thread'  # For Mutex class in Ruby 1.8

# A BankAccount has a name, a checking amount, and a savings amount.
class BankAccount
  def init(name, checking, savings)
    @name,@checking,@savings = name,checking,savings 
    @lock = Mutex.new         # For thread safety
  end

  # Lock account and transfer money from savings to checking
  def transfer_from_savings(x)
    @lock.synchronize {
      @savings -= x
      @checking += x
    }
  end

  # Lock account and report current balances
  def report
    @lock.synchronize {
      "#@name\nChecking: #@checking\nSavings: #@savings"
    }
  end
end
---------------------------
# Classic deadlock: two threads and two locks
require 'thread'

m,n = Mutex.new, Mutex.new

t = Thread.new {
  m.lock
  puts "Thread t locked Mutex m"
  sleep 1
  puts "Thread t waiting to lock Mutex n"
  n.lock
}

s = Thread.new {
  n.lock
  puts "Thread s locked Mutex n"
  sleep 1
  puts "Thread s waiting to lock Mutex m"
  m.lock
}

t.join
s.join
---------------------------
a = [-2,-1,0,1,2]
mapper = lambda {|x| x*x }             # Compute squares
injector = lambda {|total,x| total+x } # Compute sum
a.conject(0, mapper, injector)         # => 10
---------------------------
module Enumerable
  # Concurrent inject: expects an initial value and two Procs
  def conject(initial, mapper, injector)
    # Use a Queue to pass values from mapping threads to injector thread
    q = Queue.new   
    count = 0                 # How many items?
    each do |item|            # For each item
      Thread.new do           # Create a new thread
        q.enq(mapper[item])   # Map and enqueue mapped value
      end
      count += 1              # Count items
    end

    t = Thread.new do         # Create injector thread
      x = initial             # Start with specified initial value
      while(count > 0)        # Loop once for each item
        x = injector[x,q.deq] # Dequeue value and inject
        count -= 1            # Count down
      end
      x                       # Thread value is injected value
    end

    t.value   # Wait for injector thread and return its value
  end
end
---------------------------
require 'thread'

class Exchanger
  def initialize
    # These variables will hold the two values to be exchanged.
    @first_value = @second_value = nil
    # This Mutex protects access to the exchange method.
    @lock = Mutex.new
    # This Mutex allows us to determine whether we're the first or
    # second thread to call exchange.
    @first = Mutex.new
    # This ConditionVariable allows the first thread to wait for
    # the arrival of the second thread.
    @second = ConditionVariable.new
  end

  # Exchange this value for the value passed by the other thread.
  def exchange(value)
    @lock.synchronize do      # Only one thread can call this method at a time
      if @first.try_lock      # We are the first thread
        @first_value = value  # Store the first thread's argument
        # Now wait until the second thread arrives.
        # This temporarily unlocks the Mutex while we wait, so 
        # that the second thread can call this method, too
        @second.wait(@lock)   # Wait for second thread 
        @first.unlock         # Get ready for the next exchange
        @second_value         # Return the second thread's value
      else                    # Otherwise, we're the second thread
        @second_value = value # Store the second value
        @second.signal        # Tell the first thread we're here
        @first_value          # Return the first thread's value
      end
    end
  end
end
---------------------------
