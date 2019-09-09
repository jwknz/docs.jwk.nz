# Working with the playground repo

Even though you just setup the backend in the [last tutorial](./01-index), sometimes you just want to start with a plain project that has that already setup. In that scenario do the following:

# Fork and Clone the playground repo

Go to [https://github.com/to-jk11/mern101-pg/fork](https://github.com/to-jk11/mern101-pg/fork) and fork the repo to your own account.

Once you have done that, you can clone that repo to your own machine - that way you can commit and push up and changes you make to the repo.

# Create a working branch and backend project

In the repo you have just forked, you will see there are 2 branches (master and starter).
The starter is the minimum you need to get started, the master may be updated with other content.

To easily keep track of multiple versions of the same repo - use the following workflow:

1. Clone the repo and fetch all of the branches:

```
// replace <username> with your git repo name
git clone https://github.com/<username>/mern101-pg 
```

Then fetch all of the branches.

```
git fetch --all
```

2. Create and use the starter branch, you can name it anything you like, but make sure it creates a copy of `origin/starter`

```
git checkout -b <name> origin/starter
```

Navigate into the `mern101-pg` folder before moving onto the next step.

3. Run the Mongo Server

In the mogodb folder, you will need to create 2 folders, one for the `db` and one for the `logs`

```
mkdir db logs
```

Next you will need to start the MongoDB project:

```
mongod --conf mongo.conf
```

If you do not have any data of your own, you can use the `setup.js` file to populate your db with some basic dummy data.

```
mongo mongo-script setup.js
```

4. NPM Install

Before you can start working on the app you will need to install the package, you can do this from the `mern101-pg` folder like so:

```
npm --prefix express i
npm --prefix express i -D
```

NOTE: You will need to run both, since `nodemon` is a devDependency.

5. Setup the Front end Project

Now you have your backend all setup, so now we can create our front end project.

# Create a React front end

For the [next part](./03-react-forms) you will create a CRUD from using the react cli tool.

In the part we will create a simple CRUD form, and the project will be called

```
npx create-react-app simple-crud-form
```

