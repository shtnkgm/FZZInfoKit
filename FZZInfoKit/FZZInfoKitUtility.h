//
//  FZZInfoKitUtility.h
//  FZZInfoKit
//
//  Created by Administrator on 2016/03/06.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZZInfoKitUtility : NSObject

+ (UIImage *)imageNamedWithoutCache:(NSString *)name;
+ (NSString *)platform;
+ (NSString *)appVersion;
+ (NSString *)iosVersion;

@end
