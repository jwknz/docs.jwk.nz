# Consuming the API

Now that the api is working, we need to be able to interact with it. A normal user isn't going to use postman - they don't even want to know they are using an API.

## Setting up the project

The purpose of the api is deliver content in such a way that it can be consumed by 1 or more applications. This is why an api should be setup in its own project.

For that reason we are now going to create a new project that consumes our api.

At the moment we have the following structure:

```
root
|--api
|--sql-server
|--global.json
|--.git
|--.gitignore
```

For this project to work we are going to expand it to the following folder structure:

```
root
|--api
|--web
|--sql-server
|--global.json
|--.git
|--.gitignore
|--webapi.sln
```

!!! note "Separating the project"
    This project is still maintained in a single repository. The main focus is still the api, the web component is merly a service to make sure people can see an implementation of it.

In the api folder we have the actual api, this was created using the `dotnet new webapi -o api` command.

For the web project we are going to use the following command:

```
dotnet new webapp -o web
```

We are able to use frameworks like react (these templates are offered by dotnet), but let's focus on interacting with the api.

