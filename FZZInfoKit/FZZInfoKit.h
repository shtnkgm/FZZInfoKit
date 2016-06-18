//
//  FZZInfoKit.h
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/21.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FZZInfoKitDelegate;

@interface FZZInfoKit : NSObject

@property (strong, nonatomic) UIColor *tintColor;
@property (strong, nonatomic) UIColor *barTintColor;
@property (weak, nonatomic) UIViewController <FZZInfoKitDelegate> *delegate;

- (void)showInfoWithAppID:(NSString *)appID
                 iconName:(NSString *)iconName
                  appName:(NSString *)appName
             letIconRound:(BOOL)letIconRound
                 delegate:(UIViewController *)delegate
                 animated:(BOOL)animated;

@end

@protocol FZZInfoKitDelegate

- (void)FZZInfoKitDidClose;

@end
