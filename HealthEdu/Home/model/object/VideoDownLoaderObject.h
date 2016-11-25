//
//  LCDownload.h
//  LCDownloadDemo
//
//  Created by LiuChang on 16-6-24.
//  Copyright (c) 2016年 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface VideoDownLoaderObject : NSObject
@property (nonatomic, strong) NSOutputStream *stream;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) long long allLength;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@end
