//
//  DocorRequestSource.h
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DocorRequestSourceDelegate <NSObject>

- (void)onDoctorRequestSuess:(NSArray *)aArray;

@end

@interface DocorRequestSource : NSObject
@property (nonatomic, weak) id <DocorRequestSourceDelegate>delegate;
- (void)getDoctorRequest:(NSString *)aUsername;

@end
