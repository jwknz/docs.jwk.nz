# Exercises 

These exercises are all done using git bash or the terminal

!!! warning "Note for windows users:"

    The unix system outputs paths using forward slashes (`/`) not the backwards slash (`\`) So to go to a path on a particular drive type in something like:

    ```
    /d/code
    ```

    This is will take you to D:\code

    The unix system is also case sensitive, so D:\Code is not the same as D:\code

## 01 - Create a repository

* Navigate to a working folder (H:)
* Create a folder called Code
* Inside that folder create a folder called **project101**
* Inside that folder create a git repository

## 02 - Create a second repository 

* Navigate to your working folder (/drive letter/Code)
* Inside that folder create a folder called **project102** that includes a git repository using a single command

## 03 - Delete a folder

* Delete folder **project102**

## 04 - Create a folder structure

* Create the following folders: css, images, js
* Create the following files: index.html, css/style.css, javascript/script.js

## 05 - Create handy shortcuts

Using the `&&` symbols, you can run multiple commands on a single line.

* Create a the same folder structure in a folder called **project103**
* The folder must include a git repository

## 06 - Create your first commit

* Open the index.html in your text editor of choice
* Add the following code `<h1>Hello World!</h1>`
* Commit the changes to your repository (use "Initial Commit")

## 07 - Git log

* Type in Git log and study the log so far
* Make some changes to index.html, by adding: `<h2>I am learning git</h2>`
* Add a commit with the message "Update index.html"
* Type in Git log and see the changes

## 08 - Delete the index.html

* Close the text editor, if it is open
* Delete the index.html file (`rm index.html`)
* Get it back using git (it won't be in the recycle bin)

## 09 - Go back a commit

* Still in the terminal, go back to the first commit, but make sure your changes of index.html are still there.

## 10 - create a branch

* Create a branch called feature/hotdog
* in the style.css file add the following code:

```
body {
  background-color: red;
  color: yellow;
}
```

* Add the code to your repository (by commiting it)
* Switch back to your master branch
* Notice that the style sheet is empty

## 11 - Merging braches

* Merge your branches by typing in:
```
git merge master feature/hotdog
git branch -d feature/hotdog
```

* Type in `git branch` to check you are on the master branch
* Check that your stylesheet contains the hotdog colours.
