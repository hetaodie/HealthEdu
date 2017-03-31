//
//  AccountViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/9/27.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "AccountViewController.h"
#import "UIColor+HEX.h"
#import "AccountContentTableViewCell.h"
#import "AccountContentObject.h"

#import "DoctorRepeatViewController.h"
#import "CacheViewController.h"
#import "BMIViewController.h"

#import "PersonInfoViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SettingViewController.h"
#import "UserInfoManager.h"
#import "UserInfo.h"
@interface AccountViewController () <UITableViewDelegate,UITableViewDataSource,LoginViewControllerDelegate,RegisterViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIView *loginedView;
@property (weak, nonatomic) IBOutlet UIView *NoLoginedView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) UserInfo *userInfo;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@end

@implementation AccountViewController

#pragma mark -
#pragma mark lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentArray = [[NSMutableArray  alloc] init];
    [self setUpTableView];

    [self testData];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.userInfo = [[UserInfoManager shareManager] getUserInfo];
    if (self.userInfo) {
        self.loginedView.hidden = NO;
        self.usernameLabel.text = self.userInfo.userName;
        self.headerImageView.image = [UIImage imageNamed:@"touxiang2"];
        self.NoLoginedView.hidden = YES;
    }
    else{
        self.loginedView.hidden = YES;
        self.NoLoginedView.hidden = NO;
        self.headerImageView.image = [UIImage imageNamed:@"touxiang"];
    }
}

#pragma mark -
#pragma mark IBActions

- (IBAction)settingBtnPress:(id)sender {
    SettingViewController *ndVC = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];

}

- (IBAction)infoBtnPress:(id)sender {
    UserInfo *userinfo = [[UserInfoManager shareManager] getUserInfo];
    if (userinfo != nil) {
        PersonInfoViewController *ndVC = [[PersonInfoViewController alloc] initWithNibName:@"PersonInfoViewController" bundle:nil];
        ndVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ndVC animated:YES];
    }
   }

- (IBAction)loginBtnPress:(id)sender {
    LoginViewController *ndVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    ndVC.delegate = self;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];

}

- (IBAction)registerBtnPress:(id)sender {
    RegisterViewController *ndVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    ndVC.delegate = self;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];

}

#pragma mark -
#pragma mark public

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger count = [self.contentArray count];
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [[self.contentArray objectAtIndex:section] count];
    return count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerSectionView = [[UIView alloc] init];
    headerSectionView.backgroundColor = [UIColor colorWithHexString:@"ededed" alpha:1.0];
    return headerSectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *sections = [self.contentArray objectAtIndex:section];
    AccountContentObject *object = [sections objectAtIndex:row];
    
    
    AccountContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountContentTableViewCell" forIndexPath:indexPath];
    
    [cell showCellWithData:object];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *sections = [self.contentArray objectAtIndex:section];
    AccountContentObject *object = [sections objectAtIndex:row];

    [self presentVCWithAction:object.pAction];
}

- (void)onClictToRegiterViewController:(UIViewController *)aVC{
    RegisterViewController *ndVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    ndVC.delegate = self;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
    
    NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy];

    if ([viewControllers containsObject:aVC]) {
        [viewControllers removeObject:aVC];
    }
    [self.navigationController setViewControllers:viewControllers animated:YES];
    
}

- (void)onClictToLoginViewController:(UIViewController *)aVC{
    LoginViewController *ndVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    ndVC.delegate = self;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
    
    NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy];
    
    if ([viewControllers containsObject:aVC]) {
        [viewControllers removeObject:aVC];
    }
    [self.navigationController setViewControllers:viewControllers animated:YES];
}

- (void)onRegisterSussess:(UIViewController *)aVC {
    LoginViewController *ndVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    ndVC.delegate = self;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
    
    NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy];
    
    if ([viewControllers containsObject:aVC]) {
        [viewControllers removeObject:aVC];
    }
    [self.navigationController setViewControllers:viewControllers animated:YES];
}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)presentVCWithAction:(NSInteger)aAction{
    switch (aAction) {
        case 0:
        {
            DoctorRepeatViewController *ndVC = [[DoctorRepeatViewController alloc] initWithNibName:@"DoctorRepeatViewController" bundle:nil];
            ndVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ndVC animated:YES];

        }
            break;
            
        case 1:
        {
            CacheViewController *ndVC = [[CacheViewController alloc] initWithNibName:@"CacheViewController" bundle:nil];
            ndVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ndVC animated:YES];

        }
            break;

            
        case 2:
        {
            BMIViewController *ndVC = [[BMIViewController alloc] initWithNibName:@"BMIViewController" bundle:nil];
            ndVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ndVC animated:YES];
 
        }
            break;

        default:
            break;
    }
}

- (void)setUpTableView{
    UINib *nib = [UINib nibWithNibName:@"AccountContentTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AccountContentTableViewCell"];
}

- (void)testData{
    NSMutableArray *array1 = [NSMutableArray array];
    
    AccountContentObject *object1 = [[AccountContentObject alloc] init];
    object1.headerImage = @"xiaoxi";
    object1.title = @"医生回复";
    object1.pAction = 0;
    [array1 addObject:object1];
    
    NSMutableArray *array2 = [NSMutableArray array];
    
    AccountContentObject *object2 = [[AccountContentObject alloc] init];
    object2.headerImage = @"huancun";
    object2.title = @"我的缓存";
    object2.pAction = 1;
    [array2 addObject:object2];
    
    AccountContentObject *object3 = [[AccountContentObject alloc] init];
    object3.headerImage = @"BIM";
    object3.title = @"BMI指数";
    object3.pAction = 2;
    [array2 addObject:object3];
    
    AccountContentObject *object4 = [[AccountContentObject alloc] init];
    object4.headerImage = @"计步器";
    object4.title = @"BMI指数";
    object4.pAction = 2;
    [array2 addObject:object4];
    
    [self.contentArray addObject:array1];
    [self.contentArray addObject:array2];
}


@end
