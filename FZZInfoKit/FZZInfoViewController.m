//
//  FZZInfoViewController.m
//  CommonParts
//
//  Created by Administrator on 2014/10/11.
//  Copyright (c) 2014年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoViewController.h"
#import "FZZInfoCell.h"
#import "FZZCreditViewController.h"

//iOS SDK
#import <StoreKit/StoreKit.h>

//オープンソースライブラリ
#import "SVProgressHUD.h"

static NSString *const kName = @"name";
static NSString *const kRows = @"rows";
static NSString *const kValue = @"value";
static NSString *const kUrl = @"url";
static NSString *const kFile = @"file";
 
static const NSInteger kSupportSection   = 0;
static const NSInteger kDeveloperSection = 1;
static const NSInteger kCreditSection    = 2;


static NSString *const kLocalizeFile = @"FZZInfoViewControllerLocalizable";

@interface FZZInfoViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *supportSiteURL;
@property (nonatomic, copy) NSString *developerID;
@property (nonatomic, copy) NSString *icons8URL;
@property (nonatomic, copy) NSString *bugReportURL;
@property (nonatomic, copy) NSString *bugReportURLWithOption;
@property (nonatomic, copy) NSString *privacyPolicyURL;
@property (nonatomic, copy) NSString *appstoreURL;
@property (nonatomic, copy) NSString *reviewPageURL;
@property (nonatomic, copy) NSString *otherAppsURL;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *appVersion;

@property (nonatomic, copy) NSString *appNameFormID;
@property (nonatomic, copy) NSString *iOSVersionFormID;

@end

@implementation FZZInfoViewController

# pragma mark UIViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //初期化
    self.appName = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleName"];
    self.appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    self.developerID = @"457011383";
    self.supportSiteURL = @"http://shtnkgm.github.io";
    self.icons8URL = @"https://icons8.com";
    self.bugReportURL = @"https://docs.google.com/forms/d/1jAD7A1ch6D1SXbxf3hPzF15hicTbxKadaHf03axRbQk/viewform";
    self.privacyPolicyURL = @"http://shtnkgm.github.io/privacy.html";
    self.appstoreURL = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",_appIDString];
    self.reviewPageURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",_appIDString];
    self.otherAppsURL = @"itms-apps://itunes.com/apps/shotanakagami";
    
    self.appNameFormID = @"entry_724500489";
    self.iOSVersionFormID = @"entry_299887800";
    
    
    self.bugReportURLWithOption = [NSString stringWithFormat:@"%@?%@=%@%@&%@=%@",_bugReportURL,_appNameFormID,_appName,_appVersion,_iOSVersionFormID,[[UIDevice currentDevice] systemVersion]];
    
    //TableViewセルの初期化
    UINib *nib = [UINib nibWithNibName:@"FZZInfoCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"InfoCell"];
    
    
    _data = [NSMutableArray array];
    [_data addObject:[NSMutableDictionary dictionary]];
    [_data addObject:[NSMutableDictionary dictionary]];
    [_data addObject:[NSMutableDictionary dictionary]];
    
    [self setSupportDictionary];
    [self setDeveloperDictionary];
    [self setCreditDictionary];
    
    //閉じるボタンの作成
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:[self localizedString:@"Close"]
                                                                   style:UIBarButtonItemStyleDone
                                                                                target:self
                                                                                action:@selector(doneButtonDidPushed:)];
    
    self.navigationController.navigationBar.topItem.leftBarButtonItem = doneButton;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [self cleanUp];
}

