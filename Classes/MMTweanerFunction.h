//
//  MMTweanerFunction.h
//  MMTweanerAnimation
//
//  Created by Ralph Li on 4/4/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, MMTweanerEasingType) {
    MMTweanerEasingIn,
    MMTweanerEasingOut,
    MMTweanerEasingInOut,
    MMTweanerEasingTypeMax
};

typedef NS_ENUM (NSUInteger, MMTweanerFunctionType) {
    MMTweanerFunctionBack,
    MMTweanerFunctionBounce,
    MMTweanerFunctionCirc,
    MMTweanerFunctionCubic,
    MMTweanerFunctionElastic,
    MMTweanerFunctionExpo,
    MMTweanerFunctionQuad,
    MMTweanerFunctionQuart,
    MMTweanerFunctionQuint,
    MMTweanerFunctionSine,
    MMTweanerFunctionTypeMax
};

typedef double (^MMTweanerFunctionBlock)(double t, //time
                                         double b, //begining
                                         double c, //change
                                         double d  //duration
                                         );

@interface MMTweanerFunction : NSObject

@property (nonatomic, readonly) NSArray *functionTable;
@property (nonatomic, readonly) NSArray *functionNames;
@property (nonatomic, readonly) NSArray *easingNames;
@property (nonatomic, assign) MMTweanerFunctionType functionType;

+ (instancetype)sharedInstance;

+ (MMTweanerFunctionBlock)blockWithFunctionType:(MMTweanerFunctionType)functionType
                                      easingType:(MMTweanerEasingType)easingType;

@end
