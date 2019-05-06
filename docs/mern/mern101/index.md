# MERN101

## Setup

Setup a Folder into an ENV (Environment Variable)

``` bash
FOLDER=MERN101
```

Clone the following repository to get your setup

``` bash
curl -LOk https://github.com/to-jk11/mern101-pg/archive/master.zip && unzip master.zip && rm -f  master.zip && mv mern101-pg-master $FOLDER
```

You should now have a folder called MERN101 (or whatever you called it and inside of there you should have the following folder structure:

``` bash
root/
|--- .vscode
|--- express
|--- mongodb
|--- react
|--- .gitignore
```

## Install Extensions

In the project there is an `extensions.json` file which has some recommended extensions for this project.

To install there do the following:

1. Open the MERN101 project in VSCODE 
2. Open the Extension tab (5th one down)
3. Type in `@recommended ` in the search bar and install or enable to those extensions if they are not already.
4. Restart vscode if you are being asked too (later versions don't require this)

Keep VSCODE open - we won't be leaving it anytime soon :-)

## Change your terminal into Bash

All the commands listed below will work with Bash - but not necessarily with Powershell, therefore if you are on Windows, open up the file **settings.json** in the .vscode folder and uncomment the terminal line.  
  
After this you will need to trash any terminal sessions you have open to see the bash terminal.

## NPM Install

The repository does not come with any of the remote packages installed - so let's do that first.

1. Go into the mern folder => `cd react`
2. Install node packages => `npm i`

## Start the Mongodb server

1. Go up one folder => `cd ..`
2. Navigate into the mongodb folder = `cd mongodb`
3. Start the mongod server => `mongod --config mongo.conf`
4. Terminal window in VSCode is now taken up by the mongod server, so click the `+` symbol to open another one.

## Viewing your database files

1. In the left bar of VSCode you should see an icon that looks like the Azure logo. (it is a triangle shaped letter A)
2. From here you should be able to connect to the database by clicking on the "Attached Database Accounts" and then "Attach Database Account..."
3. The Wizard will take your through the connection steps. 
4. Select MongoDB from the list and after that you won't need to change anything.

## Setup a user and structure for your database

In a fresh bash shell (remmember that `+` you clicked) 

You can then load the setup file that you find in the mongodb folder.

``` bash
mongo mongo-script setup.js
```

After this you can refresh your db connection in the azure extension and see that the db, collections and user has been created.

## Setup Express

To be able to view our data on a webpage, we need to setup a webserver. We do this using express and node. (The N and E of MERN)

If we go back to the MVC model, then this section is setting up the Controller and the Model.

Inside of our express, we are going to create a number of api endpoints and then access those later in React - which will serve as the View.

In the express folder, there is a **package.json** file, which contains the packages that we need to install. 

1. Make sure you are in the root folder of this project.
2. To check if you are, type in `ls -la` and you should see the above mentioned root directory structure.

``` bash
drwxr-xr-x  13 jeff_mba  staff  416  5 May 19:57 .git
-rw-r--r--   1 jeff_mba  staff   49  5 May 17:39 .gitignore
drwxr-xr-x   4 jeff_mba  staff  128  5 May 18:05 .vscode
drwxr-xr-x   3 jeff_mba  staff   96  5 May 20:00 express
drwxr-xr-x   6 jeff_mba  staff  192  5 May 18:41 mongodb
drwxr-xr-x   9 jeff_mba  staff  288  5 May 17:39 react
```

3. Go into the express folder => `cd express` (everything in this section will be in that folder unless otherwise specified)

4. Install the node packages => `npm install`
5. The rest we need to manually setup.

Now we need to setup express, as part of the recommended extensions you will have installed or enabled the express snippets extensions.

## Setup Server.js

Next create an **server.js** file and use the `ex4` followed by the <TAB> key to give yourself an express template. You will need to make the following changes:

1. On Line 3 add `const port = 4000` - react will run on port 3000 later
2. On Line 10 (probably) replace the console.log with this => 

``` javascript
console.log(`Server running on port ${port}`);
```

3. Remove the commented line on line 13 (again probably)

Test that your app runs correctly, by typing in `npm start` in the terminal - this will start the express server using nodemon. (use `npm i -g nodemon` if you haven't got this installed)

Using the browser preview (by clicking on in the left tab) you should be able to navigate to [localhost:4000/](localhost:4000/) and see `Hello World` on the screen.

## Creating our Database Models

Create a folder and a file in the express folder => `mkdir config && touch config/keys.js`

Inside of the **keys.js** file add the following code:

``` javascript
module.exports = { 
    mongoURI: "mongodb://admin:admin123@localhost:27017/students" 
}
```

Next we need to create our Model files:

``` bash
mkdir Models
touch Models/names.js
touch Models/subjects.js
```

In these files, we create the models that we need to match our database

Here is the schema for the names collection - you will need to create the schema for the subjects yourself.

``` javascript
// Schema definition file for our colour collection data 

var mongoose = require('mongoose'); 
var Schema = mongoose.Schema; 

//create a schema description of our color document structure 
const namesSchema = new Schema(
  { 
    "_id": Number, 
    "name": String
  },
  {collection: "names"}, 
  {versionKey: false}
); 
    
module.exports = Names = mongoose.model('Names', namesSchema);
```

## Connecting Express to Database

Before we create the api, let's make a small adjustment to our **server.js** file

Replace this code:

``` javascript
app.get('/', (req, res) => {
  res.send('Hello World!');
});
```

With this:

``` javascript
const mongoose = require('mongoose');
const bodyparser = require('body-parser');

const namesroute = require('./routes/api/namesroute');
const subjectsroute = require('./routes/api/subjectsroute');

app.use(bodyparser.json());

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.use('/api/names', namesroute );
app.use('/api/subjects', subjectsroute );

const db = require('./config/keys').mongoURI;

mongoose.connect( db, {useNewURLParser: true})   
    .then( function(){ 
        console.log('MongoDB connected...');   
    })   
    .catch( function( err ){ 
        console.log( err )   
    });
    
app.get('/', (req, res) => {
    res.json({reply:'Route for HOME path.'});
});
```

In the abovde code, we are adding the mongoose and bodyparser middelwares. We are also setting up our api endpoints and connecting to our database.

The last part for our server is to add our API routes.

## Setting up our API CRUD endpoints

Still in our express folder, create a new folder called routes and then another folder called api.

``` bash
mkdir -p express/api
```

Inside of this folder create 2 files:

``` bash
touch routes/api/namesroute.js
touch routes/api/subjectsroute.js
```

Again - just like with the model - I will show you the names route and you have to create the subjects route.

At the top of a route file type in:

``` javascript
const express = require('express');
const router = express.Router();

const names = require('../../models/names');
```

You won't need to do an npm install for this, since the router is build into express.

Each of the endpoints that we cover below we add start with the following comments:

``` javascript
//@route    GET /api/names
//@desc     Get all Names from the DB
//@access   Public
```

We need these, so we can easily identity what each of the routes do for us.

Each of the route endpoints is placed after the endpoint set in the **server.js** file

For example - when we define `/` we get there by typing in `/api/names/` as the url.

Each of the route endpoints is setup as a javascript promise inside of a javascript object.


### Get Methods


``` javascript
//@route    GET /api/names
//@desc     Get all Names from the DB
//@access   Public
router.get('/', function( req, res){  
    names
    .find() 
    .sort({name: 1})  
    .then( function( name ){ 
        res.json( name ); 
    }) 
    .catch( function( err ){ 
        console.log( err ); 
    }) 
});
```

In the above code we do the following:

1. Set the route
2. Set the name of the collection
3. use the `find()` method that finds all the data
4. sort the data in ascending order
5. present the data to us in json format OR gives us information if there is an error

If we have a look at find a single piece of data, the setup is very similar:

``` javascript
//@route    GET /api/names/:names
//@desc     Get all Names from the DB matching the parameter
//@access   Public
router.get('/:name', function( req, res){  
    names
    .find({name: req.params.name}) 
    .sort({name: 1})  
    .then( function( name ){ 
        (name === 0) ? res.json({"msg": `${req.params.name} does not exist`}) : res.json( name );
    }) 
    .catch( function( err ){ 
        console.log( err ); 
    }) 
}); 
```

In the above code we do the following:

1. Set the route
2. Set the name of the collection
3. use the `find({name: req.params.name})` method that finds the data matching the name
4. sort the data in ascending order
5. present the data to us in json format OR gives us information if there is an error


For the other routes, we need to deal with the object schema we created earlier:

### For the POST Method

For post we need to read incoming data - this is done using the `req.body` property.

``` javascript
//@route    POST /api/names/
//@desc Add a new Name to the DB 
//@access Public 
router.post('/', function( req, res){ 

    let newName = new Names(req.body);
        
    newName
    .save(newName)
    .then(() => {
        res.json({
            success:'Name Added'}); 
        })
    .catch(err => {
        res.status(404).json({
            error: err
        })
    })

});
```

In the above code we do the following:

1. Set the route
2. Instantiate the info from `req.body` to a new Names object
3. With the new object we call the save function and pass in the object.
4. Return a success message if the object was added successfully OR an error message


### For the DELETE Method

To delete a record we need to know the id.

``` javascript
//@route    DELETE /api/names/:id
//@desc     Delete a name from the DB by _id key 
//@access   Public (should be secured) 
router.delete('/:id', function( req, res){  

    names
    .findByIdAndDelete(req.params.id)
    .then(name => {
        name.remove();
        res.json({
            success:'Name Deleted'}); 
        })
    .catch(err => {
        res.status(404).json({
            error: err
        })
    }) 

}); 
```

In the above code we do the following:

1. Set the route
2. Find the record that matches the id
3. Delete the matching record
4. Return a success message if the object was removed successfully OR an error message

### For the Update Method 

For the update method, you will need an id - so only a single object is updated and the content from the form.

```
//@route    UPDATE /api/names/:id
//@desc     Update a Name from the DB by _id key 
//@access   Public (should be secured) 
router.put('/:id', ( req, res) => {

    names
    .findByIdAndUpdate(req.params.id, req.body)
    .then(name => {
        name.set(req.body)
        res.json({
            success:'Name Updated'}); 
        })
    .catch(err => {
        res.status(404).json({
            error: err
        })
    })

});
```

In the above code we do the following:

1. Set the route
2. Find the record that matches the id
3. Call the set method and pass in the `req.body` information.
4. Return a success message if the object was removed successfully OR an error message

At the end of a router file you need to export it:

``` javascript
module.exports = router;
```

Now the api has been completed and you can check it in a tool like postman, or inside VSCode itself with an extension we installed earlier.

Create a new folder inside the express folder called requests and inside of it a file with an `.http` extension. For example: `get.http`

Make sure your server is up and running with nodemon and then in the **get.http** file type in:

``` bash
GET http://loclahost:4000/api/names/
```

and then you can run it by right clicking on the code area and select "Send Request"

The result of the request should now appear on the right side of the editor.

# Adding React

At this stage I would suggest creating another branch in your git reposiotry, because we are now going to add the View.

In a later class, we can then create a different branch and add other view using Angular.

``` bash
git checkout -b react master
```

You will notice you are now in that branch when you look at the bottom left of the editor.

Now there is already a react folder here, but if there wasn't we would now go back to our webroot folder and type in:

``` bash
create-react-app react
```

Since we already have it, go into the folder and make sure everything is setup correctly.

At this stage, you should still have your mongodb running, so open a new terminal by clicking on the `+` symbol and type in:

``` bash
npm install
```

Then you can start the app by running:

``` bash
npm start
```

Now you should be able to see both the express server and the react app in the browser by typing in http://localhost:4000 and http://localhost:3000 respectively.

To be able to use the data from a database we need to know a little about life cycles.

React has a few of them, but for this part we will only look at one.

``` javascript
componentWillMount()
```

What this allows us to do is do some data processing - like a fetch request - before the component mounts and then we can see the data displayed properly.

A lifecycle is placed within the component under the state, but above the render function.


The code for the lifecycle we need is:

``` javascript
  state = {
    data : []
  }

  getAllTheNames() {
    return fetch('http://localhost:4000/api/names')
    .then(resp => resp.json())
    .then(data => this.setState({data: data}));
  }

  componentWillMount()
  {
    this.getAllTheNames()
  }
```

Now if we copy and paste this into our App function, this won't work - because react functions are stateless. So after removing everything we don't need from our component

Change this:

``` javascript
import React from 'react';
import './App.css';

function App() {

  return (
    <div className="App">

    </div>
  );
}

export default App;
```

Into this:


``` javascript
import React, {Component} from 'react';
import './App.css';

class App extends Component {

  state = {
    data : []
  }

  getAllTheNames() {
    return fetch('http://localhost:4000/api/names')
    .then(resp => resp.json())
    .then(data => this.setState({data: data}));
  }

  componentWillMount()
  {
    this.getAllTheNames()
  }

  render() {
    return (
      <div className="App">
        <h1>Student Names</h1> 
        <ul>{this.state.data.map(n => <li>{n.name}</li>)}</ul>
      </div>
    );
  }
}

export default App;

```

Now we have come full circle and see how we connect a database to a react app.




