# PHP Debugging

You can use VSCode to debug your PHP code and depending on wether you are using Docker or XAMPP, the setup is slightly different. So read the relevant section for you.

In both cases you will need to setup the debugger called xDebug, so we will do that first:

# XAMPP Setup

Run XAMPP and setup a working folder in your XAMPP root folder and adjust the `.htaccess` file accordingly. You can view an example of it [here](https://gist.github.com/to-jk11/51d9190fecc90aa37efa9286391b4642)

Next in the XAMPP control panel click on the **Shell** button and type in:

```
php -i > H:\phpinfo.txt
```

This will create a textfile in your H: drive with the information you need.

Next open up a browser and go to http://xdebug.org/wizard and paste the content of the text file in the textbox that you see in the browser. Click on the "Analyse my phpinfo() output" button.

It will tell you that Xdebug is not installed, so let's do that next.

Under the instructions page, it tells you to download a file - save that file into C:\xampp\php\ext

Next open up the php.ini file that inside of C:\xampp\php\ folder using vscode and paste the following code at the bottom of it:

```
[xDebug]
zend_extension = php_xdebug-2.7.2-7.2-vc15.dll
xdebug.remote_enable = 1
xdebug.remote_autostart=on
```

Save the file and restart the apache server in the XAMPP control panel.

The first part is now setup, next we need to setup vscode - but that is in the next section.

# Docker Setup

Let's assume that for this setup we are using the [php-container-kit](https://github.com/to-jk11/php-container-kit), which is a docker-compose file.

If you are using another container image then you will need to adjust the compose file accordingly.

If you have used this container setup before then you will see that there are 2 new files:

`docker-compose.debug.yml` and `Dockerfile.debug`

To run this setup you will need to stop any current instances of the php-container-kit that you might be running, to free up the ports and then run the following command:

```
docker-compose -f docker-compose.debug.yml up -d --force-recreate
```

This will setup your containers with xdebug enabled.

You can look at the differences in the script here:

??? NOTE "UPDATED Dockerfile"

    ```
    FROM php:7.2.5-apache
    EXPOSE 80
    EXPOSE 443

    RUN mkdir /setups

    COPY ./configs/shell /setups
    COPY ./configs/mods-available/ /usr/local/etc/php/modules/
    COPY ./configs/hostfile /etc/apache2/sites-available
    COPY ./configs/inifiles /usr/local/etc/php/conf.d

    RUN /setups/web-get-install.sh

    RUN pecl install redis-4.0.1 \
        && pecl install xdebug-2.6.0 \
        && docker-php-ext-enable redis xdebug

    WORKDIR /var/www/html
    ```

??? NOTE "UPDATED docker-compose file"

    ```
    version: "3"

    services:
      db: 
        image: mysql:5.7.20
        ports:
          - "3306:3306"
        environment:
          MYSQL_ROOT_PASSWORD: "(password123)" #probably should change this
          MYSQL_DATABASE: "containerdb"
          MYSQL_USER: "user"
          MYSQL_PASSWORD: "user1234"

      web_debug:
        build:
          context: .
          dockerfile: Dockerfile.debug
        volumes:
            - ${PWD}/www:/var/www/html
        ports:
          - "8000:80"
        depends_on:
          - db
        environment:
            XDEBUG_CONFIG: remote_host=host.docker.internal remote_port=9001 remote_enable=1

      phpmyadmin:
        image: phpmyadmin/phpmyadmin
        ports: 
          - "8080:80"
        depends_on:
          - db

    ```

# Updating VSCode

Once the setup above has been completed, you need to configure the debug area in vscode.

First we need to install the php debug extension:

```
code --install-extension felixfbecker.php-debug
code --install-extension felixfbecker.php-intellisense
code --install-extension bmewburn.vscode-intelephense-client
```

Another way to get these is to type in PHP in the extension tab and install the first 3 extensions that pop up.

Next you need to update the launch.json file so that your working directory is linked to the debugger

??? NOTE "USING XAMPP"

    ```
    {
        "version": "0.2.0",
        "configurations": [
        
            {
                "name": "Listen for XDebug",
                "type": "php",
                "request": "launch",
                "port": 9000
            },
            {
                "name": "Launch currently open script",
                "type": "php",
                "request": "launch",
                "program": "${file}",
                "cwd": "${fileDirname}",
                "port": 9000,
                "runtimeExecutable": "C:\\xampp\\php\\php.exe"
            }
        ]
    }
    ```

**FOR XAMPP USERS**

Last thing is to set the PHP path. So create a `settings.json` file inside of the `.vscode` folder and add this to it:

```
{
  "php.executablePath": "C:\\xampp\\php\\php.exe"
}
```

??? NOTE "USING DOCKER"

    ```
    {
      "version": "0.2.0",
      "configurations": [
        {
          "name": "Listen for XDebug",
          "type": "php",
          "request": "launch",
          "port": 9001,
          "pathMappings": {
            "/var/www/html": "${workspaceFolder}/www"
        },
        "xdebugSettings": {
            "max_data": 65535,
            "show_hidden": 1,
            "max_children": 100,
            "max_depth": 5
          }
        }
      ]
    }
    ```

Now we can debug some PHP!!