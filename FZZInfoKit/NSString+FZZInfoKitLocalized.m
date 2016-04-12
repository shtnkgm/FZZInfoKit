//
//  NSString+Localized.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/21.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "NSString+FZZInfoKitLocalized.h"

@implementation NSString (FZZInfoKitLocalized)

- (instancetype)localized{
    NSString *localizedFileName = @"FZZInfoKitLocalizable";
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"FZZInfoKit" withExtension:@"bundle"];
    NSBundle *bundle;
    
    if (bundleURL) {
        NSLog(@"Localize:%@",localizedFileName);
        bundle = [NSBundle bundleWithURL:bundleURL];
    } else {
        NSLog(@"Localize:mainBundle");
        bundle = [NSBundle mainBundle];
    }
    
    NSString *localizedString = NSLocalizedStringFromTableInBundle(self,localizedFileName,bundle, nil);
    return localizedString;
}

@end
