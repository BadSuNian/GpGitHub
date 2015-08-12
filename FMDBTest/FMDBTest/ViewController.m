//
//  ViewController.m
//  FMDBTest
//
//  Created by qingsong on 15/6/3.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//

#import "ViewController.h"
#import "MeModel.h"

#import "BaseModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [XYDatabase createTable:@"MeModel"];
    
    MeModel * memo = [[MeModel alloc] init];
   
    [XYDatabase createTable:memo];
    
//    [XYDatabase addColumn:memo columnName:@"勺子"]; 增加一列
//    [XYDatabase dropColumn:memo columnName:@"勺子"]; //删除一列
//    memo.personid = @"110";
//    memo.name = @"qingsong";
//    memo.school = @"北京大学";
//    memo.age = @"2013";
//    memo.sex = @"10010";
//    memo.my_ages = @"25";
//    memo.avatar = @"www.baidu.com";
//    memo.bigAvatar = @"baidu.com";
    
//    BaseModel *tempContact = [[BaseModel alloc]init];
////    插入数据的方法
//    [tempContact  saveBySQL:memo];
//    
////    查找一条数据的方法
////  MeModel * meModel = (MeModel *)[tempContact findFirstByModel:@"where sex = '23'" table:memo];
//    
//    NSMutableArray * mutArray =     [tempContact findBySQL:@"where sex = '10010'" table:memo];
//    NSLog(@"muarray     %lu",(unsigned long)mutArray.count);
////    查找数据Count的方法
//   NSInteger mm = [tempContact countBySQL:@"where sex = '10010'" table:memo];
//    NSLog(@"mm  %ld",(long)mm);
//    
//    NSString * upSQL = [NSString stringWithFormat:@"name = '%@' where personid = %@",@"wangshuai",@"110"];
//    //更新数据的方法   personid = ? WHERE 'index' = ?
//    [tempContact updateBySQL:upSQL withContact:memo];
//    
////    删除数据的方法
//    [tempContact deleteBySQL:@"sex = '222'" table:memo];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
