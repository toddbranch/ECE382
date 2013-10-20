title = 'Intro to vim'

**This is a work in progress - I'll add / edit as I can.  If there's something else you want to see, [file a bug report!](https://github.com/toddbranch/ECE382/issues)**

# Intro to vim

vim is a text editor available from the command line and operated solely via the keyboard.

Most installations of vim come with a built-in tutorial.  Execute `vimtutor` from your shell to access it!

To edit a file, execute `vim <FILE_NAME>` from your shell.  vim should open and the file should be displayed.

## Modes of Operation

vim has two main modes of operation: **insert mode** and **command mode**.

To enter **insert mode**, press `i`.  This will allow you to add text to the file.

To enter **command mode**, press `<ESC>`.  This will allow you to execute commands.

Most heavy vim users remap their `<ESC>` to their `<CAPS_LOCK>` key because they use it so much.

## Movement within a File

The ability to move around and edit a file quickly is what makes vim so powerful.  You'll find the way you navigate changes as you grow more accustomed to the "vim way".  More efficient / faster movement comes with practice.

Movement happens in **command mode**.

### Basic Movement

It's possible to move around via the arrow keys, but that's pretty slow.

It would be faster if our fingers didn't have to leave the home row.  So `k` moves up, `j` moves down, `h` moves left, and `l` moves right.

It would be even faster if we didn't have to move one character at a time.  So `w` moves one word to the right and `b` moves one word to the left.  If we want to go the end of the word our cursor is on, type `e`.

### More Advanced Movement

It would be even faster if we could navigate directly to the character within a line we're looking for.  So `f<character>` searches forward and `F<character>` searches backward.  If there are multiple appearances of the character in the line, `;` moves you to the next one and `,` moves you to the previous.

It would be even faster if we could search outside of single lines and specify more than a single character.  So `/<search string>` searches for the appearance of the string from the cursor forward and `?<search string>` searches from the cursor backword.  If there are multiple appearances of the search string, `n` goes to the next one forward and `N` goes to the next one backward.

I've found that using search is one of the fastest ways to move through a document with precision.

### Common Movement Shortcuts

- `0` - move to the beginning of the line
- `$` - move to the end of the line
- `^` - move to the first character on the line
- `gg` - move to the top of the document
- `G` - move to the bottom of the document
- `<CTL>-f` - move forward one page
- `<CTL>-b` - move back one page
- `zz` - move the current line to the middle of the page
- `zt` - move the current line to the top of the page
- `zb` - move the current line to the bottom of the page

## Editing a File

There are more efficient ways to edit documents than just typing `i` and inserting at your current cursor position.

Say I want to insert after my cursor position, typing `a` (for append) will put me into insert mode after my cursor.

Say I want to insert text at the end of the current line, typing `A` will put me into insert mode at the end of the line.

Say I want to delete the character under my cursor, I'd press `x` - deleting the character while keeping me in command mode.

These commands illustrate vim users' obsession with eliminating keystrokes.  We could accomplish these tasks using our movement commands and insert, but **we want to be fast**.

### Composing Commands

The power of vim really comes to light in combining commands.

Take `c` (for change), for instance.  On its own, it doesn't do anything.  You have to combine it with movement commands for it to make sense.  Say I want to rewrite a word I've written - typing `cw` will delete the word and put me in insert mode.  It helps me to think `cw` = "change word" in my head.  `c` can be combined with any of the other movement commands.

`d` (for delete) is similar.  `dw` deletes the word at your cursor, but keeps you in command mode.

You can also specify repetition in vim.  Say I wanted to delete the next 5 words - I could type `5dw` to accomplish that.

Composition doesn't just work for edits - `5j` would move down 5 lines and `5w` would move 5 words.

### Common Editing Shortcuts

- `dd` - delete current line
- `yy` - yank (copy) current line
- `p` - paste
- `C` - change all text to end of line

## Saving, Switching Files, and Quitting

**In command mode:**

- `:w` - save (write) the current file
- `:e <filename>` - edit a different file without leaving vim
- `:e! <filename>` - edit a different file and discard any changes to current file
- `:x` - save and quit
- `:q` - quit without saving
- `:q!` - quit without saving and discard any changes

## Configuration

Another powerful feature of vim is its configurability.  It's possible to adjust almost every aspect of your environment to your liking.

Configurations are also very portable - you can replicate your environment on a new computer by simply copying over a single file, your **vimrc**.

### vimrc

The vimrc is a file containing a list of commands specifying the configuration of your vim environment.  It's typically saved as `.vimrc` in your home directory.  To edit it in vim, type `:e $MYVIMRC`.

Here are some lines from my vimrc with comments:
```
syntax on               " turn on syntax highlightinp
set rnu                 " turn on relative line numbering
set cursorline          " show marker beneath current line
```

There's a lot more in there - research and go nuts.

**Caution:** There's a temptation to spend a ton of time on your vimrc and "create the perfect environment".  Resist this.  Learning how to navigate and use vim effectively is a better use of your time.  The important vimrc settings will find their way in over time.

### Plugins

## Managing Multiple Files

### Windows

### Tabs

## Miscellaneous Stuff

### Macros

Anytime you notice that you're doing the same action over and over, you're probably a macro away from saving yourself a ton of work.

A macro is a recording of a series of keystrokes that you want to repeat.

To being recording a macro, type `q<character>`.  The `q` indicates you want to begin recording a macro and the `<character` specifies the identifier of the macro.  After you've completed all the keystrokes for your specified action, type `q` to end recording.  To use the macro, type `@<character>` at the location you want to use it.  The true power of macro comes in specifying repetition: typing `100@a` runs the `a` macro 100 times!

Say I wanted to create a list of numbers 1-100 - the kind of repetitive task a macro is perfect for.  I'd first enter insert mode and enter 1.  Now, to record my macro - type `qa`.  You should see `recording` text come up at the bottom left of your screen.  Type `yy`, then `p` to copy and paste 1 to the second line.  Then type `<CTRL>-a` to increment the number, then `q` to stop recording.  Now, I can type `100@a` to repeat the macro 100 times and create my list!  Magic!

### Autocompletion

`<CTRL>-n`, `<CTRL>-p`
