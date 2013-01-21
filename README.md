SCPinions
=========

Steamclock uses various tools and utilities to build our apps. We call these tools Pinions and like to open source them. Right now we're still reformatting, commenting, and organizing our code so if you're here now, know that documentation is coming.

<<<<<<< HEAD
Using SCPinions
---------------

You can clone the entire repository and then pick and choose what pinions you use, but it might be nicer for you to use them with ```git subtree``` and ```sparse-checkout``` if you find that you want to contribute back to our repository.
=======
Angelina is adding this message so that she has something to use to test subtree merging.
>>>>>>> 5c91f7ea17c69280f6f612374b1449ed43bd0c68

Please note that you need to have version of git >= 1.7.11 for the following instructions to work:

1. ```git remote add SCPinions git@github.com:steamclock/SCPinions.git```
2. ```git fetch SCPinions```
3. ```git checkout -b SCPinions SCPinions/master```
4. ```git checkout master```
5. ```git read-tree --prefix=SCPinions/ -u SCPinions```

Now you have a directory in your master where SCPinions lives, and you can use it in your project.

To get changes from SCPinions and merge them into your project:

1. ```git checkout SCPinions```
2. ```git pull```
3. ```git merge --squash -s subtree --no-commit SCPinions```

To submit changes upstream to the SCPinions repository, do the following:

1. ```git diff-tree -p SCPinions``` to review changes you made in the subtree of your master branch
2. ```git merge --squash -s subtree --no-commit master```
3. Submit a pull request or push changes if you have the necessary permissions for the latter.

**IMPORTANT:** When I (@afabbro) was first experimenting with subtrees, I was a little nervous about pushing back upstream because my branch appeared to have files in the root that were from my main/master project after branching. git was/is not keeping track of those files in the same context as SCPinions; when you try and operate on those files with git commands it's as though git doesn't know anything about them. That's what we want though since we don't want to push anything from the master branch up to SCPinions.

