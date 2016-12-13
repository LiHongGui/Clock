//
//  ViewController.m
//  Clock
//
//  Created by lihonggui on 2016/12/12.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong) UIView *viewSecond;
@property(nonatomic,strong) UIView *viewMinute;
@property(nonatomic,strong) UIView *viewHour;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //图层初始化
//    CALayer *layer = [CALayer layer];
//    [self.view.layer addSublayer:layer];
    CGPoint centerPoint = self.imageView.center;
    
    //设置时针
    UIView *viewHour = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 70)];
    _viewHour = viewHour;
    viewHour.center = self.imageView.center;
    viewHour.layer.anchorPoint = CGPointMake(0.5, 1);
    [viewHour setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:viewHour];
    //设置分针
    UIView *viewMinute = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 3, 90)];
    _viewMinute = viewMinute;
    viewMinute.layer.anchorPoint = CGPointMake(0.5, 1);
    [viewMinute setBackgroundColor:[UIColor blackColor]];
    viewMinute.center = self.imageView.center;
    [self.view addSubview:viewMinute];

    //设置秒针
    UIView *viewSecond = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 120)];
    _viewSecond = viewSecond;
    viewSecond.layer.anchorPoint = CGPointMake(0.5,1);
    viewSecond.center = centerPoint;
    [viewSecond setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:viewSecond];
    
    
    
    
    //定时器:1
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(fire) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
//    [timer fire];
    
    
    //定时器:2
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fire)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)fire
{
    //当前日历
    NSCalendar *calender = [NSCalendar currentCalendar];
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSLog(@"currentDate%@",currentDate);
    //截取一部分时间----秒
    NSDateComponents *componentSecond = [calender components:NSCalendarUnitSecond fromDate:currentDate];
    NSInteger second = componentSecond.second;
    //截取一部分时间----分
    NSDateComponents *componentMinute = [calender components:NSCalendarUnitMinute fromDate:currentDate];
    NSInteger minute = componentMinute.minute;
    //截取一部分时间----小时
    NSDateComponents *componentHour =[calender components:NSCalendarUnitHour fromDate:currentDate];
    NSInteger hour = componentHour.hour;
    /*******秒******/
    //设置弧度
    CGFloat radianSecond = 2*M_PI/60.0;
    CGFloat radianMinute = 2*M_PI/60.0;
    CGFloat radianHour = 2*M_PI/12.0;
    //转换一秒=多少弧度
   CGFloat radianSec = radianSecond*second;
    self.viewSecond.transform = CGAffineTransformMakeRotation(radianSec);
    /*******分******/
    CGFloat radianMin = minute*radianMinute+ radianSecond/60.0;
//    CGFloat radianMinute = radian*60*60;
    self.viewMinute.transform = CGAffineTransformMakeRotation(radianMin);
    /*******小时******/
    CGFloat radianHou = hour *radianHour+ radianMin/12;
    self.viewHour.transform = CGAffineTransformMakeRotation(radianHou);
    
}

@end
