//
//  TopTabScrollView.m
//  HealthEdu
//
//  Created by NetEase on 16/10/26.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "TopTabScrollView.h"
#import "UIColor+MaxColor.h"
#import "UIColor+HEX.h"

typedef NS_ENUM(NSInteger, MoveDirection) {
    MoveDirectionLeft,
    MoveDirectionRight
};


#define moveViewHeight 2
#define moveViewWidth 38  // 这个初始值

#define moveOneIndexDurationTime 0.1
#define moveMaxDurationTime 0.4

@interface TopTabScrollView()
@property (nonatomic, assign) NSInteger cellIndex;
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) UIView *moveView;

@end

@implementation TopTabScrollView

@dynamic delegate;

#pragma mark -
#pragma mark life cycle

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpData];
        [self setUpSubViews];
        
        [self addNSNotification];
        self.scrollEnabled = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addNSNotification];
        [self setUpData];
        [self setUpSubViews];
        self.scrollEnabled = YES;
    }
    return self;
}

#pragma mark -
#pragma mark delegate

#pragma mark -
#pragma mark Notification Function

- (void)oneTopTabCellSelect:(NSNotification *)notification{
    TopTabScrollViewCell *cell = [notification object];
    
    NSInteger index = [self.cellArray indexOfObject:cell];
 
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTabScrollView:didSelectRow:)]) {
        [self.delegate topTabScrollView:self didSelectRow:index];
    }
    
    CGFloat moveDuration = moveOneIndexDurationTime * labs(self.cellIndex - index) >moveMaxDurationTime ? moveMaxDurationTime : moveOneIndexDurationTime * labs(self.cellIndex - index) ;
    
    [UIView animateWithDuration:moveDuration animations:^{
        [self changeMoveViewFrameAtCell:cell];
    }];
    
    self.cellIndex = index;
}

#pragma mark -
#pragma mark public Function

- (void)reloadData{
    
    [self.cellArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.cellArray removeAllObjects];
    
    NSInteger count = [self getTopTabNumber];
    for (int i = 0; i<count; i++) {
        TopTabScrollViewCell *cell = [self getTopTabScrollViewCellWithRow:i];
        CGFloat cellWidth = [self getTopTabScrollViewCellSizeWithRow:i];
        [self addCellToViewWithCell:cell withWidth:cellWidth];
        [self.cellArray addObject:cell];
    }
    
    [self bringSubviewToFront:self.moveView];
}

- (void)selectRow:(NSInteger)row animated:(BOOL)animated scrollPosition:(TopTabScrollViewScrollPosition)topTabScrollViewScrollPosition{
    NSInteger count = [self.cellArray count];
    
    if (row >= count) {
        return;
    }
    else{
        TopTabScrollViewCell *cell = [self.cellArray objectAtIndex:row];
        [[NSNotificationCenter defaultCenter] postNotificationName:TopTabScrollViewCellSelect object:cell];
        
        [self changeContentOffSetWithRow:row andPosition:topTabScrollViewScrollPosition animated:YES];
        self.cellIndex = row;
    }
}

- (void)moveWithOffset:(CGFloat)offset{
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger nextIndex = offset/screenWidth;
    CGFloat offsetMod = fmodf(offset, screenWidth);
    
    MoveDirection moveDirection = [self getMoveDirectionWithOffset:offset];
    
    CGFloat moveOffset;
    CGPoint center = self.moveView.center;
    
    TopTabScrollViewCell *cell = [self.cellArray objectAtIndex:nextIndex];
    CGFloat beginX = CGRectGetMidX(cell.frame);
    
    if (moveDirection == MoveDirectionRight) {
        moveOffset = [self getTopMoveOffsetWithOffset:offsetMod andIndex:nextIndex + 1];
    }
    else{
        moveOffset = [self getTopMoveOffsetWithOffset: offsetMod andIndex:nextIndex];
    }
    center.x = beginX + moveOffset;

    self.moveView.center = center;
    
}

#pragma mark -
#pragma mark btn Function

#pragma mark -
#pragma mark private Function

- (void)setUpData{
    self.cellArray = [[NSMutableArray alloc] init];
}

- (void)setUpSubViews{
    self.moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, moveViewWidth, moveViewHeight)];
    
    [self addSubview:self.moveView];
    self.moveView.backgroundColor = [UIColor colorWithHexString:@"0099e6" alpha:1.0f];
}

- (void)addNSNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oneTopTabCellSelect:) name:TopTabScrollViewCellSelect object:nil];
}

- (NSInteger)getTopTabNumber{
    NSInteger number = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfRowInTopTabScrollView:)]) {
        number = [self.delegate numberOfRowInTopTabScrollView:self];
    }
    return number;
}

- (TopTabScrollViewCell *)getTopTabScrollViewCellWithRow:(NSInteger)row{
    TopTabScrollViewCell *cell = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTabScrollView:cellForItemAtRow:)]) {
        cell = [self.delegate topTabScrollView:self cellForItemAtRow:row];
    }
    return cell;
}

