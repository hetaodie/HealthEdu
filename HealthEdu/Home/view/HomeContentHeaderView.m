//
//  HomeContentHeaderView.m
//  HealthEdu
//
//  Created by xu.wei on 16/10/17.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "HomeContentHeaderView.h"

@implementation HomeContentHeaderView

+ (id)viewWithXib{
    NSString *className = NSStringFromClass([self class]);
    HomeContentHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
    return view;
}

@end
