//
//  ConsultContentView.m
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultContentView.h"
#import "ConsultContentCollectionViewCell.h"

@interface ConsultContentView()<UICollectionViewDelegate,UICollectionViewDataSource,ConsultContentViewDelegate,ConsultContentCollectionViewCellDelegate>
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *contentArray;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation ConsultContentView

#pragma mark -
#pragma mark lifecycle


- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    self.collectionViewFlowLayout.itemSize = self.bounds.size;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ConsultContentCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"ConsultContentCollectionViewCell"];
    self.collectionView.scrollsToTop = NO;
    
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

- (void)showConsultContentViewWithData:(NSArray *)aArray{
    [self.contentArray setArray:aArray];
    [self.collectionView reloadData];
}

- (void)selectContentWithIndex:(NSInteger)aIndex{
    self.selectIndex = aIndex;
    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:aIndex inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionNone
                                            animated:NO];
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
}

#pragma mark -
#pragma mark delegate

#pragma mark -
#pragma mark ConsultContentViewDelegate


- (void)clickOneElementOfCellWithInfo:(ConsultListObject *)aObject withIndex:(NSInteger)aIndex{
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentOneContentCellWithSelect:withIndex:)]) {
        [self.delegate contentOneContentCellWithSelect:aObject withIndex:aIndex];
    }

}

- (void)contentScrollOffSet:(CGPoint)offset{

}

#pragma mark -
#pragma mark collectionViewdelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    NSArray *array = [self.contentArray objectAtIndex:row];
    
    ConsultContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConsultContentCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell showCellWithData:array];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentViewWithscrollViewDidScroll:)]) {
    [self.delegate contentViewWithscrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x/scrollView.frame.size.width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentViewWithScrollView:didScrollToIndex:)]) {
        [self.delegate contentViewWithScrollView:scrollView didScrollToIndex:index];
    }
}


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)setUpData{
    self.contentArray = [[NSMutableArray alloc] init];
}

@end
