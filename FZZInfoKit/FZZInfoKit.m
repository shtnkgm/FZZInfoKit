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
#import "Chameleon.h"

@interface FZZInfoKit ()

@property (nonatomic, assign) BOOL animeted;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation FZZInfoKit

- (instancetype)init{
    self = [super init];
    self.letIconRound = NO;
    return self;
}

- (void)showInfoWithAppID:(NSString *)appID
                 iconName:(NSString *)iconName
                  appName:(NSString *)appName
                 delegate:(UIViewController *)delegate
                 animated:(BOOL)animeted{
    
    __weak id weakDelegate = delegate;
    
    self.delegate = weakDelegate;
    self.animeted = animeted;
    
    FZZInfoViewController *viewController = [FZZInfoViewController new];
    viewController.appID = appID;
    viewController.iconName = iconName;
    viewController.appName = appName;
    viewController.letIconRound = _letIconRound;
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.navigationController.navigationBar.tintColor = FlatWhite;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.05 alpha:1];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.translucent = YES;
    
    //閉じるボタンの作成
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithImage:[self imageNamedWithoutCache:@"Delete"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(doneButtonDidPushed:)];
    
    self.navigationController.navigationBar.topItem.rightBarButtonItem = doneButton;
    
    
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

- (UIImage *)imageNamedWithoutCache:(NSString *)name{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:name];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
