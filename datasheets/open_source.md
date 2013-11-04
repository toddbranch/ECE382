title = 'Open Source'

# Open Source

git and Github put you in a great position to use open source work in your project or make contributions to open source yourself.

Before you re-invent the wheel, a great first step for most projects is to see if there is open source work available you can use or build on - Github has great search features for this.

In this course, I expect you to write your own code unless you receive explicit permission from me to use open source.

## Using a Library As-Is

To use an existing library, all you need to do is clone it.  Navigate to your project folder and:

`git clone <REPO URL>`

If you want to update your version with the most current changes to the library:

`git pull origin master`

Now that you have it in your project folder, include it:

`#include REPO_NAME/REPO_NAME.h`

## Making Modifications to a Library

If you plan to modify a library, you need to fork it.

On Github, navigate to the repo and click Fork at the top-right of the page.  Now, you have your own copy of the repo on Github.  To get it onto your computer:

`git clone <REPO URL>`

### Contributing Your Changes

If you want to submit your fixes or improvements back to the library, you have to send the maintainer a pull request.  Once you've pushed your changes back up to Github, navigate to your repo and click Pull Request at the right.  Click New Pull Request - this should bring up a screen showing your changes.  Click Create a New Pull Request from These Changes at the top of the screen - add relevant details about what you're sending and submit it.  It's up to the maintainer to decide whether to accept your contribution - usually they'll interact with you via comments.
