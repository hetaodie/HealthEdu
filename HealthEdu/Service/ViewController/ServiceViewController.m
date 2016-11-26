//
//  ServiceViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/9/27.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ServiceViewController.h"
#import "UIColor+HEX.h"


@interface ServiceViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *yuyinView;
@property (weak, nonatomic) IBOutlet UIView *tuPianImageView;
@property (weak, nonatomic) IBOutlet UIButton *commintButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请用10到500字简要描述你的问题"]) {
        textView.text = @" ";
    }
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
