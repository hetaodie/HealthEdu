//
//  MapViewController.m
//  MapDemo
//
//  Created by Weixu on 16/8/16.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KCAnnotation.h"

#define LAT_OFFSET_0(x,y) -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x))
#define LAT_OFFSET_1 (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0
#define LAT_OFFSET_2 (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0
#define LAT_OFFSET_3 (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0

#define LON_OFFSET_0(x,y) 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x))
#define LON_OFFSET_1 (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0
#define LON_OFFSET_2 (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0
#define LON_OFFSET_3 (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0

#define RANGE_LON_MAX 137.8347
#define RANGE_LON_MIN 72.004
#define RANGE_LAT_MAX 55.8271
#define RANGE_LAT_MIN 0.8293

#define jzA 6378245.0
#define jzEE 0.00669342162296594323

const double a = 6378245.0;
const double ee = 0.00669342162296594323;
const double pi = 3.14159265358979324;

const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;


@interface MapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, assign) CLLocationCoordinate2D fromCoordinate;

@property (nonatomic, assign) CLLocationCoordinate2D toCoordinate;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithLocationManager];
    [self initWithMapView];
    
    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(self.longitude,self.latitude);
//    location = [self transformFromWGSToGCJ:location];
//    location = [self bd_decrypt:location];
    
    location = [self bd09ToGcj02:location];
    KCAnnotation *annotation=[[KCAnnotation alloc]init];
    annotation.title=@"定位";
    annotation.subtitle=@"测试";
    annotation.coordinate=location;
    
    [_mapView addAnnotation:annotation];
    //放大到标注的位置
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 1000, 1000);
    [self.mapView setRegion:region animated:YES];
}

- (void)doBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithLocationManager
{
    //初始化定位服务管理对象
    _locationManager = [[CLLocationManager alloc] init];
    
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    //设置精确度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置设备移动后获取位置信息的最小距离。单位为米
    self.locationManager.distanceFilter = 10.0f;
}


- (void)initWithMapView
{
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    //设置代理
    _mapView.delegate = self;
    //开启自动定位
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:(MKUserTrackingModeFollow) animated:YES];
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

- (void)addLocationToMap:(CGFloat)latitude longitude:(CGFloat)longitude title:(NSString *)title dizhi:(NSString *)dizhi{
    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(120.0707, 30.16);
    KCAnnotation *annotation=[[KCAnnotation alloc]init];
    annotation.title=title;
    annotation.subtitle=dizhi;
    annotation.coordinate=location;

    [_mapView addAnnotation:annotation];
    
    self.toCoordinate = location;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //开始定位
    //[self.locationManager startUpdatingLocation];

}

- (void)viewWillDisappear:(BOOL)animated
{
    _mapView.delegate = nil;
    self.locationManager.delegate = nil;

    //停止定位
   // [self.locationManager stopUpdatingLocation];
}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation{
//    self.fromCoordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    _mapView.centerCoordinate = userLocation.location.coordinate;
//    
//    CLLocation *locNow = [[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
//    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
//    
//    [geocoder reverseGeocodeLocation:locNow completionHandler:^(NSArray *placemarks,NSError *error)
//     {
////         CLPlacemark *placemark=[placemarks objectAtIndex:0];
//         CLLocationCoordinate2D coordinate;
//         coordinate.latitude = userLocation.location.coordinate.latitude;
//         coordinate.longitude = userLocation.location.coordinate.longitude;
////         KCAnnotation *annotation = [[KCAnnotation alloc] init];
////         //设置中心
////         annotation.coordinate = coordinate;
////         //触发viewForAnnotation
////         
//         //设置显示范围
//         MKCoordinateRegion region;
//         region.span.latitudeDelta = 0.011111;
//         region.span.longitudeDelta = 0.011111;
//         region.center = coordinate;
//         // 设置显示位置(动画)
//         [_mapView setRegion:region animated:YES];
////         // 设置地图显示的类型及根据范围进行显示
////         [_mapView regionThatFits:region];
////         _mapView.showsUserLocation = NO;
////         annotation.title = @"我的位置";
////         annotation.subtitle = [NSString stringWithFormat:@"%@, %@, %@",placemark.locality,placemark.administrativeArea,placemark.thoroughfare];
////         annotation.coordinate = placemark.location.coordinate;
////         [_mapView addAnnotation:annotation];
//     }];
//    
//    [self lineDrawing:nil];
//}

- (IBAction)lineDrawing:(id)sender {
    
    MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.fromCoordinate addressDictionary:nil];
    MKPlacemark *toPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.toCoordinate addressDictionary:nil];
    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
    MKMapItem *toItem = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = fromItem;
    request.destination = toItem;
    request.requestsAlternateRoutes = YES;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             NSLog(@"error:%@", error);
         }
         else {
             MKRoute *route = response.routes[0];
             [self.mapView addOverlay:route.polyline];
         }
     }];
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer;
    renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.lineWidth = 1.0;
    renderer.strokeColor = [UIColor purpleColor];
    
    return renderer;
}

