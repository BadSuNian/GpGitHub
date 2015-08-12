//
//  BaseModel.h
//  FMDBTest
//
//  Created by qingsong on 15/6/3.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "XYDatabase.h"
#import <objc/runtime.h>

@class MeModel;
@interface BaseModel : XYDatabase

- (id)init:(NSString *)tableName;

// SELECT 找到所有的数据
- (NSMutableArray *)findBySQL:(NSString *)SQL table:(id)tableName;

//根据条件搜索，找到最新的那条数据
- (id)findFirstBySQL:(NSString *)SQL table:(id)tableName;

//找到对应数据的条数
- (NSInteger)countBySQL:(NSString *)SQL table:(id)tableName;

// INSERT   插入新数据
- (void)saveBySQL:(id)tableName;

//更新数据
- (BOOL)updateBySQL:(NSString *)SQL withContact:(id)tableName;

//删除数据
- (BOOL)deleteBySQL:(NSString *)SQL table:(id)tablename;

@end
