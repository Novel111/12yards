//
//  NewsDetailResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReCommendNews.h"
@class NewsDetailModel,Creator,Comments,Comment,Creator;
@interface NewsDetailResponseModel : NSObject

@property (nonatomic, strong) NewsDetailModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface NewsDetailModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, strong) NSArray<Comments *> *comments;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, assign) NSInteger viewed;

@property (nonatomic, strong) NSArray<NSString *> *tags;

@property (nonatomic, strong) NSArray *medias;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) Creator *creator;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSArray *loves;

@property (nonatomic, strong) NSArray *viewers;
- (NSString*)getInfo;
@end


@interface Comments : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, strong) Comment *comment;

@property (nonatomic, assign) NSInteger news;

@end

@interface Comment : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) Creator *creator;

@property (nonatomic, copy) NSString *replyUser;

@property (nonatomic, strong) NSArray *replies;

@end



