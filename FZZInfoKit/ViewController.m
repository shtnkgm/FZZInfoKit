//
//  ViewController.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/01.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "ViewController.h"
#import "FZZInfoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FZZInfoViewController *vc = [FZZInfoViewController new];
    vc.appIDString = @"480099135";
    vc.developerIDString = @"457011383";
    vc.supportSiteURLString = @"http://shtnkgm.github.io";
    
    vc.delegate = self;
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
