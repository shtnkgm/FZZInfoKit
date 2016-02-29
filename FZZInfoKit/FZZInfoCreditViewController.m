//
//  FZZCreditViewController.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/18.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoCreditViewController.h"

@interface FZZInfoCreditViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FZZInfoCreditViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.editable = NO;
    self.textView.selectable = YES;
    self.textView.dataDetectorTypes = UIDataDetectorTypeLink;
    self.textView.font = [UIFont systemFontOfSize:10];
    
    NSDictionary* mainBundleData;
    NSString *mainBundleFile = [[NSBundle mainBundle] pathForResource:@"Pods-acknowledgements" ofType:@"plist"];
    
    if(mainBundleFile){
        mainBundleData = [NSDictionary dictionaryWithContentsOfFile:mainBundleFile];
    }
    
    NSDictionary* podsBundleData;
    NSString *podsBundleFile = [[self bundle] pathForResource:@"Pods-acknowledgements" ofType:@"plist"];
    
    if(podsBundleFile){
        podsBundleData = [NSDictionary dictionaryWithContentsOfFile:podsBundleFile];
    }
    
    NSMutableDictionary *creditDictionary = [NSMutableDictionary new];
    
    for (NSDictionary *dictionary in mainBundleData[@"PreferenceSpecifiers"]) {
        if(dictionary[@"Title"] && ![dictionary[@"Title"] hasPrefix:@"FZZ"] && ![dictionary[@"Title"] isEqualToString:@""] && ![dictionary[@"Title"] isEqualToString:@"Acknowledgements"] && dictionary[@"FooterText"]){
            creditDictionary[dictionary[@"Title"]] = dictionary[@"FooterText"];
        }
    }
    
    for (NSDictionary *dictionary in podsBundleData[@"PreferenceSpecifiers"]) {
        if(dictionary[@"Title"] && ![dictionary[@"Title"] hasPrefix:@"FZZ"] && ![dictionary[@"Title"] isEqualToString:@""] && ![dictionary[@"Title"] isEqualToString:@"Acknowledgements"] && dictionary[@"FooterText"]){
            creditDictionary[dictionary[@"Title"]] = dictionary[@"FooterText"];
        }
    }
    
    NSString *lisencesString = @"";
    
    for(NSString *key in [creditDictionary allKeys]){
        lisencesString = [lisencesString stringByAppendingFormat:@"--- %@ ---",key];
        lisencesString = [lisencesString stringByAppendingFormat:@"\n\n"];
        lisencesString = [lisencesString stringByAppendingString:creditDictionary[key]];
        lisencesString = [lisencesString stringByAppendingFormat:@"\n\n\n"];
    }
    
    lisencesString = [lisencesString stringByAppendingFormat:@"--- %@ ---",@"icons8"];
    lisencesString = [lisencesString stringByAppendingFormat:@"\n\n"];
    lisencesString = [lisencesString stringByAppendingString:@"https://icons8.com"];
    lisencesString = [lisencesString stringByAppendingFormat:@"\n\n\n"];
    
    self.textView.text = lisencesString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSBundle *)bundle
{
    NSBundle *bundle;
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"FZZInfoKit" withExtension:@"bundle"];
    
    if (bundleURL) {
        bundle = [NSBundle bundleWithURL:bundleURL];
    } else {
        bundle = [NSBundle mainBundle];
    }
    return bundle;
}

@end
