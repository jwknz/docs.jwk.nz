# Consuming the API

Now that the api is working, we need to be able to interact with it. A normal user isn't going to use postman - they don't even want to know they are using an API.

## Setting up the project

The purpose of the api is deliver content in such a way that it can be consumed by 1 or more applications. This is why an api should be setup in its own project.

For that reason we are now going to create a new project that consumes our api.

At the moment we have the following structure:

```
root
|--.vscode/
|--api/
|--sql/
|--global.json
|--.git/ # you may not see this folder, but it is there if you use git
|--.gitignore
```

For this project to work we are going to expand it to the following folder structure:

```
root
|--.vscode/
|--api/
|--web/
|--sql/
|--global.json
|--.git/ # you may not see this folder, but it is there if you use git
|--.gitignore
```

!!! note "Separating the project"
    This project is still maintained in a single repository. The main focus is still the api, the web component is a means to make sure people can see an implementation of it.

For this part you will need to be in the `webapi` folder, so you have to type in `cd ..` in the terminal. The prompt should now say `webapi`.

In the api folder we have the actual api, this was created using the `dotnet new webapi -o api` command.

For the web project we are going to use the following command:

```
dotnet new webapp -o web --no-https
```

We are able to use frameworks like react (these templates are offered by dotnet), but let's focus on interacting with the api.

Let's also make sure our api is running:

```
dotnet run -p api
```

Since our terminal is now taken up by the application, we need to open another one.
Just click the `+` symbol at the top of the terminal, if you are using the integrated terminal - this will create another terminal instance.

## Changing some settings in the web project

Next we need to change the port on which the web project runs, since the api takes up port 5000.

In the **launchsettings.json** file, change the port on line 21 from `5000` to `6000`.

If you didn't use the `--no-https` flag when creating the project, you will also need to change `5001` into `6001` for the https port.

Run the project by using `dotnet run` and you will see that you now have 2 dotnet services running.

You can now see your project on https://localhost:6001 or http://localhost:6000

## Cleaning up the project

The webapp template comes with a lot of boilerplate code that we don't need, so let's remove and change some files:

Remove the following files in the Pages folder:

```
About.cshtml
About.cshtml.cs
Contact.cshtml
Contact.cshtml.cs
Error.cshtml
Error.cshtml.cs
Privacy.cshtml
Privacy.cshtml.cs
```

??? note "Index.cshtml file"
    ```
    @page
    @model IndexModel
    @{
        ViewData["Title"] = "API Page";
        ViewData["ApiType"] = "Player Data";
    }

    <h1>@ViewData["Title"]</h1>

    <h2>@ViewData["ApiType"]</h2>

    <div id="data">
        <ul>

        </ul>
    </div>
    ```

Change the Pages/Shared/_Layout.cshtml file into this:

??? note "_Layout.cshtml file"
    ```
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>@ViewData["Title"] - web</title>
        <link rel="stylesheet" href="~/lib/bootstrap/dist/css/bootstrap.css" />
        <link rel="stylesheet" href="~/css/site.css" />
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a asp-page="/Index" class="navbar-brand">web</a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a asp-page="/Index">Home</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container body-content">
            @RenderBody()
            <hr />
            <footer>
                <p>&copy; 2019 - web</p>
            </footer>
        </div>
        @RenderSection("Scripts", required: false)
    </body>
    </html>
    ```

You may notice a few odd symbols - we look at them later, so don't worry about them for now.

## Project Setup

In the **wwwroot** folder is all of our static and public accessible stuff like images, css and javascript files. We won't really touch them, but that is where they are if you need to find them.

In the **Pages** folder are all the dynamic files.
The **.cshtml.cs** files are the View - the things we see in the web browser.
the **.cs** file with the same name is the code-behind for that page.

These pages are reffered to as Razor pages. 
Razor pages still use the Model View Controller Setup, but it is a bit easier to manage them.

## First API Call

Let's get something from our API on the page.

To get something on the page we need to make an api call and that api call is going to return to us a JSON string.

So getting remote data onto our website from an api is done using Javascript - No C# involved here (but we will add some later on).

Add this simple fetch request to your **Index.cshtml** page inside a set script tags.

``` javascript
fetch("https://localhost:5001/api/players")
.then(res => res.json())
.then(data => {
    
    let players = data.map(d => `
        <li>${d.name}</li>
    `)

    document.querySelector("#data > ul").innerHTML = players
})
```

You will get a CORS (Cross-Origin Resource Sharing) error, since your api and web page are on a different URL.

Back in the API project, you will need to enable CORS and for now, we are just going allow it. You will need to tighten up the security when you are in the production stage of your code.

Allowing CORS is easy and it is all done in your **Startup.cs** file.

In the `public void Configure ` method add the following middleware:

```
app.UseCors(options => options.AllowAnyOrigin());
```

and in the `public void ConfigureServices` method add the following:

```
services.AddCors(c =>  
{  
    c.AddPolicy("AllowOrigin", options => options.AllowAnyOrigin());  
});  
```

Recompile your api application by pressing Ctrl+c and then `dotnet run` again.

Refresh your website at http://localhost:6000 (or https://localhost:6001) and you should be good to go and see the name you added when posted some data in the players method when testing the API.

## ViewData Dictionary

Right so back to the C# question and the Razor syntax.

In the model of a razor page (same file name, but with a cs extension) you will see a `Get()` method. Inside of this method you can add the `ViewData` dictionary and do some serverside coding so that you can pass the result onto the View.

At the top of the cshtml file you will see this piece of code:

``` C#
@{
    ViewData["Title"] = "API Page";
    ViewData["ApiType"] = "Player Data";
}
```

Inside of the Model of the page you can code any C# methods and place the value of them inside the ViewData Dictionary.

This can be useful if you want to set the title dynamically or other content.

The idea of clean coding is that you keep your content out of the HTML page, so this way you can keep that from happening.

# @Renders

Inside of a **_Layout.cshtml** file you will see the keyword @Render like:

* `@RenderBody()`
* `@RenderSection("Scripts", required: false)`

The _Layout.cshtml file is the main template for your website and each of the other **.cshtml** file is a section of the main page.

Any bit of code that is common between each page, is placed in the **_Layout.cshtml** page.
Where ever the `@RenderBody()` is placed, the view for the particular URL is placed.

# Conclusion

So now you have it - a complete web api that you can view through a website.

You write the websites backend in C# and you write the front end in whatever you feel like.

* if it is a webpage you just use JavaScript.
* if it a mobile or desktop app, you use whatever the platform offers to parse JSON data.

