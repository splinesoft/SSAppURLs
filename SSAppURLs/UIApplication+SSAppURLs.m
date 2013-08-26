//
//  UIApplication+SSAppURLs.m
//  SSAppURLs
//
//  Created by Jonathan Hersh on 8/25/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "UIApplication+SSAppURLs.h"

static inline NSString * SSURLFormatForAppType(SSAppURLType type) {
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
            @(SSAppURLType1PasswordHTTPURL)     : @"ophttp://%@",
            @(SSAppURLType1PasswordHTTPSURL)    : @"ophttps://%@",                        
        };
    });
    
    return appTypeDict[@(type)];
};

static inline NSString * SSSanitizedURL(NSString *input) {
  if( [input length] == 0 )
      return @"";
    
    NSRange schemeRange = [input rangeOfString:@"://"];
    
    if( schemeRange.location != NSNotFound ) {
        NSArray *bits = [input componentsSeparatedByString:@"://"];
        return [bits lastObject];
    }
    
    return input;
};

static inline NSURL * NSURLWithSchemeAndValue(NSString *scheme, NSString *value) {
    if( [scheme length] == 0 || [value length] == 0 )
        return nil;
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",
                                 scheme,
                                 value]];
}

static inline NSURL * NSURLWithAppTypeAndValue(SSAppURLType type, NSString *value) {
    NSString *format = SSURLFormatForAppType(type);
    
    if( !format )
        return nil;
    
    return [NSURL URLWithString:[NSString stringWithFormat:format,
                                 SSSanitizedURL(value)]];
};

@implementation UIApplication (SSAppURLs)

- (BOOL) canOpenAppType:(SSAppURLType)appType {
    NSURL *targetURL = NSURLWithAppTypeAndValue(appType, @"415-555-1212");
    
    if( !targetURL )
        return NO;
    
    return [self canOpenURL:targetURL];
}

- (BOOL)canOpenAppWithScheme:(NSString *)scheme {    
    NSURL *targetURL = NSURLWithSchemeAndValue(SSSanitizedURL(scheme), @"testValue");
    
    if( !targetURL )
        return NO;
    
    return [self canOpenURL:targetURL];
}

- (BOOL) openAppType:(SSAppURLType)appType
           withValue:(NSString *)value {
    
    NSURL *targetURL = NSURLWithAppTypeAndValue(appType, value);
    
    if( !targetURL )
        return NO;
    
    return [self openURL:targetURL];
}

- (BOOL)openAppWithScheme:(NSString *)scheme
                withValue:(NSString *)value {
    
    NSURL *targetURL = NSURLWithSchemeAndValue(scheme, value);
    
    if( !targetURL )
        return NO;
    
    return [self openURL:targetURL];
}

@end
