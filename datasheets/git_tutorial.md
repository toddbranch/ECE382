title = 'Git Tutorial'

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
    - If you mess up the URL:
        - You can remove the remote by `git remote rm origin`
        - Now, add it again with the correct URL
- Type `git remote -v`
    - You should see origin - we just added it!
    - The `-v` tack means verbose - it will show us the names of the remotes and their URL
- Type `git branch`
    - You should see a single branch - master - because we haven't added any other branches yet.
- Type `git push origin master`
    - This tells git to push the master branch of our repo to the remote location called origin.
- You should be prompted for your username and password
- After entering that, you should see a bunch of files getting sent to Github!
- Go to https://github.com/YOUR_USER_NAME/YOUR_REPOO_NAME
    - Mine is at https://github.com/toddbranch/pong
    - Your first open source repo is being hosted on github!  Awesome!

## If You Added a README.md on the Github Website

Git is going to complain because your local repo and the repo on Github (origin) are different.  It wants you to pull in the new changes from Github before pushing your new changes.

- Let's pull in the new files from Github
    - Type `git pull origin master`
        - This is telling github to pull the master branch from origin
- Commit if you need to
- Now, we can push all our new changes back to Github!
    - Type `git push origin master`
- It should work now!

## Deleting a Repo

So you put a git repo where you didn't want one.  Maybe you put your whole hard drive under version control.  What next?

git keeps all of its files in a .git directory - to delete the repo, we just have to remove that: `rm -rf .git`.  This says remove the git directory and everything inside of it and don't ask me to verify deletes.

## Cloning

So you've got your repo created and being hosted on github.  What if you want to work on your files on a different computer?  You should clone (duplicate) your repository!

- Note the URL of the repo on github
- Navigate to the directory you want to clone into
- Type `git clone REPO_URL`
- Now you've got a copy of the repo in a new location!
- After you've made changes:
    - Push them back to the repo on Github via `git push origin master`

## Forking

You see some code you'd like to modify for your own purposes - you should fork your own copy!

- Navigate to the github page of the repo you're interested in
- In the top right corner, there's a button labeled fork - click it!
- Now you have your own copy in your git account
- Time to clone it to your local machine!  (see Cloning section)

## Branching

What if we want to maintain different versions of our code?  Say we want to store a version for required, B, and A functionality.  Or maybe we've got a piece of functionality going and we want to add a new feature without breaking existing code.  These are use cases for branches!

I'll use the "add a new feature" in my example.  Imagine we have our robot navigating the maze using IR sensors.  But we want to add a sonar feature to increase accuracy without breaking functionality of our working code.

- Let's take a look at our existing branches
    - Type `git branch`
        - This shows all of the branches in our repo
        - It should just list the master branch at this point
- Let's create a "sonar-feature" branch in which to add sonar support
    - Type `git branch sonar-feature`
- Let's make sure it was added
    - Type `git branch`
        - This should list two branches: master and sonar-feature
        - Master should have a * next to it - this means master is the branch we're currently developing in
- Let's switch to using our sonar-feature branch
    - Type `git checkout sonar-feature`
        - This switches our development to the sonar-feature branch
- Let's make sure we've switched
    - Type `git branch`
        - The sonar-feature branch should now be starred
- Now we can make and commit changes to our sonar-feature branch without impacting our master branch!  Great success!
- We can always checkout our master branch if we want to run our earlier code version!

## Ignoring Certain Files

Sometimes there are a bunch of files in your directory that you don't want to place under version control.  It's annoying to have git constantly complaining about these files being untracked.

### Temporarily Ignoring

Instead of `git status`, type `git status -u no`.  This will not display status information on untracked files.

### Permanently Ignoring

We can specify files we don't want to track in a .gitignore file!  For instance, vim creates .swp files when you open files for editing.  I don't want those to go under version control.  So I can specify that in my .gitignore:

.gitignore contents:
```
*.swp
```
Now, git won't notice changes to any .swp files.

Make sure you add your .gitignore file to git and commit it!

Here's a bash command to add all currently untracked files to your .gitignore, if that's what you want to do:

`git status --porcelain | grep '^??' | cut -c4- >> .gitignore`
