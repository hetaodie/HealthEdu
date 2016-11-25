//
//  LecturePlayerView.m
//  HealthEdu
//
//  Created by weixu on 16/11/22.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "LecturePlayerView.h"
#import "PlayerView.h"
#import "UIColor+HEX.h"
#import "UIDevice+JWDevice.h"

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
@property (nonatomic, assign) BOOL isFullScreen;

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
    self.downView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.6];
    
    self.isFullScreen = NO;
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
- (IBAction)playAndPauseBtnPress:(id)sender {
  PlayerStatus playStatus =  [self.playView getPlayerStatus];
    if (playStatus == PlayerPlay) {
        [self.playView pause];
        [self.playBtn setImage:[UIImage imageNamed:@"MoviePlayer_Stop"] forState:UIControlStateNormal];
    }
    else{
        [self.playView play];
        [self.playBtn setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
    }
}

- (IBAction)playerSliderChanged:(UISlider *)sender {
    [self.playView pause];
    //转换成CMTime才能给player来控制播放进度
    [self.playView playFromTime:self.playProgress.value];
}
- (IBAction)playerSliderInside:(UISlider *)sender {
    NSLog(@"释放播放");
    [self.playView play];
}
- (IBAction)playerSliderDown:(UISlider *)sender {
    NSLog(@"按动暂停");
    [self.playView pause];
}

- (IBAction)totateOrigBtnPress:(id)sender {
    if (self.isFullScreen) {
        [UIDevice setOrientation:UIInterfaceOrientationPortrait];
        self.isFullScreen=NO;
        
    }else{
        [UIDevice setOrientation:UIInterfaceOrientationLandscapeRight];
        self.isFullScreen=YES;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onChangeDeviceOrientation:)]) {
        [self.delegate onChangeDeviceOrientation:self.isFullScreen];
    }
}
#pragma mark -
#pragma mark public
- (void)setNewUrl:(NSURL *)aNewUrl isCircle:(BOOL)isCircle{
    [self.playView setNewUrl:aNewUrl isCircle:isCircle];
    [self.playView play];
}


#pragma mark -
#pragma mark delegate


- (void)onPlayerloadSuccessWithTotalSecond:(float)totalSecond{
    NSString *timeStr =[self timeFormatted:rintf(totalSecond)];
    self.totalTimeLabel.text = timeStr;
    self.playProgress.maximumValue = totalSecond;
}

- (void)onPlayerFinish{

}


- (void)onPlayerloadError:(int)aError{

}

- (void)onplaybackStalled{

}

- (void)onPlayerCurrentSecond:(float)aCurrentSecond{
    
    NSString *timeStr =[self timeFormatted:rintf(aCurrentSecond)];
    self.currentTimeLabel.text =  timeStr;
    self.playProgress.value = aCurrentSecond;
    
}

- (void)onPlayerBufferSecond:(float)aBufferSecond{
    
}


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


@end
