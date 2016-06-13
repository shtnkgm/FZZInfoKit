//
//  FZZInfoKit.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/21.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoKit.h"

//MY
#import "FZZInfoViewController.h"
#import "FZZInfoKitUtility.h"
#import "NSString+FZZInfoKitLocalized.h"

//OSS
#import "Chameleon.h"

@interface FZZInfoKit ()

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation FZZInfoKit

- (instancetype)init{
    self = [super init];
    return self;
}

- (void)showInfoWithAppID:(NSString *)appID
                 iconName:(NSString *)iconName
                  appName:(NSString *)appName
             letIconRound:(BOOL)letIconRound
                 delegate:(UIViewController *)delegate
                 animated:(BOOL)animated{
    
    __weak id weakDelegate = delegate;
    
    self.delegate = weakDelegate;
    
    FZZInfoViewController *viewController = [FZZInfoViewController new];
    viewController.appID = appID;
    viewController.iconName = iconName;
    viewController.appName = appName;
    viewController.letIconRound = letIconRound;
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.navigationController.navigationBar.tintColor = FlatWhite;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.05 alpha:1];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: FlatWhite};
    self.navigationController.navigationBar.translucent = YES;
    
    //閉じるボタンの作成
    UIImage *buttonImage = [FZZInfoKitUtility imageNamedWithoutCache:@"Delete"];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithImage:buttonImage
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(doneButtonDidPushed:)];
    
    self.navigationController.navigationBar.topItem.rightBarButtonItem = doneButton;
    
    
    [self.delegate presentViewController:self.navigationController
                            animated:animated
                          completion:nil];
}

- (void)doneButtonDidPushed:(id)sender{
    __weak typeof(self) weakSelf = self;
    
    //モーダルビューを閉じる
    [(UIViewController *)self.delegate dismissViewControllerAnimated:YES completion:^{
        [weakSelf.delegate FZZInfoKitDidClose];
    }];
    
}

@end
