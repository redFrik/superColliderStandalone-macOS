#!/bin/bash

#for running sclang (including Qt GUI) without SCIDE

cd -- "$(dirname "$BASH_SOURCE")"
HOME=.  #the trick
*.app/Contents/MacOS/sclang -D -i scqt -l Library/Application\ Support/SuperCollider/sclang_conf.yaml
osascript -e 'tell application "Terminal" to quit' & exit  #optional: quit terminal after quitting sc
