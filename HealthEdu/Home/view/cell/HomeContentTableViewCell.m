//
//  HomeContentTableViewCell.m
//  HealthEdu
//
//  Created by xu.wei on 16/10/17.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "HomeContentTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface HomeContentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end


@implementation HomeContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)showCellWithObject:(PopularRecommendObject *)aObject{
    self.titleLabel.text = aObject.title;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:aObject.imageUrl] placeholderImage:[UIImage imageNamed:@"1.png"]];
    [self setNeedsLayout];
    
}

@end
