# Setup new container

!!! danger "IF YOU ARE USING DOCKER-TOOLBOX FOR WINDOWS"
    For Docker Toolbox for Windows to be able to share it's files with the host machine to the container, the container **MUST** be placed inside the **`C:\Users\**`** folder.

    So create a folder called `docker` inside `C:\Users\<your username>\` otherwise you cannot make this work.

!!! warning "important"
    Stop any current containers you have going this will free up the ports that are in use:

    ``` bash
    docker stop $(docker ps -a)
    ```

    This won't delete them, but it will free up the ports that are used by any containers.

Navigate to your code folder where you want to store you project, this could be your desktop or a designated folder.

!!! note ""
    ``` bash
    cd ~/Desktop

    // **REMEMBER IF YOU ARE USING DOCKER TOOLBOX FOR WINDOWS**
    cd /c/Users/<username>/docker
    ```

Set a ENV Variable temporary for the folder name

`FOLDER=<VALUE>` where <VALUE> = the name you want your project to be

!!! note
    ENV Variables, will loose their value when you close the terminal window. There is a way to recreate them, but since we don't want to have this variable permanently setup we won't do that here.

    Every time you want to reference our project, we can just use `$FOLDER` instead of the actual name.

Download the **docker-compose** file

!!! note ""
    ``` bash
    curl -LOk https://github.com/to-jk11/php-container-kit/archive/master.zip && unzip master.zip && rm -f  master.zip && mv php-container-kit-master $FOLDER && mkdir -p $FOLDER/www
    ```

Go into the `<VALUE>` folder:

!!! note ""
    ```
    cd $FOLDER
    ```

Inside the folder there is a `docker-compose.yml` file.
Run the docker-compose command to get your containers up and running:

!!! note ""
    ```
    docker-compose up -d
    ```

The **www** folder serves as the root folder of your website. So that is where you put your code files.

You can now open the www in your favourite code editor. (for example `code www`)

Next you will need to install composer which you can do here:

!!! note "Download for windows"
    [Composer for Windows](https://getcomposer.org/Composer-Setup.exe)

!!! note "Download for Mac"

    Copy each of these lines into your terminal
   
    ```
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    
    php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    
    php composer-setup.php
    
    php -r "unlink('composer-setup.php');"
    ```


!!! note
    The container has been setup with the apache2 rewrite module enabled. This will be important when we start using MVC.