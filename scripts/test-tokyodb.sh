#!/bin/bash 

set -ex

git clone --depth=1 https://github.com/estebanlm/tokyodb.git

./pharo Pharo.image eval "
Metacello new 
	baseline: 'TokyoDB';
	repository: 'filetree://./tokyodb/mc';
	load.

Smalltalk saveAs:'tokyoDBTest'.
"

cp tokyodb/lib/linux/libtokyocabinet.so.9.11.0 .

./pharo tokyoDBTest.image test --no-xterm --fail-on-failure "TokyoDB"

