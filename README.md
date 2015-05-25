#Counting Words

__Skill Level:__ Intermediate  
__Time Limit:__ 15-20 minutes

Variations of this challenge are pretty common in code interviews and phone screens for software engineering. The task may differ but the fundamentals are usually pretty much the same - Given a file, read it, and parse the data.

##Instructions
- Read the `speech.txt` file and display a count of the most commonly used words in the document.
- Your list of commonly used words should be human readable and in descending order by count.

##Things to Think About
- What would you test first?

A> I think a good way to start working on this problem is to write tests first in order to guide the implementation. I wrote functional tests using rspec divided into appropriately granular describe and context blocks.
I started with testing the ability to create a counter with either a file or a text snippet. This ability to use text snippets allows easier testing of special cases.
- What are the edge cases?

A> We need to ensure that noise words are filtered out. Once that is done, special characters such as punctuation marks, brackets, and so on need to be removed to keep the word list meaningful and remove duplicates. An exception is the apostrophe character which, it seems, should be considered part of the word.
- Is your solution object oriented? 

A> yep

##Example

Given: "The cat is tall. The cat is much bigger than the mouse."

Then:
```
3 - the
2 - cat
1 - is
1 - mouse
1 - bigger
1 - than
1 - much
```
