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
    // Skype
    SSAppURLTypeSkype,
    
    // Safari fallback - plain HTTP and HTTPS
    SSAppURLTypeSafariHTTP,
    SSAppURLTypeSafariHTTPS,
    
    // Facetime
    SSAppURLTypeFacetime,
    
    // Google maps supports numerous custom arguments.
    // See https://developers.google.com/maps/documentation/ios/urlscheme
    SSAppURLTypeGoogleMaps,
    
    // Phone type can be used to determine if the device can make phone calls.
    SSAppURLTypePhone,
    
    // SMS type determines if the device can send text messages.
    SSAppURLTypeSMS,
    
    // 1Password
    SSAppURLType1PasswordSearch,
    SSAppURLType1PasswordHTTPURL,
    SSAppURLType1PasswordHTTPSURL,
    
    // Chrome
    SSAppURLTypeChromeHTTP,
    SSAppURLTypeChromeHTTPS,
    
    // Opera Mini
    SSAppURLTypeOperaHTTP,
    SSAppURLTypeOperaHTTPS,
};

/**
 * Determines if the current device is capable of opening a URL in a given app.
 * This works for device capabilities (e.g. Facetime) as well as other installed apps (e.g. Skype)
 */
- (BOOL) canOpenAppType:(SSAppURLType)appType;

/**
 * Determines if the device can open an app URL with an arbitrary scheme.
 * '://' is stripped, so pass in things like "telnet".
 */
- (BOOL) canOpenAppWithScheme:(NSString *)scheme;

/**
 * Constructs a URL and opens it in another app.
 * See `canOpenAppType:` above.
 * Return YES if an application was successfully opened.
 */
- (BOOL) openAppType:(SSAppURLType)appType
           withValue:(NSString *)value;

/**
 * Constructs a URL with an arbitrary scheme and attempts to open it.
 * It would be a good idea to check first if the device can open this URL
 * with `canOpenAppWithScheme:`.
 * Sample scheme: telnet
 * Sample value: nanvaent.org:23
 */
- (BOOL) openAppWithScheme:(NSString *)scheme
                 withValue:(NSString *)value;

@end
