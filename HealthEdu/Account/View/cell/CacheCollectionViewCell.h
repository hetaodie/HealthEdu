//
//  LectureHailContentCollectionViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/16.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LectureHailContentObject.h"

@protocol CacheCollectionViewCellDelegate <NSObject>

- (void)onSelectVideoWithData:(LectureHailContentObject *)aObject andIsSelected:(BOOL)isSelected;

@end

@interface CacheCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak)id<CacheCollectionViewCellDelegate>delegate;

+ (CGSize)cellSizeWithData:(LectureHailContentObject *)aData;

- (void)showCellWithData:(LectureHailContentObject *)aData;

- (void)setCellEditStatus:(NSInteger)aStatus;
@end