- (void)cleanUp{
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

# pragma mark ExtractMethod
- (void)setSupportDictionary {
    NSInteger section = kSupportSection;
    
    NSUInteger index = 0;
    _data[section][kName] = [self localizedString:@"User Feedback"];
    _data[section][kRows] = [NSMutableArray array];
    [_data[section][kRows] addObject:[NSMutableDictionary dictionary]];
    [_data[section][kRows] addObject:[NSMutableDictionary dictionary]];
    [_data[section][kRows] addObject:[NSMutableDictionary dictionary]];
    
    _data[section][kRows][index][kName] = [self localizedString:@"Rate/Review in AppStore"];
    _data[section][kRows][index][kUrl] = _reviewPageURL;
    _data[section][kRows][index][kFile] = @"GoodQuality";
    index++;
    
    _data[section][kRows][index][kName] = [self localizedString:@"Report a bug"];
    _data[section][kRows][index][kUrl] = _bugReportURLWithOption;
    _data[section][kRows][index][kFile] = @"Error";
    index++;
    
    _data[section][kRows][index][kName] = [self localizedString:@"Tell a friend"];
    _data[section][kRows][index][kFile] = @"Talk";
    _data[section][kRows][index][kUrl] = @"friend";
}

- (void)setDeveloperDictionary {
    NSInteger section = kDeveloperSection;
    
    _data[section][kName] = [self localizedString:@"Developer"];
    _data[section][kRows] = [NSMutableArray array];
    [_data[section][kRows] addObject:[NSMutableDictionary dictionary]];
    [_data[section][kRows] addObject:[NSMutableDictionary dictionary]];
    [_data[section][kRows] addObject:[NSMutableDictionary dictionary]];
    
    NSUInteger index = 0;
    _data[section][kRows][index][kName] = [self localizedString:@"Web Site"];
    _data[section][kRows][index][kUrl] = _supportSiteURL;
    _data[section][kRows][index][kFile] = @"Geography";
    
    index++;
    _data[section][kRows][index][kName] = [self localizedString:@"Privacy Policy"];
    _data[section][kRows][index][kUrl] = _privacyPolicyURL;
    _data[section][kRows][index][kFile] = @"Lock";
    
    index++;
    _data[section][kRows][index][kName] = [self localizedString:@"Other Apps"];
    _data[section][kRows][index][kUrl] = _otherAppsURL;
    _data[section][kRows][index][kFile] = @"ShoppingCart";
}


- (void)setCreditDictionary {
    NSInteger section = kCreditSection;
    
    _data[section][kName] = [self localizedString:@"Credit"];
    _data[section][kRows] = [NSMutableArray array];
    [_data[section][kRows] addObject:[NSMutableDictionary dictionary]];
    [_data[section][kRows] addObject:[NSMutableDictionary dictionary]];
    
    NSUInteger index = 0;
    _data[section][kRows][index][kName] = [self localizedString:@"icons8"];
    _data[section][kRows][index][kUrl] = _icons8URL;
    _data[section][kRows][index][kFile] = @"Icons8Logo";
    
    index ++;
    _data[section][kRows][index][kName] = [self localizedString:@"Lisence"];
    _data[section][kRows][index][kUrl] = @"credit";
    _data[section][kRows][index][kFile] = @"Document";
    
}


# pragma mark UIAction
- (IBAction)doneButtonDidPushed:(id)sender{
    [_delegate viewWillClose];
}

# pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *url = _data[indexPath.section][kRows][indexPath.row][kUrl];
    
    if([url isEqualToString:@"friend"]){
        [self useActivityViewController];
        return;
    }
    
    if([url isEqualToString:@"credit"]){
        FZZCreditViewController *viewController = [FZZCreditViewController new];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    if (url){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        return;
    }
}

# pragma mark UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _data[section][kName];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data[section][kRows] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FZZInfoCell *cell = (FZZInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    
    cell.leftLabel.text = _data[indexPath.section][kRows][indexPath.row][kName];
    cell.rightLabel.text = _data[indexPath.section][kRows][indexPath.row][kValue];
    
    if(_data[indexPath.section][kRows][indexPath.row][kFile]){
        UIImage *image = [self imageNamedWithoutCache:_data[indexPath.section][kRows][indexPath.row][kFile]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        cell.iconImageView.tintColor = [UIColor darkTextColor];
        cell.iconImageView.image = image;
    }else{
        cell.iconImageView.image = nil;
    }
    
    NSString *url = _data[indexPath.section][kRows][indexPath.row][kUrl];
    
    if(url){
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (UIImage *)imageNamedWithoutCache:(NSString *)name{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:name];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

- (void)useActivityViewController{
    NSString *shareText = [NSString stringWithFormat:@"%@\n%@",_appName,_appstoreURL];
    NSArray *activityItems = @[shareText];
    
    //非表示にするアクティビティ
    NSArray *excludedActivityTypes = @[UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                        initWithActivityItems:activityItems
                                                        applicationActivities:nil];
    activityViewController.excludedActivityTypes = excludedActivityTypes;
    
    activityViewController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError){
        if(completed){
            if(!activityError){
                [SVProgressHUD showSuccessWithStatus:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:activityError.description];
            }
        }else{
            //何もしない
        }
    };
    
    [self presentViewController:activityViewController animated:YES completion:nil];
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
