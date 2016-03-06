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

@property (nonatomic, readonly) NSString *appName;
@property (nonatomic, readonly) NSString *appstoreURL;
@property (nonatomic, readonly) NSString *reviewPageURL;

- (instancetype)initWithAppID:(NSString *)appID appName:(NSString *)appName;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsinSection:(NSInteger)section;
- (NSString *)sectionNameWithSection:(NSInteger)section;
- (FZZInfoViewModelEntity *)rowWithIndexPath:(NSIndexPath *)indexPath;

@end
