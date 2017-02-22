//
//  ConsultViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultViewController.h"
#import "TopTabScrollView.h"
#import "ConsultContentView.h"
#import "ConsultDetailViewController.h"
#import "ConsultListSource.h"
#import "ConsultListObject.h"
#import "ConsultClassifyObject.h"

@interface ConsultViewController () <TopTabScrollViewDelegate,ConsultContentViewDelegate,ConsultListSourceDelegate>
@property (weak, nonatomic) IBOutlet TopTabScrollView *topTabScrollView;
@property (nonatomic, strong) NSMutableArray *topArray;
@property (weak, nonatomic) IBOutlet ConsultContentView *consultContentView;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) ConsultListSource *listSource;
@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation ConsultViewController

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"健康资讯";

    [self setUpData];
    [self setUpTopTab];
    
    self.listSource = [[ConsultListSource alloc] init];
    self.listSource.delegate = self;
    [self.listSource getConsultClassicySource];
    
//    NSArray *tmpArray = [NSArray arrayWithObjects:@"推荐",@"热点",@"前沿",@"时评",@"政策",@"提醒", @"推荐",@"热点",@"前沿",@"时评",@"政策",@"提醒", nil];
//    [self.topArray setArray:tmpArray];
//    [self.topTabScrollView reloadData];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.consultContentView.delegate = self;
    
    //[self testData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    [self.topTabScrollView reloadData];
//    [self.topTabScrollView selectRow:0 animated:YES scrollPosition:TopTabScrollViewScrollPositionMiddle];
//    [self.consultContentView selectContentWithIndex:1];
    
    [self.consultContentView layoutIfNeeded];
    [self.consultContentView setNeedsLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark delegate

#pragma mark -
#pragma mark TopTabScrollViewDelegate

- (void)onConsultClassicySourceSuccess:(NSArray *)aArray{
    [self.topArray setArray:aArray];
    [self testData];
    
    [self.topTabScrollView reloadData];
    self.selectIndex = 0;
    [self.topTabScrollView selectRow:0 animated:YES scrollPosition:TopTabScrollViewScrollPositionNone];
    [self.consultContentView selectContentWithIndex:0];
}

- (void)onConsultClassicySourceError{

}

- (void)onConsultListSourceSuccess:(NSArray *)aArray{
    [self.contentArray replaceObjectAtIndex:self.selectIndex withObject:aArray];
    [self.consultContentView showConsultContentViewWithData:self.contentArray];
}

- (void)onConsultListSourceError{
    
}

- (NSInteger)numberOfRowInTopTabScrollView:(TopTabScrollView *)topTabScrollView{
    NSInteger cont = [self.topArray count];
    return cont;
}

- (CGFloat)topTabScrollView:(TopTabScrollView *)topTabScrollView widthForItemAtRow:(NSInteger)row{
    ConsultClassifyObject *object = [self.topArray objectAtIndex:row];
    
    
    CGFloat width = [TopTabScrollViewCell cellWidthWithString:object.title];
    return width;
}

- (TopTabScrollViewCell *)topTabScrollView:(TopTabScrollView *)topTabScrollView cellForItemAtRow:(NSInteger)row{
    TopTabScrollViewCell *cell = [TopTabScrollViewCell viewFromXib];
    
    ConsultClassifyObject *object = [self.topArray objectAtIndex:row];
    cell.titleLabel.text = object.title;
    return cell;
}

- (void)topTabScrollView:(TopTabScrollView *)topTabScrollView didSelectRow:(NSInteger )row{
    self.selectIndex = row;
    [self.consultContentView selectContentWithIndex:row];
    ConsultClassifyObject *object = [self.topArray objectAtIndex:row];
    [self.listSource getConsultListSource:object.id];
}

- (void)contentOneContentCellWithSelect:(ConsultListObject *)aObject withIndex:(NSInteger)aIndex{
    ConsultDetailViewController *ndVC = [[ConsultDetailViewController alloc] initWithNibName:@"ConsultDetailViewController" bundle:nil];
    ndVC.id = aObject.id;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
}

#pragma mark -
#pragma mark ConsultViewConrentdelegate

- (void)contentViewWithscrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    [self.topTabScrollView moveWithOffset:offset.x];
}

- (void)contentViewWithScrollView:(UIScrollView *)scrollView didScrollToIndex:(NSInteger)aIndex{
    [self.topTabScrollView selectRow:aIndex animated:NO scrollPosition:TopTabScrollViewScrollPositionNone];
}

#pragma mark -
#pragma mark Notification Function

#pragma mark -
#pragma mark public Function

#pragma mark -
#pragma mark btn Function

#pragma mark -
#pragma mark private Function

- (void)setUpData{
    self.topArray = [[NSMutableArray alloc] init];
    self.contentArray = [[NSMutableArray alloc] init];
}

- (void)setUpTopTab{
    self.topTabScrollView.cellSpacing = 5;
    self.topTabScrollView.delegate = self;
}

- (void)testData{
    NSInteger count = [self.topArray count];
    for (int i= 0; i<count; i++) {
        NSArray *array = [NSArray array];
        [self.contentArray addObject:array];
    }
    
    [self.consultContentView showConsultContentViewWithData:self.contentArray];
}

@end
