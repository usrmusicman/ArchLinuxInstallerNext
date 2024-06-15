#!/bin/sh

## Add Flathub as a user instead of system-wide
flatpak remote-add --if-not-exists flathub-user --user https://dl.flathub.org/repo/flathub.flatpakrepo
