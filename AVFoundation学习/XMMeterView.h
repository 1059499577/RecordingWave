//
//  XMMeterView.h
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/12.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMMeterModel.h"

@interface XMMeterView : UIView

@property (nonatomic, retain)XMMeterModel *model;
- (void)clearAll;

@end
