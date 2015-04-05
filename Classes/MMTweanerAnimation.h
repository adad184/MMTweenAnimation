//
//  MMTweanerAnimation.h
//  MMTweanerAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "POPCustomAnimation.h"
#import "MMTweanerFunction.h"

@class MMTweanerAnimation;

typedef void(^MMTweanerAnimationBlock)(double c, //current time offset(0->duration)
                                      double d, //duration
                                      double v, //return value
                                      id target,
                                      MMTweanerAnimation *animation
                                      );

@interface MMTweanerAnimation : POPCustomAnimation

@property (nonatomic, copy)   MMTweanerAnimationBlock  animationBlock;

@property (nonatomic, assign) double fromValue;
@property (nonatomic, assign) double toValue;
@property (nonatomic, assign) double duration;

@property (nonatomic, assign) MMTweanerFunctionType functionType;
@property (nonatomic, assign) MMTweanerEasingType   easingType;

+ (instancetype)animation;

@end
