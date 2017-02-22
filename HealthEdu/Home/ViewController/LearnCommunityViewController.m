//
//  LearnCommunityViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "LearnCommunityViewController.h"

#import "CycleBannersView.h"
#import "TopTabScrollView.h"
#import "LectureHailContentView.h"
#import "PlayerViewController.h"

#import "PlayHistoryViewController.h"
#import "LearnCommunitySource.h"

#import "LearnCommunityClassifyObject.h"

@interface LearnCommunityViewController ()<TopTabScrollViewDelegate,CycleBannersViewDelegate,LectureHailContentViewDelegate,LearnCommunitySourceDelegate>
@property (nonatomic, strong) NSMutableArray *bannersArray;
@property (nonatomic, strong) NSMutableArray *topArray;
@property (nonatomic, strong) NSMutableArray *contentArray;


@property (weak, nonatomic) IBOutlet CycleBannersView *cycleBannersView;
@property (weak, nonatomic) IBOutlet TopTabScrollView *topTabScrollView;

@property (weak, nonatomic) IBOutlet LectureHailContentView *contentView;

@property (nonatomic, strong) LearnCommunitySource *communitySource;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation LearnCommunityViewController

#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"学习社区";
    
    UIButton *dituBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dituBtn.frame = CGRectMake(0, 0, 80, 25);
    [dituBtn setTitle:@"观看历史" forState:UIControlStateNormal];
    [dituBtn addTarget:self action:@selector(lookHistory:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *dituItem = [[UIBarButtonItem alloc] initWithCustomView:dituBtn];
    self.navigationItem.rightBarButtonItem = dituItem;
    
    [self setUpData];
    [self testData];
    
    
    self.topTabScrollView.delegate = self;
    self.cycleBannersView.delegate = self;
    self.contentView.delegate = self;
    
//    NSArray *tmpArray = [NSArray arrayWithObjects:@"推荐",@"常见病",@"养生",@"健身",@"两性",@"美容", @"推荐",@"热点",@"前沿",@"时评",@"政策",@"提醒", nil];
//    [self.topArray setArray:tmpArray];
//    [self.contentView showViewWithArray:self.contentArray];
    
 //   [self.topTabScrollView reloadData];
    
    
    //[self.topTabScrollView selectRow:0 animated:YES scrollPosition:TopTabScrollViewScrollPositionNone];
    self.communitySource  = [[LearnCommunitySource alloc] init];
    self.communitySource.delegate = self;
    [self.communitySource getLearnCommunityClassify];
    
    [self.cycleBannersView showBannersWithBannersArray:self.bannersArray];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark CycleBannersViewDelegate

- (void)onClickItemBannersIndex:(NSInteger)aIndex{
    
}

#pragma mark -
#pragma mark LectureHailContentViewDelegate

- (void)onOneElementContentSelectWithData:(NSString *)aObject withIndex:(NSInteger)aIndex{
    
}


#pragma mark -
#pragma mark TopTabScrollViewDelegate

- (NSInteger)numberOfRowInTopTabScrollView:(TopTabScrollView *)topTabScrollView{
    NSInteger cont = [self.topArray count];
    return cont;
}

- (CGFloat)topTabScrollView:(TopTabScrollView *)topTabScrollView widthForItemAtRow:(NSInteger)row{
    LearnCommunityClassifyObject *object = [self.topArray objectAtIndex:row];
    CGFloat width = [TopTabScrollViewCell cellWidthWithString:object.title];
    return width;
}

- (TopTabScrollViewCell *)topTabScrollView:(TopTabScrollView *)topTabScrollView cellForItemAtRow:(NSInteger)row{
    TopTabScrollViewCell *cell = [TopTabScrollViewCell viewFromXib];
    
     LearnCommunityClassifyObject *object = [self.topArray objectAtIndex:row];
    cell.titleLabel.text = object.title;
    return cell;
}

- (void)topTabScrollView:(TopTabScrollView *)topTabScrollView didSelectRow:(NSInteger )row{
    self.selectIndex = row;

    LearnCommunityClassifyObject *object = [self.topArray objectAtIndex:row];
    [self.communitySource getLearnCommunityData:object.id];
    [self.contentView selectContentWithIndex:row];
}

- (void)contentOneContentCellWithSelect:(LectureHailObject *)aObject withIndex:(NSInteger)aIndex{
    PlayerViewController *ndVC = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    ndVC.videoObject = aObject;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
}

- (void)onLearnCommunityClassifySuccess:(NSArray *)aArray{
    [self.topArray setArray:aArray];
    self.selectIndex = 0;
    
    [self testData];
    [self.contentView showViewWithArray:self.contentArray];
    
    [self.topTabScrollView reloadData];
    [self.topTabScrollView selectRow:0 animated:YES scrollPosition:TopTabScrollViewScrollPositionNone];
}

- (void)onLearnCommunityClassifyError{

}

- (void)onLearnCommunityDataSuccess:(NSArray *)aArray{
    [self.contentArray replaceObjectAtIndex:self.selectIndex withObject:aArray];
    [self.contentView showViewWithArray:self.contentArray];
}

- (void)onLearnCommunityDataError{

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
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)testData{
    NSArray *banners = [NSArray arrayWithObjects:@"1", @"1", @"1", @"1", @"1", @"1", nil];
    [self.bannersArray setArray:banners];
    
    NSInteger count = [self.topArray count];
    for (int i= 0; i<count; i++) {
        NSArray *array = [NSArray array];
        [self.contentArray addObject:array];
    }
}

- (void)lookHistory:(id)sender{
    PlayHistoryViewController *ndVC = [[PlayHistoryViewController alloc] initWithNibName:@"PlayHistoryViewController" bundle:nil];
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
}

- (void)setUpData{
    self.bannersArray = [[NSMutableArray alloc] init];
    self.topArray = [[NSMutableArray alloc] init];
    self.contentArray = [[NSMutableArray alloc] init];
}
@end
