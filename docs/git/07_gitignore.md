# Gitignore

When using git there are files that we don’t want to be tracked.  
We only want to track the files that we directly use to develop the project.  
Files (like frameworks and libraries) can easily be imported as part of an import process and do not need to be put into version control.  

When developing software we also deal with system files and binary files.  
We want to keep those out of version control as well.  
For this we use **.gitignore**  

Eventually you will know what the files are that you want to include in the **.gitignore** file and the files will be different from project to project, depending on what language(s), framework(s) and libraries you are using.

However there are some common ones are:

`.DS_Store` (a system file on a mac) even if you are on Windows you do not know if other people might use a mac

`.env` This is where you store your environment variables

Anything web include

`node_modules` when creating a website and using npm packages.
`vendor` if you are using php 

Anything dotnet at a minimum include

`bin/`
`obj/`

You can find a list of gitignore files here:

[https://github.com/github/gitignore](https://github.com/github/gitignore)

