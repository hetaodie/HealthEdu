//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SpeakerMessageItem;
@protocol ConsultListSourceDelegate <NSObject>
- (void)onConsultListSourceSuccess:(NSArray *)aArray;
- (void)onConsultListSourceError;

- (void)onConsultClassicySourceSuccess:(NSArray *)aArray;
- (void)onConsultClassicySourceError;
@end

@interface ConsultListSource : NSObject

@property (nonatomic, weak) id <ConsultListSourceDelegate>delegate;

- (void)getConsultClassicySource:(NSInteger)num;
- (void)getConsultListSource:(NSString *)aId;

@end
