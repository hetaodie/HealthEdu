//
//  LectureHailContentCollectionViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/16.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "LectureHailContentCollectionViewCell.h"
#import "PlayerView.h"

const CGFloat LectureHailContentCollectionViewCellCapHeight = 53.5;
const CGFloat LectureHailContentCollectionViewCellCapWidth = 43;

@interface LectureHailContentCollectionViewCell()
@property (weak, nonatomic) IBOutlet PlayerView *playerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation LectureHailContentCollectionViewCell


#pragma mark -
#pragma mark lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

+ (CGSize)cellSizeWithData:(NSString *)aData{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat cellWidth = (screenWidth-LectureHailContentCollectionViewCellCapWidth)/2.0f;
    CGFloat height = cellWidth * 89/167 + LectureHailContentCollectionViewCellCapHeight;
    CGSize size = CGSizeMake(cellWidth, height);
    return size;
}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

@end
