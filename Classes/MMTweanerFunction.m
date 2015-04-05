//
//  MMTweanerFunction.m
//  MMTweanerAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "MMTweanerFunction.h"

static MMTweanerFunction *sharedFunction = nil;

@interface MMTweanerFunction ()

@property (nonatomic, strong) NSArray *functionTable;
@property (nonatomic, strong) NSArray *functionNames;
@property (nonatomic, strong) NSArray *easingNames;

@end

@implementation MMTweanerFunction

+ (void)load {
    MMTweanerFunction *func = [MMTweanerFunction sharedInstance];
    
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

+ (MMTweanerFunctionBlock)blockWithFunctionType:(MMTweanerFunctionType)functionType easingType:(MMTweanerEasingType)easingType {
    return nil;
}

- (void)setupBlocks {
    //MMTweanerFunctionBack
    MMTweanerFunctionBlock blockBackIn = ^(double t, double b, double c, double d)
    {
        double s = 1.70158;
        t /= d;
        return c * t * t * ((s + 1) * t - s) + b;
    };
    
    MMTweanerFunctionBlock blockBackOut = ^(double t, double b, double c, double d)
    {
        double s = 1.70158;
        t = t / d - 1;
        return c * (t * t * ((s + 1) * t + s) + 1) + b;
    };
    
    MMTweanerFunctionBlock blockBackInOut = ^(double t, double b, double c, double d)
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
    
    //MMTweanerFunctionBounce
    MMTweanerFunctionBlock blockBounceOut = ^(double t, double b, double c, double d)
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
    
    MMTweanerFunctionBlock blockBounceIn = ^(double t, double b, double c, double d)
    {
        return c - blockBounceOut(d - t, 0, c, d) + b;
    };
    
    MMTweanerFunctionBlock blockBounceInOut = ^(double t, double b, double c, double d)
    {
        if (t < d * .5) {
            return blockBounceIn(t * 2, 0, c, d) * .5 + b;
        }
        else {
            return blockBounceOut(t * 2 - d, 0, c, d) * .5 + c * .5 + b;
        }
    };
    
    //MMTweanerFunctionCirc
    MMTweanerFunctionBlock blockCircIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return -c * (sqrt(1 - t * t) - 1) + b;
    };
    
    MMTweanerFunctionBlock blockCircOut = ^(double t, double b, double c, double d)
    {
        t = t / d - 1;
        return c * sqrt(1 - t * t) + b;
    };
    
    MMTweanerFunctionBlock blockCircInOut = ^(double t, double b, double c, double d)
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
    
    
    //MMTweanerFunctionCubic
    MMTweanerFunctionBlock blockCubicIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t * t + b;
    };
    
    MMTweanerFunctionBlock blockCubicOut = ^(double t, double b, double c, double d)
    {
        t = t / d - 1;
        return c * (t * t * t + 1) + b;
    };
    
    MMTweanerFunctionBlock blockCubicInOut = ^(double t, double b, double c, double d)
    {
        t /= d / 2;
        if (t < 1) {
            return c / 2 * t * t * t + b;
        }
        
        t -= 2;
        return c / 2 * (t * t * t + 2) + b;
    };
    
    
    //MMTweanerFunctionElastic
    MMTweanerFunctionBlock blockElasticIn = ^(double t, double b, double c, double d)
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
        if (a < abs(c)) {
            a = c; s = p / 4;
        }
        else {
            s = p / (2 * 3.1419) * asin(c / a);
        }
        t--;
        return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * 3.1419) / p)) + b;
    };
    
    MMTweanerFunctionBlock blockElasticOut = ^(double t, double b, double c, double d)
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
        if (a < abs(c)) {
            a = c; s = p / 4;
        }
        else {
            s = p / (2 * 3.1419) * asin(c / a);
        }
        return a * pow(2, -10 * t) * sin((t * d - s) * (2 * 3.1419) / p) + c + b;
    };
    
    MMTweanerFunctionBlock blockElasticInOut = ^(double t, double b, double c, double d)
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
        if (a < abs(c)) {
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
    
    
    //MMTweanerFunctionExpo
    MMTweanerFunctionBlock blockExpoIn = ^(double t, double b, double c, double d)
    {
        return (t == 0) ? b : c *pow(2, 10 * (t / d - 1)) + b;
    };
    
    MMTweanerFunctionBlock blockExpoOut = ^(double t, double b, double c, double d)
    {
        return (t == d) ? b + c : c * (-pow(2, -10 * t / d) + 1) + b;
    };
    
    MMTweanerFunctionBlock blockExpoInOut = ^(double t, double b, double c, double d)
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
    
    
    //MMTweanerFunctionQuad
    MMTweanerFunctionBlock blockQuadIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t + b;
    };
    
    MMTweanerFunctionBlock blockQuadOut = ^(double t, double b, double c, double d)
    {
        t /= d;
        return -c * t * (t - 2) + b;
    };
    
    MMTweanerFunctionBlock blockQuadInOut = ^(double t, double b, double c, double d)
    {
        t /= d / 2;
        if (t < 1) {
            return c / 2 * t * t + b;
        }
        t--;
        return -c / 2 * (t * (t - 2) - 1) + b;
    };
    
    
    //MMTweanerFunctionQuart
    MMTweanerFunctionBlock blockQuartIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t * t * t + b;
    };
    
    MMTweanerFunctionBlock blockQuartOut = ^(double t, double b, double c, double d)
    {
        t = t / d - 1;
        return -c * (t * t * t * t - 1) + b;
    };
    
    MMTweanerFunctionBlock blockQuartInOut = ^(double t, double b, double c, double d)
    {
        t /= d / 2;
        if (t < 1) {
            return c / 2 * t * t * t * t + b;
        }
        
        t -= 2;
        return -c / 2 * (t * t * t * t - 2) + b;
    };
    
    
    //MMTweanerFunctionQuint
    MMTweanerFunctionBlock blockQuintIn = ^(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t * t * t * t + b;
    };
    
    MMTweanerFunctionBlock blockQuintOut = ^(double t, double b, double c, double d)
    {
        t = t / d - 1;
        return c * (t * t * t * t * t + 1) + b;
    };
    
    MMTweanerFunctionBlock blockQuintInOut = ^(double t, double b, double c, double d)
    {
        t /= d / 2;
        if (t < 1) {
            return c / 2 * t * t * t * t * t + b;
        }
        t -= 2;
        return c / 2 * (t * t * t * t * t + 2) + b;
    };
    
    
    //MMTweanerFunctionSine
    MMTweanerFunctionBlock blockSineIn = ^(double t, double b, double c, double d)
    {
        return -c *cos(t / d * (M_PI / 2)) + c + b;
    };
    
    MMTweanerFunctionBlock blockSineOut = ^(double t, double b, double c, double d)
    {
        return c * sin(t / d * (M_PI / 2)) + b;
    };
    
    MMTweanerFunctionBlock blockSineInOut = ^(double t, double b, double c, double d)
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
    
//    [MMTweanerFunction test];
}

+ (void)test {
    MMTweanerFunction *func = [MMTweanerFunction sharedInstance];
    
    for (int i = 0; i < MMTweanerFunctionTypeMax; ++i) {
        for (int j = 0; j < MMTweanerEasingTypeMax; ++j) {
            NSLog(@"%@\t\t%@", func.functionNames[i], func.easingNames[j]);
        }
    }
}

@end
