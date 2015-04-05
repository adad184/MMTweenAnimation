//
//  MMPaintView.m
//  MMTweenAnimation
//
//  Created by Ralph Li on 4/5/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "MMPaintView.h"
#import "CGPointExtension.h"

@interface MMPaintView()

@property (nonatomic, strong) UIBezierPath   *path;
@property (nonatomic, strong) NSMutableArray *dots;


@end

@implementation MMPaintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        self.path = [UIBezierPath bezierPath];
        self.path.lineWidth = 1.0f;
        
        self.dots = [@[] mutableCopy];
    }
    return self;
}

- (void)clearPaint
{
    [self.dots removeAllObjects];
    
    self.path = [self interpolateCGPointsWithHermite:self.dots];
    
    [self setNeedsDisplay];
}

- (void)addDot:(CGPoint)pt
{
    [self.dots addObject:[NSValue valueWithCGPoint:pt]];
    
    self.path = [self interpolateCGPointsWithHermite:self.dots];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self.path stroke];
}

- (UIBezierPath *)interpolateCGPointsWithCatmullRom:(NSArray *)pointsAsNSValues
{
    if ([pointsAsNSValues count] < 4)
        return nil;
    
    bool closed = NO;
    float alpha = 1.0f;
    
    int endIndex = (int)[pointsAsNSValues count]-2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    int startIndex = (closed ? 0 : 1);
    for (int ii=startIndex; ii < endIndex; ++ii) {
        CGPoint p0, p1, p2, p3;
        int nextii      = (ii+1)%[pointsAsNSValues count];
        int nextnextii  = (nextii+1)%[pointsAsNSValues count];
        int previi      = (ii-1 < 0 ? (int)[pointsAsNSValues count]-1 : ii-1);
        
        [pointsAsNSValues[ii] getValue:&p1];
        [pointsAsNSValues[previi] getValue:&p0];
        [pointsAsNSValues[nextii] getValue:&p2];
        [pointsAsNSValues[nextnextii] getValue:&p3];
        
        float d1 = ccpLength(ccpSub(p1, p0));
        float d2 = ccpLength(ccpSub(p2, p1));
        float d3 = ccpLength(ccpSub(p3, p2));
        
        CGPoint b1, b2;
        b1 = ccpMult(p2, powf(d1, 2*alpha));
        b1 = ccpSub(b1, ccpMult(p0, powf(d2, 2*alpha)));
        b1 = ccpAdd(b1, ccpMult(p1,(2*powf(d1, 2*alpha) + 3*powf(d1, alpha)*powf(d2, alpha) + powf(d2, 2*alpha))));
        b1 = ccpMult(b1, 1.0 / (3*powf(d1, alpha)*(powf(d1, alpha)+powf(d2, alpha))));
        
        b2 = ccpMult(p1, powf(d3, 2*alpha));
        b2 = ccpSub(b2, ccpMult(p3, powf(d2, 2*alpha)));
        b2 = ccpAdd(b2, ccpMult(p2,(2*powf(d3, 2*alpha) + 3*powf(d3, alpha)*powf(d2, alpha) + powf(d2, 2*alpha))));
        b2 = ccpMult(b2, 1.0 / (3*powf(d3, alpha)*(powf(d3, alpha)+powf(d2, alpha))));
        
        if (ii==startIndex)
            [path moveToPoint:p1];
        
        [path addCurveToPoint:p2 controlPoint1:b1 controlPoint2:b2];
    }
    return path;
}

- (UIBezierPath *)interpolateCGPointsWithHermite:(NSArray *)pointsAsNSValues
{
    if ([pointsAsNSValues count] < 2)
        return nil;
    
    bool closed = NO;
    
    int nCurves = (int)[pointsAsNSValues count]-1;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int ii=0; ii < nCurves; ++ii) {
        NSValue *value  = pointsAsNSValues[ii];
        
        CGPoint curPt, prevPt, nextPt, endPt;
        [value getValue:&curPt];
        if (ii==0)
            [path moveToPoint:curPt];
        
        int nextii = (ii+1)%[pointsAsNSValues count];
        int previi = (ii-1 < 0 ? (int)[pointsAsNSValues count]-1 : ii-1);
        
        [pointsAsNSValues[previi] getValue:&prevPt];
        [pointsAsNSValues[nextii] getValue:&nextPt];
        endPt = nextPt;
        
        float mx, my;
        if (closed || ii > 0) {
            mx = (nextPt.x - curPt.x)*0.5 + (curPt.x - prevPt.x)*0.5;
            my = (nextPt.y - curPt.y)*0.5 + (curPt.y - prevPt.y)*0.5;
        }
        else {
            mx = (nextPt.x - curPt.x)*0.5;
            my = (nextPt.y - curPt.y)*0.5;
        }
        
        CGPoint ctrlPt1;
        ctrlPt1.x = curPt.x + mx / 3.0;
        ctrlPt1.y = curPt.y + my / 3.0;
        
        [pointsAsNSValues[nextii] getValue:&curPt];
        
        nextii = (nextii+1)%[pointsAsNSValues count];
        previi = ii;
        
        [pointsAsNSValues[previi] getValue:&prevPt];
        [pointsAsNSValues[nextii] getValue:&nextPt];
        
        if (closed || ii < nCurves-1) {
            mx = (nextPt.x - curPt.x)*0.5 + (curPt.x - prevPt.x)*0.5;
            my = (nextPt.y - curPt.y)*0.5 + (curPt.y - prevPt.y)*0.5;
        }
        else {
            mx = (curPt.x - prevPt.x)*0.5;
            my = (curPt.y - prevPt.y)*0.5;
        }
        
        CGPoint ctrlPt2;
        ctrlPt2.x = curPt.x - mx / 3.0;
        ctrlPt2.y = curPt.y - my / 3.0;
        
        [path addCurveToPoint:endPt controlPoint1:ctrlPt1 controlPoint2:ctrlPt2];
    }
    
    if (closed)
        [path closePath];
    
    return path;
}

@end
