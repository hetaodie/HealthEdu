//
//  HENetTask.m
//  TestAFNetWorking
//
//  Created by hzzhanyawei on 16/7/2.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import "HENetTask.h"
#import "AFNetworking.h"

//static const NSString *HEHttpServer = @"http://202.75.210.186/";//@"http://121.40.79.118/jkbl/";

@implementation HENetTask

- (instancetype)init{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for the HENetTask, plase use initWithUrlString:"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initWithUrlString:(NSString *)aPath{
    self = [super init];
    if (self) {
        _urlString = [NSString stringWithFormat:@"%@%@", HEHttpServer, aPath];
    }
    return self;
}

- (instancetype)initWithTotalUrlString:(NSString *)aUrl{
    self = [super init];
    if (self) {
        self.urlString = aUrl;
    }
    return self;
}

- (void)runInMethod:(HEHttpMethod)method{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html",@"text",@"text/plain",]];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURL *url = [NSURL URLWithString:self.urlString];


    switch (method) {
        case HE_GET:
            [manager GET:url.absoluteString parameters:nil progress:nil success:self.successBlock failure:self.failedBlock];
            break;            
        case HE_POST:
            [manager POST:url.absoluteString parameters:nil progress:nil success:self.successBlock failure:self.failedBlock];
            break;
        case HE_PUT:
            [manager PUT:url.absoluteString parameters:nil success:self.successBlock failure:self.failedBlock];
            break;
        case HE_DELETE:
            [manager DELETE:url.absoluteString parameters:nil success:self.successBlock failure:self.failedBlock];
            break;
    }
}

- (void)dealloc{
    self.successBlock = nil;
    self.failedBlock  = nil;
}
@end
