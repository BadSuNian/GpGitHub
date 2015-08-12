//
//  XYDatabase.h
//  FMDBTest
//
//  Created by qingsong on 15/6/3.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class FMDatabase;
@interface XYDatabase : NSObject
{
    FMDatabase * db;

}

@property(nonatomic,strong)    FMDatabase * db;
- (NSString * )SQL:(NSString *)sql inTable:(NSString *)table;
+ (void)createTable:(id)model;
//加一列 （新增表的属性）
+(void)addColumn:(id)model columnName:(NSString *)columnName;

//drop 删除一列
+(void)dropColumn:(id)model columnName:(NSString *)columnName;

@end
