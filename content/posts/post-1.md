---
title: "Everyone works differently and that's Ok"
date: 2025-03-03T00:00:00+01:00
description: "While being at several companies, I have encountered a special thing. Everyone work differently, because every person is unique..."
tags: [programming, individuality, work]
---
This is one of the realizations that I had, when I started to work at my first job. I thought that everyone should do things the same way. This is how the education system always worked.

You used the same Microsoft suite on the same PC and same app for coding. I felt like I hit a wall when someone said that they use JetBrains Rider instead of Visual Studio.

This became even more plain when I got hired.

## Everyone is working different
No matter what the given task was, I never had two people that did the same thing the exact same way. Even if the description of the task was identical.

Coworker wrote tutorial on how to deploy a complex project. It had many services and post deployment scripts with frontend on top. Next person tried to use this tutorial and failed. After some fixes, other person tried to deploy it and failed with different issues.

Results were not consistent. Everyone used different tools, different shells, different editors and so on.

## Different tools
### Do you know docker?
Well, let me tell you, this is not the only way to avoid the it works on my machine issue. With docker you can create a simple Dockerfile, that stores you build script for the project. For example, like this.

```dockerfile
FROM golang:1.21 AS builder
WORKDIR /app 
COPY . . 
RUN go mod download 
RUN go build -o main . 

FROM alpine:latest 
WORKDIR /root/ 
COPY - from=builder /app/main . 
CMD ["./main"]
```

This script need to be build and run:

```dockerfile
docker build -t my-golang-app .
docker run -rm -p 8080:8080 -e PORT=8080 -e ALLOW_HTTP=true my-golang-app
```

This is all fine and dandy, but what if you have more variables for your service. Now you need to remember all environment variables or save this lengthy command somewhere.

You can also use **.env** file and pass it with command

```shell
docker run -rm -env-file .env my-golang-app
```

At this point you are maintaining 2 files for you Go app. What happens when you have more services, that are independent? You could use something more powerful than a Dockerfile.

### Docker compose
Now you realized that having Dockerfile and .env file for each service is a bad idea. You need to store all docker commands somewhere, so why not have one command to rule them all.

The docker compose allows you to store environment variables inside it. But it still requires you to maintain the Dockerfiles for each service.
 
But wait there is more.

### Helm charts
It can be annoying to maintain some of your services, when need to have some data after start. You want a Keycloak instance, that stores users and roles. You want a translating service, that stores your translations for different languages. You want to have customizable layout composition for navigating your UI.

This is where the helm charts come in. You can decide what steps you want to include in your builds. You can decide when and if you want to run them. File values.yaml stores all variables for that and you can change them all in one place.

I don’t know much about helm, but I imagine it as easier way to deploy things into Kubernetes.

This is just the tip of the iceberg, when it comes to build tools. You can still use bash scripts, make or even zig build system if you want.

{{< dots >}}

## Different shells
Shell is the part, that programmer interacts with the terminal. It usually depends on your development platform. Generally, you would use cmd or powershell for Windows, bash for Linux and zsh for Mac.

In my job, I used to use Windows with wsl. So, bash on Windows. But after “security improvements”, it breaks more often, then it works.

You can’t download some unsigned software, even if you need it for your development. It takes 2 seconds to save a file on C drive. Ubuntu has 2-year-old bugs, that were not fixed.

_**|** It is not a nice experience._

So, after trying to figure out how to use powershell verbose commands, I sticked to regular cmd. The cmd feels like very rusty hammer. But it can run one line command without any effort.

Don’t get me wrong, I love Linux shell. When I stated my job, I didn’t feel comfortable switching to Linux for my primary OS. And now I regret it dearly.

{{< dots >}}

## Different editors
I use Vcode, because I was most comfortable with it. It was OK for my dev projects. When I used python, it was very hard to debug my code in Vscode. I didn’t want to put a lot of effort into it. I switched to pyCharm for the debugger only. I could figure out what was wrong and then fix my code in Vscode.

Some of my coworkers used Visual Studio. The launch time of this editor makes me avoid it like hell fire. I die inside whenever I missclick and open Json file with VS.

I tried neovim, but I always missed the intuitive functionality of Vscode. And I didn’t want to learn another language for my editor (lua). Maybe I'll go back to it at some point, but for now I prefer to use the Microsoft’s tool.

## Why is everyone doing things different?

The industry has grown tremendously over the years. This is why we have so many ways to do things. And everyone likes to take the thing that we use and adjust it to their needs. And that is ok.

_The choice is the key for good software._
