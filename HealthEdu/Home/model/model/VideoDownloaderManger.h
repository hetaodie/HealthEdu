//
//  VideoDownloaderManger.h
//  HealthEdu
//
//  Created by weixu on 16/11/23.
//  Copyright © 2016年 allWants. All rights reserved.
//

#define VideoDownloaderMangerDownVideoChanged @"VideoDownloaderMangerDownVideoChanged"
#define VideoDownloaderMangerCompletedVideoChanged @"VideoDownloaderMangerCompletedVideoChanged"

#define VideoDownloaderMangerDataPregross @"VideoDownloaderMangerDataPregross"
#define VideoDownloaderDownloadingCompleted @"VideoDownloaderDownloadingCompleted"
#define VideoDownloaderDownloadingError @"VideoDownloaderDownloadingError"


#import <Foundation/Foundation.h>
#import "LectureHailObject.h"

@interface VideoDownloaderManger : NSObject

+ (instancetype)sharedInstance;

- (NSDictionary *)getDownloadingVideo;

- (NSDictionary *)getCompletedVideo;

- (void)downloadVideoWithString:(LectureHailObject *)aObject;

- (void)downloadAllVideo;

- (void)stopDownLoadWithString:(NSString *)aStrUrl;

- (void)stopAllDownLoad;

- (void)startAllDownLoad;

- (void)removeDownLoadingVideoWithString:(NSString *)aStrUrl;

- (void)removeAllDownLoadingVideo;

- (void)removeCompletedVideoWithString:(NSString *)aStrUrl;

- (void)removeAllCompletedVideo;

- (NSString *)getVideoFilePathWithUrl:(NSString *)aStrUrl;
@end
