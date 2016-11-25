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

#define  playerViewLayoutPriorityWithFull 1000
#define  playerViewLayoutPriorityWithNoFull 888


@interface PlayerViewController ()<LecturePlayerViewDelegate>
@property (weak, nonatomic) IBOutlet LecturePlayerView *playerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerViewLayout;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet UILabel *downBtnNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerViewTopLayout;

@end

@implementation PlayerViewController

#pragma mark -
#pragma mark lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.playerView.delegate = self;
    
    VideoDownloaderManger *manager = [VideoDownloaderManger sharedInstance];
    NSDictionary *completedVideoDic = [manager getCompletedVideo];
    
    LectureHailContentObject *completedVideoObject = [completedVideoDic objectForKey:self.videoObject.videoUrl.MD5];
    if (completedVideoObject) {
        NSString *videoPath = [manager getVideoFilePathWithUrl:self.videoObject.videoUrl];
        NSURL *url=[NSURL fileURLWithPath:videoPath];
        [self.playerView setNewUrl:url isCircle:NO];

    }
    else{
        
        NSURL *url = [NSURL URLWithString:self.videoObject.videoUrl ];
        [self.playerView setNewUrl:url isCircle:NO];

    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDownLoadCompleted:) name:VideoDownloaderDownloadingCompleted object:nil];
    
    [[VideoHistoryManager sharedInstance] addVideoToHistory:self.videoObject];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    VideoDownloaderManger *manager = [VideoDownloaderManger sharedInstance];
    NSDictionary *downVideoDic = [manager getDownloadingVideo];
    NSDictionary *completedVideoDic = [manager getCompletedVideo];
    
    LectureHailContentObject *downVideoObject = [downVideoDic objectForKey:self.videoObject.videoUrl.MD5];
    
    LectureHailContentObject *completedVideoObject = [completedVideoDic objectForKey:self.videoObject.videoUrl.MD5];
    
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
        self.playerViewTopLayout.constant = 64;

    }
}
#pragma mark -
#pragma mark NSNotification

- (void)videoDownLoadCompleted:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *videoUrl=[userInfo objectForKey:@"videoUrl"];
    if ([videoUrl isEqualToString:self.videoObject.videoUrl]) {
        [self.downBtnNameLabel setText:@"已缓存"];
        [self.downLoadButton setEnabled:NO];
    }
}

#pragma mark -
#pragma mark private


@end
