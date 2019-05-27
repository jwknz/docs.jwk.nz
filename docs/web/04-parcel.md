# Using parceljs

The problem we are currently having is that we do not see any of our styles and our scripts do not work. When our website is hosted on a shared hosting server, we do not have access to the node_modules folder - so we need to find a work around.

Parceljs is a "Blazing fast, zero configuration web application bundler" and it creates a production version of our website without using the node_modules folder. 

To use parceljs we need to add it to our package.json file.

```
npm i parcel-bundler --save-dev
```

You will notice that your package.json will now contain the following code:

``` json
"dependencies": {
  "bootstrap": "^4.3.1",
  "jquery": "^3.4.1",
  "popper.js": "^1.15.0"
},
"devDependencies": {
  "parcel-bundler": "^1.12.3"
}
```

The `parcel-bundler` is listed under `devDependencies` because it is only required while our website is under development, where as the frameworks are used to support our website at all times.

Next we need to make another change to our package.json file:

Change:

``` json
"scripts": {
  "test": "echo \"Error: no test specified\" && exit 1"
},
```

into this:

``` json
"scripts": {
  "test": "echo \"Error: no test specified\" && exit 1",
  "dev": "parcel index.html",
  "build": "parcel build index.html"
},
```

Save the file and now you can run the command:

```
npm run dev
```

This will package up the website and run it on a local server available from [http://localhost:1234](http://localhost:1234).

Before we make a commit, we want to update our **.gitignore** file to the following:

```
.DS_Store
node_modules/
dist/
.cache/
```

The new entries are part of parceljs and are generated code that will be done on the remote server.

Make a commit, but do not push it up to GitHub yet. 

# Updating Netlify 

Back on the Netlify we now need to make a few changes to our configuration:

1. Go to the [app page](https://app.netlify.com/) and select the project you created earlier.
2. Click on "Deploys" in the top menu
2. Click on the "Deploy Settings" button on the next screen
3. Click in "Edit settings" button in the Build settings section

* In the "Build settings" field add `npm run build`
* In the "Publish directory" field add `/dist`

Click on the Save button.

Now you can push up your latest commit - the following will happen:

* Your project is pushed up to GitHub
* Netlify recognises that there is a new commit and pulls the information
* Netlify starts buidling your site by using the build command you previously entered
* Your site should be live in about a minute on the same link as before, but this time the styles and scripts will work.

Congratualtions - you have published your website and made your first Continous Integration ! :smile:

!!! warning "REMEMBER"
    Each time you now push to master, netlify will kick in and update the url

!!! tip "What now?"
    At this stage you are using a sub-domain url based on the netlify domain, look through the options on how you can add your own domain if you have one. A nice things Netlify does for you is give you HTTPS for free!

    