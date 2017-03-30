//
//  ConsultationViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/9/27.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultationViewController.h"
#import "SelectCityView.h"
#import "ConsultationContentTableViewCell.h"
#import "CitysView.h"
#import "LocationManager.h"
#import "ConsultationObject.h"
#import "ConsultationSource.h"
#import "MapViewController.h"

@interface ConsultationViewController ()<UITableViewDelegate,UITableViewDataSource,CitysViewDelegate,SelectCityViewDelegate,LocationManagerDelegate,ConsultationSourceDelegate>
@property (weak, nonatomic) IBOutlet SelectCityView *selectCityView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet CitysView *cityView;
@property (nonatomic, strong) NSMutableArray *citysArray;
@property (nonatomic, strong) LocationManager *locationManager;

@property (nonatomic, strong) ConsultationSource *consultationSource;
@property (nonatomic, strong) ConsultationObject *consultationObject;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation ConsultationViewController

#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.citysArray= [[NSMutableArray alloc] init];
   // [self testData];
    
    [self setUpTableView];
    
    self.cityView.delegate = self;
    self.selectCityView.delegate = self;
    
    //[self.cityView showViewWithArray:self.citysArray];
    self.locationManager = [[LocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager getLocationCity];
    
    self.consultationSource = [[ConsultationSource alloc] init];
    self.consultationSource.delegate = self;
    
    [self.consultationSource getConsultation];
    
    self.listArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate

- (void)onlocationCity:(NSString *)aCityName{
    [self.selectCityView setLocCityName:aCityName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
    NSInteger count = [self.listArray count];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [ConsultationContentTableViewCell cellHeightWithData:nil];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsultationContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsultationContentTableViewCell" forIndexPath:indexPath];
    ConsultationListObject *object = [self.listArray objectAtIndex:indexPath.row];
    [cell showCellWithObject:object];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ConsultationListObject *object = [self.listArray objectAtIndex:indexPath.row];
    MapViewController *jkdeVC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    jkdeVC.hidesBottomBarWhenPushed = YES;
    jkdeVC.latitude = [object.latitude floatValue];
    jkdeVC.longitude = [object.longitude floatValue];
    [self.navigationController pushViewController:jkdeVC animated:YES];
}

- (void)onSelectOneElementWithData:(ConsultationObject *)aObject withIndex:(NSInteger)aIndex{
    [self.selectCityView setSelectCityName:aObject.title];
    [self.cityView setHidden:YES];
    
    [self.consultationSource getConsultationDetail:aObject.id];
}

- (void)onSelectCity:(BOOL)isUnfold{
    if (isUnfold) {
        self.cityView.hidden = NO;
    }
    else{
        self.cityView.hidden = YES;
    }
 
}

- (void)onConsultationSuccess:(NSArray *)aArray{
    [self.citysArray setArray:aArray];
    [self.cityView showViewWithArray:self.citysArray];
    
    if ([aArray count] >0) {
        ConsultationObject *object = [self.citysArray objectAtIndex:0];
        [self.consultationSource getConsultationDetail:object.id];
    }
    
}

- (void)onConsultationError{

}

- (void)onConsultationDetailSuccess:(NSArray *)aArray {
    [self.listArray setArray:aArray];
    [self.tableView reloadData];
}

- (void)onConsultationDetailError {

}

#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private


- (void)setUpTableView{
    UINib *nib = [UINib nibWithNibName:@"ConsultationContentTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ConsultationContentTableViewCell"];
}

- (void)testData{
    NSArray *array = [NSArray arrayWithObjects:@"杭州市",@"郑州市",@"富阳市",@"杭州市",@"郑州市",@"富阳市",@"杭州市",@"郑州市",@"富阳市",@"杭州市",@"郑州市",@"富阳市",@"杭州市",@"郑州市",@"富阳市",@"杭州市",@"郑州市",@"富阳市",@"杭州市",@"郑州市",@"富阳市", nil];
    [self.citysArray setArray:array];
    
}
@end
