//
//  XMMeterModel.h
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/12.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMMeterModel : NSObject

@property (nonatomic,assign)float averageLevel;
@property (nonatomic,assign)float peakLevel;
+ (instancetype)meterWithAverage:(float)average peak:(float)peak;

@end
