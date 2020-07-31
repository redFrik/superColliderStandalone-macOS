#!/bin/bash

#for running sclang (including Qt GUI) without SCIDE

cd -- "$(dirname "$BASH_SOURCE")"
HOME=.  #the trick
SuperCollider.app/Contents/MacOS/sclang -a -D -i scqt -l Library/Application\ Support/SuperCollider/sclang_conf.yaml  #optional: set a custom name for the app
osascript -e 'tell application "Terminal" to quit' & exit  #optional: quit terminal after quitting sc
