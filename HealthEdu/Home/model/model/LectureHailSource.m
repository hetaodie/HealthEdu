//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "LectureHailSource.h"
#import "HENetTask.h"
#import "LectureHailObject.h"
#import "LectureHailClassifyObject.h"

@interface LectureHailSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LectureHailSource

- (void)getLectureHailClassify{
    
    NSString *strUrl;
    strUrl = @"/mobile/getCategory.action?catid=4";
    
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onLectureHailClassifySuccess:)]) {
            NSArray *array = [self arrayWithObject:responseObject];
            [weakSelf.delegate onLectureHailClassifySuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onLectureHailClassifyError)]) {
            [self.delegate onLectureHailClassifyError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LectureHailClassifyObject *object = [[LectureHailClassifyObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        [array addObject:object];
    }];
    return array;
}

- (void)getLectureHailData:(NSString *)aId{
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/getContentList.action?cid=%@",aId];

    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onLectureHailDataSuccess:)]) {
            NSArray *array = [self listarrayWithObject:responseObject];
            [weakSelf.delegate onLectureHailDataSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onLectureHailDataError)]) {
            [self.delegate onLectureHailDataError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)listarrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LectureHailObject *object = [[LectureHailObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.content1 = [obj objectForKey:@"content1"];
        object.content2 = [obj objectForKey:@"content2"];
        object.exturl = [obj objectForKey:@"exturl"];
        object.picurl = [obj objectForKey:@"picurl"];
        
        [array addObject:object];
    }];
    return array;
}

@end
