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

The first time you start your standalone the following files and folders will be created inside here...

* archive.sctxar
* downloaded-quarks
* HistoryLogs
* sessions
* synthdefs
* tmp
* and the empty folder Help/ will be filled up with rendered help files.

### Plugins and extensions

Put any additional classes and .scx plugins you want to include in the folder Library/Application Support/SuperCollider/Extensions/

You can also make your own extensions folder and include it like normal in the file sclang_conf.yaml under includePaths.

As a side note, you might also want to turn off postInlineWarnings by setting it to false in sclang_conf.yaml.

## Custom name

To give your standalone a unique name you will need to...

* change the name of the .app itself
* edit the line in the .command script to use that name
* edit the first line in sclang_conf.yaml under includePaths to use that name.

Note that your standalone will still say SuperCollider in the top menu bar, but your .app will have the correct name in the macOS dock.
I have not tried to use a custom icon.

## Caveats

This standalone is still not completely independent. There are two minor problems with stray files and folders being written to the user's real home directory (~/Library/). But these are harmless and will not be problematic for other SuperCollider installations.

The two unsolved problems are...

1. SCIDE will create a QtWebEngine folder with some stuff in it. It will be written to your ~/Library/Application Support/SuperCollider/QtWebEngine/ folder. This path is hardcoded somewhere in the WebView primitive (related to QWebEngineSettings::LocalStorageEnabled I believe).

2. sclang is creating a folder with three files in your ~/Library/Saved Application State/ folder. The files are...
   * net.sourceforge.supercollider.savedState/data.data
   * net.sourceforge.supercollider.savedState/window_1.data
   * net.sourceforge.supercollider.savedState/windows.plist

At the moment I see no way around this without editing the C++ code and compile a custom SuperCollider.app.

Also, at startup you will get two warnings in the terminal that I do not know how to avoid:

* _scide warning: Failed to load fallback translation file._
* _/Library/Caches/com.apple.xbs/Sources/AppleGVA..._

This method is confirmed to work under macOS 10.12.6 with SuperCollider 3.11.0. 

---

## Refining

Here is how you can use the wonderful software [Platypus](https://sveinbjorn.org/platypus) together with the files in this repository to make a native application with an icon.

1. Download [SuperCollider](https://supercollider.github.io/download) (signed or not does not matter).
2. Download the files from this repository.
3. Copy the Library/ folder from here to the SuperCollider folder
4. Edit the startup.scd file found in Library/Application Support/SuperCollider/ to suit your needs.

The top-level of your standalone should now look something like this...

```
SuperCollider/
│   AUTHORS
│   CHANGELOG.md
│   COPYING
│   examples/
│   Library/
│   README_MACOS.md
│   README.md
│   SuperCollider.app
```

**Note**: You are required to keep the licensing files.

5. Start Platypus.app (<https://sveinbjorn.org/platypus>).
6. Click 'Select Script...' and find either \_start_.command or _start_sclang.command (depending on if you want to use the full IDE or only run sclang).
7. Set App Name and add an icon.
8. You can experiment with different Interfaces but normally you will want to set this to 'None'.
9. 'Run with root privileges' - OFF
10. 'Run in background' - OFF
11. 'Remain running after execution' - OFF
12. Click the + sign and add all the files from inside the SuperCollider folder above (AUTHORS, CHANGELOG, COPYING etc).
13. Click 'Create App'.
14. 'Strip nib file to reduce app size' will not save you much (~100kB here) so I suggest turning that OFF.
15. Done. Zip-archive it for distribution and _then_ test it.

**Note**: Again, do not run the .app on your machine. The .app should be in mint condition when the user receives and unpacks it.
