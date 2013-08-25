//
//  UIApplication+SSAppURLs.m
//  SSAppURLs
//
//  Created by Jonathan Hersh on 8/25/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "UIApplication+SSAppURLs.h"

static NSString * const kSkypeFormat =          @"skype://%@?call";
static NSString * const kFacetimeFormat =       @"facetime://%@";
static NSString * const kGoogleMapsFormat =     @"comgooglemaps://%@";
static NSString * const kPhoneFormat =          @"tel:%@";
static NSString * const kSMSFormat =            @"sms:%@";
static NSString * const k1PasswordFormat =      @"onepassword://search/%@";
static NSString * const k1PasswordHTTPFormat =  @"ophttp://%@";
static NSString * const k1PasswordHTTPSFormat = @"ophttps://%@";
static NSString * const kChromeHTTPFormat =     @"googlechrome://%@";
static NSString * const kChromeHTTPSFormat =    @"googlechromes://%@";
static NSString * const kOperaHTTPFormat =      @"ohttp://%@";
static NSString * const kOperaHTTPSFormat =     @"ohttps://%@";

// Safari fallback
static NSString * const kSafariHTTPURLFormat =  @"http://%@";
static NSString * const kSafariHTTPSURLFormat = @"https://%@";

static inline NSString * SSURLFormatForAppType(SSAppURLType appType) {
    switch( appType ) {
        case SSAppURLTypeSkype:
            return kSkypeFormat;
        case SSAppURLTypeFacetime:
            return kFacetimeFormat;
        case SSAppURLTypeGoogleMaps:
            return kGoogleMapsFormat;
        case SSAppURLTypePhone:
            return kPhoneFormat;
        case SSAppURLTypeSMS:
            return kSMSFormat;
        case SSAppURLType1PasswordSearch:
            return k1PasswordFormat;
        case SSAppURLType1PasswordHTTPURL:
            return k1PasswordHTTPFormat;
        case SSAppURLType1PasswordHTTPSURL:
            return k1PasswordHTTPSFormat;
        case SSAppURLTypeChromeHTTP:
            return kChromeHTTPFormat;
        case SSAppURLTypeChromeHTTPS:
            return kChromeHTTPSFormat;
        case SSAppURLTypeOperaHTTP:
            return kOperaHTTPFormat;
        case SSAppURLTypeOperaHTTPS:
            return kOperaHTTPSFormat;
        case SSAppURLTypeSafariHTTP:
            return kSafariHTTPURLFormat;
        case SSAppURLTypeSafariHTTPS:
            return kSafariHTTPSURLFormat;
        default:
            break;
    }
    
    return nil;
}

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
