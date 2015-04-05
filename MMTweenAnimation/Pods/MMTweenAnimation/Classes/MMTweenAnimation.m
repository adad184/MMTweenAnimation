//
//  MMTweenAnimation.m
//  MMTweenAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "MMTweenAnimation.h"

@interface MMTweenAnimation()

@property (nonatomic, copy) MMTweenFunctionBlock functionBlock;

@end

@implementation MMTweenAnimation

+ (instancetype)animation
{
    MMTweenAnimation *tweaner = [super animationWithBlock:^BOOL(id target, POPCustomAnimation *animation) {
        
        MMTweenAnimation *anim = (MMTweenAnimation*)animation;
        
        double t = (animation.currentTime-animation.beginTime);
        double b = anim.fromValue;
        double c = anim.toValue-anim.fromValue;
        double d = anim.duration;
        
        if ( t<d )
        {
            double value = anim.functionBlock(t,b,c,d);
            
            if ( anim.animationBlock )
            {
                anim.animationBlock(t,d,value,target,anim);
            }
            return YES;
        }
        else
        {
            return NO;
        }
    }];
    tweaner.duration = 0.3;
    tweaner.functionType = MMTweenFunctionBounce;
    tweaner.easingType   = MMTweenEasingOut;
    
    return tweaner;
}

+ (instancetype)animationWithBlock:(POPCustomAnimationBlock)block __attribute__((unavailable("You should call +animation")));
{
    return nil;
}

- (void)setFunctionType:(MMTweenFunctionType)functionType
{
    _functionType = functionType;
    
    MMTweenFunction *function = [MMTweenFunction sharedInstance];
    
    self.functionBlock = function.functionTable[functionType][self.easingType];
}

- (void)setEasingType:(MMTweenEasingType)easingType
{
    _easingType = easingType;
    
    MMTweenFunction *function = [MMTweenFunction sharedInstance];
    
    self.functionBlock = function.functionTable[self.functionType][easingType];
}

@end
