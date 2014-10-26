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

    sudo docker run -p 4040:4040 -v /mymusicfolder:/music -v /mypodcastfolder:/podcasts -v /mysubsonicfolder:/data captnbp/docker-subsonic

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
#### `/data`

Home directory for subsonic, subsonic stores it's log, database properties in this folder. (i.e. /opt/appdata/subsonic)

#### `/music`

Defualt music folder. If remote share ensure it's mounted before run command is issued. 
(i.e. /opt/downloads/music or /media/Tower/music)

#### `/podcasts`

Defualt podcasts folder. If remote share ensure it's mounted before run command is issued.
(i.e. /opt/downloads/podcasts or /media/Tower/podcasts)

## Troubleshooting
### FLAC playback
The FFmpeg transcoder doesn't handle FLAC files well, and clients will often fail to play the resultant streams. (at least, on my machine) Using FLAC and LAME instead of FFmpeg solves this issue.

Start Subsonic and go to settings > transcoding. Ensure that the default FFmpeg transcoder does not get used on files with a "flac" extension, then add a new entry. You'll end up with something like this: 

| Name | Convert from | Convert to | Step 1 | Step 2 |
| ---- | ------------ | ---------- | ------ | ------ |
| mp3 | default | ... NOT flac ... | mp3 | ffmpeg ... |
| mp3 flac | flac | mp3 | flac --silent --decode --stdout %s | lame --silent -h -b %b - |
