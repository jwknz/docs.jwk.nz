# Using Branches

Up until this point we have looked at the master branch.
The master branch is the main branch and most commonly used to have the code that is currently in production (i.e. the version of the code users currently see)

As you may imagine, this is not a good place to make continous changes.

Branches - just like commits - are snapshots, but these snapshots allow us to make adjustments to our code and test them separately from the master branch.

A number of uses for branches are:

* Feature Development
* Bug Fixes (fixes or improvements of an app)
* Hot Fixes (fixes or improvements of an app that are out of cycle)
* Testing
* Building towards release

Why is it called a branch?

No reason other than terminology.  
Each code commit contains what is known as a tree - this is a list of all the files in the current code base.

![Git Tree](https://git-scm.com/book/en/v2/images/commit-and-tree.png)
_Source: https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell_

A branch is a snapshot of that tree.

The **HEAD** is the place where you are currently on and represents the "space" between the last commit and your current changes and it moves when you switch to another branch.

To create a branch you will need to type in:

```
git branch <branch-name>
```

The above command creates the new branch, but you are not switching to it.

```
git checkout -b <branch-name>
```

The above command will create a new branch from the position your HEAD is currently at and switches you to it.

```
git checkout -b <new-branch-name> <other-branch-name>
```

The above command will create a new branch with the starting point being another branch and switches you to it, this saves you having to switch back to other braches first.

!!! tip "Good Practice"
    Each time you add a new feature, create a branch for it.  
    That way when you add someone to your team they can work of what is already there and your code won't accidently be erased.

