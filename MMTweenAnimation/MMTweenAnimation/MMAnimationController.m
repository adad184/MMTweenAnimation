//
//  MMAnimationController.m
//  MMTweenAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "MMAnimationController.h"
#import "MMPaintView.h"
#import <Masonry/Masonry.h>
#import "MMTweenAnimation.h"

@interface MMAnimationController ()

@property (nonatomic, strong) MMPaintView *paintView;
@property (nonatomic, strong) UIView *dummy;
@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) MMTweenAnimation *anim;

@end

@implementation MMAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@ - %@",[MMTweenFunction sharedInstance].functionNames[self.functionType],[MMTweenFunction sharedInstance].easingNames[self.easingType]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.paintView = [[MMPaintView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.paintView];
    [self.paintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.paintView.backgroundColor = [UIColor whiteColor];
    
    self.dummy = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.dummy.layer.cornerRadius = 15.0f;
    self.dummy.backgroundColor = [UIColor darkGrayColor];
    self.dummy.center = CGPointMake(CGRectGetMaxX([UIScreen mainScreen].bounds)-50, 150);
    
    UIView *centerMark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self.dummy addSubview:centerMark];
    centerMark.backgroundColor = [UIColor redColor];
    centerMark.layer.cornerRadius = 5.0f;
    centerMark.center = CGPointMake(15.0f, 15.0f);
    
    [self.paintView addSubview:self.dummy];
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.ball.layer.cornerRadius = 5.0f;
    self.ball.backgroundColor = [UIColor redColor];
    self.ball.center = CGPointMake(CGRectGetMinX([UIScreen mainScreen].bounds)+50, 150);
    
    [self.paintView addSubview:self.ball];
    
    
    __weak __typeof(&*self)ws = self;
    
    self.anim = [MMTweenAnimation animation];
    self.anim.functionType   = self.functionType;
    self.anim.easingType     = self.easingType;
    self.anim.duration       = 2.0f;
    self.anim.fromValue      = self.dummy.center.y;
    self.anim.toValue        = self.anim.fromValue + 200;
    self.anim.animationBlock = ^(double c,double d,double v,id target,MMTweenAnimation *animation)
    {
        ws.dummy.center = CGPointMake(ws.dummy.center.x, v);
        ws.ball.center = CGPointMake(50+(CGRectGetWidth([UIScreen mainScreen].bounds)-150)*(c/d), v);
        
        [ws.paintView addDot:ws.ball.center];
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.paintView clearPaint];
    [self.dummy pop_addAnimation:self.anim forKey:@"center"];
}

- (void)dealloc
{
    [self.dummy pop_removeAllAnimations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
