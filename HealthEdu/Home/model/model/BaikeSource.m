//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "BaikeSource.h"
#import "HENetTask.h"
#import "BaikeObject.h"
#import "BaiKeClassifyObject.h"


@interface BaikeSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation BaikeSource

- (void)getBaikeClassify:(int)type{
    
    NSString *strUrl;
    if (type==0) {
        strUrl = @"/mobile/getCategory.action?catid=11";
    }
    else if (type==1){
        strUrl = @"/mobile/getCategory.action?catid=12";
    }
    
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onBaikeClassifySuccess:)]) {
            NSArray *array = [self arrayWithObject:responseObject];
            [weakSelf.delegate onBaikeClassifySuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onBaikeClassifyError)]) {
            [self.delegate onBaikeClassifyError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaiKeClassifyObject *object = [[BaiKeClassifyObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.ordernum = [obj objectForKey:@"ordernum"];
        [array addObject:object];
    }];
    return array;
}

- (void)getBaikeData:(NSString *)aId{
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/getContentList.action?cid=%@",aId];

    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onBaikeDataSuccess:)]) {
            NSArray *array = [self listarrayWithObject:responseObject];
            [weakSelf.delegate onBaikeDataSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onBaikeDataError)]) {
            [self.delegate onBaikeDataError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)listarrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaikeObject *object = [[BaikeObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        [array addObject:object];
    }];
    return array;
}

@end
