//
//  FZZInfoNavigationController.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/18.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoNavigationController.h"
#import "FZZInfoViewController.h"

@interface FZZInfoNavigationController ()
<FZZInfoViewControllerDelegate>
@end

@implementation FZZInfoNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init{
    FZZInfoViewController *viewController = [FZZInfoViewController new];
    viewController.delegate = self;
    return  [super initWithRootViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillClose{
    [_closeDelegate viewWillClose];
}

@end
