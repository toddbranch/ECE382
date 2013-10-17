# L24 Git In-Class Exercise

We introduced git last lesson and you got some practice with it on the homework.  But I'm sure there's still some confusion - so I'm going to use first 20 minutes of class to work through an exercise.

## The Basic Idea

Dr. York and I need to know your accounts in order to review the code in the repositories you create in the future.  It's also helpful for you to know the accounts of your classmates so you can collaborate on future work.

I've create a repo to track your accounts that only contains a README.md file: https://github.com/toddbranch/ECE382-student-accounts.

Your task for this exercise is to add your name and account to the README.md file and send me a request to merge your changes back into my master branch.

## Step-by-Step Process

- Navigate to the repo: https://github.com/toddbranch/ECE382-student-accounts
- Now you need to **fork** the repo so you have your own copy to work on
    - Push the fork button at the top right of the screen
    - Now you have your own copy!
    - You should be redirected to a duplicate repo in your own account
- Now you need to **clone** the repo to our computer so you can make changes
    - Note the URL in your browser - this is the address of the repo
    - Navigate to the directory where you want the repo stored and type `git clone REPO_URL`
    - Now you've got a copy of the repo on your local computer!
- Time to make your changes!
    - Open your favorite text editor
    - Add your name and link to your repo under the correct section
        - `- [YOUR NAME](YOUR REPO URL)`
        - `- [Capt Branchflower](https://github.com/toddbranch)`
- Let's make sure git is tracking our changes
    - Type `git status`
        - We should see that README.md has been modified
- Time to commit our change!
    - Type `git commit -am "added my name to the README!"`
        - This tells git to add and commit all the files currently being tracked that have changes
- Let's push our changes back up to Github
    - Type `git push`, enter your username / password
    - The changes should now be reflected in your repo on Github
- Now you need to ask me to merge the changes back into my branch - this is call a **pull request**.  You want me to pull changes into my branch from you.
    - Navigate to your fork of the repo
    - Click the Pull Request button at the right of the screen.
    - Click the New pull request button at the right.
    - Click the "Click to create a pull request from the comparison" link at the top.
        - Your commit message should be populated into the title of the request.
        - If you want, you can add more comments below.
    - Click Send Pull Request.

You're done!  I'll go in and merge your changes - assuming you didn't do anything bad...
