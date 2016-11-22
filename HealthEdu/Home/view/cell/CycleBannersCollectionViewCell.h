//
//  CycleBannersCollectionViewCell.h
//  CircleBannersDemo
//
//  Created by Weixu on 16/6/1.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleBannersCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *tuiguangLogoLabel;

/**
 *  通过给定的url来显示image
 *
 *  @param imageStrUrl 显示image的url
 */
- (void)showImageContentFromNStringUrl:(NSString *)imageStrUrl;

@end
