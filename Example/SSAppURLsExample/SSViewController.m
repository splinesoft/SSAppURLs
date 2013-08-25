//
//  SSViewController.m
//  SSAppURLsExample
//
//  Created by Jonathan Hersh on 8/25/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSViewController.h"
#import <UIApplication+SSAppURLs.h>
#import <SSDataSources.h>

static inline NSString * NSStringFromAppURLType(SSAppURLType type) {
    switch( type ) {
        case SSAppURLTypePhone:
            return @"Phone";
        case SSAppURLTypeSkype:
            return @"Skype";
        case SSAppURLTypeOperaHTTP:
            return @"Opera";
        case SSAppURLTypeFacetime:
            return @"Facetime";
        case SSAppURLTypeChromeHTTP:
            return @"Chrome";
        case SSAppURLType1PasswordSearch:
            return @"1Password";
        case SSAppURLTypeSMS:
            return @"SMS";
        case SSAppURLTypeGoogleMaps:
            return @"Google Maps";
        case SSAppURLTypeSafariHTTP:
            return @"Safari";
        default:
            break;
    }
    
    return nil;
};

@interface SSViewController ()

@end

@implementation SSViewController {
    SSArrayDataSource *dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Available Apps";
    
    NSArray *appTypes = @[
      @(SSAppURLType1PasswordSearch),
      @(SSAppURLTypeChromeHTTP),
      @(SSAppURLTypeFacetime),
      @(SSAppURLTypeGoogleMaps),
      @(SSAppURLTypeOperaHTTP),
      @(SSAppURLTypeSkype),
      @(SSAppURLTypeSMS),
      @(SSAppURLTypePhone),
      @(SSAppURLTypeSafariHTTP),
    ];
    NSIndexSet *availableAppIndexes = [appTypes indexesOfObjectsPassingTest:^BOOL(NSNumber *object,
                                                                                  NSUInteger index,
                                                                                  BOOL *stop) {
        return [[UIApplication sharedApplication] canOpenAppType:(SSAppURLType)[object
                                                                            unsignedIntegerValue]];
    }];
	
    dataSource = [[SSArrayDataSource alloc] initWithItems:
                  [appTypes objectsAtIndexes:availableAppIndexes]];
    
    dataSource.cellConfigureBlock = ^(SSBaseTableCell *cell,
                                      NSNumber *appType,
                                      UITableView *tableView,
                                      NSIndexPath *indexPath) {
        
        NSString *type = NSStringFromAppURLType((SSAppURLType)[appType unsignedIntegerValue]);
        
        cell.textLabel.text = type;
    };
    dataSource.tableView = self.tableView;
    
    self.tableView.dataSource = dataSource;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    SSAppURLType type = (SSAppURLType)[[dataSource itemAtIndexPath:indexPath]
                                       unsignedIntegerValue];
    
    [[UIApplication sharedApplication] openAppType:type
                                         withValue:@"415-555-1212"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
