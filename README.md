SCPinions
=========

Steamclock uses various tools and utilities to build our apps. We call these tools Pinions and like to open source them. Right now we're still reformatting, commenting, and organizing our code so if you're here now, know that documentation is coming.

Using SCPinions
---------------

You can clone the entire repository and then pick and choose what pinions you use, but we recommend using them with ```git subtree``` if you expect that you will want to pull in changes as we update SCPinions. 

Please note that you need to have version of git >= 1.7.11 for the following instructions to work. You can type ```git --version``` to find out.

1. ```git remote add SCPinions git@github.com:steamclock/SCPinions.git```
2. ```git fetch SCPinions```
3. ```git branch SCPinions SCPinions/master```
4. ```git read-tree --prefix=SCPinions/ -u SCPinions```

Now you have a directory in your master where SCPinions lives, and you can use it in your project.

To get changes from SCPinions and merge them into your project:

1. ```git checkout SCPinions```
2. ```git pull```
3. ```git checkout master```
4. ```git merge --squash -s subtree --no-commit SCPinions```

Warning: if you have made local changes, that merge will try to overwrite them. Use one of the merge strategies below to get your local changes on the branch first.

The reason why we use --squash instead of a straight merge is so that we don't grab commit history from either project when merging between them. In most cases, you're not going to want SCPinions' commit history in the base project, and we're not going to want the base project's commit history in ours, especially if it's proprietary. --no-commit is just there to let you confirm that it worked before committing. Feel free to skip --squash and/or --no-commit if you do want our commit history (but remember to always use -s subtree!).

Another alternative strategy, if you don't mind having our history and have no plans to contribute back, is https://help.github.com/articles/working-with-subtree-merge - it only requires one command to pull changes, but is a lot less flexible.

Contributing to SCPinions
-------------------------

### Contributors with push permissions

To submit changes upstream to the SCPinions repository once you have your subtree set up, do the following:

1. `git diff-tree -p SCPinions` or `git log SCPinions/` to review changes you made in the subtree of your master branch
2. ```git checkout SCPinions```
2. ```git merge --squash -s subtree --no-commit master```
3. Push!

Always use --squash and --no-commit here, to keep the project history our of SCPinions. Alternately, you can cherry-pick the relevant commits like so:
`git cherry-pick --strategy=subtree <commitids>`
This has the added benefit of not clobbering any other changes, so you can use it to get out of trouble if both your master SCPinions/ and your branch have changes.

**IMPORTANT:** When I ([afabbro](http://github.com/afabbro)) was first experimenting with subtrees, I was a little nervous about pushing back upstream because my branch appeared to have files in the root that were from my main/master project after branching. git was/is not keeping track of those files in the same context as SCPinions; when you try and operate on those files with git commands it's as though git doesn't know anything about them. That's what we want though since we don't want to push anything from the master branch up to SCPinions. Don't panic, if you've followed the above steps and `git log` looks clean you should be okay.

### External contributors

Hey! You want to contribute to SCPinions? That's awesome. It's easiest if you go about things a little bit differently. 

1. Fork our code into your own repo
2. Follow the instructions above for 'Using SCPinions' with subtrees, except use the git address to your own fork rather than our repo
3. Push changes up to your fork using the instructions under 'Contributors with push permissions', the section immediately preceding this one if you're going the subtree route
4. Submit a pull request on Github
5. We love you forever. <3

You can use git submodules as an alternative if you are crazy.
