# How to setup MVC

Using this framework, setting up MVC is a pretty easy process.

Let's have a look at the folder structure:

The main folders to focus on are:

| Foldername | Purpose |
| :--- | :--- |
| **app** | backend files (all the php stuff) |
| **public** | frontend files (css, images, javascript etc)|

We will get to both of those later on

| Foldername | Purpose |
| :--- | :--- |
| **rest** | Used to do some api testing, we can ignore this for now. |
| **sql** | Used as a place where you can save your mysql files. The file (part1.sql) that is in there is used for the demo projects. |

The files in the root folder are used as follows:

| Filename | Purpose |
| :--- | :--- |
| .env | This is used to read your DB credentials and other info that needs to be secure |
| .gitignore | Ignore all the setup files that can be run remotely |
| .htaccess | There to route all the controller paths |
| composer.json | Install php composer packages, we only use this for env files for now |
| env.example | an example for when the .env file is ignored, which it should be |
| readme.md | default readme file |

## Public Folder

In the public folder we have 2 files at the base:

* .htaccess - used for routing of url paths
* index.php - used as a base, but not edited

The **index.php** contains very little php:

!!! note ""
    ``` php
    <?php
        include('../app/bootstrap.php');
        $init = new Core();
    ?>
    ```

* **`Core`** is a class which is defined in the **app/libraries** folder. 

* **bootstrap.php** is a file that sets up a number of php files we want to import, but we don't want to expose the paths of those files to the public.

* The other folders are just placeholders for any assets that are needed in the project.

* To link to any of those files we do need to use some special (sort of) php syntax, but we will get to that later.

## App Folder

The app folder is where all the magic happens.
It is also the folder we hide from the public, because all our server side code is there.

Let's go through the folder / file structure

* Here you will see **bootstrap.php**. If you have a look at that file, you will just see that it imports a bunch of other files.

* The **helper** folder contains some helper files, we will reference to them later.

* The **libraries** folder contains the **foundtion of the framework** so look, but don't touch :smile:

The **models**, **views** and **controllers** folder carry the respective files to make up the different webpages.

Which we talk about in the next section.

