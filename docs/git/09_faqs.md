# GIT FAQ

Here are some questions I have run into and hope to answer them below:

1. If I create multiple branches and edit the same file will I get a conflict when I merge them?

Technically yes you will, but the way around that is to do the following:

Option 1)  
* Make a change in branch one and push it to the remote repository (GitHub)
* Pull the changes into the other branch and fix any conflicts
* Merge the final result (after testing) it into the master branch

Option 2)  
* Make a change in branch one and merge it into the other branch
* Fix the conflicts
* Merge the final result (after testing) it into the master branch

Ideally you will not be working on the same files in different branches while they are on your machine.

2. How do I rename a file / folder?

Use the `mv` command

Usage is `mv <source file/path> <destination file/path>`

