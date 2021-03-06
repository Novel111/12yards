//
//  SEMNetworkingManager.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
#import "NewsDetailResponseModel.h"
#import "SEMNetworkingManager.h"
#import "GameDetailModel.h"
#import "GameListResponseModel.h"
NSString* const hotTopics = @"/university/hotTopics";
NSString* const hotTopicsCache = @"hotTopicsCache";
NSString* const ReconmendNewsURL = @"/university/editorViews";
NSString* const SchoolListURL = @"/area/list";
NSString* const SearchResult = @"/university/search";
NSString* const NewsURL = @"/university/articles";
NSString* const TopicsURL = @"/university/topics";
NSString* const NoticeGameURL = @"/university/previewMatches";
NSString* const HistoryGameURL = @"/university/reviewMatches";
NSString* const GameListURL = @"/university/tournaments";
NSString* const NewDetailURL = @"/news/detail";

@implementation SEMNetworkingManager
+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        NSURL* url = [NSURL URLWithString: @"http://dev.12yards.cn"];
        _sharedInstance = [[self alloc] initWithBaseURL: url];
    });
    return _sharedInstance;
}

- (NSURLSessionTask*)fetchHotTopics:(NSString*)code
                            success:(void (^)(id data))successBlock
                       failure:(void (^)(NSError *aError))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    [URL appendString:code];
    [URL appendString:hotTopics];
    
    return [self GET: URL parameters: nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        hotTopicsModel* model = [hotTopicsModel mj_objectWithKeyValues:responseObject];
        NSMutableArray* news = [NSMutableArray arrayWithArray:model.resp];
        successBlock(news);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
    }];
}

- (NSURLSessionTask*)fetchReCommendNews:(NSString*)code
                                 offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    [URL appendString:code];
    [URL appendString:ReconmendNewsURL];
    NSDictionary *para = @{@"offset":@(offset)};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ReCommendNews* model =[ReCommendNews mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (NSURLSessionTask *)fetchSchoolList:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    return [self GET:SchoolListURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SearchModel* model = [SearchModel mj_objectWithKeyValues:responseObject];
        NSArray* area = model.resp;
        successBlock(area);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }
            ];
}

- (NSURLSessionTask *)fetchSearchResults:(NSString *)name success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    NSDictionary *para = @{@"q":name};
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    return [self GET:SearchResult parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SearchResultsModel* model = [SearchResultsModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}
- (NSURLSessionTask *)fetchNews:(NSString *)name offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSDictionary *para = @{@"offset":@(offset)};
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    [URL appendString:name];
    [URL appendString:NewsURL];
    return  [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NewsModel *model = [NewsModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (NSURLSessionTask *)fetchTopics:(NSString *)name offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    NSDictionary *para = @{@"offset":@(offset)};
    [URL appendString:name];
    [URL appendString:TopicsURL];
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TopicModel* model = [TopicModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (NSURLSessionTask *)fetchNoticeGame:(NSString *)schoolCode offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    NSDictionary *para = @{@"offset":@(offset)};
    [URL appendString:schoolCode];
    [URL appendString:NoticeGameURL];
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameDetailResponseModel* model = [GameDetailResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

- (NSURLSessionTask *)fetchHistoryGame:(NSString *)schoolCode offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    NSDictionary *para = @{@"offset":@(offset)};
    [URL appendString:schoolCode];
    [URL appendString:HistoryGameURL];
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameDetailResponseModel* model = [GameDetailResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (NSURLSessionTask *)fetchGameList:(NSString *)schoolCode offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    NSDictionary *para = @{@"offset":@(offset)};
    [URL appendString:schoolCode];
    [URL appendString:GameListURL];
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameListResponseModel* model = [GameListResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
-(NSURLSessionTask *)fetchNewsDetail:(NSInteger)ide success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *para = @{@"id":@(ide)};
    return [self GET:NewDetailURL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NewsDetailResponseModel* model = [NewsDetailResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
@end

