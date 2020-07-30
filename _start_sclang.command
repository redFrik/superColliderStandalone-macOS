#!/bin/bash

#for running sclang (including Qt GUI) without SCIDE

cd -- "$(dirname "$BASH_SOURCE")"
HOME=.  #the trick
SuperCollider.app/Contents/MacOS/sclang -a -i scqt -l Library/Application\ Support/SuperCollider/sclang_conf.yaml
osascript -e 'tell application "Terminal" to quit' & exit  #optional: quit terminal after quitting sc