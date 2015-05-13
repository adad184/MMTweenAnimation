//
//  MMTweenAnimation.h
//  MMTweenAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <pop/POP.h>
#import "MMTweenFunction.h"

@class MMTweenAnimation;

typedef void(^MMTweenAnimationBlock)(double c,   //current time offset(0->duration)
                                     double d,   //duration
                                     NSArray *v, //current value
                                     id target,
                                     MMTweenAnimation *animation
                                     );

@interface MMTweenAnimation : POPCustomAnimation

@property (nonatomic, copy)   MMTweenAnimationBlock  animationBlock;

@property (nonatomic, strong) NSArray *fromValue;
@property (nonatomic, strong) NSArray *toValue;
@property (nonatomic, assign) double  duration;

@property (nonatomic, assign) MMTweenFunctionType functionType;
@property (nonatomic, assign) MMTweenEasingType   easingType;

+ (instancetype)animation;

@end
