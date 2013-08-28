//
//  UIApplication+SSAppURLs.h
//  SSAppURLs
//
//  Created by Jonathan Hersh on 8/25/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIApplication (SSAppURLs)

// URL formats for shared apps.
typedef NS_ENUM( NSUInteger, SSAppURLType ) {
    // Phone type can be used to determine if the device can make phone calls.
    SSAppURLTypePhone,
  
    // SMS type determines if the device can send text messages.
    SSAppURLTypeSMS,
  
    // Facetime
    SSAppURLTypeFacetime,
  
    // Skype
    SSAppURLTypeSkype,
    
    // Safari fallback - plain HTTP and HTTPS
    SSAppURLTypeSafariHTTP,
    SSAppURLTypeSafariHTTPS,
    
    // Google maps supports numerous custom arguments.
    // See https://developers.google.com/maps/documentation/ios/urlscheme
    SSAppURLTypeGoogleMaps,
  
    // Google Earth
    SSAppURLTypeGoogleEarth,
  
    // Google Plus
    SSAppURLTypeGooglePlus,
    
    // Chrome
    SSAppURLTypeChromeHTTP,
    SSAppURLTypeChromeHTTPS,
  
    // 1Password
    SSAppURLType1PasswordSearch,
    SSAppURLType1PasswordHTTP,
    SSAppURLType1PasswordHTTPS,
    
    // Opera Mini
    SSAppURLTypeOperaHTTP,
    SSAppURLTypeOperaHTTPS,
  
    // Facebook
    SSAppURLTypeFacebook,
  
    // Twitter
    SSAppURLTypeTwitter,
  
    // Instagram
    // See http://instagram.com/developer/iphone-hooks/#
    SSAppURLTypeInstagram,
  
    // IMDB
    SSAppURLTypeIMDB,
};

/**
 * Determines if the current device is capable of opening a URL in a given app.
 * This works for device capabilities (e.g. Facetime) as well as other installed apps (e.g. Skype)
 *
 * @return YES if the device can open this app type.
 */
- (BOOL) canOpenAppType:(SSAppURLType)appType;

/**
 * Determines if the device can open an app URL with an arbitrary scheme.
 * '://' is stripped, so pass in things like "telnet".
 *
 * @return YES if the device can open an app to handle this scheme.
 */
- (BOOL) canOpenAppWithScheme:(NSString *)scheme;

/**
 * Constructs a URL and opens it in another app.
 * See `canOpenAppType:` above.
 *
 * @return YES if an application was successfully opened.
 */
- (BOOL) openAppType:(SSAppURLType)appType
           withValue:(NSString *)value;

/**
 * Constructs a URL with an arbitrary scheme and attempts to open it.
 * It would be a good idea to check first if the device can open this URL
 * with `canOpenAppWithScheme:`.
 * Sample scheme: telnet
 * Sample value: nanvaent.org:23
 *
 * @return YES if an application was successfully opened.
 */
- (BOOL) openAppWithScheme:(NSString *)scheme
                 withValue:(NSString *)value;

@end
