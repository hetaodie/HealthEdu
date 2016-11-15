//
//  ConsultContentCollectionViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultContentObject.h"

@protocol ConsultContentCollectionViewCellDelegate <NSObject>

- (void)clickOneElementOfCellWithInfo:(ConsultContentObject *)aObject withIndex:(NSInteger)aIndex;

- (void)contentScrollOffSet:(CGPoint)offset;

@end

@interface ConsultContentCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<ConsultContentCollectionViewCellDelegate>delegate;

- (void)showCellWithData:(NSArray *)aArray;
@end
