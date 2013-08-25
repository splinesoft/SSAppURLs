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
    
    // Safari
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

/*
 * Determines if the current device is capable of opening a URL in a given app.
 * This works for device capabilities (e.g. facetime) as well as other installed apps (e.g. Skype)
 */
- (BOOL) canOpenApp:(SSAppURLType)appType;

/*
 * Constructs a URL and opens it in another app.
 * See `canOpenApp:` above.
 * Return YES if an application was actually opened.
 */
- (BOOL) openApp:(SSAppURLType)appType withValue:(NSString *)value;

@end
