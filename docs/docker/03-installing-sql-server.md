# Setting up SQL Server using Docker

## Using docker

Once it is installed, you will need to start the program which will create the VM that you need to run docker.

![Setup01](./images/Setup10.png)

![Setup01](./images/Setup11.png)

Once Docker has started you will need to pull down the image for SQL SERVER.

```
docker pull mcr.microsoft.com/mssql/server:2017-latest-ubuntu
```

![Setup01](./images/Setup12.png)

You can see what images you have downloaded using the images command:

```
docker images
```

![Setup01](./images/Setup13.png)

Create and run the container using:

```
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<YourStrong@Passw0rd>' -e 'MSSQL_PID=Express' -p 1433:1433 --name webapi_mssql -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu 
```

and check the status of it using:

```
docker ps -a
```

to see if it is running.

In  the image below you may see that the container has an 

> Exited (1) x seconds ago

![Setup01](./images/Setup14.png)

This means that you need to allocate more RAM to your VM - which needs at least 2GB allocated to it.

Type in :

```
docker-machine stop
```

and open Virtual box - and change the value to 2048 MB

![Setup01](./images/Setup15.png)

![Setup01](./images/Setup16.png)

Then start the machine up again using:

```
docker-machine start
```

![Setup01](./images/Setup17.png)

Here is a summary of the commands and you can see that the container is up and running

![Setup01](./images/Setup18.png)

After this you can connect it to a SQL management program, below are some screenshots when using SQL Management Studio

![Setup01](./images/Setup19.png)

![Setup01](./images/Setup20.png)

You can now use the docker CLI tool to manage your database as well.

![Setup01](./images/Setup21.png)

![Setup01](./images/Setup22.png)

![Setup01](./images/Setup23.png)

![Setup01](./images/Setup24.png)



