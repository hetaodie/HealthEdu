//
//  ChangePassWordViewController.m
//  HealthEdu
//
//  Created by weixu on 16/11/29.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "ChangeUserInSource.h"
#import "UserInfoManager.h"
#import "UIView+Toast.h"

@interface ChangePassWordViewController () <ChangeUserInSourceDelegate>
@property (nonatomic, strong) ChangeUserInSource *source;
@property (weak, nonatomic) IBOutlet UITextField *originPWDTextField;
@property (weak, nonatomic) IBOutlet UITextField *pWDFirstTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdSecondTextField;
@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"修改密码";
    
    self.source = [[ChangeUserInSource alloc] init];
    self.source.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submitBtnPress:(id)sender {
    
    UserInfo *usrInfo = [[UserInfoManager shareManager] getUserInfo];
    if ([self.originPWDTextField.text isEqualToString:usrInfo.pwd]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"原始密码不对" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([self.pWDFirstTextField.text isEqualToString:self.pwdSecondTextField.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"两次输入的密码不一样" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        
        NSString *strUrl = [NSString stringWithFormat:@"/mobile/staffPasswordReset.action?username=%@&password=%@&scode=%@",usrInfo.userName,usrInfo.pwd,self.pWDFirstTextField.text];
        [self.source changeUserInfoWithURl:strUrl];
    }
    
}

- (void)onChangeUserInfoSussess {
    [self.view makeToast:@"密码修改成功" duration:0.8 position:CSToastPositionCenter];
}

@end
