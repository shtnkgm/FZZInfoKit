//
//  FZZCreditViewController.m
//  FZZInfoKit
//
//  Created by Administrator on 2016/02/18.
//  Copyright © 2016年 Shota Nakagami. All rights reserved.
//

#import "FZZCreditViewController.h"

static NSString *const kLocalizeFile = @"FZZInfoViewControllerLocalizable";

@interface FZZCreditViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FZZCreditViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.editable = NO;
    self.textView.selectable = NO;
    
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
        if(dictionary[@"Title"] && ![dictionary[@"Title"] isEqualToString:@""] && ![dictionary[@"Title"] isEqualToString:@"Acknowledgements"] && dictionary[@"FooterText"]){
            creditDictionary[dictionary[@"Title"]] = dictionary[@"FooterText"];
        }
    }
    
    for (NSDictionary *dictionary in podsBundleData[@"PreferenceSpecifiers"]) {
        if(dictionary[@"Title"] && ![dictionary[@"Title"] isEqualToString:@""] && ![dictionary[@"Title"] isEqualToString:@"Acknowledgements"] && dictionary[@"FooterText"]){
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
    
    self.textView.text = lisencesString;
    
    
    //閉じるボタンの作成
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:[self localizedString:@"Close"]
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneButtonDidPushed:)];
    
    self.navigationController.navigationBar.topItem.leftBarButtonItem = doneButton;
}

- (IBAction)doneButtonDidPushed:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)localizedString:(NSString *)string{
    return NSLocalizedStringFromTableInBundle(string,kLocalizeFile,[self bundle], nil);
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
