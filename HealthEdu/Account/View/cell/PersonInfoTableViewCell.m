//
//  PersonInfoTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/28.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "PersonInfoTableViewCell.h"

@interface PersonInfoTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleTagLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation PersonInfoTableViewCell

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

- (void)showCellWithData:(PersonInfoObject *)aObject{
    self.titleLabel.text = aObject.info;
    self.titleTagLabel.text = aObject.infoTag;
}


#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

@end
