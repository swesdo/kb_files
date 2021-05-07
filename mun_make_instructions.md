#!/bin/bash

# Unix/Mac/Linux/terminal modified guide for downloading developer branch of qmk from rgbkb and compiling Mün firmware with cli flashing steps
# Mün is an ortholinear/ergo keyboard created by Legonut of RGBKB (rgbkb.net)
# This modied guide written by swesdo

# install qmk/dependencies - *optional you may have already done this via pip or homebrew, if you don't have the dependencies you'll run into an error when compiling firmware. If you already have a build environment setup from other boards you should be able to skip to the next step.

python3 -m pip install qmk

# make dev_qmk build directory (if you already have a current qmk build environment and don't want to overwrite it.)

mkdir -p ~/dev_qmk ;

# cd into the directory you just made

cd ~/dev_qmk ;

# clone development rgbkb/qmk fork

git clone -b development https://github.com/rgbkb/qmk_firmware

# cd in this cloned directory

cd qmk_firmware

# update/initialize submodules so you can compile correctly

git submodule update --init --recursive

# change directory to keyboards, clear out everything that isn't rgbkb. change directories back up one level to dev_qmk/qmk_firmware. Clears around 100M of data.

cd keyboards ; find ./ -maxdepth 1 ! -iname rgbkb ! -iname readme.md -execdir rm -vrf {} \; cd ..

# compile firmware, replace default with your keymap name if you want to program your own mapping.

make rgbkb/mun/rev1:default

# tbd echo response flashing below

# flashing

# connect left half and place in bootloader mode

make rgbkb/mun/rev1:default:dfu-util-split-left

# connect right half and place in bootloader mode

make rgbkb/mun/rev1:default:dfu-util-split-right

# generic flash

make rgbkb/mun/rev1:default:dfu-util



