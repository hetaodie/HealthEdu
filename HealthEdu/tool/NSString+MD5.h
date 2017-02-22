//
//  NSString+MD5.h
//  TestAFNetWorking
//
//  Created by hzzhanyawei on 16/8/11.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
- (NSString *)MD5;

+(NSString*)get_pwd:(NSString*)tmpIn;
@end
