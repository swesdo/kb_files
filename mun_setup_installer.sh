#!/bin/bash

echo "Unix/Mac/Linux/terminal modified guide for downloading developer branch of qmk from rgbkb and compiling Mün firmware with cli flashing steps"
echo "Mün is an ortholinear/ergo keyboard created by Legonut of RGBKB (rgbkb.net)"
echo "Shell Script by swesdo"
echo "--------------------------------------------------------------------"
echo "Install qmk/dependencies - *optional you may have already done this via pip or homebrew,
   If you don't have the dependencies you'll run into an error when compiling firmware.
   If you already have a build environment setup from other boards you should be able to skip to the next step."

echo -n "Install qmk & its dependencies? [Y/n]

(hint: if you've already setup a qmk build environment on this computer type n) : "

read install_choice

if [[ $install_choice == y* ]]
then
  echo "Installing QMK dependencies via pip." ; python3 -m pip install qmk
else
  echo "Skipping QMK install, it is already on the system, making dev_qmk folder only."
fi

# make dev_qmk build directory (if you already have a current qmk build environment and don't want to overwrite it.)

mkdir -p ~/dev_qmk

# cd into the directory you just made

cd ~/dev_qmk

echo "Cloning qmk development branch from rgbkb"

# clone development rgbkb/qmk fork

git clone -b development https://github.com/rgbkb/qmk_firmware

# cd in this cloned directory

cd qmk_firmware

echo "Initializing qmk branch git clone submodules"

# update/initialize submodules so you can compile correctly

git submodule update --init --recursive

echo -n "Clean out other keyboard folders? [Y/n]

(hint: type yes if you want to clear out all keyboard folders except rgbkb in this rgbkb specific directory) : "

read folder_clean

if [[ $folder_clean == y* ]]
then
  echo "Cleaning folder of everything excep rgbkb folder" ; cd keyboards ; find ./ -maxdepth 1 ! -iname rgbkb ! -iname readme.md -execdir rm -vrf {} \; cd ..
else
  echo "Skipping folder clean."
fi

# change directory to keyboards, clear out everything that isn't rgbkb. change directories back up one level to dev_qmk/qmk_firmware.
# Clears around 100M of data.

echo "compiling mun firmware in ~/dev_qmk/qmk_firmware/"

# compile firmware, replace default with your keymap name if you want to program your own mapping.

make rgbkb/mun/rev1:default

# flashing

echo "
-----------------
flashing
-----------------
# connect left half, place in bootloader mode
# copy the next line and paste into terminal:

make rgbkb/mun/rev1:default:dfu-util-split-left
-
# then...
-
# connect right half, place in bootloader mode

# copy the next line and paste into terminal:

make rgbkb/mun/rev1:default:dfu-util-split-right
-
# generic flash from anywhere*
-
cd ; cd ~/dev_qmk/qmk_firmware ; make rgbkb/mun/rev1:default:dfu-util"



