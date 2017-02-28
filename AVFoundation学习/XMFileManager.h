//
//  XMFileManager.h
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/11.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#import <Foundation/Foundation.h>

@interface XMFileManager : NSObject
@property (nonatomic, retain) NSURL *tempUrl;

- (NSURL *)getNewPathUrl;
- (NSArray *)getLocalList;


+ (instancetype)shareInstance;
@end
