//
//  BaikeSicknessContentTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/15.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "BaikeSicknessContentTableViewCell.h"

@interface BaikeSicknessContentTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation BaikeSicknessContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showCellWithTitle:(NSString *)aTitle{
    self.titleLabel.text = aTitle;
}

@end
