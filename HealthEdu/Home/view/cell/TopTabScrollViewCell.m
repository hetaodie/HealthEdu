//
//  TopTabScrollViewCell.m
//  HealthEdu
//
//  Created by NetEase on 16/10/26.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "TopTabScrollViewCell.h"
#import "UIColor+HEX.h"


@implementation TopTabScrollViewCell


#pragma mark -
#pragma mark life cycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TopTabScrollViewCellSelect object:nil];
}

+ (TopTabScrollViewCell *)viewFromXib{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TopTabScrollViewCell" owner:nil options:nil];
    TopTabScrollViewCell *cell = [views firstObject];
    return cell;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addNSNotification];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addNSNotification];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addNSNotification];
    }
    return self;
}

#pragma mark -
#pragma mark delegate

#pragma mark -
#pragma mark Notification Function

- (void)oneCellSelection:(NSNotification *)notification{
    TopTabScrollViewCell *cell = [notification object];
    if (cell == self) {
        [self setSelected:YES];
    }
    else{
        [self setSelected:NO];
    }
}

#pragma mark -
#pragma mark public Function

- (IBAction)buttonPress:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:TopTabScrollViewCellSelect object:self];
}

+ (CGFloat)cellWidthWithString:(NSString *)aString{
    UIFont *font = [UIFont systemFontOfSize:16];
    NSDictionary *dict = @{NSFontAttributeName:font};
    
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(MAXFLOAT,44) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width+ 30;
}

#pragma mark -
#pragma mark btn Function

#pragma mark -
#pragma mark private Function

- (void)setSelected:(BOOL)selected{
    if (selected) {
        self.titleLabel.textColor = [UIColor colorWithHexString:@"0099e6" alpha:1.0];
    }
    else{
        self.titleLabel.textColor = [UIColor colorWithHexString:@"000000" alpha:1.0];
    }
}

- (void)addNSNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oneCellSelection:) name:TopTabScrollViewCellSelect object:nil];
}
@end
