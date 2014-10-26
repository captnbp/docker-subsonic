docker-Subsonic
============

A nice and easy way to get a Subsonic instance up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on Subsonic and check out it's [website][1].


## Building docker-subsonic

Running this will build you a docker image with the latest version of both
docker-subsonic and Subsonic itself.

    docker build -t captnbp/docker-subsonic git://github.com/captnbp/docker-subsonic.git


## Running Subsonic

You can run this container with:

    sudo docker run -p 4040:4040 -v /mymusicfolder:/music -v /mypodcastfolder:/podcasts captnbp/docker-subsonic

From now on when you start/stop docker-subsonic you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker ps` and it will show up on the left side followed by the image
name which is `captnbp/docker-subsonic:latest`.

    sudo docker start <container_id>
    sudo docker stop <container_id>

### Notes on the run command

 + `-v` is the volume you are mounting `-v host_dir:docker_dir`
 + `-d  allows this to run cleanly as a daemon, remove for debugging
 + `-p  is the port it connects to, `-p=host_port:docker_port`


[0]: http://www.docker.io/gettingstarted/
[1]: http://www.subsonic.org

## Volumes:
#### `/music`

Defualt music folder. If remote share ensure it's mounted before run command is issued. 
(i.e. /opt/downloads/music or /media/Tower/music)

#### `/podcasts`

Defualt podcasts folder. If remote share ensure it's mounted before run command is issued.
(i.e. /opt/downloads/podcasts or /media/Tower/podcasts)
