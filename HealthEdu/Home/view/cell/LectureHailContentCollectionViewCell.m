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

@interface LectureHailContentCollectionViewCell()<PlayerViewDelegate>
@property (weak, nonatomic) IBOutlet PlayerView *playerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

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

- (void)showCellWithData:(LectureHailContentObject *)aData{
    NSURL *url = [NSURL URLWithString:aData.videoUrl];
    [self.playerView setNewUrl:url isCircle:NO];
    self.playerView.delegate = self;
    
    self.titleLabel.text = aData.title;
}



#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)onPlayerloadSuccessWithTotalSecond:(float)totalSecond{
    self.videoTimeLabel.text = [self timeFormatted:rintf(totalSecond)];
}

- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

@end
