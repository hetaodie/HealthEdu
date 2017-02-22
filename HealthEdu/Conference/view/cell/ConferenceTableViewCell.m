//
//  ConferenceTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 2017/2/22.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "ConferenceTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ConferenceTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTagLabel;
@end

@implementation ConferenceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showCellWithObject:(ConferenceObject *)aObject{
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:aObject.picurl] placeholderImage:[UIImage imageNamed:@"conference"]];
    
    self.titleLabel.text = aObject.title;
    self.locationLabel.text = aObject.content1;
    self.timeLabel.text = aObject.content3;
    self.numLabel.text = aObject.content5;
    self.numTagLabel.text = [NSString stringWithFormat:@"人报名/限%@人",aObject.content6];
    [self setNeedsLayout];
}

@end
