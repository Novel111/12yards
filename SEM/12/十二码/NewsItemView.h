//
//  NewsItemView.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/25.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *  @author 汪宇豪, 16-07-25 16:07:00
 *
 *  @brief 资讯界面顶部的item
 */
@interface NewsItemView : UIView
@property (nonatomic,strong) UIView* line;
@property (nonatomic,strong) UILabel* label;
@property (nonatomic,assign) BOOL isSelected;
@end
