//
//  ConsultContentTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultContentTableViewCell.h"


@interface ConsultContentTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ConsultContentTableViewCell

#pragma mark -
#pragma mark lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (void)showCellWithData:(NSString *)aObject{
    self.titleLabel.text = aObject;
}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private



@end
