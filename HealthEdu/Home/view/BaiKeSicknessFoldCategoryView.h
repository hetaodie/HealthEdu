//
//  BaiKeSicknessCategoryView.h
//  HealthEdu
//
//  Created by weixu on 16/11/15.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiKeClassifyObject.h"

@protocol BaiKeSicknessFoldCategoryViewDelegate <NSObject>

- (void)onSelectUnfold;

- (void)onSelectOneElementWithData:(BaiKeClassifyObject *)aObject withIndex:(NSInteger)aIndex;

@end
@interface BaiKeSicknessFoldCategoryView : UIView
@property (nonatomic, weak) id<BaiKeSicknessFoldCategoryViewDelegate>delegate;

- (void)showFoldCategoryViewWithArray:(NSArray *)aArray;
@end
