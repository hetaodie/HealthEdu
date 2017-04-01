//
//  BMIViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "BMIViewController.h"
#import "BMIKnowView.h"


@interface BMIViewController ()
@property (nonatomic, strong) BMIKnowView *knowView;
@end

@implementation BMIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.knowView = [BMIKnowView viewWithXib];
    [self.view addSubview:self.knowView];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
