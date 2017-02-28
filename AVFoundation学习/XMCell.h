//
//  XMCell.h
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/11.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMModel.h"

@interface XMCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
+ (instancetype)cellWithTableView:(UITableView*)tableView model:(XMModel*)model;

@end
