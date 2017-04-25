#!/bin/bash 

set -ex

./pharo Pharo.image eval "

EpMonitor current disable.

Metacello new 
	baseline: 'AtomicClassInstaller';
	repository: 'filetree://./mc';
	load.

EpMonitor current enable.

Smalltalk saveAs:'atomicPharoInstaller'.
"

