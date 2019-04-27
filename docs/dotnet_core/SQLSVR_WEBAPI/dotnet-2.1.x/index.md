# Introduction

In this project, we are going to look at how to build a webapi that connects to a MSSQL database.

The idea (and use case) for this api is to be able to connect any (1 or more) application(s) to a database on a remote or local server without having to store any sensitive information within the application itself.

The credentails for the databse will be loaded using environment variables and the system is setup using docker containers, so it is easily deployable.

So let's get started!

!!! attention
    For this tutorial I assume you have the following installed:

    * VSCODE
    * Docker (docker-toolbox or docker for your operating system)
        * You will need to adjust your docker setup or Virtual Box docker VM to support 2GB of RAM to support the MSSQL Server
    * Git (which will give you git bash on Windows)

# Create a new project

Not all of these steps are required, but they are useful and they will help you build a good API (and coding habits) - so treat them as if they are all required.

!!! note

    * When it says "Type in" it means type in the terminal  
    * The `<projectname>` is a placeholder - type in your own name, but do not type in the angle brackets

Type in `git init <projectname>` to create a working directory with a git repository
  
Go into the folder by typing in `cd <projectname>`
  
Type in `dotnet --list-sdks` to check what versions of dotnet core you have installed on your machine. This is required to see if you need to install the version that this tutorial requires. You should see something like this:

!!! info "Output of dotnet --list-sdks"

    ```  
    $ dotnet --list-sdks
    2.1.505 [/usr/local/share/dotnet/sdk]
    2.2.104 [/usr/local/share/dotnet/sdk]
    3.0.100-preview-010184 [/usr/local/share/dotnet/sdk]
    3.0.100-preview3-010431 [/usr/local/share/dotnet/sdk]
    ```

!!! tip
    You can find all of the dotnet core sdks [here][1]  
    But for this tutorial we are working with [this][2] version.

    [1]: https://dotnet.microsoft.com/download/dotnet-core
    [2]: https://dotnet.microsoft.com/download/dotnet-core/2.1

For this tutorial we are going to focus on version **2.1.x**

Next type in `dotnet new global` to create a **global.json** file that you can use to specify what version of dotnet core you will use for the project.

* You will need to open this file in a code editor and change the version number to the version you have on your machine - I have 2.1.5

!!! info "global.json"
    ``` json
    {
      "sdk": {
        "version": "2.1.505"
      }
    }
    ```

Save and close the file.

Now you need to create your project, if you create it before the **global.json** change, you will create a project with the newest version and some of the instructions below may not work.

To create your project type in `dotnet new webapi` to create a new webapi project

Next you will need to create a **.gitignore** file since we don't want to push all our binary and non essential files into our repository.

Open the  the [**.gitignore**][3] file from the official dotnet core repository and paste it into your **.gitignore** file.

[3]: https://raw.githubusercontent.com/dotnet/core/master/.gitignore

Back in the terminal start your project by typing in `dotnet run` and view your site by going to [http://localhost:5000/api/values](http://localhost:5000/api/values)

If you see the a json string with:

!!! info "Output of default api"
    ``` json
    [
      "value1",
      "value2"
    ]
    ```

Then you have a working api project and we can start making the changes we need to connect it to a database.

!!! hint 
    * Do an initial commit to your repository type in:  
    `git add .` followed by  
    `git commit -m "Initial Commit"`

    Making regular commits allows you to revert back to previous version of your code if you make an error.

# Setting up the database

At the moment we have installed the dotnet sdk on our machine and this is the easiest since we can just run the `dotnet` commands from our terminal.

However to run a MSSQL Server you will either need to go through a tedious installation process, if you are on a Windows machine or else you are out of luck.

That is until Microsoft embraced the world of containers and allows us to install it as part of a docker container.

So in your terminal (or docker-toolbox for windows git bash terminal) type the following in to download the 2017 version of MSSQL Server

```
docker pull mcr.microsoft.com/mssql/server:2017-latest-ubuntu 
```

After the download is complete type in:

```
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(*)Password' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu 
```

The passwork is set to `yourStrong(*)Password` which is the default password with the ! changed into an * - needless to say, you should probably change this, but it would be bad if I document my passwords here :-)

