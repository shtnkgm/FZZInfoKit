//
//  FZZInfoViewController.m
//  CommonParts
//
//  Created by Administrator on 2014/10/11.
//  Copyright (c) 2014年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoViewController.h"
#import "FZZInfoCell.h"
#import "FZZInfoCreditViewController.h"
#import "NSString+Localized.h"

//オープンソースライブラリ
#import "SVProgressHUD.h"
#import "Chameleon.h"

#include <sys/types.h>
#include <sys/sysctl.h>

static NSString *const kName = @"name";
static NSString *const kRows = @"rows";
static NSString *const kValue = @"value";
static NSString *const kUrl = @"url";
static NSString *const kFile = @"file";

@interface FZZInfoViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UIView *iconView;
@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

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
@property (nonatomic, copy) NSString *iOSVersion;

@property (nonatomic, copy) NSString *infoFormID;

@end

@implementation FZZInfoViewController

# pragma mark UIViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setForegroundColor:_keyColor];

    //初期化
    self.appName = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleName"];
    self.appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    self.developerID = @"457011383";
    self.supportSiteURL = @"http://shtnkgm.github.io";
    self.bugReportURL = @"https://docs.google.com/forms/d/1jAD7A1ch6D1SXbxf3hPzF15hicTbxKadaHf03axRbQk/viewform";
    self.privacyPolicyURL = @"http://shtnkgm.github.io/privacy.html";
    self.appstoreURL = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",_appID];
    self.reviewPageURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",_appID];
    self.otherAppsURL = @"itms-apps://itunes.com/apps/shotanakagami";
    
    self.infoFormID = @"entry_724500489";
    self.iOSVersion = [[UIDevice currentDevice] systemVersion];
    
    NSString *option = [[NSString stringWithFormat:@"・%@(Ver.%@)\n・%@(iOS%@)",_appName,_appVersion,[self platform],_iOSVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //URLエンコード
    
    self.bugReportURLWithOption = [NSString stringWithFormat:@"%@?%@=%@",_bugReportURL,_infoFormID,option];
    
    //TableViewセルの初期化
    UINib *nib = [UINib nibWithNibName:@"FZZInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"InfoCell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(190, 0, 0, 0);
    
    self.iconView = [UIView new];
    self.iconView.backgroundColor = FlatNavyBlueDark;
    [self.tableView addSubview:self.iconView];
    
    self.icon = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.icon setImage:[self imageNamedWithoutCache:_iconName] forState:UIControlStateNormal];
    [self.icon addTarget:self action:@selector(iconTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.icon.layer.shadowOpacity = 0.3;
    self.icon.layer.shadowColor = [UIColor blackColor].CGColor;
    self.icon.layer.shadowOffset = CGSizeMake(0, 2);
    
    if(_letIconRound){
        self.icon.imageView.layer.cornerRadius = 18.0f;
    }else{
        self.icon.imageView.layer.cornerRadius = 0.0f;
    }
    
    [self.iconView addSubview:self.icon];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_appName];
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-BookOblique" size:20];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.iconView addSubview:self.titleLabel];
    
    self.detailLabel = [UILabel new];
    self.detailLabel.text = [NSString stringWithFormat:@"\u00A9 SHOTA NAKAGAMI"];
    self.detailLabel.font = [UIFont fontWithName:@"Avenir-Book" size:10];
    self.detailLabel.textColor = [UIColor lightGrayColor];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.iconView addSubview:self.detailLabel];

    self.data = [NSMutableArray array];
    
    [self setSupportDictionary];
    [self setDeveloperDictionary];
    [self setAppInfoDictionary];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
}

- (void)iconTapped:(UIButton *)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_reviewPageURL]];
}

- (NSString *)platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

- (void)viewDidLayoutSubviews{
    self.iconView.frame = CGRectMake(0,-190,self.tableView.frame.size.width,180);
    self.icon.frame = CGRectMake(self.iconView.frame.size.width/2.0-40,self.iconView.frame.size.height/2.0-40-20, 80, 80);
    self.titleLabel.frame = CGRectMake(0,self.icon.frame.size.height+self.icon.frame.origin.y+12,self.tableView.frame.size.width,20);
    self.detailLabel.frame = CGRectMake(0,self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+2,self.tableView.frame.size.width,15);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    
}

