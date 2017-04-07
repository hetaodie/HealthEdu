//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LectureHailSourceDelegate <NSObject>
- (void)onLectureHailClassifySuccess:(NSArray *)aArray;
- (void)onLectureHailClassifyError;

- (void)onLectureHailDataSuccess:(NSArray *)aArray;
- (void)onLectureHailDataError;

- (void)onGetLectureHailTuijianSuccess:(NSArray *)aArray;
- (void)ongetLectureHailTuijianError;
@end

@interface LectureHailSource : NSObject

@property (nonatomic, weak) id <LectureHailSourceDelegate>delegate;

- (void)getLectureHailClassify;

- (void)getLectureHailTuijian;


- (void)getLectureHailData:(NSString *)aId;
@end
