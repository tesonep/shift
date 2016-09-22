#!/bin/bash 

set -ex

./pharo atomicPharoInstaller.image eval --save "
Deprecation showWarning: false.
Deprecation raiseWarning: false.
"

