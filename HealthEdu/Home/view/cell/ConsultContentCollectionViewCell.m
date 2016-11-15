//
//  ConsultContentCollectionViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultContentCollectionViewCell.h"
#import "ConsultContentTableViewCell.h"

@interface ConsultContentCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *contentArray;

@end

@implementation ConsultContentCollectionViewCell

#pragma mark -
#pragma mark lifecycle


- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentArray = [[NSMutableArray alloc] init];
    UINib *nib = [UINib nibWithNibName:@"ConsultContentTableViewCell" bundle:nil] ;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ConsultContentTableViewCell"];
    
    self.backgroundColor= [UIColor clearColor];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (void)showCellWithData:(NSArray *)aArray{
    [self layoutIfNeeded];
    [self.contentArray setArray:aArray];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    
    NSString *title = [self.contentArray objectAtIndex:row];
    
    ConsultContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsultContentTableViewCell" forIndexPath:indexPath];
    
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    ConsultContentObject *object = [self.contentArray objectAtIndex:row];
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickOneElementOfCellWithInfo:withIndex:)]){
        [self.delegate clickOneElementOfCellWithInfo:object withIndex:row];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [ConsultContentTableViewCell cellHeightWithData:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //防止下拉是记住滚动位置
    if (scrollView.contentOffset.y <0) {
        return;
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScrollToTop");
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentScrollOffSet:)]) {
        [self.delegate contentScrollOffSet:scrollView.contentOffset];
    }
}


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private



#pragma mark -
#pragma mark TableViewDelegate

@end
