//
//  NewsDetailResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NewsDetailResponseModel.h"

@implementation NewsDetailResponseModel

@end
@implementation NewsDetailModel

+ (NSDictionary *)objectClassInArray{
    return @{@"comments" : [Comments class]};
}
- (NSString*)getDate
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.dateCreated/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy.MM.dd";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}

- (NSString*)getInfo
{
    NSMutableString* info = [NSMutableString stringWithString:self.creator.nickname];
    [info appendString:@" / "];
    [info appendString:[self getDate]];
    return info;
}
@end


@implementation Comments

@end


@implementation Comment

@end




