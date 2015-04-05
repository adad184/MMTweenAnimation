//
//  MMAnimationController.h
//  MMTweanerAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTweanerAnimation.h"

@interface MMAnimationController : UIViewController

@property (nonatomic, assign) MMTweanerFunctionType functionType;
@property (nonatomic, assign) MMTweanerEasingType   easingType;

@end
