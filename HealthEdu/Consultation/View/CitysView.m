//
//  CitysView.m
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "CitysView.h"
#import "CitysViewCollectionViewCell.h"
#import "ConsultationObject.h"

@interface CitysView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *contentArray;

@end


@implementation CitysView

#pragma mark -
#pragma mark lifecycle

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentArray = [[NSMutableArray alloc] init];
    [self setUpCollectionView];
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
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CitysViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CitysViewCollectionViewCell" forIndexPath:indexPath];
    
    ConsultationObject *object = [self.contentArray objectAtIndex:indexPath.row];
    [cell showCellWithTitle:object.title];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     ConsultationObject *object = [self.contentArray objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSelectOneElementWithData:withIndex:)]) {
        [self.delegate onSelectOneElementWithData:object withIndex:indexPath.row];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    ConsultationObject *object = [self.contentArray objectAtIndex:indexPath.row];
    
    CGSize size =[CitysViewCollectionViewCell cellSizeForString:object.title];
    return size;
}


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)setUpCollectionView{
    UINib *nib = [UINib nibWithNibName:@"CitysViewCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"CitysViewCollectionViewCell"];
}
@end
