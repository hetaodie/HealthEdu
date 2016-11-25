//
//  PlayHistoryViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "PlayHistoryViewController.h"
#import "PlayHistoryTableViewCell.h"
#import "VideoHistoryManager.h"

@interface PlayHistoryViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *historyVideoArray;

@end

@implementation PlayHistoryViewController

#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"观看历史";
    
    UIButton *dituBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dituBtn.frame = CGRectMake(0, 0, 80, 25);
    [dituBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [dituBtn addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *dituItem = [[UIBarButtonItem alloc] initWithCustomView:dituBtn];
    self.navigationItem.rightBarButtonItem = dituItem;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpTableView];
    
    self.historyVideoArray = [[NSMutableArray alloc] init];
    NSArray *historyArray = [[VideoHistoryManager sharedInstance] getAllVideoHistory];
    if ([historyArray count] >0) {
        [self.historyVideoArray setArray:historyArray];
        [self.tableView reloadData];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark IBActions

- (void)beginEditing:(id)sender{
    BOOL isEdit = self.tableView.editing;
    if (isEdit) {
        [self.tableView setEditing:NO animated:YES];
    }
    else{
        [self.tableView setEditing:YES animated:YES];
    }

}


#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = [self.historyVideoArray count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayHistoryTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"PlayHistoryTableViewCell" forIndexPath:indexPath];
    
    LectureHailContentObject *object = [self.historyVideoArray objectAtIndex:indexPath.row];
    [cell showCellWithObject:object];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
        case UITableViewCellEditingStyleNone:
        {
        }
            break;
        case UITableViewCellEditingStyleDelete:
        {
            //修改数据源，在刷新 tableView
            [self.historyVideoArray removeObjectAtIndex:indexPath.row];
            [[VideoHistoryManager sharedInstance] removeVideoFromHistory:[self.historyVideoArray objectAtIndex:indexPath.row]];
            
            //让表视图删除对应的行
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
            
        default:
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)setUpTableView{
    UINib *nib = [UINib nibWithNibName:@"PlayHistoryTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PlayHistoryTableViewCell"];
}

@end
