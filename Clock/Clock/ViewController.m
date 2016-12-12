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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //图层初始化
//    CALayer *layer = [CALayer layer];
//    [self.view.layer addSublayer:layer];
    CGPoint centerPoint = self.imageView.center;
    
    //设置指针
    UIView *viewSecond = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 100)];
    _viewSecond = viewSecond;
    viewSecond.layer.anchorPoint = CGPointMake(0.5,1);
    viewSecond.center = centerPoint;
    [viewSecond setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:viewSecond];
    [self fire];
    
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
    //截取一部分时间
    NSDateComponents *components = [calender components:NSCalendarUnitSecond fromDate:currentDate];
    NSInteger second = components.second;
    
    //设置弧度
    //转换一秒=多少弧度
    CGFloat radian =  2*M_PI/60;
    radian = radian*second;
    self.viewSecond.transform = CGAffineTransformMakeRotation(radian);
    
    
}

@end
