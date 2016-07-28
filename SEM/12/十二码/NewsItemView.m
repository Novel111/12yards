//
//  NewsItemView.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/25.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NewsItemView.h"
#import "MDABizManager.h"
@implementation NewsItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}

- (void)addSubViews
{
    [self addSubview:self.label];
    [self addSubview:self.line];
}

- (void)makeConstraits
{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).dividedBy(1.1);
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@2);
    }];
}
- (void)bindModel
{
    [RACObserve(self, isSelected) subscribeNext:^(id x) {
        self.line.hidden = !self.isSelected;
    }];
}
- (UIView*)line
{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor colorWithHexString:@"#1EA11F"];
        _line.hidden = YES;
    }
    return _line;
}

- (UILabel*)label
{
    if(!_label)
    {
        _label = [UILabel new];
        _label.textAlignment = UITextAlignmentCenter;
        _label.alpha = 0.87;
    }
    return _label;
}
@end
