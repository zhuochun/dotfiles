#!/usr/bin/env bash

# Create a localrc
mkdir localrc

# Backup SSH
mkdir localrc/ssh
cp ~/.ssh/* localrc/ssh
rm localrc/ssh/authorized*

# Backup local
cp ~/.localrc localrc/localrc
cp ~/.localenv localrc/localenv

# Backup gitconfig
cp ~/.gitconfig localrc/gitconfig
