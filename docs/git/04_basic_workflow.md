# Basic Workflow

Git can be used in a couple of ways. The 2 main ones are:

* Local first - Creating a repository locally on your machine
* Remote first - Cloning a repository

## Local first 

Local first is used when you already have a project on your machine, or want to just start on your own machine before pushing your code anywhere.

To start your repository locally use the `git init` command.

Personally I have a project folder in my users folder called Code and inside of there I have my repositories, so this is my workflow:

``` bash
cd ~/Code
git init <project>
cd <project>
```

Then I setup project and before writing any code, I do an initial commit:

``` bash
git add -A
git commit -m "Initial Commit"
```

If you see a ">" on yoru screen, you probably forgot the closing quotation mark of the git commit. To exit out of that type in **Ctrl+C** and start again.

### Adding a remote connection

Now if you want to be able to push this code a remote repository, you need to create a repository on GitHub and then use the url to that repository to link your local repository to your remote repository.

1. Go to [https://github.com/new](https://github.com/new) to get started.
2. Name your repository and give it an optional description
3. Set the repository to public or private (both are free)
4. Ignore the "Initialize this repository with a README" checkbox.

Now that you have a remote repository setup you need to link it by typing in:

```
git remote add origin <url-to-repo>
```

If you mistype anything, you can remove a link by typing in:

```
git remote rm origin
```

**Origin** is the default name for the remote connection.

Now you can "push" your code to the remote repository using:

```
git push origin master
```

## Remote first

If there is a repository already created on GitHub, then you can use that as a base. For this, you will need to clone the repository:

```
git clone <url-to-repo>
```

This will create a folder with the repository in it. My workflow for this is:

``` bash
cd ~/Code
git clone <url-to-repo>
cd <project>
```

After this you will see the code from the project and you can just start working on it.

A couple of things to note:

* If this is not your own repository, you cannot push to it unless you have permission to do so.

* If you want to push to it without permissions, you need to *fork** it first, but it will never be merged into the original repository and you won't receive updates for it after the date you forked it.

When you clone a repository, it already includes the remote connection since it came from a remote place. So adding another remote connection is possible, but not required.

The steps above are the very minimum you need to do to work with git, but there is much more to it - which we will look into next.

# Git Reset

Since we can add and update files to a git repository, it would be useful if we can go back to a previous state. Here are some of the basic options you have.

| Command | Description |
| :--- |  :--- |
| `git reset --soft <sha1 number>` | does not change any of your files, but goes back the referenced commit |
| `git reset --mixed <sha1 number>` | changes the files in the staging area, but not the working directory |
| `git reset --hard <sha1 number>` | changes the files in both the staging area and working directory |
| `git checkout -- index.html` | Reverses the changes of a file to the most recent commit |
| `git commit --amend` | Change the last commit message in a vim editor |
| `git commit --amend -m "msg"` | Change the last commit message inline |

From there you can recommit or make any changes you need.