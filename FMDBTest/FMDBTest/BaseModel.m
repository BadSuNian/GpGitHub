//
//  BaseModel.m
//  FMDBTest
//
//  Created by qingsong on 15/6/3.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//

#import "BaseModel.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "MeModel.h"
#define CurrentTable @"MeTable"

@interface BaseModel ()
@end
@implementation BaseModel

- (id)init:(NSString *)tableName{
    self = [super init];
    if (self) {
        
//        if (![db tableExists:tableName]) {
//            NSString *sql = [self SQL:@"CREATE TABLE IF NOT EXISTS '%@' ('index' INTEGER PRIMARY KEY AUTOINCREMENT, 'personid' INTEGER);" inTable:tableName];
//            NSLog(@"%@",sql);
//            BOOL result = [db executeUpdate:sql];
//            if (result) {
//                NSLog(@"create success");
//            }
//        }
//        NSLog(@"db exists!");
//        [db close];
    }
    return self;
}
#pragma mark 找出所有的数据
- (NSMutableArray *)findBySQL:(NSString *)SQL table:(id)tableName{
    
    NSString * table = [NSString stringWithUTF8String:object_getClassName(tableName)];
    NSMutableArray *reslute = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableString *sql = [NSMutableString stringWithString:[self SQL:@"SELECT * FROM %@ " inTable:table]];
    if (SQL != nil) {
        [sql appendString:SQL];
    }
    [db open];
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next]) {
        
        u_int count;
        
        objc_property_t *properties  =class_copyPropertyList([tableName class], &count);
         NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];

        for (int i = 0; i < count ; i++)
        {
            const char* propertyName =property_getName(properties[i]);
            [dic setValue:[rs stringForColumn:[NSString stringWithUTF8String: propertyName]]  forKey:[NSString stringWithUTF8String: propertyName]];
        }
        id returnModel = [[[tableName class] alloc] init];
        [returnModel setValuesForKeysWithDictionary:dic];
        [reslute addObject:returnModel];
    }
   
    [rs close];
    [db close];
    if (!reslute || reslute.count <= 0) {
        return nil;
    }
    return reslute;
}

- (id)findFirstBySQL:(NSString *)SQL table:(id)tableName
{
    NSString * table = [NSString stringWithUTF8String:object_getClassName(tableName)];
    NSMutableArray *result = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableString *sql = [NSMutableString stringWithString:[self SQL:@"SELECT * FROM %@ " inTable:table]];
    if (SQL !=nil) {
        [sql appendString:SQL];
    }
    [db open];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        
        u_int count;
        
        objc_property_t *properties  =class_copyPropertyList([tableName class], &count);
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        
        for (int i = 0; i < count ; i++)
        {
            const char* propertyName =property_getName(properties[i]);
            [dic setValue:[rs stringForColumn:[NSString stringWithUTF8String: propertyName]]  forKey:[NSString stringWithUTF8String: propertyName]];
        }
        id returnModel = [[[tableName class] alloc] init];
        [returnModel setValuesForKeysWithDictionary:dic];
        [result addObject:returnModel];
        
        
    }
    [rs close];
    [db close];
    if ([result count]>0) {
        return [result objectAtIndex:0];
    }else {
        return nil;
    }
}

- (NSInteger)countBySQL:(NSString *)SQL table:(id)tableName
{
    NSString * table = [NSString stringWithUTF8String:object_getClassName(tableName)];
    NSInteger count = 0;
    NSMutableString *sql = [NSMutableString stringWithString:[self SQL:@"SELECT COUNT(*) FROM %@ " inTable:table]];
    if (SQL != nil) {
        [sql appendString:SQL];
    }
    NSLog(@"sql %@",sql);
    [db open];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next])
    {
        count = [rs intForColumnIndex:0];
    }
    [rs close];
    [db close];
    return count;
}

