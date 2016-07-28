//
//  MDABizManager.h
//  MediaAssistant
//
//  Created by Hirat on 16/7/7.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ReactiveCocoa.h"
#import "YYCategories.h"
#import "HRTRouter.h"
#import "UILabel+UILabel_VerticalAlign.h"
#import "DataArchive.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SEMNetworkingManager.h"
@interface MDABizManager : NSObject
@property (nonatomic,assign)BOOL userLogined;
/**
 *  单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;
- (void)updataUserLoginInfo;

@end
