#!/bin/bash

. ./common.sh

mirror_id=mariadb
mirror_path=$DATA_PATH/$mirror_id
mirror_upstream="rsync://archive.mariadb.org/mariadb/"
rsync_options=$SIMPLE_RSYNC_OPTIONS

if [ "$1" = "--debug" ]; then
    rsync_options=$RSYNC_OPTIONS_DEBUG
fi

do_simple_rsync $mirror_id $rsync_options $mirror_upstream $mirror_path

