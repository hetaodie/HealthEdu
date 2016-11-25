//
//  VideoHistoryManager.h
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LectureHailContentObject.h"

@interface VideoHistoryManager : NSObject

+ (instancetype)sharedInstance;

- (void)addVideoToHistory:(LectureHailContentObject *)aObject;

- (NSArray *)getAllVideoHistory;

- (void)removeVideoFromHistory:(LectureHailContentObject *)aObject;

@end
