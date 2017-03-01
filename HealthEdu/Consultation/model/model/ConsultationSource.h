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
@protocol ConsultationSourceDelegate <NSObject>
- (void)onConsultationSuccess:(NSArray *)aArray;
- (void)onConsultationError;

- (void)onConsultationDetailSuccess:(NSArray *)aArray;
- (void)onConsultationDetailError;

@end

@interface ConsultationSource : NSObject

@property (nonatomic, weak) id <ConsultationSourceDelegate>delegate;

- (void)getConsultation;

- (void)getConsultationDetail:(NSString *)aId;
@end
