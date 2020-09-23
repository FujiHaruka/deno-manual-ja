#!/bin/bash -eux
#
# Prepare project

git submodule init
git submodule  update --recommend-shallow
