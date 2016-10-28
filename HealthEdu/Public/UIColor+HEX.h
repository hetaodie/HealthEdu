//
//  UIColor+HTML.h
//  CoreTextExtensions
//
//  Created by Oliver Drobnik on 1/9/11.
//  Copyright 2011 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(float)alpha;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(float)aAlpha;

@end


#define RGB(r,g,b) RGBA((r),(g),(b),1)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEX_ALPHA(hex, a) [UIColor colorWithHex:(hex) alpha:(a)]
#define HEX(hex) [UIColor colorWithHex:(hex) alpha:(1)]