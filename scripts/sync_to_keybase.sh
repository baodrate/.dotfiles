#!/bin/bash -l
rsync -aE --delete ~/.dotfiles /keybase/private/qubidt/backup/
rsync -aE --delete ~/.journal /keybase/private/qubidt/backup/
rsync -aE --delete ~/Documents/wiki /keybase/private/qubidt/backup/