# pragma mark ExtractMethod
- (void)addSection:(NSInteger)sectionIndex name:(NSString *)name{
    
    [_data addObject:[NSMutableDictionary dictionary]];
    
    //セクション名を追加
    _data[sectionIndex][kName] = [name localized];
    
    //配列を追加
    _data[sectionIndex][kRows] = [NSMutableArray array];
}

- (void)addRowInSection:(NSInteger)sectionIndex
                   name:(NSString *)name
                  value:(NSString *)value
                    url:(NSString *)url
                   file:(NSString *)file{
    
    NSInteger rowIndex = [_data[sectionIndex][kRows] count];
    
    //辞書を追加
    
    [_data[sectionIndex][kRows] addObject:[NSMutableDictionary dictionary]];
  
    _data[sectionIndex][kRows][rowIndex][kName] = [name localized];
    _data[sectionIndex][kRows][rowIndex][kValue] = [value localized];
    _data[sectionIndex][kRows][rowIndex][kUrl] = url;
    _data[sectionIndex][kRows][rowIndex][kFile] = file;
}

- (void)setSupportDictionary {
    NSInteger sectionIndex = [_data count];
    
    [self addSection:sectionIndex name:@"User Feedback"];
    
    [self addRowInSection:sectionIndex
                     name:@"Rate/Review in AppStore"
                    value:nil
                      url:_reviewPageURL
                     file:@"Like"];
    [self addRowInSection:sectionIndex
                     name:@"Report a bug"
                    value:nil
                      url:_bugReportURLWithOption
                     file:@"Error"];
    [self addRowInSection:sectionIndex
                     name:@"Tell a friend"
                    value:nil
                      url:@"friend"
                     file:@"Talk"];
}

- (void)setDeveloperDictionary {
    NSInteger sectionIndex = [_data count];
    
    [self addSection:sectionIndex name:@"Creater"];
    
    [self addRowInSection:sectionIndex
                     name:@"Other Apps"
                    value:nil
                      url:_otherAppsURL
                     file:@"ShoppingCart"];
    [self addRowInSection:sectionIndex
                     name:@"Portfolio Site"
                    value:nil
                      url:_supportSiteURL
                     file:@"Briefcase"];
}


- (void)setAppInfoDictionary {
    NSInteger sectionIndex = [_data count];
    
    [self addSection:sectionIndex name:@"AppInfo"];
    
    [self addRowInSection:sectionIndex
                     name:@"Version"
                    value:_appVersion
                      url:nil
                     file:@"Tag"];
    [self addRowInSection:sectionIndex
                     name:@"Open Source License"
                    value:nil
                      url:@"credit"
                     file:@"Document"];
    [self addRowInSection:sectionIndex
                     name:@"Privacy Policy"
                    value:nil
                      url:_privacyPolicyURL
                     file:@"Lock"];
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
        FZZInfoCreditViewController *viewController = [FZZInfoCreditViewController new];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    if (url){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        return;
    }
}

# pragma mark UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 14, tableView.frame.size.width-16*2, 22)];
    label.text = _data[section][kName];
    
    [label setFont:[UIFont systemFontOfSize:15.0]];
    [label setTextColor:[UIColor grayColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:label];
    
    return view;
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
    
    cell.rightLabel.font = [UIFont systemFontOfSize:16.0];
    cell.leftLabel.font = [UIFont systemFontOfSize:16.0];
    
    cell.rightLabel.textColor = [UIColor blackColor];
    cell.leftLabel.textColor = [UIColor blackColor];
    
    if(_data[indexPath.section][kRows][indexPath.row][kFile]){
        UIImage *image = [self imageNamedWithoutCache:_data[indexPath.section][kRows][indexPath.row][kFile]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        cell.iconImageView.tintColor = _keyColor;
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

@end
