MMTweenAnimation
=============
[![CocoaPods](https://img.shields.io/cocoapods/v/MMTweenAnimation.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/p/MMTweenAnimation.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/l/MMTweenAnimation.svg)]()


![demo][demo]

MMTweenAnimation is a extension of POP(from facebook) custom animation. Inspired by tweaner(https://code.google.com/p/tweaner), MMTweanerAnimation provide 10 types of custom animation while using POP. 

Animation functions are based on [**Easing functions**](http://easings.net/en)

> **Easing functions** specify the rate of change of a parameter over time and allow you to apply custom mathematical formulas to your animations. 

Installation
============

The preferred way of installation is via [CocoaPods](http://cocoapods.org). Just add

```ruby
pod 'MMTweenAnimation'
```

and run `pod install`. It will install the most recent version of MMTweenAnimation.

If you would like to use the latest code of MMTweenAnimation use:

```ruby
pod 'MMTweenAnimation', :head
```


Type
===============
There are 10 concrete animation types: 

| Back      | Bounce    | Circ      | Cubic     | Elastic   |
|:---------:|:---------:|:---------:|:---------:|:---------:|
| ![][1]    | ![][2]    | ![][3]    | ![][4]    | ![][5]    |


| Expo      | Quad      | Quart     | Quint     | Sine      |
|:---------:|:---------:|:---------:|:---------:|:---------:|
| ![][6]    | ![][7]    | ![][8]    | ![][9]    | ![][10]   |


Usage
===============

To apply a MMTweenAnimation, you must configure it by:

```objc
@property (nonatomic, copy)   MMTweenAnimationBlock  animationBlock;

@property (nonatomic, assign) NSArray *fromValue;
@property (nonatomic, assign) NSArray *toValue;
@property (nonatomic, assign) double duration;  //default: 0.3

@property (nonatomic, assign) MMTweenFunctionType functionType; //default: MMTweenFunctionBounce
@property (nonatomic, assign) MMTweenEasingType   easingType;   //default: MMTweenEasingOut
```

for example:
```objc
MMTweenAnimation *anim = [MMTweenAnimation animation];
anim.functionType   = MMTweenFunctionBounce;
anim.easingType     = MMTweenEasingOut;
anim.duration       = 2.0f;
anim.fromValue      = @[@0];
anim.toValue        = @[@200];
anim.animationBlock = ^(double c,double d,NSArray *v,id target,MMTweenAnimation *animation)
{
    //c: current time, from the beginning of animation
    //d: duration, always bigger than c
    //v: value, after the change at current time

    double value = [v[0] doubleValue];
    UIView *t = (UIView*)target;
    t.center = CGPointMake(t.x, value);
};

[targetView pop_addAnimation:anim forKey:@"center.y"];

```

Changelog
===============

v1.1  you can animate several values at the same time

```objc
typedef void(^MMTweenAnimationBlock)(double c,   
                                     double d,  
                                     NSArray *v, // change to array
                                     id target,
                                     MMTweenAnimation *animation
                                     );

@property (nonatomic, strong) NSArray *fromValue;	// change to array
@property (nonatomic, strong) NSArray *toValue;		// change to array
```


v1.0  you can custom or simply use it by

```objc

@interface MMTweenAnimation : POPCustomAnimation

@property (nonatomic, copy)   MMTweenAnimationBlock  animationBlock;

@property (nonatomic, assign) double fromValue;
@property (nonatomic, assign) double toValue;
@property (nonatomic, assign) double duration;

@property (nonatomic, assign) MMTweenFunctionType functionType;
@property (nonatomic, assign) MMTweenEasingType   easingType;

+ (instancetype)animation;

@end
```



[demo]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/demo.gif
[1]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/1.gif
[2]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/2.gif
[3]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/3.gif
[4]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/4.gif
[5]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/5.gif
[6]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/6.gif
[7]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/7.gif
[8]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/8.gif
[9]:  https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/9.gif
[10]: https://raw.githubusercontent.com/adad184/MMTweenAnimation/master/Images/10.gif


