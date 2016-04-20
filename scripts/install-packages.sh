#!/bin/bash 

set -ex

./pharo Pharo.image eval --save "
Metacello new 
	baseline: 'AtomicClassInstaller';
	repository: 'filetree://./mc';
	load.
"

