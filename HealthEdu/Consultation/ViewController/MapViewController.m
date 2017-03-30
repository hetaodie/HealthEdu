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

@end
