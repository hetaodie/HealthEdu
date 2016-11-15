//
//  BaiKeSicknessCategoryView.h
//  HealthEdu
//
//  Created by weixu on 16/11/15.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BaiKeSicknessUnfoldCategoryViewDelegate <NSObject>

- (void)onUnfoldCategoryOneElementSelectWithData:(NSString *)aData withIndex:(NSInteger)aIndex;

@end
@interface BaiKeSicknessUnfoldCategoryView : UIView
@property (nonatomic, weak) id<BaiKeSicknessUnfoldCategoryViewDelegate>delegate;

- (void)showUnfoldCategoryViewWithArray:(NSArray *)aArray;
@end
