# NPM - Node Package Manager

NPM stands for Node Package Manager and it is a way to easily get javascript based libraries and frameworks added to your project.

When installing NPM packages a `node_modules` folder is added to your project. If you are using git, then this is something you want to add to your .gitignore file.

## NPM Usage

NPM is a command line tool and is installed when you install nodejs. 
So even if you don't use Nodejs in your project, you will probably have it installed on your machine so you can use NPM.

NPM has a couple of basic commands:

| Commands | Descripion |
| :--- | :--- |
| `npm i` | This installs a package as a dependency (used for frameworks and libraries) |
| `npm i -D` | This installs a package as a developer's dependency (used for packaging tools and stuff not required in production) | 
| `npm i -g` | Used if you want to install a tool globally, after this the package often runs a like a software app. examples are: `create-react-app` and `nodemon` |
| `npm start` | Default way to run your application, if specified in package.json |
| `npm run deploy` | Same as `npm start`, but using a custom command not listed in the npm defaults. |
| `npm init` | A wizard to take you through the creation of a package.json file |
| `npm init -y` | The wizard is skipped and a package.json file is created using default values. |

## Package.json

What is package.json? 

> All npm packages contain a file, usually in the project root, called package.json - this file holds various metadata relevant to the project. This file is used to give information to npm that allows it to identify the project as well as handle the project's dependencies. It can also contain other metadata such as a project description, the version of the project in a particular distribution, license information and et al.