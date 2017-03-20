//
//  XMFileTool.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/3/20.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMFileTool.h"
#import <Realm.h>
@interface XMFileTool()

@property (nonatomic, copy) NSString *myFile;//保存录音的文件夹
@property (nonatomic, assign) int lastIndex;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *lastPath;

@end
@implementation XMFileTool


+(instancetype)shareInstance {
    static XMFileTool* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[XMFileTool alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.myFile = [NSString stringWithFormat:@"%@/myRecoder",kDocumentPath];
        BOOL isDirectory = NO;
        BOOL isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:self.myFile isDirectory:&isDirectory];
        if (isFileExist == NO) {
            [[NSFileManager defaultManager] createDirectoryAtPath:self.myFile withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}
- (BOOL)deleteCurrentSound {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:self.tempUrl.path error:&error];
    return error == nil;
}
/* 保存当前录音 */
- (BOOL)saveCurrentSound {
    self.lastName = [self getNewName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    _lastPath = [NSString stringWithFormat:@"%@/%@.caf",self.myFile,self.lastName];
    NSURL *newUrl = [NSURL fileURLWithPath:_lastPath];
    NSError *error = nil;
    [fileManager copyItemAtURL:self.tempUrl toURL:newUrl  error:&error];
    if (error == nil) {
        [fileManager removeItemAtPath:self.tempUrl.path error:nil];
    } else {
        return NO;
    }
    /* 把这个记录添加到数据库 */
    RLMRealm *realm = [RLMRealm defaultRealm];
    XMSound *sound = [[XMSound alloc] init];
    sound.SoundID = self.lastIndex;
    sound.name = self.lastName;
    sound.filePath = [NSString stringWithFormat:@"myRecoder/%@.caf",self.lastName];
    NSDictionary *dict = [fileManager attributesOfItemAtPath:self.lastPath error:nil];
    sound.size = [dict[@"NSFileSize"] longValue];
    sound.createDate = dict[@"NSFileCreationDate"];
    [realm transactionWithBlock:^{
        [realm addObject:sound];
    }];
    return YES;
}
- (NSMutableArray<XMSound *>*)getAllSounds {
       RLMResults *results = [XMSound allObjects];
    NSMutableArray *array = [NSMutableArray new];
    for (XMSound *sound in results) {
        [array addObject:sound];
    }
    return array;
    
}
/* 删除某个录音文件，包括数据库 */
- (BOOL)deleteSound:(XMSound *)sound {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:sound.fileFullPath error:&error];
    if (error == nil) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm deleteObject:sound];
        }];
        return YES;
    } else {
        NSLog(@"删除失败");
        return NO;
    }
}


/* 获取一个新名字 */
- (NSString *)getNewName {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSInteger lastNumber = [def integerForKey:@"kLastNumber"];
    self.lastIndex = (int)lastNumber;
    NSString *newName = [NSString stringWithFormat:@"第%ld次录音",lastNumber + 1];
    [def setInteger:lastNumber +1 forKey:@"kLastNumber"];
    [def synchronize];
    return newName;
}

- (NSURL *)tempUrl {
    if (!_tempUrl) {
        NSString *loadingPath = [NSString stringWithFormat:@"%@/downLoading",kDocumentPath];
        BOOL isDirectory = NO;
        BOOL isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:loadingPath isDirectory:&isDirectory];
        if (isFileExist == NO) {
            [[NSFileManager defaultManager] createDirectoryAtPath:loadingPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *tmpFilePath = [loadingPath stringByAppendingPathComponent:@"temp.caf"];
        _tempUrl = [NSURL fileURLWithPath:tmpFilePath];
    }
    return _tempUrl;
}
@end
