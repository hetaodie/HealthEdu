//
//  BaiKeSicknessContentView.h
//  HealthEdu
//
//  Created by weixu on 16/11/15.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaikeObject.h"

@protocol BaiKeSicknessContentViewDelegate <NSObject>

- (void)onSicknessContentOneElementSelectWithData:(BaikeObject *)aObject withIndex:(NSInteger)aIndex;

@end

@interface BaiKeSicknessContentView : UIView
@property (nonatomic,weak) id<BaiKeSicknessContentViewDelegate>delegate;

- (void)showViewWithArray:(NSArray *)aArray;

@end
