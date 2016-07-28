//
//  NewsTitleView.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/25.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItemView.h"
@interface NewsTitleView : UIView
@property (nonatomic,strong)NewsItemView* newsitem;
@property (nonatomic,strong)NewsItemView* topicItem;
@property (nonatomic,strong)NewsItemView* attensionItem;
@property (nonatomic,assign)NSInteger selectedItem;
@end
