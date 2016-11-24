//
//  NSString+MD5.m
//  TestAFNetWorking
//
//  Created by hzzhanyawei on 16/8/11.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)
- (NSString *)MD5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }

    return [result lowercaseString];
}

+ (NSString*)get_pwd:(NSString*)tmpIn
{
    
    int i, dataLen;
    unsigned char value;
    const char *data = [tmpIn cStringUsingEncoding:NSASCIIStringEncoding];
    char out[1024] = {0};
    
    dataLen = (int)strlen(data);
    if(dataLen > 32)
        dataLen = 32;
    
    for(i=0; i < dataLen; i++)
    {
        value = data[i];
        if((value > 0x60) && (value < 0x7B))
        {
            value = value - 0x20;
            value = 0x5A - value + 0x41;
        }
        else if((value > 0x40) && (value < 0x5B))
        {
            value = value + 0x20;
            value = 0x7A - value + 0x61;
        }
        else if((value >= 0x30) && (value <= 0x34))
        {
            value = value + 0x05;
        }
        else if((value >= 0x35) && (value <= 0x39))
        {
            value = value - 0x05;
        }
        out[i] = value;
    }
    
    out[i] = '\0';
    NSString *outData = [[NSString alloc] initWithCString:(const char*)out encoding:NSASCIIStringEncoding];
    return outData;
}

@end
