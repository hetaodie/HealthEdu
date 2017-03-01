//
//  ConsultationContentTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultationContentTableViewCell.h"

@interface ConsultationContentTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;  //地址的label

@end


@implementation ConsultationContentTableViewCell

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

+(CGFloat)cellHeightWithData:(ConsultationListObject *)aObject {
    return 147;
}

- (void)showCellWithObject:(ConsultationListObject *)aObject {
    self.titleLabel.text = aObject.title;
    self.phoneLabel.text = aObject.phone;
    self.addressLabel.text = aObject.content1;
}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private


@end
