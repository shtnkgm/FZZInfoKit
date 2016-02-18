//
//  ViewController.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/01.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "ViewController.h"
#import "FZZInfoNavigationController.h"

@interface ViewController ()
<FZZInfoNavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (void)viewDidAppear:(BOOL)animated{    
    FZZInfoNavigationController *vc = [FZZInfoNavigationController new];
    //vc.appIDString = @"480099135";
    
    vc.closeDelegate = self;
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
}

- (void)viewWillClose{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
