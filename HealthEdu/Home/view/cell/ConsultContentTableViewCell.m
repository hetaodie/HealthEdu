//
//  ConsultContentTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultContentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Comment.h"

const float ConsultContentTableViewCellHeight = 126;


@interface ConsultContentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
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

- (void)showCellWithData:(ConsultListObject *)aObject{
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:aObject.picurl] placeholderImage:[UIImage imageNamed:@"ConsultContentDefault.png"]];
    self.titleLabel.text = aObject.title;
    self.desclabel.text= aObject.stitle;
    
    NSDate *date = [Comment getDateTimeFromMilliSeconds:aObject.createDate];
    NSString *strDate = [Comment dateToString:date];
    self.showTimeslabel.text = strDate;
}

+ (CGFloat) cellHeightWithData:(ConsultListObject *)aObject{
    return ConsultContentTableViewCellHeight;
}


#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private



@end
