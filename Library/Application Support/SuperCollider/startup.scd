var userPath= thisProcess.nowExecutingPath.dirname.standardizePath;
var rootPath= userPath.dirname.dirname.dirname;
"hier!".postln;


//--required: else .scx plugs will be loaded from default location
s.options.ugenPluginsPath= [
	Platform.resourceDir.escapeChar($().escapeChar($))+/+"plugins",  //the plugins folder inside .app bundle
	userPath.escapeChar($().escapeChar($))+/+"Extensions"  //our Extensions folder. also add this in sclang_conf.yaml
].postln;

//--required: else .synthdef files will be loaded from default location
"SC_SYNTHDEF_PATH".setenv(userPath+/+"synthdefs");
SynthDef.synthDefDir= userPath+/+"synthdefs";

//--recommended: set up a custom recordings directory in application root folder
thisProcess.platform.recordingsDir= rootPath+/+"recordings";


//--optional: post some info
//SerialPort.listDevices;
"\n//--local address:".postln;
NetAddr.localAddr.postln;
"\n//--server options:".postln;
s.options.asOptionsString.postln;
"\n//--root path:".postln;
rootPath.postln;
"\n//--startup files:".postln;
thisProcess.platform.startupFiles.do{|x| x.postln};
"\n//--include paths:".postln;
LanguageConfig.includePaths.do{|x| x.postln};
"".postln;

//--optional: show level meters
s.meter;

//--optional: (for when not running scide) add Quit Cmd+Q menu item
{
	if(ScIDE.connected.not, {
		View.globalKeyDownAction= View.globalKeyDownAction.addFunc({|view, chr, mod, unicode, keycode, key|
			if(mod.isCmd and:{keycode==12}, {  //cmd+q
				0.exit;
			});
		});
		MainMenu.initBuiltInMenus;
	});
}.defer(1);


//--optional: add your standard startup file stuff below e.g. soundcard, latency and memory settings

//--and/or load and run your code automatically at startup like this example...
//s.waitForBoot{"examples/pieces/microhelix_study.scd".load};
