//
//  TopTabScrollViewCell.m
//  HealthEdu
//
//  Created by NetEase on 16/10/26.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "TopTabScrollViewCell.h"


@implementation TopTabScrollViewCell


#pragma mark -
#pragma mark life cycle

+ (TopTabScrollViewCell *)viewFromXib{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TopTabScrollViewCell" owner:nil options:nil];
    TopTabScrollViewCell *cell = [views firstObject];
    return cell;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}


#pragma mark -
#pragma mark delegate

#pragma mark -
#pragma mark Notification Function

#pragma mark -
#pragma mark public Function

#pragma mark -
#pragma mark btn Function

#pragma mark -
#pragma mark private Function

- (void)setSelected:(BOOL)selected{
    if (selected) {
//        self.backgroundColor = []
    }
}
@end
