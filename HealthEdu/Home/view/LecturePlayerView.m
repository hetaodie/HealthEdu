//
//  LecturePlayerView.m
//  HealthEdu
//
//  Created by weixu on 16/11/22.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "LecturePlayerView.h"
#import "PlayerView.h"

@interface LecturePlayerView()<PlayerViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet PlayerView *playView;

@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *bufferProgress;
@property (weak, nonatomic) IBOutlet UISlider *playProgress;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *totateBtn;

@end


@implementation LecturePlayerView

#pragma mark -
#pragma mark lifecycle

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.playView.delegate = self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        self.contentView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate


- (void)onPlayerloadSuccessWithTotalSecond:(float)totalSecond{

}

- (void)onPlayerFinish{

}


- (void)onPlayerloadError:(int)aError{

}

- (void)onplaybackStalled{

}

- (void)onPlayerCurrentSecond:(float)aCurrentSecond{

}

- (void)onPlayerBufferSecond:(float)aBufferSecond{

}


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private


@end
