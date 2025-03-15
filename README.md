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
docker build -t {dockerhub username}/fairsoft:latest .

cd ..
cd FAIRROOT
docker build -t {dockerhub username}/fairroot:latest .

cd ..
cd UCESB
docker build -t {dockerhub username}/ucesb:latest .
```

Now you have created the images of all the dependencies needed for installing the R3BRoot framework. 

### **Building a Different R3BRoot Version**
If you want to compile a different version of R3BRoot, modify the following line in `R3BROOT/Dockerfile`:

```Dockerfile
RUN git clone -b dev https://github.com/R3BRootGroup/R3BRoot.git
```
Replace `dev` with the desired branch or repository URL.

Now, build the R3BRoot image:

```bash
cd ..
cd R3BROOT
docker build -t {dockerhub username}/r3broot:latest .
```

### **Faster Alternative: Pull Pre-Built Image**
Instead of building everything manually, you can pull the pre-built image:

```bash
docker pull pablogrusell/r3broot:latest 
```

However, this may include outdated packages, so be careful.

Once the R3BRoot image has been created, rename it for easier use:

```bash
docker tag {dockerhub username}/r3broot:latest r3broot
```

---

## **Running the Container**
At this point, there are still some issues:

- All programs will run in **bash mode**, meaning **no external windows** will be opened.
- Files are contained **inside Docker**, so everything should be created in the session **and will be deleted afterwards**. 

### **Fixing File Persistence**
To keep files after closing the container, use a **bind-mounted folder**:

```bash
mkdir macros
docker volume create --driver local --opt type=none --opt device=$(pwd)/macros --opt o=bind macros
source run_shared.sh
```
Now, the `macros` folder will be accessible both inside and outside the container.

---

## **Running Graphical Applications (macOS)**
If you're using **macOS**, you need to enable **XQuartz** to run ROOT in interactive mode.

### **Install and Configure XQuartz**
```bash
# Install XQuartz with Homebrew
brew install xquartz 

# Allow network connections
defaults write org.xquartz.X11 nolisten_tcp -bool false
defaults write org.xquartz.X11 enable_iglx -bool true
```

### **Run the Configuration Script**
```bash
source run_r3b.sh
```
This will configure **XQuartz** and **Docker** to allow interactive ROOT windows.

## **Summary**

✔ **Step 1:** Build the images or pull them from Docker Hub.  
✔ **Step 2:** Run the container using `source run_shared.sh`.  
✔ **Step 3 (macOS only):** Install and configure XQuartz.  
✔ **Step 4 (macOS only):** Use `source run_r3b.sh` to enable graphical mode.  

