//
//  MessageTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 2017/4/11.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface MessageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (nonatomic, strong) MessageObject *messageObject;


@end

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)moreBtnPress:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onMessageMore:)]) {
        [self.delegate onMessageMore:self.messageObject];
    }
}

- (void)showCellWithData:(MessageObject *)aObject {
    self.messageObject = aObject;
    self.titleLabel.text = aObject.title;
    self.contentLabel.text = aObject.contenttext;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:aObject.picurl] placeholderImage:[UIImage imageNamed:@"messageDefault"]];
}

@end
