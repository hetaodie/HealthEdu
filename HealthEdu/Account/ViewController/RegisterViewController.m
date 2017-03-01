//
//  LoginViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+HEX.h"
#import "RegisterSource.h"

@interface RegisterViewController () <RegisterSourceDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengmaTextField;

@property (nonatomic, strong) RegisterSource *registerSource;
@end

@implementation RegisterViewController


#pragma mark -
#pragma mark lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUptipsLabel];
    
    self.registerSource = [[RegisterSource alloc] init];
    self.registerSource.delegate = self;
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(onClictToLoginViewController:)]) {
        [self.delegate onClictToLoginViewController:self];
    }
    
}

- (IBAction)yanzhengmaBtnPress:(id)sender {
    [self.view endEditing:YES];
    [self.registerSource getRegisterCode:self.phoneTextField.text];
    
}

- (IBAction)registerBtnPress:(id)sender {
    [self.registerSource registerWithName:self.phoneTextField.text andPWD:self.pwdTextField.text andCode:self.yanzhengmaTextField.text];
}

- (void)onRegisterSuccess:(NSString *)aUsername andPWD:(NSString *)pwd{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onClictToLoginViewController:)]) {
        [self.delegate onClictToLoginViewController:self];
    }
}

- (void)onRegisterError{

}

@end
