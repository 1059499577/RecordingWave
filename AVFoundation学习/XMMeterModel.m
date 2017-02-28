//
//  XMMeterModel.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/12.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMMeterModel.h"

@implementation XMMeterModel

+(instancetype)meterWithAverage:(float)average peak:(float)peak {
    XMMeterModel *model = [[XMMeterModel alloc] init];
    model.averageLevel = average;
    model.peakLevel = peak;
    return model;
}
@end
