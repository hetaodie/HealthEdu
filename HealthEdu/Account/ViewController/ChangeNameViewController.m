//
//  ChangeNameViewController.m
//  HealthEdu
//
//  Created by weixu on 16/11/30.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ChangeNameViewController.h"
#import "ChangeUserInSource.h"
#import "UIView+Toast.h"
#import "UserInfoManager.h"

@interface ChangeNameViewController () <ChangeUserInSourceDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) NSString *strUrl;
@property (nonatomic, strong) ChangeUserInSource *source;

@end

@implementation ChangeNameViewController

#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self showTagAndUrlWithPaction:self.pAction];
    self.source = [[ChangeUserInSource alloc] init];
    self.source.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (IBAction)submitBtnPress:(id)sender {
    
    UserInfo *userInfo = [[UserInfoManager shareManager] getUserInfo];
    switch (self.pAction) {
        case 2:
        {
            self.strUrl = [NSString stringWithFormat:@"/mobile/updateStaff.action?username=%@&name=%@",userInfo.userName,self.nameTextField];
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            self.strUrl = [NSString stringWithFormat:@"/mobile/updateStaff.action?username=%@&phone=%@",userInfo.userName,self.nameTextField];
        }
            break;
        case 6:
        {
          self.strUrl = [NSString stringWithFormat:@"/mobile/updateStaff.action?username=%@&company=%@",userInfo.userName,self.nameTextField];
        }
            break;
        case 7:
        {
            self.strUrl = [NSString stringWithFormat:@"/mobile/updateStaff.action?username=%@&title=%@",userInfo.userName,self.nameTextField];
        }
            break;
        case 8:
        {
            self.strUrl = [NSString stringWithFormat:@"/mobile/updateStaff.action?username=%@&email=%@",userInfo.userName,self.nameTextField];               
        }
            break;
        default:
            break;
    }
    
    [self.source changeUserInfoWithURl:self.strUrl];
}


- (void) showTagAndUrlWithPaction:(NSInteger)aAction {
    NSString *navTitle;
    switch (aAction) {
        case 2:
        {
            navTitle = @"修改姓名";
            self.strUrl = @"/mobile/updateStaff.action?username=%@&name=%@";
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            navTitle = @"手机";
            self.strUrl = @"/mobile/updateStaff.action?username=%@&phone=%@";
        }
            break;
        case 6:
        {
            navTitle = @"单位";
            self.strUrl = @"/mobile/updateStaff.action?username=%@&company=%@";
        }
            break;
        case 7:
        {
            navTitle = @"职位";
            self.strUrl = @"/mobile/updateStaff.action?username=%@&title=%@";
        }
            break;
        case 8:
        {
            navTitle = @"邮箱";
            self.strUrl = @"/mobile/updateStaff.action?username=%@&email=%@";
        }
            break;
        default:
            break;
    }
    
     self.navigationItem.title = navTitle;
}


- (void)onChangeUserInfoSussess {
    [self.view makeToast:@"修改成功" duration:0.8 position:CSToastPositionCenter];
}
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
