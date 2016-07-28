//
//  NewsDetailViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NewsDetailViewModel.h"

@implementation NewsDetailViewModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.identifier = [dictionary[@"id"] integerValue];
        [self fetchdata];
    }
    return self;
}
- (void)fetchdata
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchNewsDetail:self.identifier success:^(id data) {
        self.newdetail = data;
        self.isLoaded = YES;
    } failure:^(NSError *aError) {
        
    }];
}

@end
