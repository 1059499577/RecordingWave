//
//  XMFileTool.h
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/3/20.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMSound.h"


#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

@interface XMFileTool : NSObject

@property (nonatomic, retain) NSURL *tempUrl;

+ (instancetype)shareInstance;

/* 保存当前录音 */
-(BOOL)saveCurrentSound;

/* 删除当前录音 */
- (BOOL)deleteCurrentSound;

/* 获取都有录音 */
- (NSMutableArray<XMSound *>*)getAllSounds;

/* 删除某个 */
- (BOOL)deleteSound:(XMSound *)sound;

@end
