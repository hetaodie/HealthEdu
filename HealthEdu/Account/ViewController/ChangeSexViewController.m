//
//  ChangeNameViewController.m
//  HealthEdu
//
//  Created by weixu on 16/11/30.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ChangeSexViewController.h"

@interface ChangeSexViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *manImageView;

@property (weak, nonatomic) IBOutlet UIImageView *womenImageView;
@end

@implementation ChangeSexViewController

#pragma mark -
#pragma mark lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.manImageView.image = [UIImage imageNamed:@"xuanze"];
    self.womenImageView.image = nil;
}

- (IBAction)womenSelectBtnPress:(id)sender {
    self.womenImageView.image = [UIImage imageNamed:@"xuanze"];
    self.manImageView.image = nil;
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
