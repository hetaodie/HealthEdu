//
//  UILabel+Calculate.m
//  PRIS_iPhone
//
//  Created by Weixu on 16/6/16.
//
//

#import "UILabel+Calculate.h"

@implementation UILabel (Calculate)


- (CGFloat)calculateHeightOfMaxNum:(NSInteger)aNum{
    
    CGFloat rate = self.font.lineHeight; //每一行需要的高度
    CGFloat width = self.frame.size.width;
    
    NSDictionary *dict = @{NSFontAttributeName:self.font};
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    if (rect.size.height > rate * aNum) {
        return rate * aNum;
    }
    else {
        return rect.size.height;
    }
}

- (CGFloat)calculateAttributeHeightOfMaxNum:(NSInteger)aNum{
     CGFloat oneRowHeight = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].height;
    CGFloat width = self.frame.size.width;
    
    NSDictionary *dict = @{NSFontAttributeName:self.font};
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    //计算出真实大小
    NSInteger rows = rect.size.height / oneRowHeight;
    if (rows >  aNum && aNum !=0) {
        rows = aNum;
    }
     CGFloat realHeight = (rows * oneRowHeight) + (rows - 1) * 8 * oneRowHeight;
    return realHeight;
}

@end
