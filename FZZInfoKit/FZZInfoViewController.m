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
#import "FZZInfoViewModel.h"
#import "FZZInfoViewModelEntity.h"
#import "FZZInfoKitUtility.h"
#import "NSString+FZZInfoKitLocalized.h"

//オープンソースライブラリ
#import "SVProgressHUD.h"
#import "Chameleon.h"

@interface FZZInfoViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic,strong) FZZInfoViewModel *model;

@property (nonatomic, strong) UIView *iconView;
@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation FZZInfoViewController

# pragma mark UIViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.model = [[FZZInfoViewModel alloc] initWithAppID:_appID appName:_appName];
    
    //TableViewセルの初期化
    UINib *nib = [UINib nibWithNibName:@"FZZInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"InfoCell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.07 alpha:1];
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self addHeaderView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews{
    self.iconView.frame = CGRectMake(0,-190,self.tableView.frame.size.width,180);
    self.icon.frame = CGRectMake(self.iconView.frame.size.width/2.0-40,self.iconView.frame.size.height/2.0-40-20, 80, 80);
    self.titleLabel.frame = CGRectMake(0,self.icon.frame.size.height+self.icon.frame.origin.y+12,self.tableView.frame.size.width,28);
    self.detailLabel.frame = CGRectMake(0,self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+2,self.tableView.frame.size.width,15);
    
    self.iconView.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom
                                                          withFrame:_iconView.frame
                                                          andColors:@[[UIColor colorWithRed:229/255.0
                                                                                      green:228/255.0
                                                                                       blue:226/255.0
                                                                                      alpha:1],
                                                                      [UIColor colorWithRed:216/255.0
                                                                                      green:216/255.0
                                                                                       blue:216/255.0
                                                                                      alpha:1]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma mark HeaderView

- (void)addHeaderView{
    self.iconView = [UIView new];
    
    [self.tableView addSubview:self.iconView];
    self.icon = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.icon setImage:[FZZInfoKitUtility imageNamedWithoutCache:_iconName] forState:UIControlStateNormal];
    [self.icon addTarget:self action:@selector(iconTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.icon.layer.shadowOpacity = 0.6;
    self.icon.layer.shadowRadius = 2;
    self.icon.layer.shadowColor = [UIColor blackColor].CGColor;
    self.icon.layer.shadowOffset = CGSizeMake(0, 2);
    
    if(_letIconRound){
        self.icon.imageView.layer.cornerRadius = 18.0f;
    }else{
        self.icon.imageView.layer.cornerRadius = 0.0f;
    }
    
    [self.iconView addSubview:self.icon];
    
    self.titleLabel = [UILabel new];
    
    NSMutableAttributedString *titleText = [NSMutableAttributedString new];
    
    for (int i = 0 ; i < [_model.appName length] ; i++) {
        unichar c = [_model.appName characterAtIndex:i];
        
        NSString *character = [_model.appName substringWithRange:NSMakeRange(i, 1)];
        
        if(isupper(c)){
            NSDictionary *cAttributes = @{ NSForegroundColorAttributeName :FlatBlackDark,
                                                NSFontAttributeName : [UIFont fontWithName:@"Futura-Medium" size:14],
                                                NSKernAttributeName : @8.0f};
            NSAttributedString *titleC = [[NSAttributedString alloc] initWithString:character
                                                                            attributes:cAttributes];
            [titleText appendAttributedString:titleC];
            
        }else{
            NSDictionary *cAttributes = @{ NSForegroundColorAttributeName : FlatBlack,
                                           NSFontAttributeName : [UIFont fontWithName:@"Futura-Medium" size:14],
                                           NSKernAttributeName : @8.0f};
            NSAttributedString *titleC = [[NSAttributedString alloc] initWithString:character
                                                                         attributes:cAttributes];
            [titleText appendAttributedString:titleC];
        }
        
    }
    
    self.titleLabel.attributedText = titleText;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.iconView addSubview:self.titleLabel];
    
    self.detailLabel = [UILabel new];
    
    self.detailLabel.text = [NSString stringWithFormat:@"Designed by Shota Nakagami"];
    self.detailLabel.font = [UIFont fontWithName:@"Avenir-Book" size:10];
    self.detailLabel.textColor = FlatGrayDark;
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.iconView addSubview:self.detailLabel];
}

- (void)iconTapped:(UIButton *)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_model.reviewPageURL]];
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
    
    FZZInfoViewModelEntity *entity = [_model rowWithIndexPath:indexPath];
    
    if([entity.url isEqualToString:FZZInfoViewModelFrinedUrl]){
        [self useActivityViewController];
        return;
    }
    
    if([entity.url isEqualToString:FZZInfoViewModelCreditUrl]){
        FZZInfoCreditViewController *viewController = [FZZInfoCreditViewController new];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    if (entity.url){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:entity.url]];
        return;
    }
}

# pragma mark UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 14, tableView.frame.size.width-16*2, 22)];
    label.text = [_model sectionNameWithSection:section];
    [label setFont:[UIFont systemFontOfSize:15.0]];
    [label setTextColor:[UIColor grayColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:label];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_model numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_model numberOfRowsinSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FZZInfoViewModelEntity *entity = [_model rowWithIndexPath:indexPath];
    FZZInfoCell *cell = (FZZInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    
    cell.leftLabel.text = entity.name;
    cell.rightLabel.text = entity.value;
    
    if(entity.file){
        UIImage *image = [FZZInfoKitUtility imageNamedWithoutCache:entity.file];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        cell.iconImageView.tintColor = FlatWhiteDark;
        cell.iconImageView.image = image;
    }else{
        cell.iconImageView.image = nil;
    }
    
    if(entity.url){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

# pragma mark ActivityViewController

- (void)useActivityViewController{
    NSString *shareText = [NSString stringWithFormat:@"%@\n\n%@\n%@",_model.appName,[@"Download on the AppStore" FZZInfoKitLocalized],_model.appstoreURL];
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
                if([NSThread isMainThread]){
                    [SVProgressHUD showSuccessWithStatus:nil];
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD showSuccessWithStatus:nil];
                    });
                }
                
            }else{
                if([NSThread isMainThread]){
                    [SVProgressHUD showErrorWithStatus:activityError.description];
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD showErrorWithStatus:activityError.description];
                    });
                }
            }
        }else{
            //何もしない
        }
    };
    
    [self presentViewController:activityViewController animated:YES completion:^{
        //何もしない
    }];
}

@end
