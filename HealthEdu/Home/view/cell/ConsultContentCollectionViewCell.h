//
//  ConsultContentCollectionViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConsultContentCollectionViewCellDelegate <NSObject>

- (void)clickOneElementOfCellWithInfo:(NSString *)aObject;

- (void)contentScrollOffSet:(CGPoint)offset;

@end

@interface ConsultContentCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<ConsultContentCollectionViewCellDelegate>delegate;

- (void)showCellWithData:(NSArray *)aArray;
@end
