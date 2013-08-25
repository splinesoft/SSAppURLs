# SSAppURLs

Quickly check for and open URLs using iOS app URL schemes.

There are [many public lists](http://www.wiki.akosma.com/IPhone_URL_Schemes) of iOS URL schemes. `SSAppURLs` is a tiny library that makes it easy to:

* Check if the current device can open an app
* Check if the current device has certain capabilities (e.g. Facetime)
* Open an app with a URL scheme and pass an argument

`SSAppURLs` powers various URL actions and open-in-browser behavior in my app [MUDRammer - A Modern MUD Client for iPhone and iPad](https://itunes.apple.com/us/app/mudrammer-a-modern-mud-client/id597157072?mt=8).

# Install

Install with [Cocoapods](http://cocoapods.org/). Add to your Podfile:

```
pod 'SSAppURLs', :head # YOLO
```

# Examples

```objc
// Does the current device support Facetime?
BOOL deviceSupportsFacetime = [[UIApplication sharedApplication] canOpenApp:SSAppURLTypeFacetime];

// If so, let's make a call!
if( deviceSupportsFacetime )
  [[UIApplication sharedApplication] openApp:SSAppURLTypeFacetime 
                                   withValue:@"415-555-1212"];
  
// Does the current device have Chrome installed?
BOOL deviceHasChrome = [[UIApplication sharedApplication] canOpenApp:SSAppURLTypeChromeHTTP];

// If so, open a website in chrome!
if( deviceHasChrome )
	[[UIApplication sharedApplication] openApp:SSAppURLTypeChromeHTTP 
	                                 withValue:@"http://www.splinesoft.net"];
```

# Thanks!

`SSAppURLs` is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh) | [@jhersh](https://twitter.com/jhersh))