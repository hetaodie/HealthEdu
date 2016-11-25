//
//  ConsultationContentTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultationContentTableViewCell.h"

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

+(CGFloat)cellHeightWithData:(NSString *)aString{
    return 147;
}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private


@end
