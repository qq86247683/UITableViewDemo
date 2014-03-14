//
//  ViewController.m
//  UITableViewDemo
//
//  Created by 刘杨 on 13-12-3.
//  Copyright (c) 2013年 刘杨. All rights reserved.
//

#import "ViewController.h"
#import "DataBase.h"
#import "AppDelegate.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    DataBase *dataBase;
    
    NSMutableDictionary *_dic;
    NSIndexPath *_indexPath;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    dataBase = [[DataBase alloc]init];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 320, 460) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _indexPath = [_tableView indexPathForSelectedRow];
    NSLog(@"%d",_indexPath.row);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataBase.dataArray.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_tableView]) {
                
        NSString *string = [[NSString alloc]initWithFormat:@"%d",section];
        
        return string;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LY"];
    
    if (cell == nil) {
       
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LY"];
    }
    
    NSLog(@"indexPath.row = %d ----- _indexPath.row = %d",indexPath.row,_indexPath.row);
   
    if (indexPath.row == _indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = [dataBase.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    _indexPath = indexPath;
    
    NSLog(@"选择以后的cell %d",_indexPath.row);
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    if (cell.accessoryType == UITableViewCellAccessoryNone) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else if(cell.accessoryType == UITableViewCellAccessoryCheckmark){
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.9 green:0.6 blue:0.4 alpha:0.8]];
    }
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    
    if ([tableView isEqual:_tableView]) {
        result = UITableViewCellEditingStyleDelete;
    }
    
    return result;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [_tableView setEditing:editing animated:animated];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        [[dataBase.dataArray objectAtIndex:indexPath.section]removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
     
    }
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
