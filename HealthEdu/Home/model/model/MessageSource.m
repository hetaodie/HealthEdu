//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "MessageSource.h"
#import "HENetTask.h"
#import "MessageObject.h"

@interface MessageSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation MessageSource

- (void)getMessage{
    
    NSString *strUrl;
    strUrl = @"/mobile/getContentList.action?stype=8&pageSize=-1";
    
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onGetMessageSuccess:)]) {
            NSArray *array = [self arrayWithObject:responseObject];
            [weakSelf.delegate onGetMessageSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onGetMessageError)]) {
            [self.delegate onGetMessageError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MessageObject *object = [[MessageObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.picurl = [obj objectForKey:@"picurl"];
        object.contenttext = [obj objectForKey:@"contenttext"];
        [array addObject:object];
    }];
    return array;
}


@end
