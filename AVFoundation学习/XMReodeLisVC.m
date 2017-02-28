//
//  XMReodeLisVC.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/11.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMReodeLisVC.h"
#import "XMFileManager.h"
#import "XMCell.h"
#import "XMPlayerVC.h"

@interface XMReodeLisVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataSource;
}

@end

@implementation XMReodeLisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[XMFileManager shareInstance] getLocalList];
    // Do any additional setup after loading the view from its nib.
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
    XMModel *model = _dataSource[indexPath.row];
    XMPlayerVC *VC = [[XMPlayerVC alloc] init];
    VC.model = model;
    [self presentViewController:VC animated:YES completion:^{
        
    }];
    
}

@end
