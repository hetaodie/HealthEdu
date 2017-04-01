//
//  ChangeNameViewController.m
//  HealthEdu
//
//  Created by weixu on 16/11/30.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ChangeSexViewController.h"
#import "ChangeUserInSource.h"
#import "UserInfoManager.h"

@interface ChangeSexViewController () <ChangeUserInSourceDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *manImageView;

@property (weak, nonatomic) IBOutlet UIImageView *womenImageView;
@property (nonatomic, strong) ChangeUserInSource *source;
@end

@implementation ChangeSexViewController

#pragma mark -
#pragma mark lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.source = [[ChangeUserInSource alloc] init];
    self.source.delegate = self;
    
    self.navigationItem.title = @"修改性别";
    if ([self.sex isEqualToString:@"男"]) {
        self.manImageView.image = [UIImage imageNamed:@"xuanze"];
        self.womenImageView.image = nil;
    }
    else{
        self.womenImageView.image = [UIImage imageNamed:@"xuanze"];
        self.manImageView.image = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)manSelectBtnPress:(id)sender {
    
    UserInfo *userInfo = [[UserInfoManager shareManager] getUserInfo];
    self.manImageView.image = [UIImage imageNamed:@"xuanze"];
    self.womenImageView.image = nil;
    
    NSString *strURl = [NSString stringWithFormat:@"/mobile/updateStaff.action?username=%@&sex=男",userInfo.userName];
    
    [self.source changeUserInfoWithURl:strURl];
}

- (IBAction)womenSelectBtnPress:(id)sender {
    UserInfo *userInfo = [[UserInfoManager shareManager] getUserInfo];
    self.womenImageView.image = [UIImage imageNamed:@"xuanze"];
    self.manImageView.image = nil;
      NSString *strURl = [NSString stringWithFormat:@"/mobile/updateStaff.action?username=%@&sex=女",userInfo.userName];
      [self.source changeUserInfoWithURl:strURl];
}
#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
