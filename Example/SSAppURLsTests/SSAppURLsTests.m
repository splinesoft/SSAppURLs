//
//  SSAppURLsTests.m
//  SSAppURLsTests
//
//  Created by Jonathan Hersh on 6/30/14.
//  Copyright (c) 2014 Splinesoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIApplication+SSAppURLs.h>

@interface SSAppURLsTests : XCTestCase

@end

@implementation SSAppURLsTests
{
    UIApplication *mockApp;
}

- (void)setUp
{
    [super setUp];
    
    mockApp = [UIApplication sharedApplication];
}

- (void)tearDown
{
    
}

- (void)testSafariFallback
{
    XCTAssert([mockApp canOpenAppType:SSAppURLTypeSafariHTTP], @"Should allow safari fallback");
    XCTAssert([mockApp canOpenAppType:SSAppURLTypeSafariHTTPS], @"Should allow https fallback");
}

- (void)testCustomHTTP
{
    XCTAssert([mockApp canOpenAppWithScheme:@"http"], @"Should allow http fallback");
    XCTAssert([mockApp canOpenAppWithScheme:@"https"], @"Should allow https fallback");
}

- (void)testInvalidPrefix
{
    XCTAssertFalse([mockApp canOpenAppWithScheme:@"://"], @"Should not allow blank scheme separator");
    XCTAssertFalse([mockApp canOpenAppWithScheme:@"://test.com"], @"Should not allow unspecified scheme");
}

- (void)testSpuriousSuffixes
{
    XCTAssert([mockApp canOpenAppWithScheme:@"http://://"], @"Should allow an extra suffix");
}

- (void)testSuperfluousSchemeSuffix
{
    XCTAssert([mockApp canOpenAppWithScheme:@"https://"], @"Should allow an extra suffix");
    XCTAssert([mockApp canOpenAppWithScheme:@"https://://test.com"], @"Should allow a spurious separator");
    XCTAssert([mockApp canOpenAppWithScheme:@"https://yolo.com"], @"Should allow full domains");
}

// This test switches to another app and does something odd on simulator
// when run on the command line: it causes the test suite to run twice.
// That's also why the second test below is commented out --
// it will always fail because we're in another app (and therefore `UIApplication`
// declines to allow us to open an app).
// At most one of these two tests can be enabled at a time; any beyond the first will fail.
- (void)testOpensSafariAppType
{
    XCTAssert([mockApp openAppType:SSAppURLTypeSafariHTTP
                         withValue:@"apple.com"],
              @"Should actually open a URL");
}

//- (void)testOpensSafariScheme
//{
//    XCTAssert([mockApp openAppWithScheme:@"http"
//                               withValue:@"apple.com"],
//              @"Should open http with scheme");
//}

@end
