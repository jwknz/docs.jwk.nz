# Project Setup

To be able to create an headless api, you will need to setup 2 folders - which are in fact 2 project - we will call them "frontend" and "backend"

The **frontend** folder will be completely separate from the **backend**, not even the languages are the same.

The **"glue"** that connects the 2 will be JSON and JWT.

* JSON - this is jused to transfer data between the 2 projects.
* JWT - will provide the authentication for the login form.

There is a starting project to download that is available from here:

[https://github.com/to-jk11/php-json-content](https://github.com/to-jk11/php-json-content)

The project to start off is in week08/session01

At this stage, the project is somewhat separate, but still very much a single application.

So we need to setup the following structure:

For the backend set this up:

```
backend
|
|-- api/
|-- helpers/
|-- sql/
```

For the frontend set this up:

```
frontend
|
|-- scripts
|-- styles

All the HTML files

```

# UPDATING YOUR BACKEND

The next thing we need to do is use a program called **composer** so that we can use some packages for our PHP backend.

After this is installed create a file called composer.json in your backend folder and type in the following:

```
{
  "require": {
      "vlucas/phpdotenv": "^2.5",
      "firebase/php-jwt": "^5.0"
  }
}
```

In the code above we are adding 2 packages - one that allows us to environment variables and then another that allows us to generate jwt token.

In your terminal you can then type in `composer update` to install those packages that will be placed in a **vendor** folder.

In the API folder we are getting quite a number of files, so let's change the structure so it looks like this:

```
api
|
|-- data/
    |
    |-- addData.php
    |-- deleteData.php
    |-- updateData.php
    |-- getAllData.php
    |-- getSingleData.php
|-- users/
    |
    |-- getSingleUser.php
    |-- userLogin.php
|-- data_process.php
|-- users_process.php

```

You will have created some new files and in those files we are just separating the different functions, so the code is easier to find.

In the *_process files you will need to have the following code at the top:

```
<?php
use \Firebase\JWT\JWT;
include_once(dirname(__DIR__).'/helpers/connection.php');
```

We will refer to the helpers directory in a bit.
On the second line, we are adding the link to the JWT library

In the foldes called **helpers** folder we have the following files:

```
helpers
|
|-- creds.php
|-- connection.php
```

The database credentials will be moved to an `.env` file so change the content of the creds.php file to this:

```
<?php

//USING ENV
require_once(dirname(__DIR__).'/vendor/autoload.php');
$dotenv = new Dotenv\Dotenv(dirname(__DIR__),'/.env');
$dotenv->load();

define ("DBHOST", $_ENV['DBHOST']);
define ("DBUSER", $_ENV['DBUSER']);
define ("DBPASS", $_ENV['DBPASS']);
define ("DBNAME", $_ENV['DBNAME']);
define ("SECRET_TOKEN", $_ENV['SECRETKEY']);
define ("SERVER", $_ENV['SERVER']);
```

The connection file will just have a single function in there like this:

```
<?php

include('creds.php');

function connect() {
  try {
      $dsn = "mysql:host=".DBHOST.";dbname=".DBNAME."";
      $pdo = new PDO($dsn, DBUSER, DBPASS);
      $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
      return $pdo;
  } catch (PDOException $e) {
      print "ERROR!: ". $e->getMessage() . "<br>";
      die();
  }
}
```

In the **user_process.php** file we need the following functions:

```
function checkLoginDetailsAndCreateToken($user, $pass)
function showSingleUser($id)
```

In the **data_process.php** file we need the following functions:

```
function showdata()
function showSingleData($id)
function addVehicles($make, $models)
function updateVehicles($id, $make, $models)
function removeVehicle($id)
```

Now at this stage when we looked at the starting code, everyone was able to change anything - so the functions above need to be updated to make use of the JWT tokens - which we will cover in a bit.

Before we can do anything else, we need to re-establish the database connection.

In the backed folder we need to setup an **.env** file that will looked like this:

```
DBHOST="oopphp_db_1"
DBNAME="containerdb"
DBUSER="user"
DBPASS="user1234"

SERVER="http://localhost:8000/week08/session02/backend"
CLIENT="http://localhost:8000/week08/session02/frontend"
SECRETKEY="today_is_wednesday"
```

Some details will look familiar, but there are some new ones as well, which we will get to later.


# UPDATING THE FRONTEND

The front end will be similar in terms of how the files work, but just like in the backend, we will need to adjust the functions to use the JWT parts. So lets get started:

# USING JWT

JWT = JSON WEB TOKEN

A JWT has the following strucure 

```
header.payload.secret
xxxxxxxx.xxxxxxxx.xxxxxx
```

[You can read more about that here](https://dev.to/siwalikm/what-the-heck-is-jwt-anyway--47hg)

Other useful websites are:

* [https://jwt.io/#debugger](https://jwt.io/#debugger) to debug your token
* [https://medium.com/dev-bits/a-guide-for-adding-jwt-token-based-authentication-to-your-single-page-nodejs-applications-c403f7cf04f4](https://medium.com/dev-bits/a-guide-for-adding-jwt-token-based-authentication-to-your-single-page-nodejs-applications-c403f7cf04f4)
* [https://scotch.io/tutorials/the-anatomy-of-a-json-web-token](https://scotch.io/tutorials/the-anatomy-of-a-json-web-token)

The composer package we use will help us create the JWT token and this is how to use it:

[https://packagist.org/packages/firebase/php-jwt](https://packagist.org/packages/firebase/php-jwt)

The big idea of the workflow is:

1. Use the frontend to log in to the backend
2. The backend will then create the JWT token and send it back
3. The token has a date embedded in it, and we are wrapping a check to see if that date has passed everytime we do a SQL function.
4. If the date has passed, the user needs to log in again.

The code for the workflow looks like this:

In the Javascript we send the value from the fields to the PHP and that returns to us the JWT token

```
let userLoginButton = document.querySelector('#userLoginButton');

if(userLoginButton !== null) {

  userLoginButton.addEventListener('click', () => userLogin())
  
  let userLogin = async () => {

    let user = document.querySelector('#user').value;
    let pass = document.querySelector('#pass').value;
  
    let url = `${SERVER}/api/users/userLogin.php`;

    let data = {_user : user, _pass : pass};

    await fetch(url, {
      method: 'POST', 
      body: JSON.stringify(data), 
      headers:{
        'Content-Type': 'application/json'
      }
    })
    .then(resp => resp.json())
    .then(data => {

      if(data.MSG !== "USER WAS NOT FOUND") {
        location.replace(`index.html?loggedin=${data.MSG}`) //Redirect to homepage
      }
  
    })
  }
}
```

The PHP generates the token like this:

```
function checkLoginDetailsAndCreateToken($user, $pass) {

  $db = connect();
  $sql = "SELECT ID, USER, PASS FROM tbl_users WHERE USER = :user AND PASS = :pass";
  $params = [":user" => $user, ":pass" => $pass];

  $stmt = $db->prepare($sql);
  $stmt->execute($params);

  $results = $stmt->FETCHALL();

  if( count($results) > 0 ) {

    $today = new DateTime('now');
    $todayPrint = $today->format('Y-m-d'); // format date to show (e.g. 2019-07-21)
    $epochNow = $today->format('U'); // shows epoch start time
    $today->add(new DateInterval('P10D')); // adding 10 days 
    $epochExpiry = $today->format('U'); // shows epoch stop time

    $token = array(
      "iss" => SERVER, //issuer
      "aud" => "http://example.com", //client - we are not using that right now, but its an example
      "iat" => $epochNow, //token was "issues at time"
      "exp" => $epochExpiry  //token "expiry time"
    );

    $jwt = JWT::encode($token, SECRET_TOKEN);

    return json_encode(["MSG" => $jwt]);

  } else {
    return json_encode(["MSG" => "USER WAS NOT FOUND"]);
  }
}
```

Now that you have the token we can do our checks like this:

```
function showdata() {

  if(isset(getallheaders()['Authorization'])) {
    $jwt = getallheaders()['Authorization'];

    $decoded = JWT::decode($jwt, SECRET_TOKEN, array('HS256'));
    $decoded_array = (array) $decoded;
  
    if (new DateTime() < new DateTime(date('r', $decoded_array['exp'])))
    {
  
      return json_encode("This token has expired");
  
    } else {

      // Do stuff with a valid token....

    }
  }
}
```




