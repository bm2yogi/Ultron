# Ultron
Template for WebAPI apps pre-configured with IoC and psake build scripts.

Just a little something to help get a head-start on greenfield ASP.NET WebApi projects.

Comes with some of my preferred goodies like [Sahara](https://www.nuget.org/packages/Sahara/) (with [nUnit](https://www.nuget.org/packages/NUnit/) and [Moq](http://www.moqthis.com/)) for unit tests, [AutoFac](http://autofac.org/) for dependency injection, a [psake](https://github.com/psake/psake) build script and probably a few more goodies later.

Ideally, you should only have to clone the repo, then run 

`psake -parameters @{appName=<<yourApp'sName>>}`

The script **_should_** bring down any declared nuget dependencies, build, run tests and deploy the app to your webroot, then configure IIS to serve up the files.

It's a work in progress.
