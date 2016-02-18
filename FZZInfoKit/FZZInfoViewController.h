//
//  FZZInfoViewController.h
//  CommonParts
//
//  Created by Administrator on 2014/10/11.
//  Copyright (c) 2014年 Shota Nakagami. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FZZInfoViewControllerDelegate;

@interface FZZInfoViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, weak) id<FZZInfoViewControllerDelegate>delegate;
@property (nonatomic, copy) NSString *appIDString;


@end

@protocol FZZInfoViewControllerDelegate

- (void)viewWillClose;

@end