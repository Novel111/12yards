//
//  BottomView.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "BottomView.h"
#import "Masonry.h"
#import "YYCategories.h"
@implementation BottomView
#pragma initialization
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self makeConstraits];
    }
    return self;
}


- (void)addSubviews
{
    [self addSubview:self.inifoLabel];
    [self addSubview:self.commentLabel];
    [self addSubview:self.conmmentView];
}

- (void)makeConstraits
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    self.scale = [data floatForKey:@"scale"];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.mas_width).dividedBy(10);
//        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.conmmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
//        make.bottom.equalTo(self.commentLabel.mas_bottom);
        make.right.equalTo(self.commentLabel.mas_left).offset(-5*self.scale);
        make.width.equalTo(self.mas_width).dividedBy(14);
    }];
    [self.inifoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.conmmentView.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_top);
    }];
    
}

- (void)updateConstraintsIfNeeded
{
    [super updateConstraintsIfNeeded];
    NSLog(@"%f",self.frame.size.width);
    NSLog(@"%f",self.frame.size.height);
}
#pragma mark -getter
- (UILabel*)inifoLabel
{
    if (!_inifoLabel) {
        _inifoLabel = [[UILabel alloc] init];
        _inifoLabel.font = [UIFont systemFontOfSize:14];
        [_inifoLabel setTextColor:[UIColor colorWithHexString:@"#C9C9C9"]];
    }
    return _inifoLabel;
}

- (UILabel*)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:14];
        [_commentLabel setTextColor:[UIColor colorWithHexString:@"#C9C9C9"]];
        
    }
    return _commentLabel;
}
- (UIImageView*)conmmentView
{
    if(!_conmmentView)
    {
        _conmmentView = [[UIImageView alloc] init];
        _conmmentView.image = [UIImage imageNamed:@"消息icon"];
        _conmmentView.contentMode =  UIViewContentModeScaleToFill;
    }
    return _conmmentView;
}

@end
