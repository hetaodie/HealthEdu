//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "ConferenceDetailSource.h"
#import "HENetTask.h"


@interface ConferenceDetailSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ConferenceDetailSource

- (void)getCousultDetailWithId:(NSString *)aId{
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/getContentDetail.action?cid=%@",aId];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onConferenceDetailSourceSuccess:)]) {
            ConferenceDetailObject *object = [self arrayWithObject:responseObject];
            [weakSelf.delegate onConferenceDetailSourceSuccess:object];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onConferenceDetailSourceError)]) {
            [self.delegate onConferenceDetailSourceError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (ConferenceDetailObject *)arrayWithObject:(NSDictionary *)aDictionary{
    ConferenceDetailObject *object = [[ConferenceDetailObject alloc] init];
    object.id = [aDictionary objectForKey:@"id"];
    object.title = [aDictionary objectForKey:@"title"];
    object.picurl = [aDictionary objectForKey:@"picurl"];
    object.content1 = [aDictionary objectForKey:@"content1"];
    object.contenttext = [aDictionary objectForKey:@"contenttext"];
    object.content2 = [aDictionary objectForKey:@"content2"];
    object.content3 = [aDictionary objectForKey:@"content3"];
    object.content4 = [aDictionary objectForKey:@"content4"];
    object.content5 = [aDictionary objectForKey:@"content5"];
    object.content6 = [aDictionary objectForKey:@"content6"];

    return object;
}
@end
