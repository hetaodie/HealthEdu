//
//  DoctorRequestTableViewCell.h
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorRequestObject.h"

@interface DoctorRequestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questLabel;

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIView *questBg;
- (void)showCellWithObject:(DoctorRequestObject *)aObject;
@end
