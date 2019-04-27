# Create a new project

Not all of these steps are required, they are useful and they help you build a good API - so treat them as if they are all required.

* Run `git init <projectname>` to create a working directory with a git repository

* Go into the folder by typting in `cd <projectname>`

* Run `dotnet --list-sdks` to check what versions of dotnet core you have installed on your machine.

* Run `dotnet new global` to create a **global.json** file that you can 

* Run `dotnet new webapi` to create a new webapi project

* Add a **.gitignore** file

!!! note

    Adding a **.gitignore** file makes sure that you only commit the code that you need to commit. You will still have some details related to your setup that are important - like your database connection string (which we will get to later), so make sure that you write those down somewhere* 

Download the **.gitignore** file from the link below and paste into your project.

```
https://raw.githubusercontent.com/dotnet/core/master/.gitignore
```

* Run the base project by typing in `dotnet run` and view your site by going to [http://localhost:5000/api/values](http://localhost:5000/api/values)

* Do an initial commit to your repository `git add .` && `git commit -m "Initial Commit"`

!!! hint 
    Making regular commits allows you to revert back to previous version of your code if you make an error.

# Setup your docker environment

Download SQL Server based on ubuntu

```
docker pull mcr.microsoft.com/mssql/server:2017-latest-ubuntu 
```

Run your database on your machine

```
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(*)Password' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu 
```

# SETUP EF

Entity Framework is part of the .net family and allows for super easy integration of a database to an application, may it be web based or otherwise.

There are 2 approaches you can take: 1) Code First or 2) Data First.
Since we already have a database, let's look st the Data First option.

Copy the `ItemGroup` tag below and paste it in the **.csproj** file of your project. Run `dotnet restore` to install the nuget packages.

*Note: These packages are aligned to work with dotnet core 2.1.x, so these will need to be updated if you are using a newer version.*

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

Create a folder called **Models** and then run this command to have it create all the models for you.

*Note: You will need to change the credentials to suit your setup.*

```
dotnet ef dbcontext scaffold "Server=localhost;Database=Rugby7db;User=sa;Password=yourStrong(*)Password;" Microsoft.EntityFrameworkCore.SqlServer -o Models -f -c Rugby7Context 
```

```
Environment="ASPNETCORE_ENVIRONMENT=Development" "ConnectionStrings__Development='Server=localhost;Database=Rugby7db;User=sa;Password=yourStrong(*)Password;'"
```