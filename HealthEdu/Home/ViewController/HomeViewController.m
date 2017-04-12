//
//  HomeViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/9/27.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeContentTableViewCell.h"
#import "HomeContentHeaderView.h"
#import "HomeTagView.h"

#import "ConsultViewController.h"
#import "BaiKeViewController.h"
#import "LectureHailViewController.h"
#import "LearnCommunityViewController.h"
#import "HomePageModelSource.h"
#import "ConsultDetailViewController.h"
#import "PlayerViewController.h"
#import "UIColor+HEX.h"

#import "MessageViewController.h"

#define HomeContentCellHeight 168

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomePageModelSourceDelegate,HomeTagViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (weak, nonatomic) IBOutlet HomeTagView *homeTagView;
@property (strong, nonatomic) HomePageModelSource *modelSource;
@property (strong, nonatomic) NSMutableArray *contentArray;

@end

@implementation HomeViewController

#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpContentTableView];
    
    self.homeTagView.delegate = self;
    
    self.modelSource = [[HomePageModelSource alloc] init];
    self.modelSource.delegate =self;
    [self.modelSource getHomePageNews];
    
    self.contentArray = [[NSMutableArray alloc] init];
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(0, 0, 55, 23);
    [messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [messageBtn setTintColor:[UIColor colorWithHexString:@"ffffff" alpha:1.0]];
    messageBtn.layer.cornerRadius = 10;
    messageBtn.layer.borderColor  = [UIColor colorWithHexString:@"ffffff" alpha:1.0].CGColor;
    messageBtn.layer.borderWidth = 2.0;
    messageBtn.clipsToBounds = YES;
    [messageBtn addTarget:self action:@selector(messageBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark IBActions

- (void)messageBtnPress:(id)sender {
    MessageViewController *ndVC = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
}

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate

- (void)onHomePageNewsError{
    
}

- (void)onHomePageNewsSuccess:(NSArray *)aArray{
    [self.contentArray setArray:aArray];
    [self.contentTableView reloadData];
    
}

#pragma mark -
#pragma mark HomeTagViewDelegate

- (void)onSelectBtnWithTag:(HomeTagsName)aTag{
    switch (aTag) {
        case HomeTagsNameOfConsult:
        {
            ConsultViewController *ndVC = [[ConsultViewController alloc] initWithNibName:@"ConsultViewController" bundle:nil];
            ndVC.hidesBottomBarWhenPushed = YES;
            ndVC.num = 2;
            [self.navigationController pushViewController:ndVC animated:YES];
            break;
        }
        case HomeTagsNameOfBaiKe:
        {
            ConsultViewController *ndVC = [[ConsultViewController alloc] initWithNibName:@"ConsultViewController" bundle:nil];
            ndVC.hidesBottomBarWhenPushed = YES;
            ndVC.num = 3;
            [self.navigationController pushViewController:ndVC animated:YES];
            break;
        }
        case HomeTagsNameOfLectureHail:
        {
            LectureHailViewController *ndVC = [[LectureHailViewController alloc] initWithNibName:@"LectureHailViewController" bundle:nil];
            ndVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ndVC animated:YES];
            break;
        }
        case HomeTagsNameOfLearnCommuity:
        {
            LearnCommunityViewController *ndVC = [[LearnCommunityViewController alloc] initWithNibName:@"LearnCommunityViewController" bundle:nil];
            ndVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ndVC animated:YES];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate & UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeContentTableViewCell" forIndexPath:indexPath];
    [cell showCellWithObject:[self.contentArray objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HomeContentCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PopularRecommendObject *object = [self.contentArray objectAtIndex:indexPath.row];
    
    NSUInteger style = [object.stype integerValue];
    if (style == 4 || style ==5) {
        [self.modelSource getVideoContent:object.id];
    }
    else {
        ConsultDetailViewController *ndVC = [[ConsultDetailViewController alloc] initWithNibName:@"ConsultDetailViewController" bundle:nil];
        ndVC.id = object.id;
        ndVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ndVC animated:YES];
    }
}



- (void)onGetVideoContentSuccess:(LectureHailObject *)aObject {
    PlayerViewController *ndVC = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    ndVC.videoObject = aObject;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];

}


- (void)onGetVideoContentError {

}

#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)setUpContentTableView{
    UINib *nib = [UINib nibWithNibName:@"HomeContentTableViewCell" bundle:nil];
    [self.contentTableView registerNib:nib forCellReuseIdentifier:@"HomeContentTableViewCell"];
    
    HomeContentHeaderView *view = [HomeContentHeaderView viewWithXib];
    self.contentTableView.tableHeaderView = view;
}
@end
