# supercolliderStandalone-macOS

Standalone template for macOS and SuperCollider version >= 3.11.0 by f0.

This version does not need any modifications to the .app bundle.

_The program SuperCollider on macOS uses the user's $HOME/Library/SuperCollider directory to store files in. This makes it hard to run separate installations and versions on the same user account. The different applications will read and write conflicting files. In the configuration files for SuperCollider there are settings to ignore this directory and run 'standalone', but it never worked 100%. My trick here is to dupe SC into thinking that $HOME is the SuperCollider application folder itself and use the included Library/SuperCollider/ instead of the global ~/Library/SuperCollider/._

## Quick start

1. Download [SuperCollider](https://supercollider.github.io/download) (signed or not does not matter).
2. Download the files in this repository.
3. Move one of the .command files and the Library folder found here into the new SuperCollider folder.
4. Edit the startup.scd file found in Library/Application Support/SuperCollider/ to suit your needs.
5. Zip-archive and distribute the SuperCollider folder - now a standalone.
6. Done. Tell the user to _always_ start the standalone by double-clicking the .command script and not the .app

**NOTE**: do not run the SuperCollider.app you downloaded on your machine before archiving it. The .app should be in mint condition when the user of your standalone receives it.


## Details

Some unsorted notes...

* The start script `_start_sclang.command` will start sclang without SCIDE but including Qt GUI. This is useful if you want to distribute a piece - maybe with a GUI - for someone to play/perform with. The code will not be visible.

* To start the full SuperCollider IDE double-click the `_start_.command` script. This will launch the complete program as normal. Users can see and edit the code.

* The first time you start this standalone the following files and folders will be written to Library/SuperCollider/...
  - archive.sctxar
  - downloaded-quarks
  - HistoryLogs
  - sessions
  - synthdefs
  - tmp
  - and the folder Help will be filled with the rendered help files.

* at startup you will get two harmless warnings in the terminal:  
  `scide warning: Failed to load fallback translation file.`  
  `/Library/Caches/com.apple.xbs/Sources/AppleGVA...`


## Caveats

This standalone is still not 100% independent. There are two minor problems with stray files being written to the user's real home directory. But these will both not conflict with other SuperCollider installations.

* PROBLEM #2  
  SCIDE will create a QtWebEngine folder with some stuff will be written into your `~/Library/Application\ Support/SuperCollider/QtWebEngine/`  
  This path is hardcoded somewhere in WebView primitive (related to QWebEngineSettings::LocalStorageEnabled I believe).

* PROBLEM #3
  sclang is creating three files in your `~/Library/Saved\ Application\ State/`  
  `net.sourceforge.supercollider.savedState/data.data`  
  `net.sourceforge.supercollider.savedState/window_1.data`  
  `net.sourceforge.supercollider.savedState/windows.plist`
