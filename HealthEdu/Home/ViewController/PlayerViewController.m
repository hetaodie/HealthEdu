//
//  PlayerViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "PlayerViewController.h"
#import "LecturePlayerView.h"
#import "VideoDownloaderManger.h"
#import "NSString+MD5.h"
#import "VideoHistoryManager.h"
#import <PLPlayerKit/PLPlayerKit.h>

#define  playerViewLayoutPriorityWithFull 1000
#define  playerViewLayoutPriorityWithNoFull 888


@interface PlayerViewController ()<LecturePlayerViewDelegate,PLPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *qnplayView;
@property (weak, nonatomic) IBOutlet LecturePlayerView *playerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerViewLayout;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet UILabel *downBtnNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerViewTopLayout;
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;

@property (nonatomic, strong) PLPlayer  *player;
@end

@implementation PlayerViewController

#pragma mark -
#pragma mark lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.playerView.delegate = self;
    
    self.videoTitleLabel.text = self.videoObject.title;
    
    VideoDownloaderManger *manager = [VideoDownloaderManger sharedInstance];
    NSDictionary *completedVideoDic = [manager getCompletedVideo];
    
    NSString *strUrl = [self.videoObject.exturl length]>0 ? self.videoObject.exturl : self.videoObject.content1;
    
    
    if ([strUrl length] >0 && [strUrl containsString:@"rtmp"]) {
        self.qnplayView.hidden = NO;
        PLPlayerOption *option = [PLPlayerOption defaultOption];
        [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
        NSURL *url = [NSURL URLWithString:@"rtmp://pili-live-rtmp.mmqqbb.com/jkjt/jiangtang"];
        self.player = [PLPlayer playerWithURL:url option:option];
        self.player.delegate = self;
        
        [self.qnplayView addSubview:self.player.playerView];
        [self.player play];
    }
    else {
        self.qnplayView.hidden = YES;

        LectureHailObject *completedVideoObject = [completedVideoDic objectForKey:strUrl.MD5];
        if (completedVideoObject) {
            NSString *videoPath = [manager getVideoFilePathWithUrl:strUrl];
            NSURL *url=[NSURL fileURLWithPath:videoPath];
            [self.playerView setNewUrl:url isCircle:NO];
            
        }
        else{
            
            NSURL *url = [NSURL URLWithString:self.videoObject.exturl ];
            [self.playerView setNewUrl:url isCircle:NO];
            
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDownLoadCompleted:) name:VideoDownloaderDownloadingCompleted object:nil];
        
        [[VideoHistoryManager sharedInstance] addVideoToHistory:self.videoObject];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.player.playerView.frame = self.qnplayView.bounds;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    VideoDownloaderManger *manager = [VideoDownloaderManger sharedInstance];
    NSDictionary *downVideoDic = [manager getDownloadingVideo];
    NSDictionary *completedVideoDic = [manager getCompletedVideo];
    
    LectureHailObject *downVideoObject = [downVideoDic objectForKey:self.videoObject.exturl.MD5];
    
    LectureHailObject *completedVideoObject = [completedVideoDic objectForKey:self.videoObject.exturl.MD5];
    
    if (downVideoObject) {
        [self.downBtnNameLabel setText:@"正在缓存"];
        [self.downLoadButton setEnabled:NO];
    }
    else if (completedVideoObject) {
        [self.downBtnNameLabel setText:@"已缓存"];
        [self.downLoadButton setEnabled:NO];
    }
    else{
        [self.downBtnNameLabel setText:@"缓存视频"];
        [self.downLoadButton setEnabled:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark IBActions
- (IBAction)downLoadBtnPress:(id)sender {
    [[VideoDownloaderManger sharedInstance] downloadVideoWithString:self.videoObject];
    [self.downBtnNameLabel setText:@"正在缓存"];
    [self.downLoadButton setEnabled:NO];
}

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate

- (void)onChangeDeviceOrientation:(BOOL)isFull{
    if (isFull) {
        [self.navigationController setNavigationBarHidden:YES];
        self.playerViewTopLayout.constant = 0;
    }
    else{
         [self.navigationController setNavigationBarHidden:NO];
        self.playerViewTopLayout.constant = 107;

    }
}
#pragma mark -
#pragma mark NSNotification

- (void)videoDownLoadCompleted:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *strUrl = [self.videoObject.exturl length]>0 ? self.videoObject.exturl : self.videoObject.content1;
    
    NSString *exturl=[userInfo objectForKey:@"exturl"];
    
    
    if ([exturl isEqualToString:strUrl]) {
        [self.downBtnNameLabel setText:@"已缓存"];
        [self.downLoadButton setEnabled:NO];
    }
}

#pragma mark -
#pragma mark private


@end