- (CGFloat)getTopTabScrollViewCellSizeWithRow:(NSInteger)row{
    CGFloat width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTabScrollView:widthForItemAtRow:)]) {
        width = [self.delegate topTabScrollView:self widthForItemAtRow:row];
    }
    return width;
}

- (void)addCellToViewWithCell:(TopTabScrollViewCell *)cell withWidth:(CGFloat)width{
    NSInteger count = [self.cellArray count];
    
    CGFloat beginX =0;
    if (count > 0) {
        TopTabScrollViewCell *cell = [self.cellArray lastObject];
        beginX = CGRectGetMaxX(cell.frame);
        beginX +=self.cellSpacing;
    }
    else{
        beginX = 0;
    }
    
    CGRect frame = CGRectMake(beginX, 0, width, self.frame.size.height);
    cell.frame = frame;
    
    CGSize size = CGSizeMake(CGRectGetMaxX(frame), self.frame.size.height);
    [self changeContentSize:size];
    
    [self addSubview:cell];
}

- (void)changeContentSize:(CGSize)size{
    self.contentSize = size;
}

- (void)changeContentOffSetWithRow:(NSInteger)row andPosition:(TopTabScrollViewScrollPosition)topTabScrollViewScrollPosition animated:(BOOL)animated{
    
    TopTabScrollViewCell *cell = [self.cellArray objectAtIndex:row];
    CGFloat moveX = CGRectGetMinX(cell.frame);
    
    switch (topTabScrollViewScrollPosition) {
        case TopTabScrollViewScrollPositionNone:
        {
            CGFloat minX = CGRectGetMinX(cell.frame);
            CGFloat maxX = CGRectGetMaxX(cell.frame);
            if (minX - self.contentOffset.x <0){
                moveX = minX;
            }
            else if(maxX-self.contentOffset.x > self.frame.size.width){
                moveX = maxX - self.frame.size.width;
            }
            else{
                moveX = self.contentOffset.x;
            }
            
            break;
        }
        case TopTabScrollViewScrollPositionTop:
        {
            moveX = CGRectGetMinX(cell.frame);
            BOOL isGreaterthanMax = (moveX + self.frame.size.width) > self.contentSize.width;
            
            if (isGreaterthanMax) {
                moveX =self.contentSize.width - self.frame.size.width;
            }

            break;
        }
        case TopTabScrollViewScrollPositionMiddle:
        {
            moveX = CGRectGetMidX(cell.frame);
            BOOL isGreaterthanMax = (moveX + self.frame.size.width/2) > self.contentSize.width;
            BOOL isLessthanMin = moveX - self.frame.size.width/2 < 0;
            
            if (isGreaterthanMax) {
                moveX =self.contentSize.width - self.frame.size.width;
            }
            else{
                if (isLessthanMin) {
                    moveX = 0;
                }
                else{
                    moveX -=self.frame.size.width/2;
                }
            }

            break;
        }
        case TopTabScrollViewScrollPositionBottom:
        {
            moveX = CGRectGetMaxX(cell.frame);
            BOOL isLessthanMin = moveX - self.frame.size.width < 0;
            
            if (isLessthanMin) {
                moveX =0;
            }
            else{
                moveX -= self.frame.size.width;
            }
            
            break;
        }
            
        default:
            break;
    }
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint point = self.contentOffset;
            point.x = moveX;
            [self setContentOffset:point];
        }];
    }
    else{
        CGPoint point = self.contentOffset;
        point.x = moveX;
        [self setContentOffset:point];
    }
    
    [self changeMoveViewFrameAtCell:cell];
    
    
}

- (void)changeMoveViewFrameAtCell:(TopTabScrollViewCell *)topTabScrollViewCell{
    CGRect frame = self.moveView.frame;
    frame.origin.y = topTabScrollViewCell.frame.size.height - frame.size.height;
    
    self.moveView.frame = frame;
    
    CGPoint center = self.moveView.center;
    center.x = topTabScrollViewCell.center.x;
    self.moveView.center = center;
}

- (MoveDirection)getMoveDirectionWithOffset:(CGFloat)offset{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger nextIndex = offset/screenWidth;

    if (nextIndex >= self.cellIndex) {
        return MoveDirectionRight;
    }
    else{
        return MoveDirectionLeft;
    }
}

- (CGFloat)getTopMoveOffsetWithOffset:(CGFloat)offset andIndex:(NSInteger)aIndex{
    
    if ([self.cellArray count]<=aIndex) {
        return 0;
    }
    TopTabScrollViewCell *cell = [self.cellArray objectAtIndex:aIndex];
    CGFloat width = CGRectGetWidth(cell.frame);
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat moveOffset = ((width+self.cellSpacing) * offset)/screenWidth;
    return moveOffset;
}

@end
