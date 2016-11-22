//
//  CycleBannersCollectionViewCell.m
//  CircleBannersDemo
//
//  Created by Weixu on 16/6/1.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "CycleBannersCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation CycleBannersCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];

}


- (void)showImageContentFromNStringUrl:(NSString *)imageStrUrl{
    //图片处理
   [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageStrUrl] placeholderImage:[UIImage imageNamed:@"lectureHailCycleDefaut"]];
}

@end
