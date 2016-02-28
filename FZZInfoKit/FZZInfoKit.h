//
//  FZZInfoKit.h
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/21.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chameleon.h"


@protocol FZZInfoKitDelegate;

@interface FZZInfoKit : NSObject

@property (nonatomic, weak) UIViewController <FZZInfoKitDelegate> *delegate;
@property (nonatomic, strong) UIColor *keyColor;
@property (nonatomic, assign) BOOL letIconRound;

- (void)showInfoWithAppID:(NSString *)appID
                 iconName:(NSString *)iconName
                 delegate:(UIViewController *)delegate
                 animated:(BOOL)animeted;

@end

@protocol FZZInfoKitDelegate

- (void)FZZInfoKitWillClose;

@end
