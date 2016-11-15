//
//  BaiKeSicknessCategoryView.m
//  HealthEdu
//
//  Created by weixu on 16/11/15.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "BaiKeSicknessUnfoldCategoryView.h"
#import "BaiKeSicknessCategoryCollectionViewCell.h"

@interface BaiKeSicknessUnfoldCategoryView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) NSMutableArray *contentArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BaiKeSicknessUnfoldCategoryView

#pragma mark -
#pragma mark lifecycle

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUpCollectionView];
    
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

- (void)showUnfoldCategoryViewWithArray:(NSArray *)aArray{
    [self.contentArray setArray:aArray];
    [self.collectionView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}


#pragma mark -
#pragma mark UICollectionViewDelegate 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BaiKeSicknessCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaiKeSicknessCategoryCollectionViewCell" forIndexPath:indexPath];
    
    NSString *title = [self.contentArray objectAtIndex:indexPath.row];
    [cell showCellWithTitle:title];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [self.contentArray objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(onUnfoldCategoryOneElementSelectWithData:withIndex:)]) {
        [self.delegate onUnfoldCategoryOneElementSelectWithData:title withIndex:indexPath.row];
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [self.contentArray objectAtIndex:indexPath.row];

    
    CGSize size =[BaiKeSicknessCategoryCollectionViewCell cellSizeForString:title];
    return size;
}
#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private
- (void)setUpCollectionView{
    UINib *nib = [UINib nibWithNibName:@"BaiKeSicknessCategoryCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"BaiKeSicknessCategoryCollectionViewCell"];
}


@end
