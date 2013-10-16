# Git Tutorial

- Open up Git Bash
- Set some git properties by running these commands:
    - `git config --global user.name "First Last"`
        - stores your name as a property to be used for each commit
    - `git config --global user.email first.last@usafa.edu`
        - stores your email as a property to be used for each commit
- Navigate to the directory where your pong project is located
    - If you don't know where that is:
        - Open CCS
        - Right click on the project in project explorer
        - Select properties
        - Note the project directory
- Let's see if the directory is under version control.
    - Type `git status`
    - This command would give us the status of the repo in the directory, but there is no repo!
- Let's create a git repository to track the files in this directory.
    - Type `git init`
    - This creates a git repo in your current directory
- Ok, let's check the status of this directory again.
    - Type `git status`
    - This should show a list of files as untracked.
    - We have a repo, cool!
- Now we have to put the files we want to track under version control.
    - Type `git add main.c`
    - This adds main.c to version control!
- Let's check the status again.
    - Type `git status`
    - We should see main.c as a new file staged for commit and a bunch of untracked files
- Let's add the other files we care about
    - Type `git add pong.c pong.h`
    - This adds pong.c and pong.h to version control
- Let's make our first commit.
    - Type `git commit -m "first commit"`
    - Should see some data about the change listed
- Let's look at our commit history.
    - Type `git log`
    - This displays all of the commits we've ever made to the repo
- Let's make a change to a file in our repo
    - Add a comment somewhere in main.c
    - Type `git status`
    - To should see main.c show up as modified
- Let's commit our change.
    - Type `git add main.c`
        - Stages main.c for commit
    - Type `git commit -m "added a comment`
        - Commits our change
- Let's look at our change in the commit history
    - Type `git log`
    - Our new commit shows up!
- But wait, we don't want this comment!  Let's revert to a previous version.
    - Type `git checkout <first few letters of commit hash> main.c`
    - Look at main.c!  It's the same as it was initially.
    - Type `git status` - it shows up as changed!
- Nevermind, we like that change
    - Type `git checkout HEAD main.c`
    - Look at main.c!  Comment is back in place
    - Type `git status` - it no longer shows up!

## Adding a Remote

We want to share our work with the world!  Let's create a repository on Github.

- Go to http://www.github.com
- At the top right, there's an icon that looks like a book with a +-sign on it - click it!
- Give your repository a name - let's call ours **pong**
- Let's give it a description
    - I'll put "Capt B's pong game!"
- Leave the rest of the settings as their defaults
- Click create repository!
- We've create a repository, now we need to **push** our work to it.
- The page for your repo should give you a URL.
    - Mine is https://github.com/toddbranch/pong.git
- Type `git remote`
    - This shouldn't display anything - we haven't added any remote locations for our code yet!
- Type `git remote add origin "YOUR URL!"`
- Type `git remote`
    - You should see origin - we just added it!
- Type `git branch`
    - You should see a single branch - master - because we haven't added any other branches yet.
- Type `git push origin master`
    - This tells git to push the master branch of our repo to the remote location called origin.
- You should be prompted for your username and password
- After entering that, you should see a bunch of files getting sent to Github!
- Go to https://github.com/YOUR_USER_NAME/YOUR_REPOO_NAME
    - Mine is at https://github.com/toddbranch/pong
    - Your first open source repo is being hosted on github!  Awesome!

## Cloning

So you've got your repo created and being hosted on github.  What if you want to work on your files on a different computer?  You should clone (duplicate) your repository!

- Note the URL of the repo on github
- Navigate to the directory you want to clone into
- Type `git clone REPO_URL`
- Now you've got a copy of the repo in a new location!

## Forking

You see some code you'd like to modify for your own purposes - you should fork your own copy!

- Navigate to the github page of the repo you're interested in
- In the top right corner, there's a button labeled fork - click it!
- Now you have your own copy in your git account
- Time to clone it to your local machine!  (see Cloning section)

## Branching

- Create a branch
- Checkout branch
- Make a change to a branch
- Commit it
- Checkout master branch
- Show change not reflected

## Other Tips

### Ignoring Certain Files

Sometimes there are a bunch of files in your directory that you don't want to place under version control.  It's annoying to have git constantly complaining about these files being untracked.

We can specify files we don't want to track in a .gitignore file!  For instance, vim creates .swp files when you open files for editing.  I don't want those to go under version control.  So I can specify that in my .gitignore:

.gitignore contents:
```
*.swp
```
Now, git won't notice changes to any .swp files.

**Command to Add All Untracked Files to .gitignore**
