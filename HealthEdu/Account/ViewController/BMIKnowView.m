//
//  BMIKnowView.m
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "BMIKnowView.h"

@implementation BMIKnowView

+ (BMIKnowView *)viewWithXib {
    NSArray *nibs = [[NSBundle mainBundle]
                     loadNibNamed:@"BMIKnowView"
                            owner:nil
                     options:nil];
    return [nibs firstObject];
}
- (IBAction)btnPress:(id)sender {
    [self setHidden:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    self.Knowbtn.layer.cornerRadius = 25;
    self.Knowbtn.clipsToBounds = YES;
}
@end
