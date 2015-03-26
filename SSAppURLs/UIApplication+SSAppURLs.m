//
//  UIApplication+SSAppURLs.m
//  SSAppURLs
//
//  Created by Jonathan Hersh on 8/25/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "UIApplication+SSAppURLs.h"

static NSString * const kSchemeSeparator = @"://";

CG_INLINE NSString * SSURLFormatForAppType(SSAppURLType type) {
    static NSDictionary *appTypeDict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appTypeDict = @{
            @(SSAppURLTypeSkype)                : @"skype://%@?call",
            @(SSAppURLTypeSMS)                  : @"sms:%@",
            @(SSAppURLTypeSafariHTTPS)          : @"https://%@",
            @(SSAppURLTypeSafariHTTP)           : @"http://%@",
            @(SSAppURLTypePhone)                : @"tel:%@",
            @(SSAppURLTypeOperaHTTP)            : @"ohttp://%@",
            @(SSAppURLTypeOperaHTTPS)           : @"ohttps://%@",
            @(SSAppURLTypeGoogleMaps)           : @"comgooglemaps://%@",
            @(SSAppURLTypeFacetime)             : @"facetime://%@",
            @(SSAppURLTypeChromeHTTP)           : @"googlechrome://%@",
            @(SSAppURLTypeChromeHTTPS)          : @"googlechromes://%@",
            @(SSAppURLType1PasswordSearch)      : @"onepassword://search/%@",
            @(SSAppURLType1PasswordHTTP)        : @"ophttp://%@",
            @(SSAppURLType1PasswordHTTPS)       : @"ophttps://%@",         
            @(SSAppURLTypeFacebook)             : @"fb://%@",
            @(SSAppURLTypeTwitter)              : @"twitter://%@",
            @(SSAppURLTypeInstagram)            : @"instagram://%@",
            @(SSAppURLTypeGoogleEarth)          : @"comgoogleearth://%@",
            @(SSAppURLTypeIMDB)                 : @"imdb://%@",
            @(SSAppURLTypeGooglePlus)           : @"gplus://%@",
        };
    });
    
    return appTypeDict[@(type)];
};

CG_INLINE NSString * SSSanitizedURL(NSString *input) {
    if ([input length] == 0) {
        return @"";
    }
    
    NSRange schemeRange = [input rangeOfString:kSchemeSeparator];
    
    if (schemeRange.location != NSNotFound) {
        // This URL already has a scheme separator (://) and it falls at the end
        if ([input hasSuffix:kSchemeSeparator]) {
            return input;
        }
        
        // URL begins with a scheme? No good.
        if ([input hasPrefix:kSchemeSeparator]) {
            return [input substringFromIndex:[kSchemeSeparator length]];
        }
        
        // There is a scheme separator somewhere else. return it as-is
        return input;
    }
    
    return [input stringByAppendingString:kSchemeSeparator];
};

CG_INLINE NSURL * NSURLWithSchemeAndValue(NSString *scheme, NSString *value) {
    if ([scheme length] == 0) {
        return nil;
    }
  
    NSString *URLString = SSSanitizedURL(scheme);
  
    if ([value length] > 0) {
        URLString = [URLString stringByAppendingString:SSSanitizedURL(value)];
    }
    
    return [NSURL URLWithString:URLString];
}

CG_INLINE NSURL * NSURLWithAppTypeAndValue(SSAppURLType type, NSString *value) {
    NSString *format = SSURLFormatForAppType(type);
    
    if (!format) {
        return nil;
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:format,
                                 SSSanitizedURL(value)]];
};

@implementation UIApplication (SSAppURLs)

- (BOOL) canOpenAppType:(SSAppURLType)appType {
    NSURL *targetURL = NSURLWithAppTypeAndValue(appType, nil);
    
    if (!targetURL) {
        return NO;
    }
    
    return [self canOpenURL:targetURL];
}

- (BOOL)canOpenAppWithScheme:(NSString *)scheme {    
    NSURL *targetURL = NSURLWithSchemeAndValue(scheme, nil);
    
    if (!targetURL) {
        return NO;
    }
    
    return [self canOpenURL:targetURL];
}

- (BOOL) openAppType:(SSAppURLType)appType
           withValue:(NSString *)value {
    
    NSURL *targetURL = NSURLWithAppTypeAndValue(appType, value);
    
    if (!targetURL) {
        return NO;
    }
    
    return [self openURL:targetURL];
}

- (BOOL)openAppWithScheme:(NSString *)scheme
                withValue:(NSString *)value {
    
    NSURL *targetURL = NSURLWithSchemeAndValue(scheme, value);
    
    if (!targetURL) {
        return NO;
    }
    
    return [self openURL:targetURL];
}

@end
