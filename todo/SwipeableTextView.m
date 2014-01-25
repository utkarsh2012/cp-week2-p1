//
//  SwipeableTextView.m
//  todo
//
//  Created by Utkarsh Sengar on 1/24/14.
//  Copyright (c) 2014 area42. All rights reserved.
//

#import "SwipeableTextView.h"

@implementation SwipeableTextView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch =[touches anyObject];
    gestureStartPoint = [touch locationInView:self];
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    
    CGFloat deltaX = fabsf(gestureStartPoint.x - currentPosition.x);
    CGFloat deltaY = fabsf(gestureStartPoint.y - currentPosition.y);
    
    if (deltaX >= kMinimumGestureLength && deltaY <= kMaximumVariance) {
        NSLog(@"Horizontal swipe detected");
    }
}

@end