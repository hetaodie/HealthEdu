//
//  LectureHailContentCollectionViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/22.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LectureHailContentObject.h"


@protocol LectureHailContentCollectionViewCellDelegate <NSObject>

- (void)clickOneElementOfCellWithInfo:(LectureHailContentObject *)aObject withIndex:(NSInteger)aIndex;

@end

@interface LectureHailContentCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign) id<LectureHailContentCollectionViewCellDelegate>delegate;
@end
