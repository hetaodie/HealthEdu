//
//  PersonInfoViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PersonInfoObject.h"

#import "PersonInfoHeaderTableViewCell.h"
#import "PersonInfoTableViewCell.h"
#import "PersonMiMaTableViewCell.h"
#import "ChangePassWordViewController.h"

#import "UIColor+HEX.h"

#import "ChangeNameViewController.h"
#import "ChangeSexViewController.h"
#import "UserInfoManager.h"
#import "GetUserInfoSource.h"

@interface PersonInfoViewController () <GetUserInfoSourceDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) GetUserInfoSource *source;

@end

@implementation PersonInfoViewController

#pragma mark -
#pragma mark lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个人信息";
    
    self.contentArray = [[NSMutableArray  alloc] init];
    [self setUpTableView];
    
    [self testData];
    
    self.source = [[GetUserInfoSource alloc] init];
    self.source.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidAppear:(BOOL)animated {
    UserInfo *userInfo = [[UserInfoManager shareManager] getUserInfo];
    
    [self.source GetUserInfoWithuserName:userInfo.userName];
}

- (void) onGetuserInfoWithSussess:(UserInfo *)aUserInfo {
    [[UserInfoManager shareManager] saveEditedUserInfo:aUserInfo];
    [self testData];
    [self.tableView reloadData];
}

- (void)onGetuserInfoWithError {

}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate


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
    
    if (section == 0) {
        return 0.f;
    }
    return 6.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 185;
    }
    else if(section == 1){
        return 55;
    }
    else{
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *sections = [self.contentArray objectAtIndex:section];
    PersonInfoObject *object = [sections objectAtIndex:row];
    
    UITableViewCell *cell;
    if (section == 0) {
        PersonInfoHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfoHeaderTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    else if (section ==1){
        PersonInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfoTableViewCell" forIndexPath:indexPath];
        [cell showCellWithData:object];
        return cell;
    }
    else if (section ==2){
        PersonMiMaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonMiMaTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *sections = [self.contentArray objectAtIndex:section];
    PersonInfoObject *object = [sections objectAtIndex:row];
    
    [self presentVCWithObject:object];
    
}



#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)presentVCWithObject:(PersonInfoObject *)aObject {
    NSInteger pAction = aObject.pAction;
    
    if (pAction == 1) {
        ChangePassWordViewController *ndVC = [[ChangePassWordViewController alloc] initWithNibName:@"ChangePassWordViewController" bundle:nil];
        ndVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ndVC animated:YES];
    }
    
    else if (pAction == 3){
        ChangeSexViewController *ndVC = [[ChangeSexViewController alloc] initWithNibName:@"ChangeSexViewController" bundle:nil];
        ndVC.sex = aObject.info;
        ndVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ndVC animated:YES];
    }
    
    else {
    
        ChangeNameViewController *ndVC = [[ChangeNameViewController alloc] initWithNibName:@"ChangeNameViewController" bundle:nil];
        ndVC.pAction = pAction;
        ndVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ndVC animated:YES];
    }
}

- (void)setUpTableView{
    UINib *nib = [UINib nibWithNibName:@"PersonInfoHeaderTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PersonInfoHeaderTableViewCell"];
    
    UINib *nib1 = [UINib nibWithNibName:@"PersonInfoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"PersonInfoTableViewCell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"PersonMiMaTableViewCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"PersonMiMaTableViewCell"];
    
}

- (void)testData{
    [self.contentArray removeAllObjects];
    
    UserInfo *userInfo = [[UserInfoManager shareManager] getUserInfo];
    
    NSMutableArray *array1 = [NSMutableArray array];
    
    PersonInfoObject *object1 = [[PersonInfoObject alloc] init];
    object1.infoTag = @"头像";
    object1.info = @"touxiang";
    object1.pAction = 0;
    [array1 addObject:object1];
    [self.contentArray addObject:array1];

    
    NSMutableArray *array2 = [NSMutableArray array];
    
    
    PersonInfoObject *object4 = [[PersonInfoObject alloc] init];
    object4.infoTag = @"修改密码";
    object4.info = @"修改密码";
    object4.pAction = 1;
    [array2 addObject:object4];
    
    PersonInfoObject *object2 = [[PersonInfoObject alloc] init];
    object2.infoTag = @"姓名";
    object2.info = userInfo.name;
    object2.pAction = 2;
    [array2 addObject:object2];
    
    PersonInfoObject *object3 = [[PersonInfoObject alloc] init];
    object3.infoTag = @"性别";
    object3.info = userInfo.sex;
    object3.pAction = 3;
    [array2 addObject:object3];
    
    PersonInfoObject *object5 = [[PersonInfoObject alloc] init];
    object5.infoTag = @"手机";
    object5.info = userInfo.userName;
    object5.pAction = 5;
    [array2 addObject:object5];
    
    PersonInfoObject *object6 = [[PersonInfoObject alloc] init];
    object6.infoTag = @"单位";
    object6.info = userInfo.company;
    object6.pAction = 6;
    [array2 addObject:object6];
    
    PersonInfoObject *object7 = [[PersonInfoObject alloc] init];
    object7.infoTag = @"职位";
    object7.info = userInfo.title;
    object7.pAction = 7;
    [array2 addObject:object7];
    
    PersonInfoObject *object8 = [[PersonInfoObject alloc] init];
    object8.infoTag = @"邮箱";
    object8.info = userInfo.email;
    object8.pAction = 8;
    [array2 addObject:object8];
    [self.contentArray addObject:array2];
}
@end
