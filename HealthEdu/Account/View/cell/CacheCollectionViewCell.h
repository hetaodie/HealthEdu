//
//  LectureHailContentCollectionViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/16.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LectureHailObject.h"

@protocol CacheCollectionViewCellDelegate <NSObject>

- (void)onSelectVideoWithData:(LectureHailObject *)aObject andIsSelected:(BOOL)isSelected;

@end

@interface CacheCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak)id<CacheCollectionViewCellDelegate>delegate;

+ (CGSize)cellSizeWithData:(LectureHailObject *)aData;

- (void)showCellWithData:(LectureHailObject *)aData;

- (void)setCellEditStatus:(NSInteger)aStatus;
@end
