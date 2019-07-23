# Setup new container

!!! danger "IF YOU ARE USING DOCKER-TOOLBOX FOR WINDOWS"
    For Docker Toolbox for Windows to be able to share it's files with the host machine to the container, the container **MUST** be placed inside the **`C:\Users\**`** folder.

    So create a folder called `docker` inside `C:\Users\<your username>\` otherwise you cannot make this work.

    To create the docker folder do this:

    1. type in cd `/c/Users/<username>/`
    2. create the docker folder `mkdir docker`
    3. go into the folder `cd docker`

    Once you have done this once, in the future you can simply go to the folder by typing in:

    `cd /c/Users/<username>/docker` (THIS IS CASE SENSITIVE)

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

!!! warning ""

    When using Virtualbox, there are some extra settings you need to do before this works.

    Use the docker-toolbox terminal to stop the docker-machine - type in:

    * `docker-machine stop`

    You can confirm that the VM has stopped by opening up the Virtualbox Window.

    * Create a folder on your H: Drive - called docker

    * Next open CMD prompt (not the docker toolbox terminal)

    * Type in each of the following commands (or copy / paste them)

    1. `C:`
    2. `cd "Program Files\Oracle\Virtualbox"
    3. `VBoxManage.exe sharedfolder add default --name "h/docker" --hostpath "\\?\h:\docker" --automount`
    4. `VBoxManage.exe setextradata default VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root 1`
    5. `VBoxManage.exe setextradata default VBoxInternal2/SharedFoldersEnableSymlinksCreate/h/docker 1`

    Close the CMD window and go back to the Docker Terminal Window

    * Type in `docker-machine ssh default`

    Next type in:

    1. `sudo mkdir --parents /h/docker`
    2. `sudo mount -t vboxsf h/docker /h/docker/`
    3. `exit`

    Now you can run the curl command below from your H: Drive.

    For reference you can read up on it [here](https://blog.shahinrostami.com/2017/11/docker-toolbox-windows-7-shared-volumes/)

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