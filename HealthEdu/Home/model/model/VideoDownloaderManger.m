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
#import "VideoDownLoaderObject.h"

#define completedVideoFileName @"completedVideoFile"
#define downVideoFileName @"downVideoFile"

@interface VideoDownloaderManger()<NSURLSessionDelegate>
@property (nonatomic, strong) NSMutableDictionary *completedVideoDic;
@property (nonatomic, strong) NSMutableDictionary *downVideoDic;
@property (nonatomic, strong) NSMutableDictionary *taskDictionary;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSMutableDictionary *requestDownVideoDic;

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
        self.downVideoDic = [[NSMutableDictionary alloc] init];
        self.completedVideoDic = [[NSMutableDictionary alloc] init];
        self.taskDictionary = [[NSMutableDictionary alloc] init];
        self.requestDownVideoDic = [[NSMutableDictionary alloc] init];
        
        NSDictionary *downVideos = [self readDownVideoForFile];
        if ([downVideos.allKeys count] > 0) {
            [self.downVideoDic setDictionary:downVideos];
        }
        
        NSDictionary *completedVideos = [self readCompletedVideoForFile];
        if ([completedVideos.allKeys count] > 0) {
            [self.completedVideoDic setDictionary:completedVideos];
        }
        
    }
    return self;
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public


- (NSDictionary *)getDownloadingVideo{
    return self.downVideoDic;
}

- (NSDictionary *)getCompletedVideo{
    return self.completedVideoDic;
}

- (void)downloadAllVideo{
    [self.downVideoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, LectureHailContentObject *obj, BOOL * _Nonnull stop) {
        [self downloadVideoWithString:obj];
    }];
}


- (void)downloadVideoWithString:(LectureHailContentObject *)aObject{
    NSString *aStrUrl = aObject.videoUrl;
    
    if ([aStrUrl length]==0) {
        return;
    }
    
    [self.downVideoDic setObject:aObject forKey:aStrUrl.MD5];
    [self writeDownVideoToFile];
    
    [self.requestDownVideoDic setObject:aObject forKey:aStrUrl.MD5];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoDownloaderMangerDownVideoChanged object:nil];
    
    if ([self.taskDictionary valueForKey:aStrUrl.MD5]) {
        VideoDownLoaderObject *videoLoaderObject = [self.taskDictionary valueForKey:aStrUrl.MD5];
        if (videoLoaderObject.task.state != NSURLSessionTaskStateRunning) {
            [videoLoaderObject.task resume];
        }
        return;
    }
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:aStrUrl]];
    // 设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-", [self getFileDownloadedLength:aStrUrl]];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    // 创建一个Data任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    
    
    VideoDownLoaderObject *videoLoaderObject = [[VideoDownLoaderObject alloc]init];
    videoLoaderObject.task = task;
    [self.taskDictionary setValue:videoLoaderObject forKey:aStrUrl.MD5];
    
    [task resume];
    
}

- (void)stopDownLoadWithString:(NSString *)aStrUrl{
    VideoDownLoaderObject *videoLoaderObject = [self.taskDictionary valueForKey:aStrUrl.MD5];
    if (videoLoaderObject) {
        [videoLoaderObject.task suspend];
    }
}


- (void)stopAllDownLoad{
    [self.taskDictionary.allValues enumerateObjectsUsingBlock:^(VideoDownLoaderObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.task suspend];
    }];
}

- (void)startAllDownLoad{
    [self.taskDictionary.allValues enumerateObjectsUsingBlock:^(VideoDownLoaderObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.task resume];
    }];
}

- (void)removeDownLoadingVideoWithString:(NSString *)aStrUrl{
    NSString *fullPath = [self getVideoFilePathWithUrl:aStrUrl];
    NSFileManager *fileManager = [NSFileManager defaultManager ];
    if ([fileManager fileExistsAtPath:fullPath]) {
        [fileManager removeItemAtPath:fullPath error:nil];
    }
    VideoDownLoaderObject *lc_D = [self.taskDictionary valueForKey:aStrUrl.MD5];
    if (lc_D) {
        [lc_D.task cancel];
    }
    [self.downVideoDic removeObjectForKey:aStrUrl.MD5];
    [self writeDownVideoToFile];


}

- (void)removeAllDownLoadingVideo{
    [self.downVideoDic.allValues enumerateObjectsUsingBlock:^(  LectureHailContentObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *fullPath = [self getVideoFilePathWithUrl:obj.videoUrl];
        NSFileManager *fileManager = [NSFileManager defaultManager ];
        if ([fileManager fileExistsAtPath:fullPath]) {
            [fileManager removeItemAtPath:fullPath error:nil];
        }
        VideoDownLoaderObject *lc_D = [self.taskDictionary valueForKey:obj.videoUrl.MD5];
        if (lc_D) {
            [lc_D.task cancel];
        }
    }];
    [self.downVideoDic removeAllObjects];
    [self writeDownVideoToFile];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoDownloaderMangerDownVideoChanged object:nil];
}

