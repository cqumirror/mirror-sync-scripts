#!/bin/bash

. ./common.sh

mirror_id=archlinux-cn
mirror_path=$DATA_PATH/$mirror_id
mirror_upstream="rsync://mirrors.ustc.edu.cn/repo/archlinuxcn/"
rsync_options=$SIMPLE_RSYNC_OPTIONS

if [ "$1" = "--debug" ]; then
    rsync_options=$RSYNC_OPTIONS_DEBUG
fi

do_simple_rsync $mirror_id $rsync_options $mirror_upstream $mirror_path
