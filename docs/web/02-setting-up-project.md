# Project Setup

In this example we are going to look at deploying a website using the bootstrap framework.  
Later in the exercises, you can test out this process yourself using [bulma.io](http://bulma.io) and [tailwindcss](https://tailwindcss.com)

The starter project can be found [here](https://github.com/to-jk11/framework-answer-model).

In this repository you can see there are 3 folders, each of them contain a single HTML file and make the same wesbite using 3 different UI frameworks.

After cloning this repository, we are going to break it up into 3 new repositories, one for the example and two for the exercises.

Clone the repository by copying the following command:

```
git clone https://github.com/to-jk11/framework-answer-model
```

After the clone is completed, copy the **bootstrap** folder and place it at the same level as the **framework-answer-model** folder.

For example, if you cloned the **framework-answer-model** onto the Desktop, then place the **bootstrap** there as well.

For now - until the exercises - you can ignore the **framework-answer-model** folder, but don't delete it.

## Running the bootstrap project.

If you look at the code in the bootstrap folder, you can see the links to the framework (css and javascript) are absolute and they are linking to an external CSS. When we put our website in production, we want it to always work and show the right frameworks - so we don't want to rely on an external resource for this.

In the **bootstrap** folder we need to create a git repository, so navigate into the folder and type in:

```
git init
```

Next we need to create a **.gitignore** file and need to fill it with the following lines:

```
.DS_Store
node_modules/
```

These lines stop us from including the **node_modules** folder and the indexing file that is created on a machine running macOS. Since you are never sure on what machine your project will be running, it is good practice to add the **.DS_Store** - even if you don't use a mac :smile:

Next we need to create a **package.json** file.

!!! note "Previous Knowledge"
    Previously we looked at how to add NPM packages to our project, so I am not going to explain the pro's and con's in much detail. I will just explain the steps on what to do. 

To be able to add your frameworks locally to your project, we will use something called NPM (Node Package Modules). To save the package we use with our project we need to create a **package.json** file.

Open the bootstrap folder in vscode and open the integrated terminal and type in:

```
npm init -y
```

The above command will create a **package.json** file for you and it will allow us to save a list of our web dependencies which are used to download our frameworks.

First let's add the frameworks required for making a bootstrap website - type the following into the terminal:

```
npm i bootstrap popper.js jquery
```

You should end up with an error that contains the following line:

> npm ERR! Refusing to install package with name "bootstrap" under a package<br>
npm ERR! also called "bootstrap". Did you name your project the same<br>
npm ERR! as the dependency you're installing?<br>

This is because your project name at the top of the package.json file is bootstrap and npm cannot install a package with the same name. So change the name of the project to `bootstrap_` and run the command again and you shouldn't have any issues.

In the **index.html** file you can now change the links relevant to the frameworks to the npm packages.

For the CSS this will be:

```
<link rel="stylesheet" href="/node_modules/bootstrap/dist/css/bootstrap.min.css">
```

For the Script tags just above the `</body>` this will be:

```
<script src="/node_modules/jquery/dist/jquery.slim.min.js"></script>
<script src="/node_modules/popper.js/dist/umd/popper.min.js"></script>
<script src="/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
```

Now using Live server you are able to run the project and see that the website looks the same, but this time the framework is local to our project.

??? note "Live-Server"
    Live server can be installed in a couple of ways:

    1. Using vscode, we can install the extension by typing the following into the terminal: 

    ```
    code --install-extension ritwickdey.liveserver
    ```

    To run the live-server extension, use the "go live" button at the bottom or find it in the quick menu. The website will open on http://localhost:5500 using your default browser.

    2. Using npm, we can install a local live-server by typing the following into the terminal:

    ```
    npm i -g live-server
    ```

    To run the live server using npm do this:

    ```
    live-server --no-browser .
    ```

    No browser will open by default, but you can access the page from http://localhost:8080 using any browser.

Now we have our project running with the frameworks locally to our project, next we are going to look at the first step of deployment.

It would be a wise move to make a commit now, since we are about to push our code up to GitHub.