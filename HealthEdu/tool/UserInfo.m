//
//  UserInfo.m
//  HealthExpo
//
//  Created by zhanyawei on 16/6/26.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.userName = [coder decodeObjectForKey:@"userName"];
        self.pwd = [coder decodeObjectForKey:@"pwd"];
        self.name = [coder decodeObjectForKey:@"name"];

        self.sex = [coder decodeObjectForKey:@"sex"];
        self.company = [coder decodeObjectForKey:@"company"];
        self.title = [coder decodeObjectForKey:@"title"];

        self.email = [coder decodeObjectForKey:@"email"];
        self.picurl = [coder decodeObjectForKey:@"picurl"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    
    [aCoder encodeObject:self.company forKey:@"company"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.picurl forKey:@"picurl"];
}
@end
