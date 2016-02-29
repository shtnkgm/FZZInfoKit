//
//  FZZInfoViewModel.h
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/29.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FZZInfoViewModelEntity.h"

static NSString *const FZZInfoViewModelFrinedUrl = @"friendUrl";
static NSString *const FZZInfoViewModelCreditUrl = @"creditUrl";

@interface FZZInfoViewModel : NSObject

@property (nonatomic, copy) NSString *appID;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *supportSiteURL;
@property (nonatomic, copy) NSString *developerID;
@property (nonatomic, copy) NSString *bugReportURL;
@property (nonatomic, copy) NSString *bugReportURLWithOption;
@property (nonatomic, copy) NSString *privacyPolicyURL;
@property (nonatomic, copy) NSString *appstoreURL;
@property (nonatomic, copy) NSString *reviewPageURL;
@property (nonatomic, copy) NSString *otherAppsURL;
@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *iOSVersion;
@property (nonatomic, copy) NSString *infoFormID;

- (instancetype)initWithAppID:(NSString *)appID;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsinSection:(NSInteger)section;
- (NSString *)sectionNameWithSection:(NSInteger)section;
- (FZZInfoViewModelEntity *)rowWithIndexPath:(NSIndexPath *)indexPath;

@end
