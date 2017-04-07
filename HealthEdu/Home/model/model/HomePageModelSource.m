//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "HomePageModelSource.h"
#import "HENetTask.h"
#import "PopularRecommendObject.h"

@interface HomePageModelSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation HomePageModelSource

- (void)getHomePageNews{
    HENetTask *task = [[HENetTask alloc] initWithUrlString:@"/mobile/getContentList.action?top=1"];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onHomePageNewsSuccess:)]) {
            NSArray *array = [self arrayWithObject:responseObject];
            [weakSelf.delegate onHomePageNewsSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onHomePageNewsError)]) {
            [self.delegate onHomePageNewsError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PopularRecommendObject *object = [[PopularRecommendObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.imageUrl = [obj objectForKey:@"picurl"];
        object.stype = [obj objectForKey:@"stype"];
        [array addObject:object];
    }];
    return array;
}


- (void)getVideoContent:(NSString *)aId {
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/getContentDetail.action?cid=%@",aId];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onGetVideoContentSuccess:)]) {
            LectureHailObject *object = [self listarrayWithObject:responseObject];
            [weakSelf.delegate onGetVideoContentSuccess:object];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onGetVideoContentError)]) {
            [self.delegate onGetVideoContentError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (LectureHailObject *)listarrayWithObject:(NSDictionary *)obj{
        LectureHailObject *object = [[LectureHailObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.content1 = [obj objectForKey:@"content1"];
        object.content2 = [obj objectForKey:@"content2"];
        object.exturl = [obj objectForKey:@"exturl"];
        object.picurl = [obj objectForKey:@"picurl"];
        
    return object;
}

@end
