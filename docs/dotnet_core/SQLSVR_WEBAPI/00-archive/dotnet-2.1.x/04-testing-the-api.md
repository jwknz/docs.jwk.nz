# Testing the api using VSCODE

Now that we have created our API and all the controllers for it, we need to test it - and then fix anything that went wrong :smile:

There are a number of tools that you can use to test an API. A popular one being Postman (this is a free tool). However you do need to install the program, so you can also keep everything inside of Visual Studio Code.

First let's have a look at using a Visual Studio Code Extension, since it allows us to save the routes we want to test.

## REST Client

Install the following extension: `code --install-extension humao.rest-client`

We need to have a file that ends with an `http` extension to test our routes, but to keep our folder structure tidy we will put them in a folder.

Create a folder called **test-routes** and inside of that folder create the following files:

* get-routes.http
* post-routes.http
* put-routes.http
* delete-routes.http

## GET ROUTE

Open the **get-routes.http** file and add the following code:

```
#GET http://localhost:5000/api/gameschedule/
#GET http://localhost:5000/api/gameschedule/f2

#GET http://localhost:5000/api/players/

#GET http://localhost:5000/api/poolpoints/
#GET http://localhost:5000/api/poolpoints/1

#GET http://localhost:5000/api/staff/
#GET http://localhost:5000/api/staff/1

#GET http://localhost:5000/api/teams/
#GET http://localhost:5000/api/teams/AKLF
```

You can only test a single request at a time, so uncomment each request to see the result.

!!! success "Get Successful"
    ```
    HTTP/1.1 200 OK
    Connection: close
    Date: Tue, 07 May 2019 03:30:27 GMT
    Content-Type: application/json; charset=utf-8
    Server: Kestrel
    Transfer-Encoding: chunked

    {
      "id": "f2",
      "fieldNumber": 2,
      "time": "10.25am",
      "teamA": "BOPF",
      "teamB": "HAWF",
      "teamAScore": null,
      "teamBScore": null
    }
    ```

Now if you receive any errors, make sure you have got the right setup in each controller.

!!! warning "Copy and pasting code"
    You may have copied the controller file a number of times and resolvded all the dependencies and your code would have compiled, but have you checked your models against your controllers??

    * Copy and pasting code without checking it - may compile your code - may not be correct at run time.

## POST ROUTE

For the post route, we need to supply some data that would otherwise come through a form. So the request file will look a little different:

```
# POST http://localhost:5000/api/players
# content-type: application/json

# {
#   "Name":"Stephen Holland",
#   "TeamId":"AKLM",
# }

################################################

# POST http://localhost:5000/api/players
# content-type: application/json

# {
#   "Name":"Lisa England",
#   "TeamId":"AKLF",
# }
```

You will we still target the URL, but we use the word POST. We also need to specify the content type, since we are sending JSON data.

Inside of the curly braces, we place the content that matches the Model in our code.

When the Post is successful you will see a message like:

!!! success "Post Successfull"
    ```
    HTTP/1.1 201 Created
    Connection: close
    Date: Tue, 07 May 2019 03:27:24 GMT
    Content-Type: application/json; charset=utf-8
    Server: Kestrel
    Transfer-Encoding: chunked
    Location: http://localhost:5000/api/Players

    {
      "id": 2,
      "name": "Lisa England",
      "teamId": "AKLF"
    }
    ```

## PUT ROUTE

For the update route, we need to have the ID of the record we want to change and the new data, so those requests look like:

```
PUT http://localhost:5000/api/players/1
content-type: application/json

{
  "id": 1,
  "Name":"Lisa England",
  "TeamId":"HWBF",
}
```
The result of the request looks like this:

!!! success "Update Successful"
    ```
    HTTP/1.1 200 OK
    Connection: close
    Date: Tue, 07 May 2019 03:33:00 GMT
    Content-Type: text/plain; charset=utf-8
    Server: Kestrel
    Content-Length: 24

    Players has been updated
    ```

Note that we need the ID as part of the URL, but also in the request block??

This is because if we where to use a webform, the id is grabbed from the URL and placed in the request behind the scenes.

## DELETE ROUTE

For the delete request, we only need the ID - so that is simple :smile:

DELETE http://localhost:5000/api/players/1
content-type: application/json

A successul request would look like:

!!! success "Update Successful"
    ```
    HTTP/1.1 200 OK
    Connection: close
    Date: Tue, 07 May 2019 03:35:35 GMT
    Content-Type: text/plain; charset=utf-8
    Server: Kestrel
    Content-Length: 22

    Player has been removed
    ```

All done!

Since we ran the tests inside of VSCODE, we have them saved - so it is easy to use them again.
