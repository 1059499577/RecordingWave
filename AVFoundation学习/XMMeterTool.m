//
//  XMMeterTool.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/12.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//
#define MIN_DB -60.0f
#define TABLE_SIZE 300

#import "XMMeterTool.h"

@implementation XMMeterTool
{
    float _scaleFactor;
    NSMutableArray *_meterTable;

}

- (id)init {
    self = [super init];
    if (self) {
        float dbResolution = MIN_DB / (TABLE_SIZE - 1);
        
        _meterTable = [NSMutableArray arrayWithCapacity:TABLE_SIZE];
        _scaleFactor = 1.0f / dbResolution;
        
        float minAmp = dbToAmp(MIN_DB);
        float ampRange = 1.0 - minAmp;
        float invAmpRange = 1.0 / ampRange;
        
        for (int i = 0; i < TABLE_SIZE; i++) {
            float decibels = i * dbResolution;
            float amp = dbToAmp(decibels);
            float adjAmp = (amp - minAmp) * invAmpRange;
            _meterTable[i] = @(adjAmp);
        }
    }
    return self;
}

float dbToAmp(float dB) {
    return powf(10.0f, 0.05f * dB);
}

- (float)valueForPower:(float)power {
    if (power < MIN_DB) {
        return 0.0f;
    } else if (power >= 0.0f) {
        return 1.0f;
    } else {
        int index = (int) (power * _scaleFactor);
        return [_meterTable[index] floatValue];
    }
}

@end
