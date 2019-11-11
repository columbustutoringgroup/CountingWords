// Use the Node file system module, fs.
const fs = require('fs');

// Use the fs.readFileSync method to read speech.txt,
// and use the callback function to see if it worked.
// (I know synchronous methods are unsexy, but it just
// makes it easier because I know my program isn't
// going to be doing anything else at the same time.)
const text = fs.readFileSync("speech.txt", "utf8")

// Create an array of the words in the file, using
// regex to return things that are actually words,
// that is, made up of capital or lowercase letters
// A to Z or an apostrophe and having one or more
// characters.
const words = text.match(/[A-Za-z']+/g)

// Create a dictionary object to keep track of
// all the words in the text and how many times
// each one appears.
let dictionary = {}

// Iterate through the words from the text...
for (let i = 0; i < words.length; i++) {

    // If it's already in our dictionary,
    // add one to the count.
    if (words[i] in dictionary)
        dictionary[words[i]]++
    // Otherwise, add this word to our
    // dictionary with a count of one.
    else
        dictionary[words[i]] = 1
}

// Next, move our dictionary information over
// to an array so we can sort it by the number
// of appearances of each word.

let output = []

for (const word in dictionary)
    output.push(dictionary[word] + " - " + word)
    
// Sort the array and then print the results.
//
// I use a little regex magic to sort primarily
// by the number at the beginning of each string
// (descending) and then secondarily by the text
// content (ascending). The regex for the first
// part of the match returns one or more digits
// at the beginning of the string. The regex
// for the secondary sort first takes the lower
// case version of the string (because we don't
// care about case) and then returns one or more
// lower case letters from a to z or the
// apostrophe. Then the ternary makes the
// secondary comparison return 1 if the first
// word is first alphabetically or -1 if the first
// word is last alphabetically.
//
// The logical or here makes it so we only look at
// the second part of the comparison if the value
// of the first part is zero.

output.sort((a,b) => b.match(/^\d+/) - a.match(/^\d+/) ||
    (a.toLowerCase().match(/[a-z']+/) >
    b.toLowerCase().match(/[a-z']+/) ? 1 : -1))

// I use the join method to print each element
// of the sorted array on a new line with the
// \n character.
console.log(output.join('\n'))
    




