//
//  LocationManager.h
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LocationManagerDelegate <NSObject>

- (void)onlocationCity:(NSString *)aCityName;

@end

@interface LocationManager : NSObject
@property (nonatomic, weak) id<LocationManagerDelegate>delegate;

- (void)getLocationCity;
@end
