//
//  LectureHailObject.m
//  HealthEdu
//
//  Created by weixu on 2017/2/22.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "LectureHailObject.h"

@implementation LectureHailObject


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.id = [coder decodeObjectForKey:@"id"];
        self.picurl = [coder decodeObjectForKey:@"picurl"];
        
        self.content1 = [coder decodeObjectForKey:@"content1"];
        self.content2 = [coder decodeObjectForKey:@"content2"];
        
        self.exturl = [coder decodeObjectForKey:@"exturl"];
        self.title = [coder decodeObjectForKey:@"title"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.id forKey:@"id"];
    [coder encodeObject:self.picurl forKey:@"picurl"];
    
    [coder encodeObject:self.content1 forKey:@"content1"];
    [coder encodeObject:self.content2 forKey:@"content2"];
    
    [coder encodeObject:self.exturl forKey:@"exturl"];
    [coder encodeObject:self.title forKey:@"title"];
}

@end
