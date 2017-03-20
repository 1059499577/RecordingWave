//
//  XMSound.h
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/3/16.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <Realm/Realm.h>

@interface XMSound : RLMObject

@property int SoundID;//主键
@property NSString *name;
@property int time;//单位为秒
@property NSString *filePath;//存储路径
@property long size;
@property NSDate *createDate;
@property (nonatomic, copy, readonly) NSString *formatTime;
@property (nonatomic, copy, readonly) NSString *formatSize;
@property (nonatomic, copy, readonly) NSString *formateDate;
@property (nonatomic, copy,) NSString *fileFullPath;

@end
