//
//  XYDatabase.m
//  FMDBTest
//
//  Created by qingsong on 15/6/3.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//


#import <objc/runtime.h>
#import "XYDatabase.h"
#import "CreateTableSql.h"
#define RoadShow @"RoadShowDB.db"//sqlite

@implementation XYDatabase
@synthesize db;
static FMDatabase *_fmdb;
- (instancetype)init{
    
    self = [super init];
    if (self) {
        BOOL success;
       
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:RoadShow];
        db = [FMDatabase databaseWithPath:filePath];
        NSLog(@"%@",filePath);
        if ([db open]) {
            [db setShouldCacheStatements:YES];
            
            NSLog(@"Open success db !");
        }else {
            NSLog(@"Failed to open db!");
            success = NO;
        }
    }
    return self;
}

+ (void)initialize {
    // 执行打开数据库和创建表操作
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:RoadShow];
    _fmdb = [FMDatabase databaseWithPath:filePath];
    if ([_fmdb open]) {
        [_fmdb setShouldCacheStatements:YES];

    }else {
        
    }
}

- (NSString *)SQL:(NSString *)sql inTable:(NSString *)table{
    return [NSString stringWithFormat:sql,table];
}


+(void)addColumn:(id)model columnName:(NSString *)columnName
{
    NSString * sql;
    NSString *   tableName =  [NSString stringWithUTF8String:object_getClassName(model)];
    sql = [NSString stringWithFormat:@"alter table %@ add column %@ text",tableName,columnName];
    [_fmdb executeUpdate:sql];
}
//drop 删除
+(void)dropColumn:(id)model columnName:(NSString *)columnName
{
    NSString * sql;
    NSString *   tableName =  [NSString stringWithUTF8String:object_getClassName(model)];
    sql = [NSString stringWithFormat:@"alter table %@ drop column %@ text",tableName,columnName];
    [_fmdb executeUpdate:sql];
}


+ (void)createTable:(id)model
{
    NSString * sql;
    NSString *   tableName =  [NSString stringWithUTF8String:object_getClassName(model)];
    //啦啦
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([model class], &count);
    NSString * vlues = @"";
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        
        if (i == 0) {
            vlues = [NSString stringWithFormat:@"'%@'TEXT", [NSString stringWithUTF8String: propertyName]] ;
        }
        else
        {
            vlues = [NSString stringWithFormat:@"%@,'%@'TEXT",vlues, [NSString stringWithUTF8String: propertyName]];
        }
    }
    
    free(properties);
    
    if (![_fmdb tableExists:tableName]) {
        sql = [NSString stringWithFormat: @"CREATE TABLE IF NOT EXISTS '%@' ('index' INTEGER PRIMARY KEY AUTOINCREMENT,%@)  ",tableName,vlues];
        [_fmdb executeUpdate:sql];
        
        NSLog(@"表格创建成功");
    }
}

@end
