//
//  PlayHistoryTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "PlayHistoryTableViewCell.h"
#import <AVFoundation/AVFoundation.h>


@interface PlayHistoryTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation PlayHistoryTableViewCell
#pragma mark -
#pragma mark lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (void)showCellWithObject:(LectureHailContentObject *)aObject{
    self.titleLabel.text = aObject.title;
    [self setVideoInfoWithUrl:aObject.videoUrl];
}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headerImageView.image = img;
        });
        
    });
    
    
}

@end
