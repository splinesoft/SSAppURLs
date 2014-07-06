# SSAppURLs

[![Build Status](https://travis-ci.org/splinesoft/SSAppURLs.png?branch=master)](https://travis-ci.org/splinesoft/SSAppURLs)

Quickly check for and open URLs using [iOS app URL schemes](http://www.wiki.akosma.com/IPhone_URL_Schemes).

`SSAppURLs` is a tiny `UIApplication` category that makes it easy to:

* Check if the current device has an app installed (e.g. Skype)
* Check if the current device has certain capabilities (e.g. Facetime)
* Open an app with a URL scheme and pass some arguments

`SSAppURLs`, along with [SSPreferredBrowser](https://github.com/splinesoft/SSPreferredBrowser), powers various URL actions and open-in-browser behavior in my app [MUDRammer - A Modern MUD Client for iPhone and iPad](https://itunes.apple.com/us/app/mudrammer-a-modern-mud-client/id597157072?mt=8).

# Install

Install with [Cocoapods](http://cocoapods.org/). Add to your Podfile:

```
pod 'SSAppURLs', :head # YOLO
```

# Examples

Check out `Example` for an app example.


```objc
#import <UIApplication+SSAppURLs.h>

// Does the current device have skype installed?
BOOL deviceSupportsSkype = [[UIApplication sharedApplication] 
                             canOpenAppType:SSAppURLTypeSkype];

// If so, let's make a call!
if (deviceSupportsSkype) {
    [[UIApplication sharedApplication] openAppType:SSAppURLTypeSkype 
                                         withValue:@"415-555-1212"];
}
  
// Does the current device have Chrome installed?
BOOL deviceHasChrome = [[UIApplication sharedApplication] 
                        canOpenAppType:SSAppURLTypeChromeHTTP];

// If so, open a website in chrome!
if (deviceHasChrome) {
	[[UIApplication sharedApplication] openAppType:SSAppURLTypeChromeHTTP 
	                                     withValue:@"http://www.splinesoft.net"];
}
	                                     
// Check for an arbitrary scheme type
BOOL deviceHasTelnetApp = [[UIApplication sharedApplication] 
                           canOpenAppWithScheme:@"telnet"];

// Let's play NANVAENT!
if (deviceHasTelnetApp) {
	[[UIApplication sharedApplication] openAppWithScheme:@"telnet"
	                                           withValue:@"nanvaent.org:23"];
}
```

# Thanks!

`SSAppURLs` is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh) | [@jhersh](https://twitter.com/jhersh))