#pragma mark 插入数据
- (void)saveBySQL:(id)tableName
{
    NSString * table = [NSString stringWithUTF8String:object_getClassName(tableName)];
    //啦啦
    u_int count;
    
    objc_property_t *properties  =class_copyPropertyList([tableName class], &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    NSString * selname = @"";
    NSString * vlues = @"";
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        
        if (i == 0) {
            selname = [NSString stringWithUTF8String: propertyName];
            vlues = [NSString stringWithFormat:@"'%@'",[tableName valueForKey:[NSString stringWithUTF8String: propertyName]]] ;
        }
        else
        {
            selname =[NSString stringWithFormat:@"%@,%s",selname,propertyName];
            vlues = [NSString stringWithFormat:@"%@,'%@'",vlues,[tableName valueForKey:[NSString stringWithUTF8String: propertyName]]];
            [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
        }
    }
    
    free(properties);
    
    [db open];
    [db beginTransaction];
    NSString * insertSql = [NSString stringWithFormat:@"INSERT OR IGNORE INTO '%@' (%@) VALUES (%@)",table,selname,vlues];
    
    [db executeUpdate:insertSql];
    
    NSLog(@"%d",[db commit]);
    
    [db close];
}

/*
#pragma mark 保存多条数据
- (void)saveContacts:(NSArray *)contacts table:(NSString *)tableName{
    NSMutableArray *values = [[NSMutableArray alloc]init];
    for (MeModel *contact in contacts) {
        NSMutableString *value = [[NSMutableString alloc]initWithFormat:@"(%@)",personID];
        NSLog(@"%@",value);
        [values addObject:value];
    }
    if ([values count]>0) {
        [db open];
        [db beginTransaction];
        NSString *insertSql = [self SQL:@"INSERT OR IGNORE INTO '%@' ('personid') VALUES %@ " inTable:tableName];
        NSLog(@"%@",insertSql);
        NSString *compinentStr = [values componentsJoinedByString:@","];
        NSLog(@"%@",compinentStr);
        NSString *sqliteStr = [NSString stringWithFormat:@"%@%@",insertSql,[values componentsJoinedByString:@","]];
        NSLog(@"%@",sqliteStr);
        [db executeUpdate:sqliteStr];
        //[db executeUpdate:insertSql,[values componentsJoinedByString:@","]];
        [db commit];
        [db close];
    }
}
*/
/*
#pragma mark 更新当前的数据
- (BOOL)updateAtIndex:(int)index withContact:(MeModel *)contact table:(NSString *)tableName
{
    BOOL success = YES;
//    NSNumber *indexID = [[NSNumber alloc]initWithInt:contact.index];
    NSNumber *personID = [[NSNumber alloc]initWithInt:[contact.personid intValue]];
    [db open];
    [db executeUpdate:[self SQL:@"UPDATE %@ SET personid = ? WHERE 'index' = ?" inTable:tableName],personID,index];
    if ([db hadError]) {
        NSLog(@"Err %d: %@",[db lastErrorCode],[db lastErrorMessage]);
        success = NO;
    }
    [db close];
    return success;
}
*/
#pragma mark 更新当前的数据
- (BOOL)updateBySQL:(NSString *)SQL withContact:(id)tableName
{
    
    NSString * table = [NSString stringWithUTF8String:object_getClassName(tableName)];
    BOOL success = YES;
    [db open];
    // personid = ? WHERE 'index' = ?
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE %@ SET %@",table,SQL];
    [db executeUpdate:updateSQL];
    if ([db hadError]) {
        NSLog(@"Err %d: %@",[db lastErrorCode],[db lastErrorMessage]);
        success = NO;
    }else {
        [db clearCachedStatements];
    }
    [db close];
    return success;
}

/*
- (BOOL)deleteAtIndex:(int)index table:(NSString *)tableName{
    BOOL success = YES;
    [db open];
    [db executeUpdate:[self SQL:@"DELETE FROM %@ WHERE 'index' = ? " inTable:tableName],[NSNumber numberWithInt:index]];
    [db close];
    if ([db hadError]) {
        NSLog(@"Err %d: %@",[db lastErrorCode],[db lastErrorMessage]);
        success = NO;
    }else {
        [db clearCachedStatements];
    }
    return success;
}
 */
- (BOOL)deleteBySQL:(NSString *)SQL table:(id)tablename
{
    NSString * table = [NSString stringWithUTF8String:object_getClassName(tablename)];
    BOOL success = YES;
    [db open];
    NSString *delSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ ",table,SQL];
    [db executeUpdate:delSQL];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@",[db lastErrorCode],[db lastErrorMessage]);
        success = NO;
    }else {
        [db clearCachedStatements];
    }
    [db close];
    return success;
}
@end
