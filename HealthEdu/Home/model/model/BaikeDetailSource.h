//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ConsultDetailSourceDelegate <NSObject>
- (void)onConsultDetailSourceSuccess:(ConsultDetailObject *)aObject;
- (void)onConsultDetailSourceError;
@end

@interface ConsultDetailSource : NSObject

@property (nonatomic, weak) id <ConsultDetailSourceDelegate>delegate;

- (void)getCousultDetailWithId:(NSString *)aId;


@end
