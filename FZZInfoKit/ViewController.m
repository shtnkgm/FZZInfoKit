//
//  ViewController.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/01.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "ViewController.h"

#import "FZZInfoKit.h"

@interface ViewController ()

<FZZInfoKitDelegate>

@property (nonatomic, assign) BOOL opend;

@property (nonatomic, strong) FZZInfoKit *infoKit;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _opend = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(_opend){
        return;
    }
    
    self.infoKit = [FZZInfoKit new];
    self.infoKit.letIconRound = YES;
    [self.infoKit showInfoWithAppID:@"480099135"
                           iconName:@"icon350x350"
                            appName:@"Roundgraphy"
                           delegate:self
                           animated:YES];
    
    _opend = YES;
}

- (void)FZZInfoKitWillClose{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
