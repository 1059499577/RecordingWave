//
//  XMFileManager.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/11.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMFileManager.h"
#import "XMModel.h"

@interface XMFileManager ()
@property (nonatomic,copy) NSString *myFile;
@end

@implementation XMFileManager
+(instancetype)shareInstance {
    static XMFileManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[XMFileManager alloc] init];
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
- (NSArray *)getLocalList {
    NSFileManager *fm = [NSFileManager defaultManager];
    //使用递归的方式 获取当前目录及子目录下的所有的文件及文件夹
    NSArray *subPaths = [fm subpathsAtPath:self.myFile];
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i<subPaths.count; i++) {
        NSString *name = subPaths[i];
       NSDictionary *dict = [fm attributesOfItemAtPath:[self.myFile stringByAppendingPathComponent:name] error:nil];
        XMModel *model = [[XMModel alloc] init];
        model.name = name;
        NSDate *time = dict[@"NSFileCreationDate"];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        model.time = [formater stringFromDate:time];
        NSNumber *size = dict[@"NSFileSize"];
        int intSize = [size intValue];
        
        model.filePath = [self.myFile stringByAppendingPathComponent:name];
        if (intSize < 1024) {
            model.size = [NSString stringWithFormat:@"%dB",intSize];
        } else if (intSize < 1024*1024) {
            model.size = [NSString stringWithFormat:@"%dk",intSize/(1024)];
        } else {
            model.size = [NSString stringWithFormat:@"%dk",intSize/(1024*1024)];
        }
        [dataSource addObject:model];
    }
    return dataSource;

}
- (NSURL *)getNewPathUrl {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSInteger lastNumber = [def integerForKey:@"kLastNumber"];
    NSString *path = [NSString stringWithFormat:@"%@/myRecoder/第%ld条录音.caf",kDocumentPath,lastNumber + 1];
    [def setInteger:lastNumber +1 forKey:@"kLastNumber"];
    [def synchronize];
    return [NSURL fileURLWithPath:path];
}
- (NSURL *)tempUrl {
    if (!_tempUrl) {
        NSString *tmpFile = NSTemporaryDirectory();
        NSString *tmpFilePath = [tmpFile stringByAppendingPathComponent:@"temp.caf"];
        _tempUrl = [NSURL fileURLWithPath:tmpFilePath];
    }
    return _tempUrl;
}
@end
