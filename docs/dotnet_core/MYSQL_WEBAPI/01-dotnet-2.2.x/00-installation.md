# Project Setup

For our database, we are going to use XAMPP - which is already installed on your machine. If you want it on your own machine at home you can download it from apachefriends.org.

The main difference is that at tech you will be using `localhost:9080` instead of `localhost:80` to access your website

When starting XAMPP for the first time you will need to choose a language - I recommend the american flag :-D

![Setup](images/Setup01.png)

If all goes well, you should see the following screenshot

![Setup](images/Setup02.png)

Click on the start button for Apache and MySQL - the others should be greyed out.

![Setup](images/Setup03.png)

Inside of the meca_stack folder create a new project by typing in:

```
dotnet new webapi -o meca_api --no-https
```

![Setup](images/Setup04.png)

Inside of the `meca_api` folder paste the following lines to install the relevant nuget packages:

```
dotnet add package Pomelo.EntityFrameworkCore.MySql --version 2.2.0
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.Extensions.Configuration.UserSecrets --version 2.2.0
```

![Setup](images/Setup06.png)

Check that your project runs by running `dotnet run`

![Setup](images/Setup07.png)

Open up vscode and have a look at the meca_api.csproj file - you should see the nuget packages that have been added.

![Setup](images/Setup08.png)

Check and install the following extensions:

![Setup](images/Setup09.png)
![Setup](images/Setup10.png)
![Setup](images/Setup30.png)
![Setup](images/Setup25.png)
![Setup](images/Setup26.png)
![Setup](images/Setup27.png)
![Setup](images/Setup28.png)

Create a `.gitignore` file and add the following content in it from this page:

[https://github.com/github/gitignore/blob/master/VisualStudio.gitignore](https://github.com/github/gitignore/blob/master/VisualStudio.gitignore)

![Setup](images/Setup11.png)

![Setup](images/Setup12.png)

# Adding sql files to the database

Go to [http://localhost:9080/phpmyadmin](http://localhost:9080/phpmyadmin) or click on the admin button next to mysql in the xampp panel


![Setup](images/Setup13.png)
![Setup](images/Setup14.png)
![Setup](images/Setup15.png)

You can find the sql files here

[https://gist.github.com/to-jk11/d714208f3036f80e566abbfdf70b4149](https://gist.github.com/to-jk11/d714208f3036f80e566abbfdf70b4149)

![Setup](images/Setup17.png)
![Setup](images/Setup18.png)

![Setup](images/Setup19.png)
![Setup](images/Setup20.png)
![Setup](images/Setup21.png)
![Setup](images/Setup22.png)

We are using EF scafholding to setup our models

```
dotnet ef dbcontext scaffold "Server=localhost;Database=postdb;User=root;" Pomelo.EntityFrameworkCore.MySql -o Models -f -c PostDBContext 
```

![Setup](images/Setup23.png)

![Setup](images/Setup24.png)

![Setup](images/Setup29.png)


# Basic Contoller

```
namespace People.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PeopleController : Controller
    {
        private readonly PostDBContext _context;

        public PeopleController(PostDBContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TblPeople>>> GetTblPeople()
        {
            
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TblPeople>> GetTblPeople(int id)
        {   

        }

        [HttpPost]
        public async Task<ActionResult<TblPeople>> PostTblPeople(TblPeople item)
        {

        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutTblPeopleItem(short id, TblPeople item)
        {

        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTblPeopleItem(int id)
        {

        }
    }
}
```

# Connection String

```
{
    "ConnectionStrings": {
        "DefaultConnection": "Server=localhost;Database=postdb;User=root;"
    },
    "Logging": {
    "IncludeScopes": false,
    "LogLevel": {
        "Default": "Warning"
    }
  }
}
```

# Add to Startup.cs

```
public Startup(IHostingEnvironment env)
{
    var builder = new ConfigurationBuilder()
        .SetBasePath(env.ContentRootPath)
        .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
        .AddEnvironmentVariables();
    Configuration = builder.Build();
}
```

Put this in the `ConfigureServices(IServiceCollection services)` method:

```
services.AddDbContext<PostDBContext>( 
options => options.UseMySql(Configuration.GetConnectionString("DefaultConnection"), // replace with your Connection String
    mySqlOptions =>
    {
        mySqlOptions.ServerVersion(new Version(5, 7, 20), ServerType.MySql); // replace with your Server Version and Type
    }
));
````

If all goes well - your api should run now.