//
//  ConsultContentTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultContentTableViewCell.h"
const float ConsultContentTableViewCellHeight = 126;


@interface ConsultContentTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property (weak, nonatomic) IBOutlet UILabel *showTimeslabel;

@end

@implementation ConsultContentTableViewCell

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

- (void)showCellWithData:(ConsultContentObject *)aObject{
}

+ (CGFloat) cellHeightWithData:(ConsultContentObject *)aObject{
    return ConsultContentTableViewCellHeight;
}


#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private



@end
