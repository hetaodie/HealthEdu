//
//  LectureHailContentObject.m
//  HealthEdu
//
//  Created by weixu on 16/11/22.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "LectureHailContentObject.h"

@implementation LectureHailContentObject

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.videoUrl = [coder decodeObjectForKey:@"videoUrl"];
        self.title = [coder decodeObjectForKey:@"title"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.videoUrl forKey:@"videoUrl"];
    [coder encodeObject:self.title forKey:@"title"];
}
@end
