//
//  UIColor+MaxColor.m
//  HealthEdu
//
//  Created by NetEase on 16/10/28.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "UIColor+MaxColor.h"

@implementation UIColor (MaxColor)
+(UIColor *)mixColor1:(UIColor*)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio
{
    if(ratio > 1)
        ratio = 1;
    const CGFloat * components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat * components2 = CGColorGetComponents(color2.CGColor);
    
    NSLog(@"ratio = %f",ratio);
    CGFloat r = components1[0]*ratio + components2[0]*(1-ratio);
    CGFloat g = components1[1]*ratio + components2[1]*(1-ratio);
    CGFloat b = components1[2]*ratio + components2[2]*(1-ratio);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
@end
