//
//  LectureHailContentCollectionViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/16.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "CacheCollectionViewCell.h"
#import "PlayerView.h"

const CGFloat CacheCollectionViewCellCapHeight = 53.5;
const CGFloat CacheCollectionViewCellCapWidth = 43;

@interface CacheCollectionViewCell()<PlayerViewDelegate>
@property (weak, nonatomic) IBOutlet PlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *editedStatusButton;
@property (strong, nonatomic) LectureHailContentObject *hailContentObject;
@end

@implementation CacheCollectionViewCell


#pragma mark -
#pragma mark lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.playerImageView.image = nil;
    self.titleLabel.text = nil;
    self.videoTimeLabel.text = nil;
}

#pragma mark -
#pragma mark IBActions

- (IBAction)editedStatusBtnPress:(id)sender {
    self.editedStatusButton.selected = !self.editedStatusButton.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSelectVideoWithData:andIsSelected:)]) {
        [self.delegate onSelectVideoWithData:self.hailContentObject andIsSelected:self.editedStatusButton.selected];
    }
    
}

#pragma mark -
#pragma mark public

+ (CGSize)cellSizeWithData:(NSString *)aData{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat cellWidth = (screenWidth-CacheCollectionViewCellCapWidth)/2.0f;
    CGFloat height = cellWidth * 89/167 + CacheCollectionViewCellCapHeight;
    CGSize size = CGSizeMake(cellWidth, height);
    return size;
}

- (void)showCellWithData:(LectureHailContentObject *)aData{
    self.hailContentObject = aData;
    
    [self setVideoInfoWithUrl:aData.videoUrl];
    self.titleLabel.text = aData.title;
}

- (void) setVideoInfoWithUrl:(NSString *)aStrUrl
{
    dispatch_queue_t queue = dispatch_queue_create("videoPreView", nil);

    dispatch_async(queue, ^{
        NSURL *videoPath = [NSURL URLWithString:aStrUrl];
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *img = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        CMTime assetTime = [asset duration];
        CGFloat duration = CMTimeGetSeconds(assetTime);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.playerImageView.image = img;
            self.videoTimeLabel.text = [self timeFormatted:rintf(duration)];
        });

    });
    

}

- (void)setCellEditStatus:(NSInteger)aStatus{
    if (aStatus == 0) {
        self.editedStatusButton.hidden = YES;
    }
    else if (aStatus == 1){
        self.editedStatusButton.hidden = NO;
        self.editedStatusButton.selected = NO;
    }
    else if (aStatus == 2){
        self.editedStatusButton.hidden = NO;
        self.editedStatusButton.selected = YES;

    }
}


#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

- (void)dealloc
{
    
}
@end
