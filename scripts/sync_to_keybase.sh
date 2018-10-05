#!/bin/bash -l
rsync -aE --delete ~/.dotfiles /keybase/private/qubidt/
rsync -aE --delete ~/.journal /keybase/private/qubidt/
rsync -aE --delete ~/Documents/wiki /keybase/private/qubidt/
