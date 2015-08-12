//
//  CreateTableSql.h
//  FMDBTest
//
//  Created by qingsong on 15/6/3.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//

#ifndef FMDBTest_CreateTableSql_h

//    [_fmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS t_modals(id INTEGER PRIMARY KEY, name TEXT NOT NULL, age INTEGER NOT NULL, ID_No INTEGER NOT NULL);"];

//CREATE TABLE IF NOT EXISTS '%@' ('index' INTEGER PRIMARY KEY AUTOINCREMENT, 'personid' INTEGER);
//#define MeModelTable1 @"CREATE TABLE IF NOT EXISTS %@(id INTEGER PRIMARY KEY, name TEXT NOT NULL, sex INTEGER NOT NULL, school INTEGER NOT NULL , my_ages TEXT not null , avatar text not null , bigAvatar text not null , year text not null , age text not null , index INTEGER not null , personid INTEGER not null , ID_No text not null)"

//#define MeModelTable1 @"CREATE TABLE IF NOT EXISTS MeModelTable('index' INTEGER PRIMARY KEY, person_id INTEGER,name TEXT, sex TEXT,school TEXT,my_ages TEXT,avatar TEXT,bigAvatar TEXT,year TEXT,age INTEGER, ID_No INTEGER;"

#define MeModelTable1 @"CREATE TABLE IF NOT EXISTS 'MeModel' ('index' INTEGER PRIMARY KEY AUTOINCREMENT,'index_Me' TEXT, 'personid' TEXT, 'name' TEXT, 'sex' TEXT, 'school' TEXT , 'my_ages' TEXT, 'avatar' TEXT,'bigAvatar' TEXT,'age' TEXT);"


#define MeModelTable2 @"CREATE TABLE IF NOT EXISTS %@('id' INTEGER PRIMARY KEY, 'name' TEXT NOT NULL, 'haha2' INTEGER NOT NULL, 'ID_No' INTEGER NOT NULL , 'sex_2' TEXT not null , 'school_2' text not null , 'my_ages_2' text not null);"

#define MeModelTable3 @"CREATE TABLE IF NOT EXISTS %@(id INTEGER PRIMARY KEY, name TEXT NOT NULL, age_3 INTEGER NOT NULL, ID_No_3 INTEGER NOT NULL , sex_3 TEXT not null , school_3 text not null , my_ages_3 text not null);"


#define FMDBTest_CreateTableSql_h


#endif
