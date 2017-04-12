//
//  MessageViewController.m
//  HealthEdu
//
//  Created by weixu on 2017/4/11.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageObject.h"
#import "MessageDetailObject.h"
#import "MessageSource.h"
#import "MessageDetailViewController.h"

@interface MessageViewController () <UITableViewDelegate,UITableViewDataSource,MessageSourceDelegate,MessageTableViewCellDelegate>
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MessageSource *messageSource;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    self.contentArray = [[NSMutableArray alloc] init];
    self.messageSource = [[MessageSource alloc] init];
    
    self.messageSource.delegate = self;
    [self.messageSource getMessage];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"系统消息";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell" forIndexPath:indexPath];
    MessageObject *object = [self.contentArray objectAtIndex:indexPath.row];
    
    cell.delegate = self;
    [cell showCellWithData:object];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 285;
}



- (void)setUpTableView{
    UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MessageTableViewCell"];
}

- (void)onGetMessageSuccess:(NSArray *)aArray {
    [self.contentArray setArray:aArray];
    [self.tableView reloadData];
}

- (void)onGetMessageError {

}

- (void)onMessageMore:(MessageObject *)aObject {
    MessageDetailViewController *ndVC = [[MessageDetailViewController alloc] initWithNibName:@"MessageDetailViewController" bundle:nil];
    ndVC.hidesBottomBarWhenPushed = YES;
    ndVC.id = aObject.id;
    [self.navigationController pushViewController:ndVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
