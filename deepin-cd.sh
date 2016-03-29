#!/bin/bash

. ./common.sh

mirror_id=deepin-cd
mirror_path=$DATA_PATH/$mirror_id
mirror_upstream="rsync://cdimage.linuxdeepin.com/releases/"
rsync_options=$SIMPLE_RSYNC_OPTIONS

if [ "$1" = "--debug" ]; then
    rsync_options=$RSYNC_OPTIONS_DEBUG
fi

do_simple_rsync $mirror_id $rsync_options $mirror_upstream $mirror_path

