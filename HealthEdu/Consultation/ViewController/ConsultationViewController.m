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

@interface ConsultationViewController ()<UITableViewDelegate,UITableViewDataSource,CitysViewDelegate,SelectCityViewDelegate>
@property (weak, nonatomic) IBOutlet SelectCityView *selectCityView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet CitysView *cityView;
@property (nonatomic, strong) NSMutableArray *citysArray;

@end

@implementation ConsultationViewController

#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.citysArray= [[NSMutableArray alloc] init];
    [self testData];
    
    [self setUpTableView];
    
    self.cityView.delegate = self;
    self.selectCityView.delegate = self;
    
    [self.cityView showViewWithArray:self.citysArray];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [ConsultationContentTableViewCell cellHeightWithData:nil];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsultationContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsultationContentTableViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)onSelectOneElementWithData:(NSString *)aString withIndex:(NSInteger)aIndex{
    [self.selectCityView setSelectCityName:aString];
    [self.cityView setHidden:YES];
}

- (void)onSelectCity:(BOOL)isUnfold{
    if (isUnfold) {
        self.cityView.hidden = NO;
    }
    else{
        self.cityView.hidden = YES;
    }
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
