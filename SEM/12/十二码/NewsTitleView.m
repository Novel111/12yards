//
//  NewsTitleView.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/25.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NewsTitleView.h"
#import "MDABizManager.h"
@implementation NewsTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
        [self makeConstraits];
        [self bildModel];
        self.selectedItem = 1;
    }
    return self;
}
- (void)addSubViews
{
    [self addSubview:self.newsitem];
    [self addSubview:self.topicItem];
    [self addSubview:self.attensionItem];
}

- (void)bildModel
{
    [RACObserve(self, selectedItem) subscribeNext:^(id x) {
        if ([x  isEqual: @1]) {
            self.newsitem.isSelected = YES;
            self.topicItem.isSelected = NO;
            self.attensionItem.isSelected = NO;
        }
        else if ([x  isEqual: @2])
        {
            self.newsitem.isSelected = NO;
            self.topicItem.isSelected = YES;
            self.attensionItem.isSelected = NO;
        }
        else
        {
            self.newsitem.isSelected = NO;
            self.topicItem.isSelected = NO;
            self.attensionItem.isSelected = YES;
        }
    }];
}
- (void)makeConstraits
{
    [self.newsitem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).dividedBy(3);
    }];
    [self.topicItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).dividedBy(3);
        make.left.equalTo(self.newsitem.mas_right);
    }];
    [self.attensionItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).dividedBy(3);
        make.left.equalTo(self.topicItem.mas_right);
    }];

    
}
- (NewsItemView*)newsitem
{
    if (!_newsitem) {
        _newsitem = [[NewsItemView alloc] initWithFrame:CGRectZero];;
        _newsitem.label.text = @"新闻";
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            self.selectedItem = 1;
        }];
        [_newsitem addGestureRecognizer:tap];
    }
    
    return _newsitem;
}

- (NewsItemView*)topicItem
{
    if (!_topicItem) {
        _topicItem = [[NewsItemView alloc] initWithFrame:CGRectZero];
        _topicItem.label.text = @"话题";
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            self.selectedItem = 2;
        }];
        [_topicItem addGestureRecognizer:tap];
    }
    return _topicItem;
}

- (NewsItemView*)attensionItem{
    if (!_attensionItem) {
        _attensionItem = [[NewsItemView alloc] initWithFrame:CGRectZero];
        _attensionItem.label.text = @"关注";
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            self.selectedItem = 3;
        }];
        [_attensionItem addGestureRecognizer:tap];
    }
    return _attensionItem;
}
@end