Once that you have run that command, you mssql server is up and running, so let's leave that sitting there for the moment.

!!! success
    If all of the stuff above went well, you now have your development environment setup. We will talk about setting up the production side of things later, but let's write some code ...

![Let's Code](https://memegenerator.net/img/instances/42970028/enough-talk-lets-code.jpg)

# Populating our Database with some data

We now need to open our project in our code editor, so type in:

``` bash
# if you are already in your project folder
code .

# if you are in its parent folder
code <projectname>
```

This will open the project in Visual Studio Code.

Create a folder called **sql** and add 2 files to that folder, call the files **tables.sql** and **data.sql** respectively.

You can view a set of SQL files in the code repository the table structure can be found [here][4] and the data for part of the database can be found [here][5]

[4]: https://github.com/to-jk11/SQLSVR-WEBAPI/blob/master/sql/tables-nofk.sql

[5]: https://github.com/to-jk11/SQLSVR-WEBAPI/blob/master/sql/data.sql

Copy the contents of the files into your project files.

Next we need to install an extension so we can execute code, since vscode detected that you are creating sql files, it may have already prompted you to install it. Since we are working with MSSQL it will be the right extension. (Do not install this extension if you are working with MySQL)

In any case, if you missed the prompt or it didn't happen, you can type this in the terminal to install it.

```
code --install-extension ms-mssql.mssql
```

After the install is complete, you will need to connect vscode to your data base, which you can do like this:

<video src="https://d2ddoduugvun08.cloudfront.net/items/2Y0H1e0Z0w1h2z3p2U1l/vscode-setup-mssql-database-connection.mov" controls style="display: block;height: auto;width: 100%;">vscode-setup-mssql-database-connection.mov</video>

!!! note
    If you are using docker toolbox, then your docker containers are inside of a Virtualbox VM.  

    Instead of typing in localhost, you will need to type in the VM's ip address, which is: `192.168.99.100`

<br>

Once you have the connection setup, go to the sql files and right click and select `Execute Query`

Do this for the **tables.sql** first and then the **data.sql**

You should see the results of the queries pop up in the side pane on the right, which you can close afterwards.

!!! warning
    The above steps assume your database is still running in the docker container. So if you have any errors, check that first by typing in `docker ps -a` into the terminal

# SETUP EF Core (Entity Framework)

Entity Framework is part of the dotnet family and allows for super easy integration of a database to an application, may it be web based or otherwise.

There are 2 approaches you can take:  
1) Code First or  
2) Data First. 

Since we already have a database, let's look at the **Data First** option.

Copy the `ItemGroup` tag below and paste it in the **.csproj** file of your project.

!!! note 
    These packages are aligned to work with dotnet core 2.1.x, so these will need to be updated if you are using a newer version.

    ```
    <ItemGroup>
      <PackageReference Include="Microsoft.AspNetCore.App" />
      <PackageReference Include="Microsoft.AspNetCore.Razor.Design" Version="2.1.2" PrivateAssets="All" />
      <PackageReference Include="Microsoft.EntityFrameworkCore" Version="2.1.1" />
      <PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="2.1.1" />
      <PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer.Design" Version="1.1.6" />
      <PackageReference Include="Microsoft.EntityFrameworkCore.Tools" Version="2.1.1">
        <IncludeAssets>runtime; build; native; contentfiles; analyzers</IncludeAssets>
        <PrivateAssets>all</PrivateAssets>
      </PackageReference>
    </ItemGroup>
    ```

Type in `dotnet restore` to install the nuget packages.

Create a folder called **Models** and then run this command to have it create all the models for you.

!!! note
    You will need to change the credentials to suit your setup.
    The DB Context is related to the sql files above, this woudl obviously be different if you are working on your own project.

    ```
    dotnet ef dbcontext scaffold "
    Server=localhost;
    Database=Rugby7db;
    User=sa;
    Password=yourStrong(*)Password;" Microsoft.EntityFrameworkCore.SqlServer -o Models -f -c Rugby7Context 
    ```

!!! success
    So now that the database and models are setup, we are able to get to coding the API.