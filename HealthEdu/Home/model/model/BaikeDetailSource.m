//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "BaikeDetailSource.h"
#import "HENetTask.h"
#import "BaikeDetailObject.h"


@interface BaikeDetailSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation BaikeDetailSource

- (void)getBaikeDetailWithId:(NSString *)aId{
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/getContentDetail.action?cid=%@",aId];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onBaikeDetailSourceSuccess:)]) {
            BaikeDetailObject *object = [self arrayWithObject:responseObject];
            [weakSelf.delegate onBaikeDetailSourceSuccess:object];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onBaikeDetailSourceError)]) {
            [self.delegate onBaikeDetailSourceError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (BaikeDetailObject *)arrayWithObject:(NSDictionary *)aDictionary{
    BaikeDetailObject *object = [[BaikeDetailObject alloc] init];
    object.id = [aDictionary objectForKey:@"id"];
    object.title = [aDictionary objectForKey:@"title"];
    object.contenttext = [aDictionary objectForKey:@"contenttext"];
    return object;
}
@end
