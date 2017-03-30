//
//  ServiceViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/9/27.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ServiceViewController.h"
#import "UIColor+HEX.h"
#import "ServerObject.h"
#import "SearveSource.h"

@interface ServiceViewController () <UITextViewDelegate,SearveSourceDelegate>
@property (weak, nonatomic) IBOutlet UIView *yuyinView;
@property (weak, nonatomic) IBOutlet UIView *tuPianImageView;
@property (weak, nonatomic) IBOutlet UIButton *commintButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;

@property (nonatomic, strong) ServerObject *serverObject;
@property (nonatomic, strong) SearveSource *searveSource;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tuPianImageView.clipsToBounds = YES;
    self.tuPianImageView.layer.borderColor = [UIColor colorWithHexString:@"cfcece" alpha:1.0].CGColor;
    self.tuPianImageView.layer.borderWidth = 1.0f;
    self.tuPianImageView.layer.cornerRadius = 13;
    
    self.yuyinView.clipsToBounds = YES;
    self.yuyinView.layer.borderColor = [UIColor colorWithHexString:@"cfcece" alpha:1.0].CGColor;
    self.yuyinView.layer.borderWidth = 1.0f;
    self.yuyinView.layer.cornerRadius = 13;
    
    self.commintButton.clipsToBounds = YES;
    self.commintButton.layer.cornerRadius = 3;
    
    self.textView.delegate = self;
    
    self.serverObject = [[ServerObject alloc] init];
    
    self.searveSource = [[SearveSource alloc] init];
    self.searveSource.delegate = self;
    
    UIToolbar *numberToolbar =
    [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                          target:nil
                                                                          action:nil],
                            [[UIBarButtonItem alloc] initWithTitle:@"Apply"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(numberTextFieldDidEndEditing)]
                            ];
    [numberToolbar sizeToFit];
    
    self.textView.inputAccessoryView = numberToolbar;
    self.titleLabel.inputAccessoryView = numberToolbar;
}

- (void) numberTextFieldDidEndEditing {
    [self.textView resignFirstResponder];
    [self.titleLabel resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请用10到500字简要描述你的问题"]) {
        textView.text = @" ";
    }
}

- (IBAction)commentBtnPress:(id)sender {
    self.serverObject.title = self.titleLabel.text;
    self.serverObject.desString = self.textView.text;
    self.serverObject.price= 0;
    
    [self.searveSource sendSeaverData:self.serverObject];
}

- (void)onSearveSourceError{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"提交失败，请重新提交，如果反复不成功，请联系后台" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [view show];
}

- (void)onSearveSourceSuccess:(NSString *)content{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提醒" message:content delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [view show];
    self.titleLabel.text =@"";
    self.textView.text = @"";
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
