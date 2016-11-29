//
//  CacheManager.h
//  HealthEdu
//
//  Created by weixu on 16/11/29.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject
+(double)fileSizeAtPath:(NSString *)path;

+(double)folderSizeAtPath:(NSString *)path;

+(void)clearCache:(NSString *)path;
@end
