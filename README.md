# supercolliderStandalone-macOS

Standalone template for macOS and SuperCollider version >= 3.11.0 by f0.

This method does not require any modifications to the .app bundle.

## Quickstart

1. Download [SuperCollider](https://supercollider.github.io/download) (signed or not does not matter).
2. Download the files from this repository.
3. Move one or both of the .command files together with the Library/ folder found here into the SuperCollider folder you downloaded.
4. Edit the startup.scd file found in Library/Application Support/SuperCollider/ to suit your needs.
5. Zip-archive and distribute the SuperCollider folder - now a standalone.
6. Done. Tell the user to _always_ start the standalone by double-clicking the .command script and not the .app

**Note**: Do not run the SuperCollider.app you downloaded on your machine before archiving it. The .app should be in mint condition when the user of your standalone receives it.

---

## Details

On macOS the program SuperCollider uses the user's $HOME/Library/Application Support/SuperCollider/ directory to store and read configuration and other files. This makes it hard to run completely separate installations and versions of SuperCollider on the same user account as the different applications will read and write conflicting files.

There _are_ built-in settings to ignore this directory and run 'standalone' (the -a command-line flag for sclang and the 'standalone:' in sc_ide_conf.yaml), but these never worked 100%. In this standalone mode, files are still leaking and the .app is not completely isolated.

My trick here is to dupe SuperCollider.app into thinking that the user's $HOME is the SuperCollider application folder itself! This is accomplished by a startup script that temporarily swaps out the $HOME environment variable before launching IDE or sclang. Thereby my custom Library/Application Support/SuperCollider/ folder will be used for the hardcoded paths still present inside SuperCollider.app.

### `_start_sclang.command`

The \_start_sclang.command script will start sclang without SCIDE but including Qt GUI. This is useful if you want to distribute a piece - maybe with a GUI - for someone to play/perform with. The code will not be visible.

### `_start_.command`

To start the full SuperCollider IDE double-click the \_start_.command script. This will launch the complete program as normal. Users can see and edit the code.

### `Library/`

This folder contains a few necessary class library overrides and a modified startup.scd file.

The first time you start your standalone the following files and folders will be written to Library/Application Support/SuperCollider/...

* archive.sctxar
* downloaded-quarks
* HistoryLogs
* sessions
* synthdefs
* tmp
* and the folder Help/ will be filled up with rendered help files.

### Plugins and extensions

Add any additional classes and .scx plugins you want to include to the folder Library/Application Support/SuperCollider/Extensions/

## Custom name

To give your standalone a custom name you will need to...

* change the name of the .app itself
* edit the line in the .command script to use your name
* edit the first line in sclang_conf.yaml under includePaths to use your name.

Note that it will still say SuperCollider in the top menu bar, but your .app will have the correct name in the macOS dock.
I have not tried to use a custom icon.

## Caveats

This standalone is still not completely independent. There are two minor problems with stray files and folders being written to the user's real home directory (~/Library/). But these are harmless and will not be problematic for other SuperCollider installations.

The two unsolved problems are...

1. SCIDE will create a QtWebEngine folder with some stuff in it. It will be written to your ~/Library/Application Support/SuperCollider/QtWebEngine/ folder. This path is hardcoded somewhere in the WebView primitive (related to QWebEngineSettings::LocalStorageEnabled I believe).

2. sclang is creating three files in your ~/Library/Saved Application State/ folder.
   * net.sourceforge.supercollider.savedState/data.data
   * net.sourceforge.supercollider.savedState/window_1.data
   * net.sourceforge.supercollider.savedState/windows.plist

At the moment I see no way around this without editing the C++ code and compile a custom SuperCollider.app.

Also, at startup you will get two warnings in the terminal that I do no now how to avoid:

* _scide warning: Failed to load fallback translation file._
* _/Library/Caches/com.apple.xbs/Sources/AppleGVA..._

And last, in SuperCollider IDE post window there will be a warning the first time you run the program: _file "[...]Library/Application Support/SuperCollider/Help/scdoc_version"_ does not exist. This will go away.
