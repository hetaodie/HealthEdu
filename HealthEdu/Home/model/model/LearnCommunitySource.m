//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "LearnCommunitySource.h"
#import "HENetTask.h"
#import "LearnCommunityObject.h"
#import "LearnCommunityClassifyObject.h"

@interface LearnCommunitySource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LearnCommunitySource

- (void)getLearnCommunityClassify{
    
    NSString *strUrl;
    strUrl = @"/mobile/getCategory.action?catid=5";
    
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onLearnCommunityClassifySuccess:)]) {
            NSArray *array = [self arrayWithObject:responseObject];
            [weakSelf.delegate onLearnCommunityClassifySuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onLearnCommunityClassifyError)]) {
            [self.delegate onLearnCommunityClassifyError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LearnCommunityClassifyObject *object = [[LearnCommunityClassifyObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        [array addObject:object];
    }];
    return array;
}

- (void)getLearnCommunityData:(NSString *)aId{
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/getContentList.action?cid=%@",aId];

    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onLearnCommunityDataSuccess:)]) {
            NSArray *array = [self listarrayWithObject:responseObject];
            [weakSelf.delegate onLearnCommunityDataSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onLearnCommunityDataError)]) {
            [self.delegate onLearnCommunityDataError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)listarrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LearnCommunityObject *object = [[LearnCommunityObject alloc] init];
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
