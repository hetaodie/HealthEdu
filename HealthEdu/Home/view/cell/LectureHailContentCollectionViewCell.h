//
//  LectureHailContentCollectionViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/22.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LectureHailObject.h"
#import "LectureHailObject.h"


@protocol LectureHailContentCollectionViewCellDelegate <NSObject>

- (void)clickOneElementOfCellWithInfo:(LectureHailObject *)aObject withIndex:(NSInteger)aIndex;

@end

@interface LectureHailContentCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<LectureHailContentCollectionViewCellDelegate>delegate;

- (void)showCellWithArray:(NSArray *)aArray;
@end
