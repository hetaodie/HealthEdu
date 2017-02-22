//
//  LectureHailContentCollectionViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/16.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LectureHailObject.h"

@interface LectureHailContentElementCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSizeWithData:(LectureHailObject *)aData;

- (void)showCellWithData:(LectureHailObject *)aData;

@end
