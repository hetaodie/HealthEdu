//
//  DoctorRequestTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "DoctorRequestTableViewCell.h"

@implementation DoctorRequestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.questBg.layer.cornerRadius =15;
    self.questBg.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)showCellWithObject:(DoctorRequestObject *)aObject {
    self.answerLabel.text =aObject.contenttext;
    self.questLabel.text = aObject.content2;
}

@end
