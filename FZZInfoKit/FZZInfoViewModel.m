//
//  FZZInfoViewModel.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/29.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoViewModel.h"
#import "NSString+Localized.h"
#include <sys/types.h>
#include <sys/sysctl.h>

static NSString *const kName = @"name";
static NSString *const kRows = @"rows";

@interface FZZInfoViewModel ()

@property (nonatomic, strong) NSMutableArray *data;

@end


@implementation FZZInfoViewModel

- (instancetype)initWithAppID:(NSString *)appID{
    self = [super init];
    if (self) {
        _data = [NSMutableArray array];
        
        _appID = appID;
        _appName = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleName"];
        _appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
        _developerID = @"457011383";
        _supportSiteURL = @"http://shtnkgm.github.io";
        _bugReportURL = @"https://docs.google.com/forms/d/1jAD7A1ch6D1SXbxf3hPzF15hicTbxKadaHf03axRbQk/viewform";
        _privacyPolicyURL = @"http://shtnkgm.github.io/privacy.html";
        _appstoreURL = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",_appID];
        _reviewPageURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",_appID];
        _otherAppsURL = @"itms-apps://itunes.com/apps/shotanakagami";
        
        _infoFormID = @"entry_724500489";
        _iOSVersion = [[UIDevice currentDevice] systemVersion];
        
        NSString *option = [[NSString stringWithFormat:@"・%@(Ver.%@)\n・%@(iOS%@)",_appName,_appVersion,[self platform],_iOSVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //URLエンコード
        
        _bugReportURLWithOption = [NSString stringWithFormat:@"%@?%@=%@",_bugReportURL,_infoFormID,option];
        
        [self setSupportDictionary];
        [self setDeveloperDictionary];
        [self setAppInfoDictionary];
    }
    return self;
}

- (void)addSection:(NSInteger)sectionIndex name:(NSString *)name{
    
    NSMutableDictionary *section = [NSMutableDictionary new];
    section[kName] = [name localized];
    section[kRows] = [NSMutableArray array];
    
    [_data addObject:section];
}

- (void)addRowInSection:(NSInteger)sectionIndex
                   name:(NSString *)name
                  value:(NSString *)value
                    url:(NSString *)url
                   file:(NSString *)file{
    
    FZZInfoViewModelEntity *entity = [FZZInfoViewModelEntity new];
    entity.name = [name localized];
    entity.value = [value localized];
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

- (NSString *)platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
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
