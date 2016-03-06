//
//  FZZInfoViewController.h
//  CommonParts
//
//  Created by Administrator on 2014/10/11.
//  Copyright (c) 2014年 Shota Nakagami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZZInfoViewController : UIViewController

@property (nonatomic, copy) NSString *appID;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, strong) UIColor *keyColor;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, assign) BOOL letIconRound;

@end