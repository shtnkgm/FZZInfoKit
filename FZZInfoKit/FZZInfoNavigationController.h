//
//  FZZInfoNavigationController.h
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/18.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FZZInfoNavigationControllerDelegate;

@interface FZZInfoNavigationController : UINavigationController

@property (nonatomic, weak) id<FZZInfoNavigationControllerDelegate>closeDelegate;

@end

@protocol FZZInfoNavigationControllerDelegate

- (void)viewWillClose;

@end
