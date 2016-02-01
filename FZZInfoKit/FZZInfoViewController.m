//
//  FZZInfoViewController.m
//  CommonParts
//
//  Created by Administrator on 2014/10/11.
//  Copyright (c) 2014年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoViewController.h"
#import "FZZInfoCell.h"

//iOS SDK
#import <StoreKit/StoreKit.h>

//オープンソースライブラリ
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "RMUniversalAlert.h"

static NSString *const kAPIResults = @"results";
static NSString *const kAPITrackName = @"trackName";
static NSString *const kAPITrackId = @"trackId";
static NSString *const kAPIArtworkUrl60 = @"artworkUrl60";

static NSString *const kName = @"name";
static NSString *const kRows = @"rows";
static NSString *const kValue = @"value";
static NSString *const kUrl = @"url";
static NSString *const kAction = @"action";
static NSString *const kFile = @"file";
static NSString *const kAppId = @"appid";

static const NSInteger kSupport = 0;
static const NSInteger kApp = 2;
static const NSInteger kInfo = 1;
static const NSInteger kAcknowledgement = 3;

static NSString *const kLocalizeFile = @"FZZInfoViewControllerLocalizable";

@interface FZZInfoViewController ()
<UITableViewDataSource,
UITableViewDelegate,
SKStoreProductViewControllerDelegate,
UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation FZZInfoViewController

# pragma mark UIViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"FZZInfoCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"InfoCell"];
    
    _data = [NSMutableArray array];
    [_data addObject:[NSMutableDictionary dictionary]];
    [_data addObject:[NSMutableDictionary dictionary]];
    [_data addObject:[NSMutableDictionary dictionary]];
    [_data addObject:[NSMutableDictionary dictionary]];
    
    //完了ボタンの作成
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneButtonDidPushed:)];
    _navigationBar.topItem.leftBarButtonItem = doneButton;
    
    //タイトルの初期化
    _navigationBar.topItem.title = nil;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    __weak FZZInfoViewController *weakSelf = self;
    
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@&entity=software",self.developerIDString];
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* task =
    [session dataTaskWithURL:url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               
               if(!error){
                   [weakSelf setSupportDictionary];
                   [weakSelf setInfomationDictionary];
                   [weakSelf setAppDictionaryWithResponse:data];
                   [weakSelf setAcknowledgementDictionary];
               }else{
                   [weakSelf setSupportDictionary];
                   [weakSelf setInfomationDictionary];
                   [weakSelf setAcknowledgementDictionary];
               }

               dispatch_async(dispatch_get_main_queue(), ^{
                   [weakSelf.tableView reloadData];
                   [SVProgressHUD dismiss];
               });
           }];
    
    [task resume];
    
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
    NSUInteger index = 0;
    _data[kSupport][kName] = NSLocalizedStringFromTable(@"App Support",kLocalizeFile,nil);
    _data[kSupport][kRows] = [NSMutableArray array];
    [_data[kSupport][kRows] addObject:[NSMutableDictionary dictionary]];
    [_data[kSupport][kRows] addObject:[NSMutableDictionary dictionary]];
    
    _data[kSupport][kRows][index][kName] = NSLocalizedStringFromTable(@"Suport Site",kLocalizeFile,nil);
    _data[kSupport][kRows][index][kAction] = @YES;
    //_data[kSupport][kRows][index][kFile] = @"mail";
    index++;
    
    _data[kSupport][kRows][index][kName] = NSLocalizedStringFromTable(@"Rate This App",kLocalizeFile,nil);
    _data[kSupport][kRows][index][kAction] = @YES;
    //_data[kSupport][kRows][index][kFile] = @"review";
}

- (void)setInfomationDictionary {
    
    _data[kInfo][kName] = NSLocalizedStringFromTable(@"App Infomation",kLocalizeFile,nil);
    _data[kInfo][kRows] = [NSMutableArray array];
    [_data[kInfo][kRows] addObject:[NSMutableDictionary dictionary]];
    [_data[kInfo][kRows] addObject:[NSMutableDictionary dictionary]];
    [_data[kInfo][kRows] addObject:[NSMutableDictionary dictionary]];
    
    NSUInteger index = 0;
    _data[kInfo][kRows][index][kName] = NSLocalizedStringFromTable(@"AppName",kLocalizeFile,nil);
    _data[kInfo][kRows][index][kAction] = @NO;
    _data[kInfo][kRows][index][kFile] = @"topicon";
    _data[kInfo][kRows][index][kValue] = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleName"];
    
    index++;
    _data[kInfo][kRows][index][kName] = NSLocalizedStringFromTable(@"Version",kLocalizeFile,nil);
    _data[kInfo][kRows][index][kAction] = @NO;
    _data[kInfo][kRows][index][kValue] = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    
    index++;
    _data[kInfo][kRows][index][kName] = NSLocalizedStringFromTable(@"AppStore",kLocalizeFile,nil);
    _data[kInfo][kRows][index][kAction] = @YES;
}

- (void)setAppDictionaryWithResponse:(id)responseObject {
    NSUInteger index = 0;
    
     NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    
    _data[kApp][kName] = NSLocalizedStringFromTable(@"by This Developer",kLocalizeFile,nil);
    _data[kApp][kRows] = [NSMutableArray array];
    
    for (NSDictionary *app in jsonDict[kAPIResults]) {
        if([app.allKeys containsObject:kAPITrackName]){
            @autoreleasepool {
                NSString *appName = [app[kAPITrackName] componentsSeparatedByString:@"-"][0];
                if([self.appIDString integerValue] != [app[kAPITrackId] integerValue]){
                    [_data[kApp][kRows] addObject:[NSMutableDictionary dictionary]];
                    _data[kApp][kRows][index][kName] = appName;
                    _data[kApp][kRows][index][kUrl] = app[kAPIArtworkUrl60];
                    _data[kApp][kRows][index][kAction] = @YES;
                    _data[kApp][kRows][index][kAppId] = app[kAPITrackId];
                    index++;
                }
            }
        }
    }
}

