//
//  ConsultViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultViewController.h"
#import "TopTabScrollView.h"

@interface ConsultViewController () <TopTabScrollViewDelegate>
@property (weak, nonatomic) IBOutlet TopTabScrollView *topTabScrollView;
@property (nonatomic, strong) NSMutableArray *topArray;

@end

@implementation ConsultViewController

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topArray = [[NSMutableArray alloc] init];
    NSArray *tmpArray = [NSArray arrayWithObjects:@"推荐",@"热点",@"前沿",@"时评",@"政策",@"提醒", @"推荐",@"热点",@"前沿",@"时评",@"政策",@"提醒", nil];
    [self.topArray setArray:tmpArray];
    
    self.topTabScrollView.cellSpacing = 5;
    self.topTabScrollView.delegate = self;
    
    [self.topTabScrollView reloadData];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.topTabScrollView reloadData];
    [self.topTabScrollView selectRow:1 animated:YES scrollPosition:TopTabScrollViewScrollPositionMiddle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark delegate

#pragma mark -
#pragma mark TopTabScrollViewDelegate

- (NSInteger)numberOfRowInTopTabScrollView:(TopTabScrollView *)topTabScrollView{
    NSInteger cont = [self.topArray count];
    return cont;
}

- (CGFloat)topTabScrollView:(TopTabScrollView *)topTabScrollView widthForItemAtRow:(NSInteger)row{
    NSString *content = [self.topArray objectAtIndex:row];
    CGFloat width = [TopTabScrollViewCell cellWidthWithString:content];
    return width;
}

- (TopTabScrollViewCell *)topTabScrollView:(TopTabScrollView *)topTabScrollView cellForItemAtRow:(NSInteger)row{
    TopTabScrollViewCell *cell = [TopTabScrollViewCell viewFromXib];
    
    NSString *content = [self.topArray objectAtIndex:row];
    cell.titleLabel.text = content;
    return cell;
}

#pragma mark -
#pragma mark Notification Function

#pragma mark -
#pragma mark public Function

#pragma mark -
#pragma mark btn Function

#pragma mark -
#pragma mark private Function



@end
