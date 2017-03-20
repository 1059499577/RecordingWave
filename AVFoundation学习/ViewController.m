//
//  ViewController.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/9.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width



#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "XMReodeLisVC.h"
#import "XMMeterTool.h"
#import "XMMeterModel.h"
#import "XMMeterView.h"
#import "XMFileTool.h"

@interface ViewController ()

@property (nonatomic, retain) AVAudioRecorder *recoder;
@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval recodeTime;
@property (nonatomic,retain) XMMeterTool *meterTool;
@property (nonatomic, retain) XMMeterView *meterView;
@property (nonatomic, retain) CADisplayLink *link;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.waveBgView.layer.cornerRadius = 10;
    self.waveBgView.layer.masksToBounds = YES;
    [self.waveBgView addSubview:self.meterView];
    [self.recoder prepareToRecord];
    self.recodeTime = 0;
    
}

- (void)startUpdateMeter {
    _link=[CADisplayLink displayLinkWithTarget:self selector:@selector(getWave)];
    _link.frameInterval = 3;
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopUpDateMeter {
    [_link invalidate];
    _link = nil;
}

- (void)getWave {
    [self.recoder updateMeters];
    float average =  [_recoder averagePowerForChannel:0];
    float peak = [_recoder peakPowerForChannel:0];
    float averageLevel = [self.meterTool valueForPower:average];
    float peakLevel = [self.meterTool valueForPower:peak];
    XMMeterModel *model = [XMMeterModel meterWithAverage:averageLevel peak:peakLevel];
    self.meterView.model = model;
    [self.meterView setNeedsDisplay];
}

#pragma mark - Private
/* 保存当前录音文件 */
- (void)saveCurrentRecodeData {
    [[XMFileTool shareInstance] saveCurrentSound];
}

#pragma mark -Actoin Event
- (IBAction)startButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.deleteButton.enabled = NO;
        [self.deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.saveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.saveButton.enabled = NO;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.recoder record];
        [self startUpdateMeter];
    } else {
        self.deleteButton.enabled = YES;
        self.saveButton.enabled = YES;
        [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timer invalidate];
        
        [self stopUpDateMeter];
        [self.recoder pause];
    }
}

- (void)timerRun {
    self.recodeTime ++;
}

- (IBAction)deleteAction:(UIButton *)sender {
    [self.recoder stop];
   BOOL success = [[XMFileTool shareInstance] deleteCurrentSound];
    if (success) {
        self.recodeTime = 0;
        [self reloadMeterView];
    }
}

- (IBAction)saveAction:(id)sender {
    [self.recoder stop];
    if (self.recodeTime > 1) {
        [self saveCurrentRecodeData];
        self.recodeTime = 0;
    }
     [self reloadMeterView];
}

- (IBAction)jumpToList:(id)sender {
    XMReodeLisVC *VC = [[XMReodeLisVC alloc] init];
    [self presentViewController:VC animated:YES completion:^{
        
    }];
}

- (void)reloadMeterView {
    [self.meterView removeFromSuperview];
    self.meterView = nil;
    [self.waveBgView addSubview:self.meterView];
}

#pragma mark - Geter & setter

- (AVAudioRecorder *)recoder {
    if (!_recoder) {
        NSDictionary *setting = @{
                                  AVFormatIDKey : @(kAudioFormatAppleIMA4),
                                  AVSampleRateKey : @44100.0f,
                                  AVNumberOfChannelsKey : @1,
                                  AVEncoderBitDepthHintKey : @16,
                                  AVEncoderAudioQualityKey : @(AVAudioQualityMedium)
                                  };
        _recoder = [[AVAudioRecorder alloc] initWithURL:[XMFileTool shareInstance].tempUrl settings:setting error:nil];
        _recoder.meteringEnabled = YES;
    }
    return _recoder;
}

- (void)setRecodeTime:(NSTimeInterval)recodeTime {
    _recodeTime = recodeTime;
    int intTime = (int)recodeTime;
    int seconde = intTime % 60;
    int min = (intTime / 60)% 60;
    int hour = (intTime / 360)% 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,seconde];
}

- (XMMeterTool *)meterTool {
    if (!_meterTool) {
        _meterTool = [[XMMeterTool alloc] init];
    }
    return _meterTool;
}
- (XMMeterView *)meterView {
    if (!_meterView) {
        _meterView = [[XMMeterView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth - 50 , 100)];
    }
    return _meterView;
}

@end
