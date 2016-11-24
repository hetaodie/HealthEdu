//
//  VideoDownloaderManger.m
//  HealthEdu
//
//  Created by weixu on 16/11/23.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "VideoDownloaderManger.h"
#import "AFNetworking.h"
#import "NSString+MD5.h"

#define completedVideoFileName @"completedVideoFile"
#define downVideoFileName @"downVideoFile"

@interface VideoDownloaderManger()
@property (nonatomic, strong) NSMutableArray *completedVideoArray;
@property (nonatomic, strong) NSMutableArray *downVideoArray;
@property (nonatomic, strong) NSMutableDictionary *taskDictionary;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;


@end

@implementation VideoDownloaderManger

#pragma mark -
#pragma mark lifecycle
static VideoDownloaderManger *instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
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
        self.downVideoArray = [[NSMutableArray alloc] init];
        self.completedVideoArray = [[NSMutableArray alloc] init];
        self.taskDictionary = [[NSMutableDictionary alloc] init];
        
        NSArray *downVideos = [self readDownVideoForFile];
        if ([downVideos count] > 0) {
            [self.downVideoArray setArray:downVideos];
        }
        
        NSArray *completedVideos = [self readDownVideoForFile];
        if ([completedVideos count] > 0) {
            [self.completedVideoArray setArray:completedVideos];
        }
        
    }
    return self;
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (NSArray *)getDownVideoArray{
    return self.downVideoArray;
}

- (NSArray *)getCompletedVideoArray{
    return self.completedVideoArray;
}

- (void)downloadVideoWithString:(NSString *)aStrUrl{
    NSString *VideoDataName = aStrUrl.MD5;
    NSString *path = [self getVideoFilePath];
    NSString *videoPath = [path stringByAppendingPathComponent:VideoDataName];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:aStrUrl]];
    
    //下载Task操作
    self.downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        
        // 给Progress添加监听 KVO
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // 设置进度条的百分比
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *VideoDataName = aStrUrl.MD5;
        NSString *path = [self getVideoFilePath];
        NSString *videoPath = [path stringByAppendingPathComponent:VideoDataName];
        return [NSURL fileURLWithPath:videoPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        
        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
        
    }];
    [self.downloadTask resume];

    [self.taskDictionary setObject:self.downloadTask forKey:aStrUrl.MD5];
    
}

- (void)stopDownLoadWithString:(NSString *)aStrUrl{
    NSURLSessionDownloadTask *downloadTask = [self.taskDictionary objectForKey:aStrUrl.MD5];
    [downloadTask suspend];
}

- (void)startDownLoadWithString:(NSString *)aStrUrl{
    NSURLSessionDownloadTask *downloadTask = [self.taskDictionary objectForKey:aStrUrl.MD5];
    [downloadTask resume];
}

- (void)stopAllDownLoad{
    [self.taskDictionary.allValues enumerateObjectsUsingBlock:^(NSURLSessionDownloadTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj suspend];
    }];
}

- (void)startAllDownLoad{
    [self.taskDictionary.allValues enumerateObjectsUsingBlock:^(NSURLSessionDownloadTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj resume];
    }];
}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (NSString *)getVideoFilePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"video"];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

- (void)writeDownVideoArray{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:downVideoFileName];
    
    [NSKeyedArchiver archiveRootObject:self.downVideoArray toFile:docPath];
}

- (NSMutableArray *)readDownVideoForFile{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:downVideoFileName];
    NSMutableArray *downVideoArray = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
    return downVideoArray;
}

- (void)writeCompletedVideoArray{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:completedVideoFileName];
    
    [NSKeyedArchiver archiveRootObject:self.completedVideoArray toFile:docPath];
}

- (NSMutableArray *)readCompletedVideoForFile{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:completedVideoFileName];
    NSMutableArray *completedVideoArray = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
    return completedVideoArray;
}

- ( long long)fileSizeForPath:(NSString *)path{
    long long fileSize = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

@end
