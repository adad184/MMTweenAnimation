//
//  MMTweenFunction.m
//  MMTweenAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "MMTweenFunction.h"

static MMTweenFunction *sharedFunction = nil;

@interface MMTweenFunction ()

@property (nonatomic, strong) NSArray *functionTable;
@property (nonatomic, strong) NSArray *functionNames;
@property (nonatomic, strong) NSArray *easingNames;

@end

@implementation MMTweenFunction

+ (void)load {
    MMTweenFunction *func = [MMTweenFunction sharedInstance];
    
    [func setupBlocks];
}

+ (instancetype)sharedInstance {
    @synchronized(self)
    {
        if (sharedFunction == nil) {
            sharedFunction = [[self alloc] init];
        }
    }
    return sharedFunction;
}

+ (MMTweenFunctionBlock)blockWithFunctionType:(MMTweenFunctionType)functionType easingType:(MMTweenEasingType)easingType {
    return nil;
}

- (void)setupBlocks {
    //MMTweenFunctionBack
    MMTweenFunctionBlock blockBackIn = ^(double t, double b, double c, double d)
    {
        double s = 1.70158;
        t /= d;
        return c * t * t * ((s + 1) * t - s) + b;
    };
    
    MMTweenFunctionBlock blockBackOut = ^(double t, double b, double c, double d)
    {
        double s = 1.70158;
        t = t / d - 1;
        return c * (t * t * ((s + 1) * t + s) + 1) + b;
    };
    
    MMTweenFunctionBlock blockBackInOut = ^(double t, double b, double c, double d)
    {
        double s = 1.70158;
        double k = 1.525;
        t /= d / 2;
        s *= k;
        if (t < 1) {
            return c / 2 * (t * t * ((s + 1) * t - s)) + b;
        }
        else {
            t -= 2;
            return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b;
        }
    };
    
    //MMTweenFunctionBounce
    MMTweenFunctionBlock blockBounceOut = ^(double t, double b, double c, double d)
    {
        double k = 2.75;
        if ((t /= d) < (1 / k)) {
            return c * (7.5625 * t * t) + b;
        }
        else if (t < (2 / k)) {
            t -= 1.5 / k;
            return c * (7.5625 * t * t + .75) + b;
        }
        else if (t < (2.5 / k)) {
            t -= 2.25 / k;
            return c * (7.5625 * t * t + .9375) + b;
        }
        else {
            t -= 2.625 / k;
            return c * (7.5625 * t * t + .984375) + b;
        }
    };
    
    MMTweenFunctionBlock blockBounceIn = ^(double t, double b, double c, double d)
    {
        return c - blockBounceOut(d - t, 0, c, d) + b;
    };
    
    MMTweenFunctionBlock blockBounceInOut = ^(double t, double b, double c, double d)
    {
        if (t < d * .5) {
            return blockBounceIn(t * 2, 0, c, d) * .5 + b;
        }
        else {
            return blockBounceOut(t * 2 - d, 0, c, d) * .5 + c * .5 + b;
        }
    };
    
    //MMTweenFunctionCirc
    MMTweenFunctionBlock blockCircIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return -c * (sqrt(1 - t * t) - 1) + b;
    };
    
    MMTweenFunctionBlock blockCircOut = ^(double t, double b, double c, double d)
    {
        t = t / d - 1;
        return c * sqrt(1 - t * t) + b;
    };
    
    MMTweenFunctionBlock blockCircInOut = ^(double t, double b, double c, double d)
    {
        t /= (d/2);
        if (t <= 1) {
            return -c / 2 * (sqrt(1 - t * t) - 1) + b;
        }
        else {
            t -= 2;
            return c / 2 * (sqrt(1 - t * t) + 1) + b;
        }
    };
    
    
    //MMTweenFunctionCubic
    MMTweenFunctionBlock blockCubicIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t * t + b;
    };
    
    MMTweenFunctionBlock blockCubicOut = ^(double t, double b, double c, double d)
    {
        t = t / d - 1;
        return c * (t * t * t + 1) + b;
    };
    
    MMTweenFunctionBlock blockCubicInOut = ^(double t, double b, double c, double d)
    {
        t /= d / 2;
        if (t < 1) {
            return c / 2 * t * t * t + b;
        }
        
        t -= 2;
        return c / 2 * (t * t * t + 2) + b;
    };
    
    
    //MMTweenFunctionElastic
    MMTweenFunctionBlock blockElasticIn = ^(double t, double b, double c, double d)
    {
        double s = 1.70158;
        double p = 0;
        double a = c;
        if (t == 0) {
            return b;
        }
        if ((t /= d) == 1) {
            return b + c;
        }
        if (!p) {
            p = d * .3;
        }
        if (a < fabs(c)) {
            a = c; s = p / 4;
        }
        else {
            s = p / (2 * 3.1419) * asin(c / a);
        }
        t--;
        return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * 3.1419) / p)) + b;
    };
    
    MMTweenFunctionBlock blockElasticOut = ^(double t, double b, double c, double d)
    {
        double s = 1.70158;
        double p = 0;
        double a = c;
        if (t == 0) {
            return b;
        }
        if ((t /= d) == 1) {
            return b + c;
        }
        if (!p) {
            p = d * .3;
        }
        if (a < fabs(c)) {
            a = c; s = p / 4;
        }
        else {
            s = p / (2 * 3.1419) * asin(c / a);
        }
        return a * pow(2, -10 * t) * sin((t * d - s) * (2 * 3.1419) / p) + c + b;
    };
    
    MMTweenFunctionBlock blockElasticInOut = ^(double t, double b, double c, double d)
    {
        double s = 1.70158;
        double p = 0;
        double a = c;
        if (t == 0) {
            return b;
        }
        if ((t /= d / 2) == 2) {
            return b + c;
        }
        if (!p) {
            p = d * (.3 * 1.5);
        }
        if (a < fabs(c)) {
            a = c; s = p / 4;
        }
        else {
            s = p / (2 * 3.1419) * asin(c / a);
        }
        if (t < 1) {
            t--;
            return -.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * 3.1419) / p)) + b;
        }
        t--;
        return a * pow(2, -10 * t) * sin((t * d - s) * (2 * 3.1419) / p) * .5 + c + b;
    };
    
    
    //MMTweenFunctionExpo
    MMTweenFunctionBlock blockExpoIn = ^(double t, double b, double c, double d)
    {
        return (t == 0) ? b : c *pow(2, 10 * (t / d - 1)) + b;
    };
    
    MMTweenFunctionBlock blockExpoOut = ^(double t, double b, double c, double d)
    {
        return (t == d) ? b + c : c * (-pow(2, -10 * t / d) + 1) + b;
    };
    
    MMTweenFunctionBlock blockExpoInOut = ^(double t, double b, double c, double d)
    {
        if (t == 0) {
            return b;
        }
        else if (t == d) {
            return b + c;
        }
        
        t /= d / 2;
        
        if (t < 1) {
            return c / 2 * pow(2, 10 * (t - 1)) + b;
        }
        else {
            return c / 2 * (-pow(2, -10 * --t) + 2) + b;
        }
    };
    
    
    //MMTweenFunctionQuad
    MMTweenFunctionBlock blockQuadIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t + b;
    };
    
    MMTweenFunctionBlock blockQuadOut = ^(double t, double b, double c, double d)
    {
        t /= d;
        return -c * t * (t - 2) + b;
    };
    
    MMTweenFunctionBlock blockQuadInOut = ^(double t, double b, double c, double d)
    {
        t /= d / 2;
        if (t < 1) {
            return c / 2 * t * t + b;
        }
        t--;
        return -c / 2 * (t * (t - 2) - 1) + b;
    };
    
    
    //MMTweenFunctionQuart
    MMTweenFunctionBlock blockQuartIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t * t * t + b;
    };
    
    MMTweenFunctionBlock blockQuartOut = ^(double t, double b, double c, double d)
    {
        t = t / d - 1;
        return -c * (t * t * t * t - 1) + b;
    };
    
    MMTweenFunctionBlock blockQuartInOut = ^(double t, double b, double c, double d)
    {
        t /= d / 2;
        if (t < 1) {
            return c / 2 * t * t * t * t + b;
        }
        
        t -= 2;
        return -c / 2 * (t * t * t * t - 2) + b;
    };
    
    
    //MMTweenFunctionQuint
    MMTweenFunctionBlock blockQuintIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t * t * t * t + b;
    };
    
    MMTweenFunctionBlock blockQuintOut = ^(double t, double b, double c, double d)
    {
        t = t / d - 1;
        return c * (t * t * t * t * t + 1) + b;
    };
    
    MMTweenFunctionBlock blockQuintInOut = ^(double t, double b, double c, double d)
    {
        t /= d / 2;
        if (t < 1) {
            return c / 2 * t * t * t * t * t + b;
        }
        t -= 2;
        return c / 2 * (t * t * t * t * t + 2) + b;
    };
    
    
    //MMTweenFunctionSine
    MMTweenFunctionBlock blockSineIn = ^(double t, double b, double c, double d)
    {
        return -c *cos(t / d * (M_PI / 2)) + c + b;
    };
    
    MMTweenFunctionBlock blockSineOut = ^(double t, double b, double c, double d)
    {
        return c * sin(t / d * (M_PI / 2)) + b;
    };
    
    MMTweenFunctionBlock blockSineInOut = ^(double t, double b, double c, double d)
    {
        return -c / 2 * (cos(M_PI * t / d) - 1) + b;
    };
    
    self.functionTable = @[@[blockBackIn,
                             blockBackOut,
                             blockBackInOut],
                           @[blockBounceIn,
                             blockBounceOut,
                             blockBounceInOut],
                           @[blockCircIn,
                             blockCircOut,
                             blockCircInOut],
                           @[blockCubicIn,
                             blockCubicOut,
                             blockCubicInOut],
                           @[blockElasticIn,
                             blockElasticOut,
                             blockElasticInOut],
                           @[blockExpoIn,
                             blockExpoOut,
                             blockExpoInOut],
                           @[blockQuadIn,
                             blockQuadOut,
                             blockQuadInOut],
                           @[blockQuartIn,
                             blockQuartOut,
                             blockQuartInOut],
                           @[blockQuintIn,
                             blockQuintOut,
                             blockQuintInOut],
                           @[blockSineIn,
                             blockSineOut,
                             blockSineInOut]];
    
    self.functionNames = @[@"Back",
                           @"Bounce",
                           @"Circ",
                           @"Cubic",
                           @"Elastic",
                           @"Expo",
                           @"Quad",
                           @"Quart",
                           @"Quint",
                           @"Sine"];
    
    self.easingNames = @[@"EaseIn",
                         @"EaseOut",
                         @"EaseInOut"];
    
    //    [MMTweenFunction test];
}

+ (void)test {
    MMTweenFunction *func = [MMTweenFunction sharedInstance];
    
    for (int i = 0; i < MMTweenFunctionTypeMax; ++i) {
        for (int j = 0; j < MMTweenEasingTypeMax; ++j) {
            NSLog(@"%@\t\t%@", func.functionNames[i], func.easingNames[j]);
        }
    }
}

@end
