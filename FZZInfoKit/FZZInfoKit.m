//
//  FZZInfoKit.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/21.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoKit.h"

#import "FZZInfoViewController.h"
#import "NSString+FZZInfoKitLocalized.h"

@interface FZZInfoKit ()

@property (nonatomic, assign) BOOL animeted;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation FZZInfoKit

- (instancetype)init{
    self = [super init];
    self.keyColor = FlatSkyBlue;
    self.letIconRound = NO;
    return self;
}

- (void)showInfoWithAppID:(NSString *)appID
                 iconName:(NSString *)iconName
                 delegate:(UIViewController *)delegate
                 animated:(BOOL)animeted{
    
    __weak id weakDelegate = delegate;
    
    self.delegate = weakDelegate;
    self.animeted = animeted;
    
    FZZInfoViewController *viewController = [FZZInfoViewController new];
    viewController.appID = appID;
    viewController.keyColor = _keyColor;
    viewController.iconName = iconName;
    viewController.letIconRound = _letIconRound;
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.navigationController.navigationBar.topItem.title = [@"Info" localized];
    self.navigationController.navigationBar.tintColor = _keyColor;
    
    //閉じるボタンの作成
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:[@"Close" localized]
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneButtonDidPushed:)];
    
    self.navigationController.navigationBar.topItem.leftBarButtonItem = doneButton;
    
    
    [_delegate presentViewController:self.navigationController
                            animated:animeted
                          completion:nil];
}

- (IBAction)doneButtonDidPushed:(id)sender{
    [_delegate FZZInfoKitWillClose];
}

- (void)viewWillClose{
    [_delegate FZZInfoKitWillClose];
}

@end
