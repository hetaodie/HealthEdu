//
//  BMIViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "BMIViewController.h"
#import "BMIKnowView.h"
#import "UIView+Toast.h"

@interface BMIViewController ()
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (nonatomic, strong) BMIKnowView *knowView;
@property (weak, nonatomic) IBOutlet UIButton *BMIBtn;
@end

@implementation BMIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.knowView = [BMIKnowView viewWithXib];
    [self.view addSubview:self.knowView];
    self.BMIBtn.layer.cornerRadius = 2.5;
    self.BMIBtn.clipsToBounds = YES;
}

- (void)viewDidLayoutSubviews {
    self.knowView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)bmiBtnPress:(id)sender {
    CGFloat weight = [self.weightTextField.text floatValue];
    CGFloat height = [self.heightTextField.text floatValue];
    if (height<=0 || weight <= 0) {
        return;
    }
    
    
    CGFloat BMI = weight/pow(height/100, 2);
    NSString *bmiMessage = [NSString stringWithFormat:@"您的BMI值为%f",BMI];
  [self.view makeToast:bmiMessage duration:2.5 position:CSToastPositionCenter];

}

@end
