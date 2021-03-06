//
//  DataArchive.h
//  SmartCommunity
//
//  Created by apple on 15/3/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataArchive : NSObject

/**
 *  功能:存档
 */
+ (void)archiveData:(id<NSCoding>)aData withFileName:(NSString *)aFileName;

/**
 *  功能:取档(第一次使用或版本更新时会清空数据)
 */
+ (id<NSCoding>)unarchiveDataWithFileName:(NSString *)aFileName;

/**
 *  功能:取档(获取系统数据，直接取档)
 */
+ (id<NSCoding>)unarchiveSystemDataWithFileName:(NSString *)aFileName;

@end
