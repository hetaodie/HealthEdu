//
//  LectureHailContentCollectionViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/16.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LectureHailContentObject.h"

@interface LectureHailContentElementCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSizeWithData:(LectureHailContentObject *)aData;

- (void)showCellWithData:(LectureHailContentObject *)aData;

@end