//在地图视图添加标注时回调
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(KCAnnotation *)annotation
{
    MKPinAnnotationView *ann = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    if (ann == nil) {
        ann = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ID"];
    }
    ann.pinColor = MKPinAnnotationColorPurple;
    ann.animatesDrop = YES;
    ann.canShowCallout = YES;
    
    return ann;
}

-(CLLocationCoordinate2D) bd_decrypt:(CLLocationCoordinate2D) bdLoc
{
    CLLocationCoordinate2D adjustLoc;

    double x = bdLoc.longitude - 0.0065, y = bdLoc.latitude - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    adjustLoc.longitude =z * cos(theta);
    adjustLoc.latitude = z * sin(theta);
    return adjustLoc;
}

-(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc
{
    CLLocationCoordinate2D adjustLoc;

    double adjustLat = [self transformLatWithX:((double)wgsLoc.longitude - 105.0) withY:((double)wgsLoc.latitude - 35.0)];
    double adjustLon = [self transformLonWithX:((double)wgsLoc.longitude - 105.0) withY:((double)wgsLoc.latitude - 35.0)];
    double radLat = wgsLoc.latitude / 180.0 * pi;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
    adjustLoc.latitude = wgsLoc.latitude + adjustLat*2;
    adjustLoc.longitude = wgsLoc.longitude - adjustLon*2.4;

    return adjustLoc;
}

- (double)transformLatWithX:(double)x withY:(double)y
{
    double lat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(abs(x));
    lat += (20.0 * sin(6.0 * x * pi) + 20.0 *sin(2.0 * x * pi)) * 2.0 / 3.0;
    lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    lat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return lat;
}

- (double)transformLonWithX:(double)x withY:(double)y
{
    double lon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(abs(x));
    lon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    lon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    lon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return lon;
}



- (CLLocationCoordinate2D)gcj02ToWgs84:(CLLocationCoordinate2D)location
{
    return [self gcj02Decrypt:location.latitude gjLon:location.longitude];
}

- (CLLocationCoordinate2D)gcj02Decrypt:(double)gjLat gjLon:(double)gjLon {
    CLLocationCoordinate2D  gPt = [self gcj02Encrypt:gjLat bdLon:gjLon];
    double dLon = gPt.longitude - gjLon;
    double dLat = gPt.latitude - gjLat;
    CLLocationCoordinate2D pt;
    pt.latitude = gjLat - dLat;
    pt.longitude = gjLon - dLon;
    return pt;
}

- (CLLocationCoordinate2D)gcj02Encrypt:(double)ggLat bdLon:(double)ggLon
{
    CLLocationCoordinate2D resPoint;
    double mgLat;
    double mgLon;

    double dLat = [self transformLat:(ggLon - 105.0) bdLon:(ggLat - 35.0)];
    double dLon = [self transformLon:(ggLon - 105.0) bdLon:(ggLat - 35.0)];
    double radLat = ggLat / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - jzEE * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((jzA * (1 - jzEE)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (jzA / sqrtMagic * cos(radLat) * M_PI);
    mgLat = ggLat + dLat;
    mgLon = ggLon + dLon;
    
    resPoint.latitude = mgLat;
    resPoint.longitude = mgLon;
    return resPoint;
}

- (double)transformLat:(double)x bdLon:(double)y
{
    double ret = LAT_OFFSET_0(x, y);
    ret += LAT_OFFSET_1;
    ret += LAT_OFFSET_2;
    ret += LAT_OFFSET_3;
    return ret;
}

- (double)transformLon:(double)x bdLon:(double)y
{
    double ret = LON_OFFSET_0(x, y);
    ret += LON_OFFSET_1;
    ret += LON_OFFSET_2;
    ret += LON_OFFSET_3;
    return ret;
}


- (CLLocationCoordinate2D)bd09ToWgs84:(CLLocationCoordinate2D)location
{
    CLLocationCoordinate2D gcj02 = [self bd09ToGcj02:location];
    return [self gcj02Decrypt:gcj02.latitude gjLon:gcj02.longitude];
}

- (CLLocationCoordinate2D)bd09ToGcj02:(CLLocationCoordinate2D)location
{
    return [self bd09Decrypt:location.latitude bdLon:location.longitude];
}

- (CLLocationCoordinate2D)bd09Decrypt:(double)bdLat bdLon:(double)bdLon
{
    CLLocationCoordinate2D gcjPt;
    double x = bdLon - 0.0065, y = bdLat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * M_PI);
    double theta = atan2(y, x) - 0.000003 * cos(x * M_PI);
    gcjPt.longitude = z * cos(theta);
    gcjPt.latitude = z * sin(theta);
    return gcjPt;
}


@end
