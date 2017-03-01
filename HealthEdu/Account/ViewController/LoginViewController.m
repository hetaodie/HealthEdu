//
//  LoginViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+HEX.h"
#import "LoginSource.h"
#import "UserInfoManager.h"

@interface LoginViewController () <LoginSourceDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (nonatomic, strong) LoginSource *loginSource;
@end

@implementation LoginViewController


#pragma mark -
#pragma mark lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUptipsLabel];
    
    self.loginSource = [[LoginSource alloc] init];
    self.loginSource.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate

- (void)onLoginSuccess:(UserInfo *)aUserInfo{
    UserInfoManager *infoManager = [UserInfoManager shareManager];
    [infoManager LoginSeccessWith:aUserInfo];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onLoginError{

}

#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)setUptipsLabel{
    
    UIColor *color = [UIColor colorWithHexString:@"0099e6" alpha:1.0];

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:self.tipsLabel.attributedText];
    
    [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(attrString.length-4, 4)];//下划线
    
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(attrString.length-4, 4)];

    //下划线颜色
    [attrString addAttribute:NSUnderlineColorAttributeName value:color range:NSMakeRange(attrString.length-4, 4)];
    self.tipsLabel.attributedText = attrString;
    
    //添加
    self.tipsLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealClickURL:)];
    [self.tipsLabel addGestureRecognizer:tap];
}

-(void)dealClickURL:(UITapGestureRecognizer *)tap
{

    UILabel *label = (UILabel *)tap.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onClictToRegiterViewController:)]) {
        [self.delegate onClictToRegiterViewController:self];
    }
}

- (IBAction)loginBtnPress:(id)sender {
    [self.loginSource LoginWithName:self.usernameField.text andPWD:self.pwdField.text];
}
@end
