#!/bin/bash

TRAKT_ACCOUNT=${TRAKT_ACCOUNT:-shivshav}

TORRENT_DL_DIR=${TORRENT_DL_DIR:-/mnt/media/download/torrent}
TR_CONFIG_DIR=${TR_CONFIG_DIR:-/mnt/media/config/transmission-daemon}
OVERWRITE_CONFIG=${OVERWRITE_CONFIG:-true}
TR_USERNAME=${TR_USERNAME:-shiv}
TR_PASSWORD=${TR_PASSWORD:-glipglop}

SR_TV_SHOW_DIR=${SR_TV_SHOW_DIR:-/mnt/media/tv_shows}
SR_CONFIG_DIR=${SR_CONFIG_DIR:-/mnt/media/config/sickrage}
SR_POST_PROC_DIR=${SR_POST_PROC_DIR:-$TORRENT_DL_DIR/completed/tv}


# TODO: This doesn't create subdirs if toplevel exists 
# TODO: Unfortunately we can't rely on the container to already have these dirs as the upstream image already declares
# the mounted directory as a volume, thus making any mkdir's on that dir in the Dockerfile useless
[[ -d $TORRENT_DL_DIR ]] || mkdir -p $TORRENT_DL_DIR/{completed,incomplete,torrents}

[[ -d $TR_CONFIG_DIR ]] || mkdir -p $TR_CONFIG_DIR
[[ -d $SR_TV_SHOW_DIR ]] || mkdir -p $SR_TV_SHOW_DIR
[[ -d $SR_CONFIG_DIR ]] || mkdir -p $SR_CONFIG_DIR

# HomeBrewed transmission container
docker run -d \
    -p 9091:9091 \
    -p 51413:51413 \
    -p  51413:51413/udp \
    -e OVERWRITE_CONFIG=$OVERWRITE_CONFIG \
    -e TR_USERNAME=$TR_USERNAME \
    -e TR_PASSWORD=$TR_PASSWORD \
    -v $TORRENT_DL_DIR:/var/lib/transmission-daemon/downloads \
    -v $TR_CONFIG_DIR:/etc/transmission-daemon \
    --restart='always' \
    --name transmission \
    shiv/rpi-transmission

# Create HomeBrewed SickRage container
docker run -d \
    -p 8081:8081 \
    -v $SR_TV_SHOW_DIR:/data/tvshows \
    -v $SR_CONFIG_DIR:/opt/SickRage/data \
    -v $SR_POST_PROC_DIR:/data/completed_downloads \
    --restart=always \
    --name sickrage \
    shiv/rpi-sickrage

# Create flexget container
docker run -d \
    --restart='always' \
    -e TR_USERNAME=${TR_USERNAME} \
    -e TR_PASSWORD=${TR_PASSWORD} \
    -e TRAKT_ACCOUNT=${TRAKT_ACCOUNT} \
    --name flexget \
    shiv/rpi-flexget
