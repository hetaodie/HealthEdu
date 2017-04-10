//
//  SearveSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "SearveSource.h"
#import "HENetTask.h"
#import "PopularRecommendObject.h"
#import "UserInfoManager.h"
@interface SearveSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation SearveSource

- (void)sendSeaverData:(ServerObject *)aObject{
    
    UserInfo *userInfo = [[UserInfoManager shareManager] getUserInfo];
    
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/newQuestion.action?content3=%@&content1=%ld&title=%@&content2=%@",userInfo.userName,(long)aObject.price,aObject.title ,aObject.desString];
//    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)strUrl, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));

    NSString * encodedString = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:encodedString];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onSearveSourceSuccess:)]) {
            [weakSelf.delegate onSearveSourceSuccess:[responseObject objectForKey:@"contenttext"]];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onSearveSourceError)]) {
            [self.delegate onSearveSourceError];
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
        object.imageUrl = [obj objectForKey:@"picUrl"];
        object.stype = [obj objectForKey:@"stype"];
        [array addObject:object];
    }];
    return array;
}
@end
