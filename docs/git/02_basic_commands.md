# Basic Commands

To be able to use git we need to know a bit about the command line.  
Some of these commands you may already be familiar with, so just have a look through them.

First let's get to know how to navigate through locations

| Location | Description |
| :--- | :--- |
| `.` | Current Folder |
| `..`| Parent Folder |
| `~` | Home Directory |
| `/` | The root of a drive, you cannot go any higher than this |
| `<folder>` | A folder name that is in the current folder you are in, ignore the angle brackets |
| `<folder>/<file>` | Path to a file, the file may be in a sub folder |
| `ls -la` | ls = list files, -l = long list, -a = show all files, including hidden |

As mentioned earlier, git is a linux command line tool - so we need to know some basic commands to find our way around.

| Feature | Description |
| :--- | :--- |
| `cd` | change directory - this is followed by location above |
| `mkdir <folder>` | create a folder, ignore the angle brackets |
| `touch <file>` | create a file, ignore the angle brackets |
| `mkdir -p <folder>` | create a folder with subfolders |
| `rm` | remove a file followed by the file name |
| `rm -f` | force remove a file followed by the file name | 
| `rm -rf` | force remove a folder followed by the folder name | 
| `mv <source file/path> <destination file/path>` | Moving or Renaming files |

# Basic git commands

Next up are the basic git commands. Even though we are still going to cover them in more detail - here is a list of them for a quick reference.

| Feature | Description |
| :--- | :--- |
| `git init` | Create a git repository in your current folder |
| `git init <folder name>` | Create a folder with a git repository in it. Ignore the angle brackets |
| `git add .` or `git add --all` | Add all the files to the staging stage, this includes new, updated and deleted files | 
| `git add -u` | Add only new and updated files to the staging stage |
| `git commit -m "message"` | Add the files to the git repository and create a log point |
| `git push origin master` | Push the current content in your local repository to your remote repository |
| `git pull origin master` | Pull the current content from the remote repository to your local repository |
| `git clone <repo-link>` | Clone an existing remote repository to your local folder, it creates a folder with the repository name |
| `git clone <repo-link> .` | Clone an existing remote repository to your local folder, but places all the content in the current folder. This folder must be blank. |

## Some gotcha's 

* Often people will do a `git init` without navigating their terminal to the right location first.

* Do not create a git repository inside of another git repository as it messes up the tracking system.

* If you do not create any branches, then you must use git pull and git push correctly often, but this is a bad way of working, but we will get back to that later.

# Intitial Git Setup

After you setup a git repository using `git init` you will want to let git know who is making the commits. In most cases you will only need to do this once per machine.

```
git config --global user.name "Your name"
git config --global user.email "Your email"
```

If you want to override these settings for a particular project then you can use the local flag instead of the global one. The local flag will only apply to the repository you are working on.

```
git config --local user.name "Your name"
git config --local user.email "Your email"
```