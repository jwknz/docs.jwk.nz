# Setup new container

!!! warning "important"
    Stop any current containers you have going this will free up the ports that are in use:

    ``` bash
    docker stop $(docker ps -a)
    ```

    This won't delete them, but it will free up the ports that are used by any containers.

Navigate to your code folder where you want to store you project, this could be your desktop or a designated folder.

``` bash
cd ~/Desktop
```

Set a ENV Variable temporary for the folder name

`FOLDER=<VALUE>` where <VALUE> = the name you want your project to be

!!! note
    ENV Variables, will loose their value when you close the terminal window. There is a way to recreate them, but since we don't want to have this variable permanently setup we won't do that here.

    Every time you want to reference our project, we can just use `$FOLDER` instead of the actual name.

Download the **docker-compose** file

``` bash
curl -LOk https://github.com/to-jk11/php-container-kit/archive/master.zip && unzip master.zip && rm -f  master.zip && mv php-container-kit-master $FOLDER && mkdir -p $FOLDER/www
```

Go into the `<VALUE>` folder:

`cd $FOLDER`

Inside the folder there is a `docker-compose.yml` file.
Run the docker-compose command to get your containers up and running:

`docker-compose up -d`

The **www** folder serves as the root folder of your website. So that is where you put your code files.

You can now open the www in your favourite code editor. (for example `code www`)

!!! note
    The container has been setup with the apache2 rewrite module enabled. This will be important when we start using MVC.