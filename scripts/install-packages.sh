#!/bin/bash 

set -ex

./pharo Pharo.image eval "

Metacello new 
	baseline: 'Shift';
	repository: 'tonel://src';
	load: 'dev'.

Smalltalk saveAs:'shiftClassInstaller'.
"
