//
//  SelectCityView.m
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "SelectCityView.h"
#import "UIColor+HEX.h"

@interface SelectCityView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *locCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectCityLabel;
@property (nonatomic, assign) BOOL isUnfold;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@end

@implementation SelectCityView

#pragma mark -
#pragma mark lifecycle

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.isUnfold = NO;
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

- (IBAction)selectBtnPress:(id)sender {
    
    [self changeSelectStatus];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSelectCity:)]) {
        [self.delegate onSelectCity:self.isUnfold];
    }
    

}

#pragma mark -
#pragma mark public

- (void)setSelectCityName:(NSString *)aName{
    self.selectCityLabel.text = aName;
    
    self.isUnfold = YES;
    [self changeSelectStatus];
}

- (void)setLocCityName:(NSString *)aName{
    self.locCityLabel.text = aName;
}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)changeSelectStatus{
    if (self.isUnfold) {
        self.isUnfold = NO;
        self.selectView.backgroundColor = [UIColor whiteColor];
        self.selectImageView.image = [UIImage imageNamed:@"zhankai"];
    }
    else{
        self.isUnfold = YES;
        self.selectView.backgroundColor = [UIColor colorWithHexString:@"ededed" alpha:1.0];
    }
}

@end
