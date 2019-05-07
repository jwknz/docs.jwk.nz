# Setup MVC Project

!!! note "What you need"
    This repository should be loaded in the **www** folder if you are using the [https://github.com/to-jk11/php-container-kit/](https://github.com/to-jk11/php-container-kit/) repository

Download the following files into the www container

!!! tip "Get the MVC Framework"
    ```
    curl -LOk https://github.com/to-jk11/php-mvc-kit/archive/master.zip && unzip master.zip && cd php-mvc-kit-master/ && find . -maxdepth 1 -exec mv {} .. \; && cd .. && rm -rf php-mvc-kit-master && rm -rf master.zip
    ```

A lot happens in the command above, so if you want to know what it does, click on the hint below.

??? note "If you want to know what happens"
    * First we download the repostory that contains all the base code as a zip file

    ```
    curl -LOk https://github.com/to-jk11/php-mvc-kit/archive/master.zip
    ```

    * Next we unzip the master.zip file, which gives us the **php-mvc-kit-master** folder

    ```
    cd php-mvc-kit-master
    ```

    * Then we move all of the files into the parent folder:

    ```
    `find . -maxdepth 1 -exec mv {} .. \;`
    ```

    Ignore the message that says:

    > mv: cannot move `.' to `../.': Device or resource busy

    * Last we go back to the parent folder and remove the php-mvc-kit-master folder and the master.zip file

    `cd .. && rm -rf php-mvc-kit-master && rm -rf master.zip`

Once the framework has been downloaded type in `composer update` and wait while some plugins are installed.

NOTE: use `php composer.phar update` if you are on a mac.

## Setup your git repository

!!! note "Setup Git"
    Next you will need to create your git repository so you can save your work:

    ```
    git init
    ```
    
    Add the remote repository link

    ```
    // If you are using https and have a public repository (uses port 443)
    git remote add origin https://url-to-your-repo

    // If you are using https and have a private repository (uses port 443)
    git remote add origin https://token@username:url-to-your-repo

    // If you are using ssh (uses port 22)
    git remote add origin git@github.com:username/reponame
    ```

    The link "https://url-to-your-repo" is the link to your github repository

Now you can go to [http://localhost:8000](http://localhost:8000) (docker for (your OS)) or [http://192.168.99.100:8000](http://192.168.99.100:8000) (docker toolbox in combination with VirtualBox) and you will see the following screen:

![php-no-model](../../assets/images/php-no-model.png)

!!! note
    When using Docker Toolbox for windows, the URL will be [http://192.168.99.100:8000](http://192.168.99.100:8000)