//
//  XMCell.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/11.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMCell.h"

@implementation XMCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView model:(XMModel*)model {
    XMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMCell"];
    NSLog(@"%@",model);
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"XMCell" owner:self options:nil] lastObject];
    }
    cell.timeLabel.text = model.time;
    cell.titleLabel.text = model.name;
    cell.sizeLabel.text = model.size;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
