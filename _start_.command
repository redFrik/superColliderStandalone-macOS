#!/bin/bash

#for running the full SuperCollider IDE

cd -- "$(dirname "$BASH_SOURCE")"
HOME=.  #the trick
SuperCollider.app/Contents/MacOS/SuperCollider  #optional: set a custom name for the .app
osascript -e 'tell application "Terminal" to quit' & exit  #optional: quit terminal after quitting sc
