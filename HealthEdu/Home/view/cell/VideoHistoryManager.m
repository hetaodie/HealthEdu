//
//  VideoHistoryManager.m
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "VideoHistoryManager.h"
#import "NSString+MD5.h"

#define historyVideoFileName @"historyVideoData"

@interface VideoHistoryManager()
@property (nonatomic,strong) NSMutableDictionary *historyDic;
@end

@implementation VideoHistoryManager

static VideoHistoryManager *instance;

#pragma mark -
#pragma mark lifecycle

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t historyonceToken;
    dispatch_once(&historyonceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t historyonceToken;
    dispatch_once(&historyonceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.historyDic = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary *hisDic = [self readHistoryVideoForFile];
        if ([hisDic.allKeys count]>0) {
            [self.historyDic setDictionary:hisDic];
        }
    }
    return self;
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (void)addVideoToHistory:(LectureHailContentObject *)aObject{
    @synchronized (self.historyDic) {
        [self.historyDic setObject:aObject forKey:aObject.videoUrl.MD5];
    }
    [self writeHistoryVideoToFile];
}

- (NSArray *)getAllVideoHistory{
    return [self.historyDic allValues];
}

- (void)removeVideoFromHistory:(LectureHailContentObject *)aObject{
    @synchronized (self.historyDic) {
        [self.historyDic removeObjectForKey:aObject.videoUrl.MD5];
    }
    
    [self writeHistoryVideoToFile];
}


#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (NSString *)getVideoFilePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"historyVideo"];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}


- (void)writeHistoryVideoToFile{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:historyVideoFileName];
    
    [NSKeyedArchiver archiveRootObject:self.historyDic toFile:docPath];
}

- (NSMutableDictionary *)readHistoryVideoForFile{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:historyVideoFileName];
    NSMutableDictionary *downVideoDic = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
    return downVideoDic;
}
@end
