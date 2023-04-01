#!/bin/bash

# -e   exit immediately if a command returns a non-zero status
# -x   display each command and its attributes sequentially
set -ex

# init and validate
packer init .
packer validate .

# set to array
params=()

# test for input "debug"; add to params if set
if [[ $PACKER_DEBUG == true ]]; then
  params+=(-debug)
fi

# test for input "on_error_abort"; add to params if set
if [[ $PACKER_ON_ERROR_ABORT == true ]]; then
  params+=(-on-error=abort)
fi

# build
packer build "${params[@]}" .
