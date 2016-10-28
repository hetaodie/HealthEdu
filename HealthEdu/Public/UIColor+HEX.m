//
//  UIColor+HTML.m
//  CoreTextExtensions
//
//  Created by Oliver Drobnik on 1/9/11.
//  Copyright 2011 Drobnik.com. All rights reserved.
//

#import "UIColor+HEX.h"
@implementation UIColor (HEX)
+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(float)alpha {
    CGFloat red = ((hex & 0x0FF0000)>>16)/255.0;
    CGFloat green = ((hex & 0x0FF00)>>8)/255.0;
    CGFloat blue = (hex & 0xFF)/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(float)aAlpha
{
    static NSDictionary *sHex2IntDict = nil;
    if(!sHex2IntDict){
        sHex2IntDict = @{@('0'):@(0),@('1'):@(1),@('2'):@(2),@('3'):@(3),@('4'):@(4),@('5'):@(5),@('6'):@(6),@('7'):@(7),@('8'):@(8),@('9'):@(9),@('A'):@(10),@('B'):@(11),@('C'):@(12),@('D'):@(13),@('E'):@(14),@('F'):@(15)} ;
    }
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	// String should be 6 or 8 characters
	if ([cString length] < 6) return [UIColor clearColor];
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	if ([cString length] != 6) return [UIColor clearColor];
    NSInteger colors[6]={0};
    const char *tempPtr = [cString cStringUsingEncoding:NSUTF8StringEncoding];
    for(NSInteger index = 0; index!=6;index++){
        colors[index]=[[sHex2IntDict objectForKey:@(tempPtr[index])] integerValue];
    }
    return [UIColor colorWithRed:((float) (colors[0]*16+colors[1]) / 255.0f)
                            green:((float) (colors[2]*16+colors[3]) / 255.0f)
                             blue:((float) (colors[4]*16+colors[5] )/ 255.0f)
                            alpha:aAlpha];
}
@end
