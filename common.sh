#!/bin/bash
#
# Common vars and functions.
#

DATA_PATH=/srv/www/mirrors
LOG_PATH=/var/log/mirrors/sync
ERR_LOG=$LOG_PATH/error.log

SIMPLE_RSYNC_OPTIONS="-azqH --delete"
RSYNC_OPTIONS_DEBUG="-azvP"


function datetime_now
{
    echo -n `date +"%Y-%m-%dT%H:%M:%SZ"`
}

function init_sync
{
    local mirror_id=$1
    local mirror_path=$2
    local mirror_log=$LOG_PATH/$mirror_id.log

    mkdir -p $LOG_PATH
    mkdir -p $mirror_path

    datetime_now >> $mirror_log
    echo " syncing" >> $mirror_log
}

function post_sync
{
    local mirror_id=$1
    local mirror_upstream=$2
    local mirror_log=$LOG_PATH/$mirror_id.log
    local err_code=$3

    datetime_now >> $mirror_log
    if [ $err_code -eq 0 ]; then
        echo " success" >> $mirror_log
    else
        echo " failed $err_code" >> $mirror_log
        datetime_now >> $ERR_LOG
        echo " $mirror_id failed to sync from $mirror_upstream" >> $ERR_LOG
    fi
}

function do_simple_rsync()
{
    local mirror_id=$1
    local rsync_options=$2
    local mirror_upstream=$3
    local mirror_path=$4

    init_sync $mirror_id $mirror_path
    rsync $rsync_options $mirror_upstream $mirror_path 2>$ERR_LOG
    post_sync $mirror_id $mirror_upstream $?
}

