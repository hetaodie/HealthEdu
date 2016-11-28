//
//  AccountContentTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/28.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "AccountContentTableViewCell.h"

@interface AccountContentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation AccountContentTableViewCell

#pragma mark -
#pragma mark lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public
- (void)showCellWithData:(AccountContentObject *)aObject{
    self.headerImageView.image = [UIImage imageNamed:aObject.headerImage];
    self.titleLabel.text = aObject.title;
}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

@end
