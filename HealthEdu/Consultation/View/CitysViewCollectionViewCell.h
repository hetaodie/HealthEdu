//
//  CitysViewCollectionViewCell
//  HealthEdu
//
//  Created by weixu on 16/11/15.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitysViewCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSizeForString:(NSString *)aString;

- (void)showCellWithTitle:(NSString *)aTitle;

@end
