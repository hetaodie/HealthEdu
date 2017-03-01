//
//  LocationManager.m
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *lcManager;


@end

@implementation LocationManager

#pragma mark -
#pragma mark lifecycle


#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public


- (void)getLocationCity{
    
    if ([CLLocationManager locationServicesEnabled]) {
        // 创建位置管理者对象
        self.lcManager = [[CLLocationManager alloc] init];
        self.lcManager.delegate = self; // 设置代理
        // 设置定位距离过滤参数 (当本次定位和上次定位之间的距离大于或等于这个值时，调用代理方法)
        self.lcManager.distanceFilter = 100;
        self.lcManager.desiredAccuracy = kCLLocationAccuracyBest; // 设置定位精度(精度越高越耗电)
        [self.lcManager requestWhenInUseAuthorization];
        
        [self.lcManager startUpdatingLocation]; // 开始更新位置
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"权限" message:@"定位没有打开" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark -
#pragma mark delegate
/** 获取到新的位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"定位到了");
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 通过定位获取的经纬度坐标，反编码获取地理信息标记并打印改标记下得城市名
    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0){
            CLPlacemark *mark = [placemarks lastObject];
            NSString *cityName = mark.locality;
            if (!cityName) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                cityName = mark.administrativeArea;
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(onlocationCity:)]) {
                [self.delegate onlocationCity:cityName];
            }
        }
        else if (error == nil && [placemarks count] == 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"权限" message:@"查找城市失败" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if (error != nil)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"权限" message:@"查找城市失败" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];

        }
    }];
    
    [manager stopUpdatingLocation];
}
/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"获取定位失败");
}
/** 定位服务状态改变时调用*/
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"权限" message:@"访问受限" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];

            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"权限" message:@"定位服务开启，被拒绝" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alertView show];
            } else {
                NSLog(@"定位服务关闭，不可用");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"权限" message:@"定位服务关闭，不可用" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alertView show];
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private


@end