- (void)setAcknowledgementDictionary {
    
    _data[kAcknowledgement][kName] = NSLocalizedStringFromTable(@"Acknowledgement",kLocalizeFile,nil);
    _data[kAcknowledgement][kRows] = [NSMutableArray array];
    [_data[kAcknowledgement][kRows] addObject:[NSMutableDictionary dictionary]];
    
    NSUInteger index = 0;
    _data[kAcknowledgement][kRows][index][kName] = NSLocalizedStringFromTable(@"icons8",kLocalizeFile,nil);
    _data[kAcknowledgement][kRows][index][kAction] = @YES;
}


# pragma mark UIAction
- (IBAction)doneButtonDidPushed:(id)sender{
    [_delegate infoViewWillClose];
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
    
    if(indexPath.section==kInfo){
        if(indexPath.row==0){
            return;
        }
        if(indexPath.row==1){
            return;
        }
        if(indexPath.row==2){
            [self openAppStoreWithAppId:self.appIDString];
            
            return;
        }
    }
    
    if(indexPath.section==kSupport){
        if(indexPath.row==0){
            [self openSuportSite];
        }
        
        if(indexPath.row==1){
            [self openReviewPage];
        }
    }
    
    if(indexPath.section==kApp){
        [self openAppStoreWithAppId:_data[indexPath.section][kRows][indexPath.row][kAppId]];
    }
    
    if(indexPath.section == kAcknowledgement){
        if(indexPath.row==0){
            [self showJumpToIcons8Dialog];
        }
    }
}

# pragma mark UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _data[section][kName];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(section == kSupport){
        
        NSString *message = [NSString stringWithFormat:NSLocalizedStringFromTable(@"If you enjoy using %@, would you mind taking a moment to rate it? It won’t take more than a minute. Thanks for your support!", kLocalizeFile,nil),[[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleName"]];
        return message;
    }
    return nil;
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
    
    if(_data[indexPath.section][kRows][indexPath.row][kUrl]){
        NSURL *url = [NSURL URLWithString:_data[indexPath.section][kRows][indexPath.row][kUrl]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIImage *placeholderImage = nil;
        
        __weak FZZInfoCell *weakCell = cell;
        __weak UIImageView *weakImageView = cell.iconImageView;
        [cell.iconImageView setImageWithURLRequest:request
                                  placeholderImage:placeholderImage
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                               weakImageView.image = image;
                                               [weakCell setNeedsLayout];
                                           } failure:nil];
    }else if(_data[indexPath.section][kRows][indexPath.row][kFile]){
        UIImage *image = [self imageNamedWithoutCache:_data[indexPath.section][kRows][indexPath.row][kFile]];
        
        if(indexPath.section==kSupport){
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            cell.iconImageView.tintColor = [UIColor grayColor];
        }
        cell.iconImageView.image = image;
    }else{
        cell.iconImageView.image = nil;
    }
    
    if([_data[indexPath.section][kRows][indexPath.row][kAction] boolValue]){
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

- (void)openAppStoreWithAppId:(NSString *)appstoreId{
    NSDictionary *params = @{ SKStoreProductParameterITunesItemIdentifier : appstoreId };
    SKStoreProductViewController *store = [[SKStoreProductViewController alloc] init];
    store.delegate = self;
    
    [store loadProductWithParameters:params completionBlock:^(BOOL result, NSError *error) {
        if (!result) {
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
                    [SVProgressHUD showErrorWithStatus:NSLocalizedStringFromTable(@"Network Error",kLocalizeFile,nil)];
                }];
                
            });
        }
    }];
    
    [self presentViewController:store animated:YES completion:nil];
}

# pragma mark SKStoreProductViewControllerDlegate

-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark サポートサイト
- (void)openSuportSite{
    [RMUniversalAlert showAlertInViewController:self
                                      withTitle:self.supportSiteURLString
                                        message:NSLocalizedStringFromTable(@"Open suport site in Safari?",kLocalizeFile,nil)
                              cancelButtonTitle:NSLocalizedStringFromTable(@"Cancel",kLocalizeFile,nil)
                         destructiveButtonTitle:nil
                              otherButtonTitles:@[@"OK"]
                                       tapBlock:^(RMUniversalAlert *alert,NSInteger buttonIndex){
                                           if(buttonIndex == alert.firstOtherButtonIndex){
                                               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.supportSiteURLString]];
                                           }
                                       }];

}

# pragma mark レビュー

- (void)openReviewPage{
    NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",self.appIDString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)showJumpToIcons8Dialog{
    __weak typeof(self) weakSelf = self;
    [RMUniversalAlert showAlertInViewController:self
                                      withTitle:@"https://icons8.com"
                                        message:NSLocalizedStringFromTable(@"Open link in Safari?",kLocalizeFile,nil)
                              cancelButtonTitle:NSLocalizedStringFromTable(@"Cancel",kLocalizeFile,nil)
                         destructiveButtonTitle:nil
                              otherButtonTitles:@[@"OK"]
                                       tapBlock:^(RMUniversalAlert *alert,NSInteger buttonIndex){
                                           if(buttonIndex == alert.firstOtherButtonIndex){
                                               [weakSelf openIcons8Page];
                                           }
                                       }];
}

- (void)openIcons8Page{
    NSString *urlString = @"https://icons8.com";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
