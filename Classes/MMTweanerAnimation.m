//
//  MMTweanerAnimation.m
//  MMTweanerAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "MMTweanerAnimation.h"

@interface MMTweanerAnimation()

@property (nonatomic, copy) MMTweanerFunctionBlock functionBlock;

@end

@implementation MMTweanerAnimation

+ (instancetype)animation
{
    MMTweanerAnimation *tweaner = [super animationWithBlock:^BOOL(id target, POPCustomAnimation *animation) {
        
        MMTweanerAnimation *anim = (MMTweanerAnimation*)animation;
        
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
    tweaner.functionType = MMTweanerFunctionBounce;
    tweaner.easingType   = MMTweanerEasingOut;
    
    return tweaner;
}

+ (instancetype)animationWithBlock:(POPCustomAnimationBlock)block __attribute__((unavailable("You should call +animation")));
{
    return nil;
}

- (void)setFunctionType:(MMTweanerFunctionType)functionType
{
    _functionType = functionType;
    
    MMTweanerFunction *function = [MMTweanerFunction sharedInstance];
    
    self.functionBlock = function.functionTable[functionType][self.easingType];
}

- (void)setEasingType:(MMTweanerEasingType)easingType
{
    _easingType = easingType;
    
    MMTweanerFunction *function = [MMTweanerFunction sharedInstance];
    
    self.functionBlock = function.functionTable[self.functionType][easingType];
}

@end
