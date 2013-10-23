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

`t` and `T` work the same as `f` and `F`, but place your cursor directly before the target character.

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
- `H` - move cursor to top line on current screen
- `M` - move cursor to middle line on current screen
- `L` - move cursor to bottom line on current screen

## Editing a File

There are more efficient ways to edit documents than just typing `i` and inserting at your current cursor position.

Say I want to insert after my cursor position, typing `a` (for append) will put me into insert mode after my cursor.

Say I want to insert text at the end of the current line, typing `A` will put me into insert mode at the end of the line.

Say I want to delete the character under my cursor, I'd press `x` - deleting the character while keeping me in command mode.

These commands illustrate vim users' obsession with eliminating keystrokes.  We could accomplish these tasks using our movement commands and insert, but **we want to be fast**.

### Composing Commands

The power of vim really comes to light in combining commands.

Take `c` (for change), for instance.  On its own, it doesn't do anything.  You have to combine it with movement commands for it to make sense.  Say I want to rewrite a word I've written - typing `cw` will delete the word and put me in insert mode.  It helps me to think `cw` = "change word".  `c` can be combined with any of the other movement commands.

`d` (for delete) is similar.  `dw` deletes the word at your cursor, but keeps you in command mode.

You can also specify repetition in vim.  Say I wanted to delete the next 5 words - I could type `5dw` to accomplish that.

Composition doesn't just work for edits - `5j` would move down 5 lines and `5w` would move 5 words.

### Substitution (Find / Replace)

Substitution is easy and powerful in vim.  Let's say I want to substitute `foo` with `bar`.  Here are some common uses and their results:

- `:%s/foo/bar/`
    - Sub all occurences with `foo` with `bar` in document
- `:s/foo/bar/`
    - Sub next occurence of `foo` with `bar` in line
- `:s/foo/bar/g`
    - Sub all occurences of `foo` with `bar` in line
- Adding c to the end of each of these will prompt you to confirm each substitution

### Common Editing Shortcuts

- `dd` - delete current line
- `yy` - yank (copy) current line
- `p` - paste
- `C` - change all text to end of line
- `D` - delete all text to end of line

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

Configurations are very portable - you can replicate your environment on a new computer by simply copying over a single file, your **vimrc**.

**Caution:** There's a temptation to spend a ton of time on your vimrc / plugins and "create the perfect environment".  Resist this.  Learning how to navigate and use vim effectively is a better use of your time.  The important vimrc settings / plugins will find their way in eventually.

### vimrc

The vimrc is a file containing a list of commands specifying the configuration of your vim environment.  It's typically saved as `.vimrc` in your home directory.  To edit it in vim, type `:e $MYVIMRC`.

Here are some lines from my vimrc with comments:
```
syntax on               " turn on syntax highlightinp
set rnu                 " turn on relative line numbering
set cursorline          " show marker beneath current line
```

There's a lot more in there - research and go nuts.

### Plugins

vim can also be extended with plugins, providing all sorts of additional functionality.

I manage plugins with vundle: https://github.com/gmarik/vundle .

Some plugins I use:

- desert256
    - My color scheme
- vim-snipmate, snipmate-snippets
    - Tab auto-completion of common code constructs
    - Example: in C, type `main<TAB>`, completes to standard main function
- vim-startify
    - Start screen for vim - provides quick access to most recent files edited
- vim-fugitive
    - Integration with git
- vim-markdown
    - Markdown syntax highlighting
- hardmode
    - Disables common movement crutches to help make you better at using vim!

**If you find any others worth adding, let me know!**

## Managing Multiple Files

### Windows

Viewing multiple files simultaneously is easy in vim.

- `:vs <filename>` - split window vertically and display file
- `:sp <filename>` - split window horizontally and display file

You can split windows any number of times.

To navigate amongst multiple windows, use `<CTRL>-w` + direction key.

### Tabs

It's also possible to have multiple tabs within a vim session.  Type `:tabnew <FILENAME>` to open a new tab.

To switch amongst tabs, use `gt` to go to the next tab right or `gT` to go to the next tab left.

## Miscellaneous Stuff

### Macros

Anytime you notice that you're doing the same action over and over, you're probably a macro away from saving yourself a ton of work.

A macro is a recording of a series of keystrokes that you want to repeat.

To begin recording a macro, type `q<character>`.  The `q` indicates you want to begin recording a macro and the `<character` specifies the identifier of the macro.  After you've completed all the keystrokes for your specified action, type `q` to end recording.  To use the macro, type `@<character>` at the location you want to use it.  The true power of macro comes in specifying repetition: typing `100@a` runs the `a` macro 100 times!

Say I wanted to create a list of numbers 1-100 - the kind of repetitive task a macro is perfect for.  I'd first enter insert mode and enter 1.  Now, to record my macro - type `qa`.  You should see `recording` text come up at the bottom left of your screen.  Type `yy`, then `p` to copy and paste 1 to the second line.  Then type `<CTRL>-a` to increment the number, then `q` to stop recording.  Now, I can type `100@a` to repeat the macro 100 times and create my list!  Magic!

### Autocompletion

Most people cite tab-autocompletion as a reason for using an IDE over something like vim - but vim can do that too!

`<CTRL>-n` after typing the first few letters will show a list of potential completions.  `<CTRL>-n` will cycle through the list in one direction, `<CTRL>-p` in the opposite.
