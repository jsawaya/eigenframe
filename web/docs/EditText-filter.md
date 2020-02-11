# filter attribute 
## schema pattern


* filter = alphanumeric | alphabetic | whitespace | label | digits | numeric

alphanumeric : isLetterOrDigit

alphabetic : isLetter

whitespace : no whitespace allowed (blank, tab, new-line, ...)

label : isLetterOrDigit | '_' allowed

digits : isDigit

numeric : isDigit | '-' | '.' allowed

