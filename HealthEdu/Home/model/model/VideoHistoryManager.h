//
//  VideoHistoryManager.h
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LectureHailObject.h"

@interface VideoHistoryManager : NSObject

+ (instancetype)sharedInstance;

- (void)addVideoToHistory:(LectureHailObject *)aObject;

- (NSArray *)getAllVideoHistory;

- (void)removeVideoFromHistory:(LectureHailObject *)aObject;

@end