- (void)removeCompletedVideoWithString:(NSString *)aStrUrl{
    NSString *fullPath = [self getVideoFilePathWithUrl:aStrUrl];
    NSFileManager *fileManager = [NSFileManager defaultManager ];
    if ([fileManager fileExistsAtPath:fullPath]) {
        [fileManager removeItemAtPath:fullPath error:nil];
    }

    [self.completedVideoDic removeObjectForKey:aStrUrl.MD5];
    [self writeCompletedVideoToFile];
}

- (void)removeAllCompletedVideo{
    [self.completedVideoDic.allValues enumerateObjectsUsingBlock:^(  LectureHailContentObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *fullPath = [self getVideoFilePathWithUrl:obj.videoUrl];
        NSFileManager *fileManager = [NSFileManager defaultManager ];
        if ([fileManager fileExistsAtPath:fullPath]) {
            [fileManager removeItemAtPath:fullPath error:nil];
        }
    }];
    [self.completedVideoDic removeAllObjects];
    [self writeCompletedVideoToFile];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoDownloaderMangerCompletedVideoChanged object:nil];
}

#pragma mark -
#pragma mark delegate

// 收到响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    NSString *strUrl = dataTask.currentRequest.URL.absoluteString;
    VideoDownLoaderObject *videoDownLoaderObject = [self.taskDictionary valueForKey:strUrl.MD5];
    
    NSString *fullPath = [self getVideoFilePathWithUrl:strUrl];
    
    // 创建流
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:fullPath append:YES];
    videoDownLoaderObject.stream = stream;
    [videoDownLoaderObject.stream open];
    completionHandler(NSURLSessionResponseAllow);
    
}
// 接受数据（会多次调用）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    NSString *strUrl = dataTask.currentRequest.URL.absoluteString;

    VideoDownLoaderObject *videoDownLoaderObject  = [self.taskDictionary valueForKey:strUrl.MD5];
    if (videoDownLoaderObject) {
        [videoDownLoaderObject.stream write:data.bytes maxLength:data.length];
    }
    
}

// 请求完毕或失败
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSString *strUrl = task.currentRequest.URL.absoluteString;
    
    VideoDownLoaderObject *videoDownLoaderObject  = [self.taskDictionary valueForKey:strUrl.MD5];
    [videoDownLoaderObject.stream close];
    videoDownLoaderObject.stream = nil;

    [self.taskDictionary removeObjectForKey:strUrl.MD5];
    if (error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:VideoDownloaderDownloadingError object:nil userInfo:@{@"videoUrl":strUrl}];

    }
    else{
        [self.completedVideoDic setObject:[self.requestDownVideoDic objectForKey:strUrl.MD5] forKey:strUrl.MD5];
        [self.downVideoDic removeObjectForKey:strUrl.MD5];
        [self writeDownVideoToFile];
        [self writeCompletedVideoToFile];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:VideoDownloaderDownloadingCompleted object:nil userInfo:@{@"videoUrl":strUrl}];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:VideoDownloaderMangerDownVideoChanged object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:VideoDownloaderMangerCompletedVideoChanged object:nil];
    }
}


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

- (NSString *)getVideoFilePathWithUrl:(NSString *)aStrUrl{
    
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *strName = [NSString stringWithFormat:@"%@.mp4",aStrUrl.MD5];
    NSString *fullPath = [videoPath stringByAppendingPathComponent:strName];
    return fullPath;
}

- (void)writeDownVideoToFile{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:downVideoFileName];
    
    [NSKeyedArchiver archiveRootObject:self.downVideoDic toFile:docPath];
}

- (NSMutableDictionary *)readDownVideoForFile{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:downVideoFileName];
    NSMutableDictionary *downVideoDic = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
    return downVideoDic;
}

- (void)writeCompletedVideoToFile{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:completedVideoFileName];
    
    [NSKeyedArchiver archiveRootObject:self.completedVideoDic toFile:docPath];
}

- (NSMutableDictionary *)readCompletedVideoForFile{
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *docPath = [videoPath stringByAppendingPathComponent:completedVideoFileName];
    NSMutableDictionary *completedVideoDic = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
    return completedVideoDic;
}


- (NSData *)getFileDownloadedData:(NSString *)aStrUrl {
    NSString *videoPath = [self getVideoFilePath];
    
    NSString *fullPath = [videoPath stringByAppendingPathComponent:aStrUrl.MD5];
    NSFileManager *fileManager =[NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:fullPath]) {
        NSData *data = [NSData dataWithContentsOfFile:fullPath];
        return data;
    }
    return nil;
}
// 获取本地已经下载的大小
- (NSUInteger)getFileDownloadedLength:(NSString *)aStrUrl{
    NSData *data = [self getFileDownloadedData:aStrUrl];
    if (data) return data.length;
    return 0.0;
}

@end
