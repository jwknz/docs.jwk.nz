# Introduction

In this part we are going to look at creating a CRUD api that is connected MSSQL.

This part will dive right into creating the api controller. So if you need to setup the project,read [part 1](/dotnet_core/sqlsvr_webapi/dotnet-2.1.x/01-project-setup) first.

# The Models

When looking at creating an API, the design pattern closely follows the one of an MVC paradigm - but it doesn't include the V (View).

We still have **controllers** and we still need **models** we created these in part 1.

The main part to point out is that Models are normal POCO (plain old class objects) files, but only include properties - there are no methods, fields, constructors etc. of any kind in these files.

## DBContext

When creating your models using Entity Framework you also create a DBContext, in this demo we created one called Rugby7Context.

In this file we have a method that creates our models, it reads the structure of our SQL tables and then using a **ModelBuilder** it creates our model classes, which contain all of our column names and their properties.

!!! warning
    If you need to make a change to your table, you can do so, but you also need to rerun the ef scafholding command. These would be the steps to take:

    1. Make changes to your SQL file
    2. Recreate the table structure
    3. Run the EF Scafholding command (in part 1)

# The Controller

The Controllers are the beasts in the api, they can be big complex files depending on the table structure you have in your database.

Let's break down a few basics:

## The Controller Name

Each Controller matches a **single** model - no more no less.

Each Model is linked to a single table in the SQL database - no more no less.

Each Controller inherites from the `ControllerBase` class, where the different Route routes are defined.

To make sure that each Controller knows it is specific for a web api, we need to add some attributes to the class and its methods.

Just above the class we need these 2 attrinbutes

| API Attribute | Definition |
| :--- | :--- |
| `[ApiController]` | This indicates that we are creating an API |
| `[Route("api/[controller]")]` | Sits above the ApiController and defines the route we need to view our data |

Inside the class above each of the routing methods, we need to place these.

| API Attribute | Definition |
| :--- | :--- |
| `[HttpGet]` | Used for a Get method, returns all the data in the api for this controller |
| `[HttpGet]("{id}")` | Same as an HttpGet attribute, but only returns the data for a specific id, which corrolates to a row of the table in the database. |
| `[HttpPost]` | Add data to our database, this takes an instance of the model as a parameter. |
| `[HttpPut("{id}")]` | Update an existing item in the database, this takes 2 parameters - 1 for the id that needs to be updated and 2 an instance of the model to process the properties.
| `[HttpDelete("{id}")]` | Removes the item with the selected id, so that will need to be passed in as the parameter to the method. |

Next up we need instantiate the model context that matches the controller:

!!! note "Setting up the context"
    ``` C#
    private readonly Rugby7Context _context;

    public PlayersController(Rugby7Context context)
    {
        _context = context;
    }
    ```

    In the code above, the Context and Controller are matching the code given with the sql file - again if you are using different data then your project then you will need to change that.

The only other thing that the controller contains are the routing methods - anything not related to the routing is not included in this class.

Any helper methods should be included in a seperate class to keep things clean.

### The HttpGet Method

!!! note "Demo Code"
    ``` C#
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Players>>> GetPlayers()
    {
        return await _context.Players.ToListAsync();
    }
    ```

* The `HttpGet` is the simplest of all, you define that you want a method that returns `IEnumerable<ModelName>` and call it give it a meaningful name like: `GetPlayers()`

* You then just return the context with the model class convert it to a List

### The Single ID HttpGet Method

!!! note "Demo Code"
    ``` C#
    [HttpGet("{id}")]
    public async Task<ActionResult<Players>> GetPlayer(long id)
    {
      Players item = await _context.Players.FindAsync(id);

        if (item == null)
        {
            return NotFound();
        }

        return item;
    }
    ```

* First we need to see if the id is in the database and if it isn't we need to return that message to the api user. 

* If it does exist then return that object to the api user. Since we are only returning a single instance, we don't need to return it as a list.

### HttpPost Method

!!! note "Demo Code"
    ``` C#
    [HttpPost]
    public async Task<ActionResult<Players>> PostPlayer(Players item)
    {
        _context.Players.Add(item);
        await _context.SaveChangesAsync();

        return CreatedAtAction(
          nameof(GetPlayers), 
          item);
    }
    ```

* We can only ever add a single object to the database

* The item gets added and is saved to the databse

* The object details are returned to the api user


### HttpPut Method

!!! note "Demo Code"
    ``` C#
    [HttpPut("{id}")]
    public async Task<IActionResult> PutTodoItem(short id, Players item)
    {
        if (id != item.PlayerId)
        {
            return BadRequest();
        }

        _context.Entry(item).State = EntityState.Modified;
        await _context.SaveChangesAsync();

        return Content("Player has been updated");
    }
    ```

* First we check if the id argument exists in the database and if it doesn't the request is cancelled.

* If the id does exists the `EntitySate` uses the Modified property to flag any changes

* The data is then updated and saved

* We return a message to the API user

!!! Warning
    There are a couple of things to watch out for when updating data:

    * If your SQL code does not have an id columnn called id, then you will need to pass in the id property in your data

    * You will need to pass in the id you want to update in the URL, otherwise it will update all of the data that

### HttpDelete Method

!!! note "Demo Code"
    ``` C#
    public async Task<IActionResult> DeleteTodoItem(short id)
    {
        Players player = await _context.Players.FindAsync(id);

        if (player == null)
        {
            return NotFound();
        }

        _context.Players.Remove(player);
        await _context.SaveChangesAsync();

        return Content("Player has been removed");
    }
    ```

* The first part is the same as what you have seen in the `HttpGet("{id}")` method.

* If the record is found, it is removed

* The api user gets a message

## General Notes:

So that is all you need to do to create a simple api and because we use the entity framework, the `context` does all the heavy lifting for you.

Even so - there a couple of things to note:

* the Get Methods, return data from the database, this will be in JSON format by default.

* the Post, Put and Delete method don't return anything by default, but you still need to inform the api user. For this we can use the `Content()` that takes string. 

  * It would be nice to return a string that is formatted in JSON format, so use something like `"{msg: user has been updated}"`

