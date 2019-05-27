# Introduction

!!! note "Static Website"
    This guide is to deploy a static website. i.e. A website without a dynamic backend.
    Static sites can include dynamic parts, but a good example of what this guide is not for is a website like WordPress where the content is delivered via a database.

One of the main ways to deplopy a website used to be to use FTP (File Transfer Protocol) and was basically a drag 'n' drop approach to putting your website live on a server.

![FTP](https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.websitemaven.com%2Fimage-files%2Fcuteftp.jpg&f=1)

If the image above you can see on the left side files that are locally on your machine and in the right panel you see the files that are on the web server.

The big plus of this process by far is simplicity, but it comes with a few dangers:

* No file version tracking
* No test places, what is on the server is live for everyone to see

So these days we use something called CI - Continuous Integration - and we use this to now deploy our websites, no matter what the complexity is.

In this section we are going to look doing this with [Parceljs](https://parceljs.org) and a service called [Netlify](https://netlify.com).

We are also going to be using [Github](https://github.com) and [npm](npmjs.org) modules to achieve our goal, since we are using web frameworks like bootstrap.

