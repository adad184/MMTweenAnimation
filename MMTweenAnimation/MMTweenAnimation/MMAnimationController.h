//
//  MMAnimationController.h
//  MMTweenAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTweenFunction.h"

@interface MMAnimationController : UIViewController

@property (nonatomic, assign) MMTweenFunctionType functionType;
@property (nonatomic, assign) MMTweenEasingType   easingType;

@end
