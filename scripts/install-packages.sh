#!/bin/bash 

set -ex

./pharo Pharo.image eval "
Metacello new 
	baseline: 'AtomicClassInstaller';
	repository: 'filetree://./mc';
	load.

Smalltalk saveAs:'atomicPharoInstaller'.
"

