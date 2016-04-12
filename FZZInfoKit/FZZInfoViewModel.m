//
//  FZZInfoViewModel.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/29.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoViewModel.h"
#import "FZZInfoViewModelEntity.h"
#import "FZZInfoKitUtility.h"
#import "NSString+FZZInfoKitLocalized.h"

static NSString *const kName = @"name";
static NSString *const kRows = @"rows";

static NSString *const kDeveloperID = @"457011383";
static NSString *const kSupportSiteURL = @"http://shtnkgm.github.io";
static NSString *const kPrivacyPolicyURL = @"http://shtnkgm.github.io/privacy.html";
static NSString *const kBugReportURL = @"https://docs.google.com/forms/d/1jAD7A1ch6D1SXbxf3hPzF15hicTbxKadaHf03axRbQk/viewform";
static NSString *const kAppStoreBaseURL = @"https://itunes.apple.com/app";
static NSString *const kReviewPageBaseURL = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews";
static NSString *const kOtherAppsURL = @"itms-apps://itunes.com/apps/shotanakagami";
static NSString *const kInfoFormID = @"entry_724500489";

@interface FZZInfoViewModel ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, readonly) NSString *appID;
@property (nonatomic, readonly) NSString *infoFormID;
@property (nonatomic, readonly) NSString *supportSiteURL;
@property (nonatomic, readonly) NSString *developerID;
@property (nonatomic, readonly) NSString *bugReportURL;
@property (nonatomic, readonly) NSString *bugReportURLWithOption;
@property (nonatomic, readonly) NSString *privacyPolicyURL;
@property (nonatomic, readonly) NSString *otherAppsURL;
@property (nonatomic, readonly) NSString *appVersion;

@end


@implementation FZZInfoViewModel

- (instancetype)initWithAppID:(NSString *)appID appName:(NSString *)appName{
    self = [super init];
    if (self) {
        _data = [NSMutableArray array];
        
        _appID = appID;
        _appName = appName;
        _appVersion = [FZZInfoKitUtility appVersion];
        _developerID = kDeveloperID;
        _supportSiteURL = kSupportSiteURL;
        _bugReportURL = kBugReportURL;
        _privacyPolicyURL = kPrivacyPolicyURL;
        _appstoreURL = [NSString stringWithFormat:@"%@/id%@",kAppStoreBaseURL,_appID];
        _reviewPageURL = [NSString stringWithFormat:@"%@?type=Purple+Software&id=%@",kReviewPageBaseURL,_appID];
        _otherAppsURL = kOtherAppsURL;
        _infoFormID = kInfoFormID;
        
        NSString *option = [NSString stringWithFormat:@"・%@(Ver.%@)\n・%@(iOS%@)",_appName,_appVersion,[FZZInfoKitUtility platform],[FZZInfoKitUtility iosVersion]];
        NSString *encordedOption = [option stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _bugReportURLWithOption = [NSString stringWithFormat:@"%@?%@=%@",_bugReportURL,_infoFormID,encordedOption];
        
        [self setSupportDictionary];
        [self setDeveloperDictionary];
        [self setAppInfoDictionary];
    }
    return self;
}

- (void)addSection:(NSInteger)sectionIndex name:(NSString *)name{
    
    NSMutableDictionary *section = [NSMutableDictionary new];
    section[kName] = [name FZZInfoKitLocalized];
    section[kRows] = [NSMutableArray array];
    
    [_data addObject:section];
}

- (void)addRowInSection:(NSInteger)sectionIndex
                   name:(NSString *)name
                  value:(NSString *)value
                    url:(NSString *)url
                   file:(NSString *)file{
    
    FZZInfoViewModelEntity *entity = [FZZInfoViewModelEntity new];
    entity.name = [name FZZInfoKitLocalized];
    entity.value = [value FZZInfoKitLocalized];
    entity.url = url;
    entity.file = file;
    
    [_data[sectionIndex][kRows] addObject:entity];
}


- (void)setSupportDictionary {
    NSInteger sectionIndex = [_data count];
    
    [self addSection:sectionIndex name:@"User Feedback"];
    
    [self addRowInSection:sectionIndex
                     name:@"Rate/Review in AppStore"
                    value:nil
                      url:_reviewPageURL
                     file:@"Like"];
    
    [self addRowInSection:sectionIndex
                     name:@"Report a bug"
                    value:nil
                      url:_bugReportURLWithOption
                     file:@"Error"];
    
    [self addRowInSection:sectionIndex
                     name:@"Tell a friend"
                    value:nil
                      url:FZZInfoViewModelFrinedUrl
                     file:@"Talk"];
}

- (void)setDeveloperDictionary {
    NSInteger sectionIndex = [_data count];
    
    [self addSection:sectionIndex name:@"Creater"];
    
    [self addRowInSection:sectionIndex
                     name:@"Other Apps"
                    value:nil
                      url:_otherAppsURL
                     file:@"ShoppingCart"];
    
    [self addRowInSection:sectionIndex
                     name:@"Portfolio Site"
                    value:nil
                      url:_supportSiteURL
                     file:@"Briefcase"];
}


- (void)setAppInfoDictionary {
    NSInteger sectionIndex = [_data count];
    
    [self addSection:sectionIndex name:@"AppInfo"];
    
    [self addRowInSection:sectionIndex
                     name:@"Version"
                    value:_appVersion
                      url:nil
                     file:@"Tag"];
    
    [self addRowInSection:sectionIndex
                     name:@"Open Source License"
                    value:nil
                      url:FZZInfoViewModelCreditUrl
                     file:@"Document"];
    
    [self addRowInSection:sectionIndex
                     name:@"Privacy Policy"
                    value:nil
                      url:_privacyPolicyURL
                     file:@"Lock"];
}

- (NSString *)sectionNameWithSection:(NSInteger)section{
    return _data[section][kName];
}

- (NSInteger)numberOfSections{
    return [_data count];
}

- (NSInteger)numberOfRowsinSection:(NSInteger)section{
    return [_data[section][kRows] count];
}

- (NSDictionary *)rowWithIndexPath:(NSIndexPath *)indexPath{
    return _data[indexPath.section][kRows][indexPath.row];
}

@end
