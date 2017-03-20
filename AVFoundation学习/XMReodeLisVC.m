//
//  XMReodeLisVC.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/11.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMReodeLisVC.h"
#import "XMCell.h"
#import "XMPlayerVC.h"
#import "XMFileTool.h"
#

@interface XMReodeLisVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataSource;
}

@end

@implementation XMReodeLisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[XMFileTool shareInstance] getAllSounds];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMCell *cell =[XMCell cellWithTableView:tableView model:_dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XMSound *model = _dataSource[indexPath.row];
    XMPlayerVC *VC = [[XMPlayerVC alloc] init];
    VC.sound = model;
    [self presentViewController:VC animated:YES completion:^{
        
    }];
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath{
    return @"删除录音";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    XMSound *sound = _dataSource[indexPath.row];
    [[XMFileTool shareInstance] deleteSound:sound];
    [_dataSource removeObject:sound];
    [_tableView beginUpdates];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
    [_tableView endUpdates];
    
}


@end
