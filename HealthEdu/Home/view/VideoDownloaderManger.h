//
//  VideoDownloaderManger.h
//  HealthEdu
//
//  Created by weixu on 16/11/23.
//  Copyright © 2016年 allWants. All rights reserved.
//

#define VideoDownloaderMangerDownVideoChanged @"VideoDownloaderMangerDownVideoChanged"
#define VideoDownloaderMangerCompletedVideoChanged @"VideoDownloaderMangerCompletedVideoChanged"

#import <Foundation/Foundation.h>

@interface VideoDownloaderManger : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getDownVideoArray;

- (NSArray *)getCompletedVideoArray;

- (void)downloadVideoWithString:(NSString *)aStrUrl;

- (void)stopDownLoadWithString:(NSString *)aStrUrl;

- (void)startDownLoadWithString:(NSString *)aStrUrl;

- (void)stopAllDownLoad;
- (void)startAllDownLoad;
@end
