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

@interface PlayerViewController ()
@property (weak, nonatomic) IBOutlet LecturePlayerView *playerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerViewLayout;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet UILabel *downBtnNameLabel;

@end

@implementation PlayerViewController

#pragma mark -
#pragma mark lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    VideoDownloaderManger *manager = [VideoDownloaderManger sharedInstance];
    NSArray *downVideoArray = [manager getDownVideoArray];
    NSArray *completedVideoArray = [manager getCompletedVideoArray];
    if ([downVideoArray containsObject:self.videoObject.videoUrl] || [completedVideoArray containsObject:self.videoObject.videoUrl]) {
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

    [[VideoDownloaderManger sharedInstance] downloadVideoWithString:self.videoObject.videoUrl];
}

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private


@end
