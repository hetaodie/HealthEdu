//
//  PayViewController.m
//  HealthEdu
//
//  Created by weixu on 2017/2/28.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *weixinPayBtn;

@property (weak, nonatomic) IBOutlet UIButton *zhifubaoBtn;

@property (weak, nonatomic) IBOutlet UIButton *querenBtn;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weixinPayBtn.selected = YES;
    self.zhifubaoBtn.selected = NO;
    
    self.titleLabel.text = self.enrollObject.title;
    NSInteger price = self.enrollObject.num * self.enrollObject.price;
    self.priceLabel.text = [NSString stringWithFormat:@"总价： %ld 元", price];
    
    self.querenBtn.clipsToBounds = YES;
    self.querenBtn.layer.cornerRadius = 3;
    
    NSString *querenStr = [NSString stringWithFormat:@"确认支付 ￥%ld",price];
    [self.querenBtn setTitle:querenStr forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)weizhiBtnPress:(id)sender {
    self.weixinPayBtn.selected = YES;
    self.zhifubaoBtn.selected = NO;
}

- (IBAction)zhifubaoBtnPress:(id)sender {
    self.weixinPayBtn.selected = NO;
    self.zhifubaoBtn.selected = YES;
}

- (IBAction)querenBtnPres:(id)sender {
    
}

@end
