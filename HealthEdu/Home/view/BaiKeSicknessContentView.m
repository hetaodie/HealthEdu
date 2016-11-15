//
//  BaiKeSicknessContentView.m
//  HealthEdu
//
//  Created by weixu on 16/11/15.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "BaiKeSicknessContentView.h"
#import "BaikeSicknessContentTableViewCell.h"

const CGFloat BaiKeSicknessContentViewCellheight = 40;

@interface BaiKeSicknessContentView()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) NSMutableArray *contentArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation BaiKeSicknessContentView

#pragma mark -
#pragma mark lifecycle

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUpTabelView];
    
    self.contentArray = [[NSMutableArray alloc] init];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        self.contentView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (void)showViewWithArray:(NSArray *)aArray{
    [self.contentArray setArray:aArray];
    [self.tableView reloadData];
    
}

#pragma mark -
#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaikeSicknessContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaikeSicknessContentTableViewCell" forIndexPath:indexPath];
    NSString *title = [self.contentArray objectAtIndex:indexPath.row];
    [cell showCellWithTitle:title];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaiKeSicknessContentViewCellheight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [self.contentArray objectAtIndex:indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSicknessContentOneElementSelectWithData:withIndex:)]) {
        [self.delegate onSicknessContentOneElementSelectWithData:title withIndex:indexPath.row];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)setUpTabelView{
    UINib *nib = [UINib nibWithNibName:@"BaikeSicknessContentTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BaikeSicknessContentTableViewCell"];
}


@end
