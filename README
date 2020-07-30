# supercolliderStandalone-macOS

Standalone template for macOS and SuperCollider version >= 3.11.0 by f0. This version does not need any modifications to the .app bundle.

The program SuperCollider on macOS tends to use the user's $HOME Library directory to store files in. This makes it hard to run separate installations and versions on the same user account. They will read and write conflicting files. In the configuration files for SuperCollider there are settings to ignore this directory and run 'standalone', but it never worked 100%. My trick here is to dupe SC into thinking that $HOME is the SuperCollider application folder itself! Thereby the Library/SuperCollider/ folder included here will be used instead of the ~/Library/SuperCollider/.

## Instructions

1. Download [SuperCollider](https://supercollider.github.io/download) (signed or not does not matter).
2. Download the files in this repository.
3. Move one of the .command files and the Library folder found here into the new SuperCollider folder.
4. Edit the startup.scd file found in Library/Application Support/SuperCollider/ to suit your needs.
5. Zip-archive and distribute the SuperCollider folder - now a standalone.
6. Done. Tell the user to _always_ start the standalone by double-clicking the .command script and not the .app

**NOTE**: do not run the SuperCollider.app you downloaded on your machine before archiving it. The .app should be in mint condition when the user of your standalone receives it.


### Details

The start script `_start_sclang.command` will start sclang (including Qt GUI) without SCIDE. This is useful if you want to distribute a piece - maybe with a GUI - for someone to play/perform with. The code will not be visible.

To start the full SuperCollider IDE double-click the `_start_.command` script. This will launch the complete program as normal.

The first time you start this standalone the following files and folders will be written to Library/SuperCollider/...
* archive.sctxar
* downloaded-quarks
* HistoryLogs
* sessions
* synthdefs
* tmp
* and the folder Help will be filled with the rendered help files.


### Caveats

* PROBLEM #1
  you will get two harmless warnings in the terminal:  
  `scide warning: Failed to load fallback translation file.`  
  `/Library/Caches/com.apple.xbs/Sources/AppleGVA...`

* PROBLEM #2
  SCIDE creates a QtWebEngine folder with some stuff will be written into your ~/Library/Application\ Support/SuperCollider/QtWebEngine/. This path is hardcoded somewhere in WebView primitive (related to QWebEngineSettings::LocalStorageEnabled I believe). It will not conflict with your other SuperCollider installations.

* PROBLEM #3
  sclang is creating these files in your `~/Library/Saved\ Application\ State/`  
  `net.sourceforge.supercollider.savedState/data.data`  
  `net.sourceforge.supercollider.savedState/window_1.data`  
  `net.sourceforge.supercollider.savedState/windows.plist`  
  again these will not interfere with your other SuperCollider installations.
