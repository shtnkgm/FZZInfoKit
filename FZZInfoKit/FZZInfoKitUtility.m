//
//  FZZInfoKitUtility.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/03/06.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoKitUtility.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation FZZInfoKitUtility

+ (UIImage *)imageNamedWithoutCache:(NSString *)name{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:name];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

+ (NSString *)platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)appVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

+ (NSString *)iosVersion{
    return [[UIDevice currentDevice] systemVersion];
}

@end
