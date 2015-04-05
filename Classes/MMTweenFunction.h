//
//  MMTweenFunction.h
//  MMTweenAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, MMTweenEasingType) {
    MMTweenEasingIn,
    MMTweenEasingOut,
    MMTweenEasingInOut,
    MMTweenEasingTypeMax
};

typedef NS_ENUM (NSUInteger, MMTweenFunctionType) {
    MMTweenFunctionBack,
    MMTweenFunctionBounce,
    MMTweenFunctionCirc,
    MMTweenFunctionCubic,
    MMTweenFunctionElastic,
    MMTweenFunctionExpo,
    MMTweenFunctionQuad,
    MMTweenFunctionQuart,
    MMTweenFunctionQuint,
    MMTweenFunctionSine,
    MMTweenFunctionTypeMax
};

typedef double (^MMTweenFunctionBlock)(double t, //time
                                       double b, //begining
                                       double c, //change
                                       double d  //duration
                                       );

@interface MMTweenFunction : NSObject

@property (nonatomic, readonly) NSArray *functionTable;
@property (nonatomic, readonly) NSArray *functionNames;
@property (nonatomic, readonly) NSArray *easingNames;
@property (nonatomic, assign)   MMTweenFunctionType functionType;

+ (instancetype)sharedInstance;

+ (MMTweenFunctionBlock)blockWithFunctionType:(MMTweenFunctionType)functionType
                                   easingType:(MMTweenEasingType)easingType;

@end
