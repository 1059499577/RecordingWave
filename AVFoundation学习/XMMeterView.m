//
//  XMMeterView.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/12.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//


#import "XMMeterView.h"
@interface XMMeterView ()

@property (nonatomic, retain) UIBezierPath *path;
@property (nonatomic,assign) CGFloat currentX;


@end

@implementation XMMeterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 7;
        self.layer.masksToBounds = YES;
        [self setUI];
        self.currentX = 0;
    }
    return self;
}

- (void)setUI {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
}
- (void)clearAll {
    self.currentX = 0;
    self.backgroundColor = [UIColor blackColor];
}
-(void)drawRect:(CGRect)rect {
    _path = [[UIBezierPath alloc] init];
    _path.lineWidth = 0.5;
    self.currentX +=0.8;
    [_path moveToPoint:CGPointMake(self.currentX, 50)];
    [[UIColor whiteColor] setStroke];
    CGFloat Y = (self.model.peakLevel - _model.averageLevel) *50 + 50;
    CGFloat topY = -(self.model.peakLevel - _model.averageLevel) *50 + 50;
    [_path addLineToPoint:CGPointMake(self.currentX, Y)];
    [_path addLineToPoint:CGPointMake(self.currentX, topY)];
    [_path stroke];
}


@end
