#!/bin/bash

reporoot=$(readlink -f $(dirname $0))

[[ -f install-lib ]] || curl -sSOL https://raw.githubusercontent.com/roxell/local-inst-lib/master/install-lib
source install-lib

install_files=(
    "$HOME/.mutt:${reporoot}/mutt"
    "$HOME/.mailcap:${reporoot}/mailcap"
    "$HOME/mutt-filters:${reporoot}/repos/mutt-filters"
    "$HOME/.offlineimap.py:${reporoot}/offlineimap/offlineimap.py"
    "$HOME/bin/get_password.py:${reporoot}/repos/keyring-password/get_password.py"
)

external_repositories=(
    "git://github.com/roxell/keyring-password.git"
    "git://github.com/terabyte/mutt-filters.git"
)

mkdir -p ${HOME}/bin
mkdir -p ${HOME}/incoming
mkdir -p ${reporoot}/repos
pushd ${reporoot}/repos
download_external_repositories
popd

create_symlink

###############################################################################
# vim: set ts=4 sw=4 sts=4 et                                                 :
