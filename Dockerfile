FROM	ubuntu:14.04
MAINTAINER	Benoît Pourre "benoit.pourre@gmail.com"

RUN	locale-gen en_US en_US.UTF-8

# Make sure we don't get notifications we can't answer during building.
ENV	DEBIAN_FRONTEND noninteractive

# Update the system
RUN	apt-get -q update
RUN	apt-mark hold initscripts udev plymouth mountall
RUN	apt-get -qy --force-yes dist-upgrade

# install dependencies for subsonic and clean
RUN	apt-get install -qy openjdk-6-jre flac lame && apt-get clean && rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/* && rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# install subsonic
ADD	http://downloads.sourceforge.net/project/subsonic/subsonic/5.0/subsonic-5.0.deb /tmp/subsonic.deb
RUN	dpkg -i /tmp/subsonic.deb && rm /tmp/subsonic.deb

# Prepare user
RUN	addgroup --system downloads -gid 1001
RUN	adduser --system --gecos downloads --shell /usr/sbin/nologin --uid 1001 --gid 1001 --disabled-password  downloads

# Clean up
RUN	rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/* && rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Create hardlinks to the transcoding binaries.
# This way we can mount a volume over /var/subsonic.
# Apparently, Subsonic does not accept paths in the Transcoding settings.
# If you mount a volume over /var/subsonic, create symlinks
# <host-dir>/var/subsonic/transcode/ffmpeg -> /usr/local/bin/ffmpeg
# <host-dir>/var/subsonic/transcode/lame -> /usr/local/bin/lame
RUN	ln /var/subsonic/transcode/ffmpeg /var/subsonic/transcode/lame /usr/local/bin
RUN	chown -R downloads:downloads /var/subsonic

ADD	startup.sh /startup.sh

RUN	mkdir /subsonic
VOLUME	[/music]
VOLUME	[/podcasts]

EXPOSE	4040

RUN	chown downloads:downloads /subsonic
USER	downloads
ENTRYPOINT	["/startup.sh"]
