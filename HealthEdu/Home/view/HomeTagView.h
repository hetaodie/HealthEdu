//
//  HomeTagView.h
//  HealthEdu
//
//  Created by xu.wei on 16/10/17.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeTagViewDelegate <NSObject>

- (void)onSelectBtnWithTag:(int)aTag;

@end

@interface HomeTagView : UIView

@end