# How does it all work?

Without git, you can create and save files inside of a folder and there is a single version of those files.

In addition when you keep working on those files, you are always working with the latest version of those files.

When you add a git repository inside of your folder, you gain the ability to create **snapshots** of those files. These are not copies, but rather a marker of a point in time of your code. There is always only one folder or file, but you can switch between different versions of the file by going back to previous snapshots.

These snapshots are recorded once you do a commit. So by doing frequent commits you are able to back and forward to different versions of your project.

!!! tip
    When you have finished a component of your work, make a commit. Your page or screen may not be finished yet, but your code may have changed enough for you not to want to redo that task if something goes wrong

# What are commits

Previously we talked about the master branch and when you do your first commit, this master branch is created.

A commit is identified by a SHA-1 key and is made up of 40 hexadecimal (0 - F) characters like this:

```
8bfecf283eb5e471dcdbf52f9567bf05a9e159c7
```

Each of these numbers is unique and the amount of combinations is so big that you will unlikely get a duplicate key.

Funfact : As a proof of concept of the above the entire linux kernel has 839,314 commits pushed up to its [GitHub page](https://github.com/torvalds/linux) as of 19/05/2019 and has not run into duplicate numbers yet.

When referencing to these commit numbers, you will likely find that selecting the first 7 digits is enough since it gives you 268,435,456 different combinations alone.

Each of these commits is **a snapshot of you chose to commit** , so it may not include everything.

Commits include more details than just a number and when running `git log` you see something like this:

``` bash
commit 1df4bcf0f0a550e22d33acd1005f03f7e3aa771d (HEAD -> master)
Author: Jeffrey Kranenburg <jeff_mba@MBA.local>
Date:   Sun May 19 14:29:51 2019 +1200

    First commit
```

1. Commit number - The commit number and that the HEAD is matched to the master
2. Author - Who made the commit
3. Date -  When the commit was made
4. Commit message - This message should be less than 50 characters

!!! tip "Go back to the last commit"
    As long as the `.git` folder is in place, you can always recover files from a previous snapshot (or commit) even if you delete it.

    For this use `git checkout .`

