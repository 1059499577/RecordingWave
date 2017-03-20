//
//  XMSound.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/3/16.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMSound.h"

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

@implementation XMSound

+(NSString *)primaryKey {
    return @"SoundID";
}
+(NSArray<NSString *> *)ignoredProperties {
    return @[@"formatTime",@"formatSize",@"formateDate",@"fileFullPath"];
}
-(NSString *)formatTime {
    int intTime = (int)self.time;
    int seconde = intTime % 60;
    int min = (intTime / 60)% 60;
    int hour = (intTime / 360)% 60;
    return  [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,seconde];
}

- (NSString *)formateDate {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return  [formater stringFromDate:self.createDate];
}
- (NSString *)formatSize {
    if (self.size < 1024) {
        return [NSString stringWithFormat:@"%ldB",self.size];
    } else if (self.size < 1024 * 1024) {
        return [NSString stringWithFormat:@"%0.1fK",self.size/1024.0];
    } else {
        
    }return [NSString stringWithFormat:@"%0.1fM",self.size/(1024.0 * 1024.0)];
}
- (NSString *)fileFullPath {
   return  [NSString stringWithFormat:@"%@/%@",kDocumentPath,self.filePath];
}
@end
