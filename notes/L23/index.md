# Lesson 23 Notes

## Readings
- [Revision Control](https://en.wikipedia.org/wiki/Revision_control)
- <a href="https://en.wikipedia.org/wiki/Git_(software)">Git</a>
- [Github](https://en.wikipedia.org/wiki/Github)
    - This is an open source community around Git - check it out!

## Assignment
- [Assignment](L23_git.html)

## Lesson Outline
- Admin
- Review
- Writing Clean Code
- Revision Control

## Admin

- Graded labs, available in Lab
- Prog grades are in - CAMIS should be (mostly) up to date
- I'll extend turn-in deadline on pong / moving average to COB for this class

## Review

- Review pong code
- Review moving average code

## Writing Clean Code

### Meaningful Names

*[Write code in vim]*

**[Bad Code](badCode.html)**

- Use intention-revealing names ("self-documenting")
    - `int d, temp; // elapsed time in days, a temporary variable`
    - `int elapsedTimeInDays, daysSinceModification;`
- Make meaningful distinctions
    - `void copyChars(char* a1, char* a2)`
    - `void copyChars(char* source, char* destination)`
- Use pronounceable names
    - `DtaRcrd`
    - `DataRecord`
- Use searchable names
    - `MAX`
    - `MAX_STUDENTS`
- Functions: use verbs!
    - `forward()`
    - `moveForward()`
- Don't be cute
    - `holyHandGrenade()`
    - `deleteItem()`
- Pick one word per concept
    - Bad: `fetch(), retrieve(), get()`

### Functions

- Small - ideally less than 10 lines long
- Do one thing
- Use descriptive names
- Parameters: rarely need more than two or three
- Side effects - function should only do what you say it does
- Do not use static or global variables
- Only depend on local variables / parameters
- Don't repeat yourself - write a function instread of copy / paste
- Only one entry / exit point
- Indent correctly!

*[Let's fix my code!](pong_c.html)*

- Create `updateBallIfHitWall` function
- Create separate `didHitTop`, `didHitBottom`, `didHitLeft`, `didHitRight` functions

### Comments

- Comment on "big picture" items
    - Head of each file
    - Definition of each function
    - Beginning of each major block of code
- As you move deeper in the hierarchy, the comments are more specific
- Try writing functions / meaningful names
    - `if ((employeeFlags & HOURLY_FLAGS) && (employeeAge > 65)) ...`
    - `if (isEligibleForFullBenefits(employee)) ...`
- TODO comments
    - `// TODO: Make this into a function`
    - `// TODO: Write new header file to group these functions`
- Bad comments
    - Restating your code (`a = 1; // Setting a to 1`)
    - Commented-Out code
    - Too much information
    - "Don't comment bad code - rewrite it.

*[Let's fix my code!](pong_c.html)*

- Add comments to functions

## Revision Control

- Database that keeps track of multiple versions of your code
- Revision Control Terms
    - *Repository* - database where your versions are stored
    - *Commit* - submit the changes to files since last commit
    - *Revert* - go back in time to a previous version
- **Not a substitute for backing up your data!**
- Commit very frequently
    - Usually after you get a small part working (e.g. simple function)
    - It only stores the *difference* between versions (i.e. commits don't take up much disk space)
- Most common revision control tools
    - Concurrent Versions System (CVS) - older, but still popular
    - Subversion (SVN) - designed as a replacement for CVS
    - Git - hugely popular for individual / team software development
        - Required for this class
        - Invented by Linus Torvalds for use with the Linux Kernel after Bitkeeper withdrew free use of the product
        - Wrote the initial version in two weeks, used for kernel development within 2 months

### The Shell

"A shell is software that provided an interface for users of an operating system to access the services of a kernel." - Wikipedia

Basically, a shell gives you direct access to your computer.

To use git, we'll be using a shell - Git Bash.  Bash is an acronym for Bourne Again Shell - it is probably the most common shell in existence.

Here are some common shell commands that will prove useful:

- `ls`
    - Lists contents of a directory
- `cd`
    - Change directory
- `pwd`
    - Display the present working directory (directory you're currently in)
- `cat`
    - Concatenate, but practically used for displaying the contents of a file
- `vi` or `vim`
    - Sweet text editor that your instructor uses

*[Demo these commands, get them to open shell and practice them]*

### [Git Tutorial](git_tutorial.html)

### Common Git Commands

- `git config --global user.name "First Last"`
    - Stores your name as a property to be used for each commit
- `git config --global user.email first.last@usafa.edu`
    - Stores your email as a property to be used for each commit
- `git init`
    - Creates a git repository in the current directory
- `git add <filename>`
    - Adds the file `<filename>` to the git repository
- `git commit -a -m "This is what I changed."`
    - Commits all changes to files you have added and stores a message that describes those changes
- `git log`
    - Shows you a complete history of commits within the repository
- `git status`
    - Show you the status of the repo this directory is in

### [Github](http://www.github.com)

[Github](http://www.github.com) is the most popular open source code repository site in the world.  It's a web-based hosting service for projects that use Git.  It is required for this class.

*[Go to website, give brief tour]*

Github is a great place to get access to the source code for some of the world's most popular open source projects.  It's a great way to keep track of programmers whose work you're interested in.  It's also a great way to get involved in the coding community, maybe work on an open source project or release some code of your own.

### The ECE382 Electronic Lab Notebook

[The template is available on my Github](https://github.com/toddbranch/electronic_lab_notebook).

*[Walk through the structure, etc.  Talk about cloning repos, etc.]*

Talk about homework, let them get started if there's time.
