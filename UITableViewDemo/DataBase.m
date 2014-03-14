//
//  DataBase.m
//  UITableViewDemo
//
//  Created by 刘杨 on 13-12-3.
//  Copyright (c) 2013年 刘杨. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase

- (id)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc]initWithObjects:@"sfe",@"dese",@"ssfese",@"ssfesdf", nil];
    }
    return self;
}

@end
