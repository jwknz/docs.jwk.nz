# Using React to create a form

In side of the MERN folder - you could use the react folder, but to keep things separate we are going to use a new project.

So navigate to the MERN folder we have been working in and type in:

```
npx create-react-app simple-crud-form
```

This will create a react application inside a folder called `simple-crud-form`.

Since it is in the mern folder it will be added to the git repository of that folder - so that shouldn't be an issue.

# Start up Express and MongDB

If you start on this page without going through the steps of [this one](./02-quick-setup) you will need to set that up first, so go do that first and then read on...

You should be able to see your api running on port 5000, on `http://localhost:5000/api/names`

# The React app

In the react project we need to install a couple of things and delete some others, so do the following:

1. Install the packages for the project, we will bulk install the lot and refer to them later on

```
npm i react-bootstrap bootstrap popper.js jquery uuid
```

2. Update the index.js file

You will need to add the bootstrap files to the index.js file

```
import React from 'react';
import ReactDOM from 'react-dom';

import $ from 'jquery'; 
import 'bootstrap/dist/js/bootstrap.bundle.min'
import 'bootstrap/dist/css/bootstrap.min.css'

import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';
```

3. Update the App.js file

The app.js file comes with some boiler plate code that we no longer need, so update it so it looks like this:

```
import React, { Fragment } from 'react';

function App() {
  return (
    <Fragment>
    </Fragment>
  );
}

export default App;
```

We will add our components into that as we need to.

4. Add a components folder

Create a folder called `components` in the `src` folder. For each component we are going to create a new folder that will have an `index.jsx` file in there. When want to have some styling or some files that are specific to that component then we can easily add them and keep things tidy.

5. Commit the project

Right now we have done some prep and it pays to do a commit before we go any further:

```
git add .
git commit -m "React project setup"
```

# Creating our List Component

Throughout this project we are going to setup a simple CRUD template, so the first component is the READ option - which will be in the form of a list.

1. Create a new folder in the component folder called `ShowData` with an `index.jsx` file

2. In the index.jsx file paste the following code:

```
import React, {useState} from 'react';

let GetMyData = (mystate) => {
  fetch('http://localhost:5000/api/names')
  .then(resp => resp.json())
  .then(data => mystate({names : data}))
  .catch(e => console.log(e))
}

export default function ShowData() {

  const [remoteData, setData] = useState({ names: [] });

  GetMyData(setData)

  return (
    <ul>
      {remoteData.names.map((n, i) => {
        return  <li key={i}>
                  <a href={`?id=${n._id}`}> {n.name}</a>
                </li>
      })}  
    </ul>
  );
}
```

A number of things are happening in the code above:

a. Importing the React base component and the `useState` component so we can use state in our        function.

b. Create a function that processes our fetch request. It takes a parameter, which will be used to later pass in our state into the function.

c. The function that we will be exported is next. In that function we set the state object, call the function we declared above it and return the UI code that we will see in the host component (In this case `App.js`)

Save the file and go back to the App.js file where we need to import our list component and use it:

```
import React, { Fragment } from 'react';

import ShowData from './components/ShowData'

function App() {
  return (
    <Fragment>
      <ShowData />
    </Fragment>
  );
}

export default App;
```

Next we need to add a form that uses some of the bootstrap components. For this we will create another component called `AddData`

In the `index.jsx` file you can add the following code:

```
import React, { Fragment } from 'react'

import { Button } from 'react-bootstrap'

const uuidv4 = require('uuid/v4');

let PostToDB = (data) => {

  fetch('http://localhost:5000/api/names', {
    method: 'POST',
    body: JSON.stringify({_id: uuidv4(), name: data}),
    headers:{
      'Content-Type': 'application/json'
    }
  }).then(res => res.json())
  .then(response => {

    console.log('Success:', JSON.stringify(response))
    
  })
  .catch(error => console.error('Error:', error));
}

export default function AddData() {
  return (
    <Fragment>
      <div className="container">
      <div className="form-group">
        <label>Name:</label>
        <input  type="text" 
                className="form-control" 
                id="inputName" 
                aria-describedby="inputName" 
                placeholder="Enter Name" 
        />
      </div>
      <Button type="submit" className="btn btn-primary" block 
      onClick={() => PostToDB(document.getElementById('inputName').value)} >Submit</Button>
      </div>
    </Fragment>
  )
}
```

Although this component looks a little more complex, the basic structure is the same:

a. Import the files we need from the npm packages
b. Create a function that does the form processing
c. Create export function that shows the UI and calls the function created above that is triggered on a onClick basis.

Update the `App.js` file accordingly:

```
import React, { Fragment } from 'react';

import ShowData from './components/ShowData'
import AddData from './components/AddData'

function App() {
  return (
    <Fragment>
      <AddData />
      <hr/>
      <ShowData />
    </Fragment>
  );
}

export default App;
```

Now when you run your react app, you should be able to add a name in the text field and it should show up on the list.

On the next page, we will look at how to update and delete content.

**TODO:** Add more detail into explaining how the components work.

**Reference LINKS:**

* http://localhost:3000/
* http://localhost:5000/
* https://react-bootstrap.github.io/getting-started/introduction/
* https://getbootstrap.com/docs/4.3/components/forms/
* https://www.npmjs.com/package/uuid
* https://blog.logrocket.com/how-to-use-bootstrap-with-react-a354715d1121/
* https://docs.jwk.nz/
