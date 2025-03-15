# R3BRoot-Docker

These codes provide Dockerfiles to create images of [FairSoft](https://github.com/FairRootGroup/FairSoft), [FairRoot](https://github.com/FairRootGroup/FairRoot), [UCESB](https://git.chalmers.se/expsubphys/ucesb), and [R3BRoot](https://github.com/R3BRootGroup/R3BRoot). After that, a Docker container with a full installation of R3BRoot will be created. 

## Installation

The first step is to download [Docker Desktop](https://docs.docker.com/desktop/) and create a [Docker Hub](https://hub.docker.com/) account. Afterwards, clone the repository from GitHub:

```bash
git clone https://github.com/pgrusell/R3BRoot-Docker.git 
cd R3BRoot-Docker
```

Then enter each directory and create the corresponding images:

```bash
cd FAIRSOFT
docker build {dockerhub username}/fairsoft:latest .

cd ..
cd FAIRROOT
docker build {dockerhub username}/fairroot:latest .

cd ..
cd UCESB
docker build {dockerhub username}/ucesb:latest .
```

Now you have created the images of all the dependencies needed for installing the R3BRoot framework. Up to this point, we are going to create the image of the `dev` version of R3BRoot, however **if you want to compile a different version, modify the GitHub link on R3BROOT/Dockerfile to clone your on repository**.

```bash
cd ..
cd R3BROOT
docker build {dockerhub username}/r3broot:latest .
```

With these steps four images have been created. A fastest option would be just pulling my r3broot image (or ucesb image if you want to compile your own R3BRoot version) from my Docker Hub account. This has the disadvantage that some packages could have not been properly updated, so be careful with this. 

```bash
docker pull pablogrusell/r3broot:latest 
```

Once and r3broot image has been created, the last step will be running the container. This will open a pseudo-terminal with a complete R3BRoot installation. 

```bash
docker -it --rm pablogrusell/r3broot:latest
```

For later compatibility with the scripts rename the image as:

```bash
docker tag {dockerhub username}/r3broot:latest r3broot
```

# Running

At this point, there are still some problems:

+ All programs will run in bash mode so no external windows will be opened.
+ Files are contained inside the docker, so everything should be created in the session **and will be deleted afterwards**. 

To fix them, instead of launching the pseudo-terminal with the previous command use run this commands instead:

```bash
mkdir macros
docker volume create --driver local --opt type=none --opt device=. --opt o=bind macros
source run_shared.sh
```

This will launch the terminal, and create a new folder called `macros`(if it didn't exist previously). In this terminal session the folder `macros` will be common to the container and also to your computer. 

On the other hand, and just for MacOS, you can use XQuartz to run root in interactive mode. To do this, first install and configure XQuartz:

```bash
# Install XQuartz with brew
brew install xquartz 

# Allow network connections
defaults write org.xquartz.X11 nolisten_tcp -bool false
defaults write org.xquartz.X11 enable_iglx -bool true
```

Finally, run the script:

```bash
source run_r3b.sh
```

This will allow the connections to interactive windows on your own computer, and also with the macros folder. 



