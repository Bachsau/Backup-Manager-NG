#!/bin/sh
# $Revision: $
# $Date: $

set -e

# Each test script should include testlib.sh
source testlib.sh
# When the test is ready, set this to false for nice outputs.
# if you want to see what happens, use those flags
# verbose="true"
# warnings="true"

# The conffile part of the test, see confs/* for details.
source confs/base.conf
source confs/tarball.conf

export BM_ARCHIVE_ROOT="repository"
export BM_ARCHIVE_METHOD="tarball-incremental"
export BM_TARBALL_DIRECTORIES="$PWD"
export BM_TARBALLINC_MASTERDATETYPE="weekly"

# The test actions

if [ -e $BM_ARCHIVE_ROOT ]; then
    rm -f $BM_ARCHIVE_ROOT/*
fi    

bm_init_env
bm_init_today
create_archive_root_if_not_exists
make_archives

name=$(get_dir_name $PWD long)
if [ -e "$BM_ARCHIVE_ROOT/$BM_ARCHIVE_PREFIX$name.$TODAY.tar.gz" ] && 
   [ -e "$BM_ARCHIVE_ROOT/$BM_ARCHIVE_PREFIX$name.incremental-list.txt" ] ; then
    exit 0
else
    exit 1
fi        
